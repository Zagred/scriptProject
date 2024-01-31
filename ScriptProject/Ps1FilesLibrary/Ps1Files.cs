using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ps1FilesLibrary
{
    public class Ps1Files
    {
        public void RemoveEmptyRows(List<string> folderContent)
        {
            foreach (string path in folderContent)//path на всяка папка
            {
                foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// всчики файлове в папката
                {
                    string[] fileContent = File.ReadAllLines(filepath);
                    fileContent = fileContent.Where(arg => !string.IsNullOrWhiteSpace(arg)).ToArray();//маха всеки ред който не съдържа нищо
                    File.WriteAllLines(filepath, fileContent);
                }
            }
        }
        /// <summary>
        /// 2-та метода работят като използваме fileContent, за да намери реда с който трябва да заместим кода, маха ме го и на негово място слагам кода който иска
        /// </summary>
        /// <param name="filepath"></param> path на файл, който използваме в момента
        /// <param name="fileContent"></param> текста на файла, който използваме
        /// <param name="path"></param> path от коя папка е файла
        public static void scriptPath(string filepath, string fileContent, string path)
        {
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$scriptPath"))
                {
                    try//зарадо roothapth ще има много scriptpath-вове които няма да ги има в папката(Loggin.ps1) и ще ги махнем, защото нямаме нужда от тях
                    {
                        content[i] = path + content[i].Substring(content[i].IndexOf('\\')).Trim('\"');
                        content[i] = File.ReadAllText(content[i]);
                    }
                    catch
                    {
                        content[i] = null;
                    }
                }
            }
            File.WriteAllLines(filepath, content);
        }
        /// <summary>
        /// логиакта е подобна на другите, но разликата е цхе parent path наследява една папка по назад, следователно ще взимам от предишната папка а не настоящата
        /// </summary>
        /// <param name="filepath"></param> path на файла, който използваме в момента
        /// <param name="fileContent"></param> текста на файла, който използваме
        /// <param name="path"></param> path на папката на файла
        public static void parentPath(string filepath, string fileContent, string path)
        {
            int ParentConst = 14;
            path = path.Substring(0, path.LastIndexOf('\\'));
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$parentPath"))
                {
                    content[i] = path + content[i].Substring(ParentConst).Trim('\"');
                    try// слагаме try catch фунцкия, защото в един от файловете се иска файл, който не съществува и просто го занъляваме сякаш го е нямало
                    {
                        content[i] = File.ReadAllText(content[i]);
                        File.WriteAllLines(filepath, content);
                    }
                    catch
                    {
                        content[i] = null;
                    }
                }
            }

        }
        /// <summary>
        /// разлиакта с другите е че има фиксиран path, от който трябва да гледаме файлове
        /// </summary>
        /// <param name="filepath"></param> path на файла който използваме в момента
        /// <param name="fileContent"></param> teksta на файл, който използваме
        /// <param name="basePath"></param> това е главния path трябва ни специфично за roothPath, защото ще използваме изцяло друга папка
        public static void rootPath(string filepath, string fileContent, string basePath)
        {
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$rootPath") && content[i].Contains("CommonVariables")){
                    string path = basePath + content[i].Replace(". \"$rootPath\\", null).Trim('\"');// да намери от коя папка  roothpath
                    content[i]=File.ReadAllText(path);
                    File.WriteAllLines(filepath, content);

                }
            }
            
        }
        public string[] array = { "\"$rootPath\\", "\"$parentPath\\", "\"$scriptPath\\" };

        //махат се редовете за roothPath SCHEDULEtASK, WEBSERVICE и WINDOWSERVICE 
        //понеже те наследяват чрез scriptpath друг file който съдържа roothpath кум същите елементи
        public void successorRowSearcher(List<string> folderContent, string basePath)
        {
            foreach (string path in folderContent)//path на всяка папка
            {
                for (int i = 0; i < array.Length; i++)//минава през фиксиран ред от кои редове да почне
                {
                    foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// всчики файлове в папката
                    {
                        string fileContent = File.ReadAllText(filepath);
                        if (fileContent.Contains(array[i]) == true)
                        {
                            switch (array[i])
                            {
                                case "\"$parentPath\\":
                                    fileContent = fileContent.Replace("$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName", null);
                                    parentPath(filepath, fileContent, path);
                                    break;
                                case "\"$scriptPath\\":
                                    fileContent = fileContent.Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                                    scriptPath(filepath, fileContent, path);
                                    break;
                                case "\"$rootPath\\":
                                    fileContent = fileContent.Replace("$rootPath  = (Get-Item $PSScriptRoot).Parent.FullName", null);
                                    rootPath(filepath, fileContent, basePath);
                                    break;
                            }
                        }

                    }
                }
            }
        }
        //добавя всички глобални променливи без дублиране в нова папка CommonVariables
        public void commonVariablesGlobal(List<string> foldercontent)
        {
            foreach (string path in foldercontent)
            {
                List<string> valuesOfVariables = new List<string>();// лист, който ще запазва всички променливи
                Dictionary<string,int> matches= new Dictionary<string,int>();
                int i = 0;//брояч за броя файлове в папката
                foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// всчики файлове в папката
                {
                    i++;
                    string[] content = File.ReadAllLines(filepath);
                    foreach (string line in content)
                    {
                        if (line.Contains("$Global:") == true && (line[0]=='$'|| line[0]=='#' && line[1]=='$'))//проверява за глобални променливи
                        {

                            if (!matches.ContainsKey(line))
                            {

                                matches.Add(line, 1);
                            }
                            else
                            {
                                matches[line]++;
                            }
                        }
                    }
                }
                foreach(var item in matches)
                {
                    if (item.Value == i)
                    {
                        valuesOfVariables.Add(item.Key);
                    }
                }
                if (i > 1 && valuesOfVariables.Count>0)//ако е повече от 1 файл тогава да създаде нов файл
                {
                    using (StreamWriter sw = new StreamWriter(path + "\\Variables.ps1"))
                    {
                        foreach (string item in valuesOfVariables)
                        {
                            sw.WriteLine(item);
                        }
                    } //добавяне на ред за наследяване variables.ps1

                    foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// всчики файлове в папката
                    {
                        if (filepath != path + "\\Variables.ps1")
                        {
                            string[] conten = File.ReadAllLines(filepath);
                            foreach (string item in valuesOfVariables)// всички променливи, които трябва да се махнат
                            {
                                conten = conten.Where(s => s != item).ToArray();
                            }

                            File.WriteAllLines(filepath, conten);
                        }
                    }
                    foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// всчики файлове в папката
                    {
                        if (filepath != path + "\\Variables.ps1")
                        {
                            string conten = File.ReadAllText(filepath);
                            conten = "$scriptPath  = (Get-Item $PSScriptRoot).FullName \r\n" + ". \"$scriptPath\\Variables.ps1\"\" \r\n" + conten;
                            File.WriteAllText(filepath, conten);
                        }
                    }
                }
            }
        }
    }
}