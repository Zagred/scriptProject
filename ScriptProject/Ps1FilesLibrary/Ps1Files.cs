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
        /*
         todo:
        1.da mina prez vsichki failove i da vida koi afailove tryabva da se mahant i da sa v otdelni funkcii ROOTHPATH. SCRIPTPATH, PARENTPATH, LOCALSCRIPPATH,("$ourPath "$parent?)(done)
        2.da zameni kodovete kato glodea po vajnost PURVO ROOTHPATH,PARENTPATH,SCRIPPATH,LOCALSCRIPTPATH
        3.da se suzdade file commonvariables za vseki foulder kudeto subira vsichki GLOBAL  promenlivi i da se nasledyava ot vseki drug file s SCRIPTPATH
         */
        //trim function zashtoto default trima ne raboteshe
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
        //change summary
        /// <summary>
        /// 3-te metoda rabotat kato izpolzvam fileContent da mahant nasledyavashtite redove i da trimne file-a koito nasledya i go obedinayva s path i go dobavya v folecontet i go zapisva kato nov file
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="path"></param> path ot koya papka e file
        public static void ourPath(string filepath, string fileContent,string path)
        {
            string[] content=fileContent.Split('\r','\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$ourPath"))
                {
                    content[i] = path + Trim(content[i].Substring(11), '\"');
                    content[i]=File.ReadAllText(content[i]);
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
                    content[i] = path+Trim(content[i].Substring(content[i].IndexOf('\\')), '\"');
                    content[i] = File.ReadAllText(content[i]);
                }
            }
            File.WriteAllLines(filepath, content);
        }
        public static void LocalScriptPath(string filepath, string fileContent, string path)
        {
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$LocalScriptPath"))
                {
                    content[i] = path + Trim(content[i].Substring(content[i].IndexOf('\\')), '\"');
                    content[i] = File.ReadAllText(content[i]);
                }
            }
            File.WriteAllLines(filepath, content);
        }
        /// <summary>
        /// metoda ne raboti po razlichno ot drugite edinstvenata razlika e che  izpolzva base path a ne patha na papkata
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="basePath"></param> tova e glavnia ni path na nashia komp tryabva ni specifichno za rootPath poradi izpozlvaneto na izcyalo druga papka
        public static void rootPath(string filepath, string fileContent, string basePath)
        {
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$rootPath"))
                {
                    content[i] = basePath + Trim(content[i].Substring(content[i].IndexOf('\\')), '\"');
                    content[i] = File.ReadAllText(content[i]);
                }
            }
            File.WriteAllLines(filepath, content);
        }
        /// <summary>
        /// poneje parent path vzima file po nazad ot segashanta papka prosto mahame edna papka i tova ni e noviat path
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="path"></param> path ot koya papka e file
        public static void parentPath(string filepath, string fileContent, string path)
        {
            path=path.Substring(0, path.LastIndexOf('\\'));
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$parentPath"))
                {
                    content[i] = path + Trim(content[i].Substring(14), '\"');
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
        public  Dictionary<string, List <string>> files= new Dictionary<string,List<string>>();
        //za . "$ourPath\ primer otvori C:\Users\paco\Desktop\scripts\reefr\Life\LifeFromPreLife
        // za . "$LocalScriptPath otvori  C:\Users\paco\Desktop\scripts\shooger\HotFix
        // 2 idei za fix
        //1: filovete v common da im se napravi scriptPath na rukaza da moje da ima loop za root>parent>script,our,local
        //2: da se hardcodne po nyakuv nachin da napravi samo i edinstveno na common file script purvo i da si produlji natatuk normalno
        //3(random):da prekrusta papkata taka che da  e purva i taka shte izpozlva podredbata si normalno MAI NE E SIGORNO
        public string[] array = { "\"$rootPath\\", "\"$parentPath\\",, "\"$scriptPath\\",  "\"$ourPath\\", "\"$LocalScriptPath\\" };
        public void successorRowSearcher(List<string> folderContent,string basePath)
        {
            List<string> list = new List<string>();// list is used to caontains wich paths are used in array
            foreach (string path in folderContent)//path na vseki folder
            {
                list.Clear();
                foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// vsichki file-ve na vseki folder
                {
                    string fileContent = File.ReadAllText(filepath);

                    for (int i = 0; i < array.Length; i++)//proveryava prez glavnite path funkcii vseki file koe sudurja 
                    {
                        if (fileContent.Contains(array[i]) == true)
                        {
                            Console.WriteLine(array[i]);
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
                                case "\"$ourPath\\":
                                    fileContent = fileContent.Replace("$ourPath =  (Get-Item $PSScriptRoot).FullName", null);
                                    ourPath(filepath, fileContent, path);
                                    break;
                                case "\"$LocalScriptPath\\":
                                    fileContent = fileContent.Replace("$LocalScriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                                    LocalScriptPath(filepath, fileContent, path);
                                    break;
                            }
                        }
                    }
                }
            }
        }
    }

    // add new files for common virablees in every folder
    /*
    public void commonVariables(Dictionary<string, List<string>> folderContent)
    {
        Dictionary<string, int> keyValuePairs = new Dictionary<string, int>();
        foreach (KeyValuePair<string, List<string>> file in folderContent)
        {
            foreach (string path in file.Value)
            {
                //function to find which rows are variables
                int i = 0;
                foreach (string filepath in Directory.GetFiles(path, "*.ps1"))
                {
                    i++;
                    string[] readText = File.ReadAllLines(filepath);
                    foreach (string s in readText)
                    {
                        if (s.Contains("$Global:") == true && (s[0] == '#' || s[0] == '$') && s[1] >= 33)
                        {
                            try
                            {
                                keyValuePairs.Add(s, 1);
                            }
                            catch
                            {
                                keyValuePairs[s]++;
                            }
                        }
                    }
                }
                //adding variables used in every files in selected folder
                using (StreamWriter write = new StreamWriter(Path.Combine(path + "\\Variables.ps1")))
                {
                    foreach (var item in keyValuePairs)
                    {
                        if (item.Value == i)
                        {
                            write.WriteLine(item.Key);
                        }
                    }
                }

                keyValuePairs.Clear();

                //adding extend row for  every file for variables.ps1
                foreach (string filePath in Directory.GetFiles(path, "*.ps1"))
                {
                    if (filePath.Substring(path.Length) != "\\Variables.ps1" && new FileInfo(Path.Combine(path, "Variables.ps1")).Length != 0)
                    {
                        string[] lines = File.ReadAllLines(filePath)
                            .Where(line => !string.IsNullOrWhiteSpace(line) && !line.TrimStart().StartsWith("#"))
                            .ToArray();

                        string scriptPathLine = "$scriptPath  = (Get-Item $PSScriptRoot).FullName";
                        string variablesLine = ". \"$scriptPath\\Variables.ps1\"";
                        List<string> updatedLines = new List<string> { scriptPathLine, variablesLine };
                        updatedLines.AddRange(lines);

                        File.WriteAllLines(filePath, updatedLines);
                    }
                    else
                    {
                        string[] lines = File.ReadAllLines(filePath).Where(line => !string.IsNullOrWhiteSpace(line) && !line.TrimStart().StartsWith("#")).ToArray();
                        File.WriteAllLines(filePath, lines);
                    }
                }
                // remove used viruables in other files
                foreach (string filePath in Directory.GetFiles(path, "*.ps1"))
                {
                    if (filePath.Substring(path.Length) != "\\Variables.ps1")
                    {
                        string[] lines = File.ReadAllLines(Path.Combine(path + "\\Variables.ps1"));
                        string[] linesToKeep = File.ReadLines(filePath).ToArray();
                        for (int j = 0; j < lines.Length; j++)
                        {
                            linesToKeep = linesToKeep.Where(line => line != lines[j]).ToArray();
                        }
                        File.WriteAllLines(filePath, linesToKeep);
                    }
                }
                //deleting empty variables.ps1 files
                foreach (string filePath in Directory.GetFiles(path, "Variables.ps1"))
                {
                    if (new FileInfo(filePath).Length == 0)
                    {
                        File.Delete(filePath);
                    }
                }
            }
        }
    }*/

}
