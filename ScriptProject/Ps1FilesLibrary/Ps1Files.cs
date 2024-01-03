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
        public static string Trim(string str, char trimChar)
        {
            string result = string.Empty;
            for (int i = 0; i < str.Length; i++)
            {
                if (str[i] != trimChar)
                {
                    result += str[i];
                }
            }
            return result;
        }
        public void RemoveEmptyRows(List<string> folderContent)
        {
            foreach (string path in folderContent)//path на всяка папка
            {
                foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// всчики файлове в папката
                {
                    string[] fileContent = File.ReadAllLines(filepath);
                    fileContent = fileContent.Where(arg => !string.IsNullOrWhiteSpace(arg)).ToArray();//маха всеки ред който не съдържа нищп
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
        public static void ourPath(string filepath, string fileContent, string path)
        {
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$ourPath"))
                {
                    content[i] = path + Trim(content[i].Substring(11), '\"');
                    content[i] = File.ReadAllText(content[i]);
                }
            }
            File.WriteAllLines(filepath, content);
        }
        public static void scriptPath(string filepath, string fileContent, string path)
        {
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$scriptPath"))
                {
                    content[i] = path + Trim(content[i].Substring(content[i].IndexOf('\\')), '\"');
                    content[i] = File.ReadAllText(content[i]);
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
            path = path.Substring(0, path.LastIndexOf('\\'));
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$parentPath"))
                {
                    content[i] = path + Trim(content[i].Substring(14), '\"');
                    try// слагаме try catch фунцкия, защото в един от файловете се иска файл, който не съществува
                    {
                        content[i] = File.ReadAllText(content[i]);
                        File.WriteAllLines(filepath, content);
                    }
                    catch
                    {
                        Console.WriteLine($"The following file those not exist: {content[i]} ");
                    }
                }
            }

        }
        public static void parent(string filepath, string fileContent, string path)
        {
            path = path.Substring(0, path.LastIndexOf('\\'));
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$parent"))
                {
                    content[i] = path + Trim(content[i].Substring(10), '\"');
                    try
                    {
                        content[i] = File.ReadAllText(content[i]);
                        File.WriteAllLines(filepath, content);
                    }
                    catch
                    {
                        Console.WriteLine($"The following file those not exist: {content[i]} ");
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
            List<string> roothPathPaths = new List<string>();
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$rootPath"))
                {
                    string path = basePath + Trim(content[i].Replace(". \"$rootPath\\", null), '\"');// да намери от коя папка  roothpath
                    roothPathPaths.Add(path);
                }
            }
            roothScriptPath(roothPathPaths, filepath, content, basePath);
        }
        /// <summary>
        /// замества roothPath(те винаги са от 1-3) и понеже всички имат scriptPath към Login програмата ще наследи само първият а на другите ще махне реда
        /// </summary>
        /// <param name="roothPathPaths"></param> лист на всички roothPath, които се използват
        /// <param name="filepath"></param>path на файл, който използваме в момента
        /// <param name="content"></param> текста, който ще добавим
        /// <param name="basePath"></param> това е главния path трябва ни специфично за roothPath, защото ще използваме изцяло друга папка
        public static void roothScriptPath(List<string> roothPathPaths, string filepath, string[] content, string basePath)
        {
            string combineText = "";//ще заменяме определна част от стринга и ще стане по бързо да се прави със стринг околкото с масив
            int i = 0;
            foreach (string path in roothPathPaths)
            {
                if (i == 0)//първи roothpath при него махаме само loggin реда 
                {
                    combineText = File.ReadAllText(path).Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                    i++;
                }
                else// всеки друг се махат и двата реда
                {
                    string text = File.ReadAllText(path).Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null).Replace(". \"$scriptPath\\Logging.ps1\"", null);
                    combineText += text;
                }
            }

            for (int j = 0; j < content.Length; j++)// от content маха всички roothpatov освен 1 който съдържа  scriptpath
            {
                if (content[j].Contains(". \"$rootPath") && i == 1)
                {
                    content[j] = combineText;
                    i++;
                }
                else if (content[j].Contains(". \"$rootPath") && i != 1)
                {
                    content[j] = null;
                }
            }
            basePath = basePath + "common\\Logging.ps1";
            for (int k = 0; k < content.Length; k++)// функция за scriptpath
            {
                if (content[k] != null)
                {
                    if (content[k].Contains(". \"$scriptPath"))
                    {
                        content[k] = content[k].Replace(". \"$scriptPath\\Logging.ps1\"", File.ReadAllText(basePath));
                    }
                }

            }
            File.WriteAllLines(filepath, content);
        }
        /// <summary>
        /// разлиаката му с другите методи е следната: има същатата функция като scriptPath, но има порблема на roothPath(повтаря се и редове се дублират)
        /// </summary>
        /// <param name="filepath"></param> path на файла, който използваме в момента
        /// <param name="fileContent"></param> текста на файла, който използваме
        /// <param name="path"></param> path от коя папка е файла
        public static void LocalScript(string filepath, string fileContent, string path)
        {
            string[] content = fileContent.Split('\r', '\n');
            List<string> localPathPaths = new List<string>();//всички файлове, които иамт  localscriptpath
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$LocalScriptPath"))
                {
                    string basePath = path + Trim(content[i].Substring(content[i].IndexOf('\\')), '\"');
                    localPathPaths.Add(basePath);
                }
            }
            localScripPath(localPathPaths, filepath, content, path);
        }
        /// <summary>
        /// преглежда всичките файлове с scriptpath от папкта и премахва scriptpath редовете и земста всеки uniqe scriptpath с текста, който трябва
        /// </summary>
        /// <param name="localPathPaths"></param> цсички пътища, които изпозлваме
        /// <param name="filepath"></param>path на файла, който използваме в момента
        /// <param name="content"></param>текста на файла, който използваме
        /// <param name="path"></param>path от коя папка е файла
        public static void localScripPath(List<string> localPathPaths, string filepath, string[] content, string path)
        {
            string combineText = "";
            int i = 0;

            foreach (string line in localPathPaths)
            {
                if (i == 0)
                {
                    combineText += File.ReadAllText(line).Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                    i++;
                }
                else
                {
                    string text = File.ReadAllText(line).Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null).Replace(". \"$scriptPath\\CommonVariables.ps1\"", null);
                    combineText += text;
                }
            }

            for (int j = 0; j < content.Length; j++)
            {
                if (content[j].Contains(". \"$LocalScriptPath") && i == 1)
                {
                    content[j] = combineText;
                    i++;
                }
                else if (content[j].Contains(". \"$LocalScriptPath") && i != 1)
                {
                    content[j] = null;
                }
            }
            string basePath = path + "\\CommonVariables.ps1";
            for (int k = 0; k < content.Length; k++)// фунцкия scriptpath
            {
                if (content[k] != null)
                {
                    if (content[k].Contains(". \"$scriptPath"))
                    {
                        content[k] = content[k].Replace(". \"$scriptPath\\CommonVariables.ps1\"", File.ReadAllText(basePath));
                    }
                }

            }
            File.WriteAllLines(filepath, content);
        }
        public string[] array = { "\"$rootPath\\", "\"$parentPath\\", "\"$parent\\", "\"$scriptPath\\", "\"$ourPath\\", "\"$LocalScriptPath\\" };

        //ZA RESHENIE V SCHEDULEtASK, WEBSERVICE I WINDOWSERVICE SE MAHAT REDOVETE ZA ROOTHPATH
        // poneje te nasledyavat cherz scriptpath drug ifle koito sudurja roothpath kum sushtie elementi
        // ako izpozlvame roothpath case vsichko shte raboti perfektno no ako go mahnem za da mmojem da chetem filovete po lesno(da nyamat mnogo "izlishni redove") togava se dublira mnogo roothpath
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
                                case "\"$ourPath\\":
                                    fileContent = fileContent.Replace("$ourPath =  (Get-Item $PSScriptRoot).FullName", null);
                                    ourPath(filepath, fileContent, path);
                                    break;
                                case "\"$LocalScriptPath\\":
                                    fileContent = fileContent.Replace("$LocalScriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                                    LocalScript(filepath, fileContent, path);
                                    break;
                                case "\"$parent\\":
                                    fileContent = fileContent.Replace("$parent =  (Get-Item $PSScriptRoot).Parent.FullName", null);
                                    parent(filepath, fileContent, path);
                                    break;
                                    //case "\"$rootPath\\"://raboti no slaga tolkova mnogo tekst che filovete ne se chetat
                                    //    fileContent = fileContent.Replace("$rootPath  = (Get-Item $PSScriptRoot).Parent.FullName", null);
                                    //    rootPath(filepath, fileContent, basePath);
                                    //    break;
                            }
                        }

                    }
                }
            }
        }
        // add new files for common virablees in every folder
        public void commonVariables(List<string> foldercontent)
        {
            foreach (string path in foldercontent)
            {
                List<string> valuesOfVariables = new List<string>();// list koito zapazva vsichki promenlivi, shte izpolzvame lista da ppreglejdame v vseki file i da gi mahame neshtata koit osa v nego
                Dictionary<string, int> keyValuePairs = new Dictionary<string, int>();// key= promenlivata koyato sme namerili value= kolko purti se poftarya
                int i = 0;//sledi kolko file ps1 sa v papkata
                foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// vsichki file-ve na vseki folder
                {
                    i++;
                    string[] content=File.ReadAllLines(filepath);
                    foreach(string line in content)
                    {
                        if (line.Contains("$Global:") == true)//proveryava za global promenlivi
                        {
                            try//opitva da dobavi promenlivata i ako veche ya ima uvelichava value s 1( ako nakraya value =i tova oznachava che go iam v vseki file i shte se dobavi v novia file)
                            {
                                keyValuePairs.Add(line, 1);
                            }
                            catch
                            {
                                keyValuePairs[line]++;
                            }
                        }
                    }
                }
                if (i > 1 && valuesOfVariables.Count>0)//ako ima poveche ot 1 file samo togava da suzdade variables 
                {
                    using (StreamWriter sw = new StreamWriter(path + "\\Variables.ps1"))
                    {
                        foreach (var item in keyValuePairs)
                        {
                            if (item.Value == i)
                            {
                                sw.WriteLine(item.Key);
                                valuesOfVariables.Add(item.Key);
                            }
                        }
                    }
                    //adding extend row for  every file for variables.ps1
                    foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// vsichki file-ve na vseki folder
                    {
                        if (filepath != path + "\\Variables.ps1")
                        {
                            string[] conten = File.ReadAllLines(filepath);
                            foreach (string item in valuesOfVariables)// vsichki promenlivi koito tryabva da se mahnat
                            {
                                conten = conten.Where(s => s != item).ToArray();
                            }

                            File.WriteAllLines(filepath, conten);
                        }
                    }
                    foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// vsichki file-ve na vseki folder
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