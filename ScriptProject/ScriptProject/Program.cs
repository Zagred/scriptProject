using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace ScriptProject
{
    internal class Program
    {
        static void Main(string[] args)
        {

            Dictionary<string, List<string>> folderContent = new Dictionary<string, List<string>>();

            List<string> cadcloud = new List<string>();
            cadcloud.Add(basePath + @"cadcloud");
            cadcloud.Add(basePath + @"cadcloud\Test");
            folderContent.Add(basePath + @"cadcloud", cadcloud);

            List<string> common = new List<string>();
            common.Add(basePath + @"common");
            folderContent.Add(basePath + @"common", common);

            List<string> gearsix = new List<string>();
            gearsix.Add(basePath + @"gearsix");
            gearsix.Add(basePath + @"gearsix\Life");
            gearsix.Add(basePath + @"gearsix\Test");
            folderContent.Add(basePath + @"gearsix", gearsix);

            List<string> loggedin = new List<string>();
            loggedin.Add(basePath + @"loggedin");
            loggedin.Add(basePath + @"loggedin\Life");
            loggedin.Add(basePath + @"loggedin\Life\LifeFromPreLife");
            loggedin.Add(basePath + @"loggedin\Life\LifeFromTrunk");
            loggedin.Add(basePath + @"loggedin\PreLife");
            loggedin.Add(basePath + @"loggedin\Test");
            folderContent.Add(basePath + @"loggedin", loggedin);

            List<string> reefr = new List<string>();
            reefr.Add(basePath + @"reefr");
            reefr.Add(basePath + @"reefr\Life");
            reefr.Add(basePath + @"reefr\Life\LifeFromPreLife");
            reefr.Add(basePath + @"reefr\Life\LifeFromTrunk");
            reefr.Add(basePath + @"reefr\PreLife");
            reefr.Add(basePath + @"reefr\Test");
            folderContent.Add(basePath + @"reefr", reefr);

            List<string> safeco = new List<string>();
            safeco.Add(basePath + @"safeco");
            safeco.Add(basePath + @"safeco\Life");
            safeco.Add(basePath + @"safeco\Life\LifeFromPreLife");
            safeco.Add(basePath + @"safeco\Life\LifeFromTrunk");
            safeco.Add(basePath + @"safeco\PreLife");
            safeco.Add(basePath + @"safeco\Test");
            folderContent.Add(basePath + @"safeco", safeco);

            List<string> shooger = new List<string>();
            shooger.Add(basePath + @"shooger");
            shooger.Add(basePath + @"shooger\HotFix");
            shooger.Add(basePath + @"shooger\Life");
            shooger.Add(basePath + @"shooger\Life\LifeFromHotFix");
            shooger.Add(basePath + @"shooger\Life\LifeFromPreLife");
            shooger.Add(basePath + @"shooger\Life\LifeFromTrunk");
            shooger.Add(basePath + @"shooger\PreLife");
            shooger.Add(basePath + @"shooger\Test");
            folderContent.Add(basePath + @"shooger", shooger);

            List<string> SugarshackAnimation = new List<string>();
            SugarshackAnimation.Add(basePath + @"SugarshackAnimation");
            SugarshackAnimation.Add(basePath + @"SugarshackAnimation\Life");
            SugarshackAnimation.Add(basePath + @"SugarshackAnimation\Test");
            folderContent.Add(basePath + @"SugarshackAnimation", SugarshackAnimation);

            List<string> Test = new List<string>();
            Test.Add(basePath + @"Test");
            folderContent.Add(basePath + @"Test", Test);

            List<string> uncut = new List<string>();
            uncut.Add(basePath + @"uncut");
            uncut.Add(basePath + @"uncut\Life");
            uncut.Add(basePath + @"uncut\Life\LifeFromPreLife");
            uncut.Add(basePath + @"uncut\Life\LifeFromStage");
            uncut.Add(basePath + @"uncut\Life\LifeFromTrunk");
            uncut.Add(basePath + @"uncut\PreLife");
            uncut.Add(basePath + @"uncut\Stage");
            uncut.Add(basePath + @"uncut\Test");
            folderContent.Add(basePath + @"uncut", uncut);

            List<string> usdirectory = new List<string>();
            usdirectory.Add(basePath + @"usdirectory");
            usdirectory.Add(basePath + @"usdirectory\HotFix");
            usdirectory.Add(basePath + @"usdirectory\Life");
            usdirectory.Add(basePath + @"usdirectory\Life\LifeFromHotFix");
            usdirectory.Add(basePath + @"usdirectory\Life\LifeFromPreLife");
            usdirectory.Add(basePath + @"usdirectory\Life\LifeFromTrunk");
            usdirectory.Add(basePath + @"usdirectory\PreLife");
            usdirectory.Add(basePath + @"usdirectory\Test");
            folderContent.Add(basePath + @"usdirectory", usdirectory);

            return folderContent;
        }
        //
        
        static void Main(string[] args)
        {

            //da sa v otdelen klas ili inalicializirat
            //da napravi i funkciite v novi klasove
            //da probvam da go naprava s nova nahcin

            //global path MUST BE CHANGE FOR OTHER DEVICES
            string basePath = @"C:\Users\paco\Desktop\scripts\";

            //scriptPath key=path of file value=which file need to be added
            Dictionary<string, string> pathNames = new Dictionary<string, string>();

            //parentPath key=path of file value=which file need to be added
            Dictionary<string, string> PpathNames = new Dictionary<string, string>();

            //key=name of file, value=content of file
            Dictionary<string, string> pathValues = new Dictionary<string, string>();

            Dictionary<string, List<string>> folderContent=Init(basePath);
            foreach (KeyValuePair<string, List<string>> file in folderContent)
            {
                foreach (string path in file.Value)
                {
                    foreach (string filepath in Directory.GetFiles(path, "*.ps1"))
                    {
                        using (var reader = new StreamReader(filepath))
                        {
                            string lineRead;

                            while ((lineRead = reader.ReadLine()) != null)
                            {
                                //ScriptPath 
                                if (lineRead.Contains(". \"$scriptPath\\") == true)
                                {
                                    string search = lineRead;
                                    string code = search.Substring(15);
                                    code = code.Trim('"').Trim('\\');
                                    try
                                    {
                                        pathNames.Add(filepath, code);
                                    }
                                    catch { }

                                }
                                //ScriptPath 

                                //ParentPath                              
                                if (lineRead.Contains(". \"$parentPath\\") == true)
                                {
                                    string search = lineRead;
                                    string code = search.Substring(15);
                                    code = code.Trim('"').Trim('\\');
                                    try
                                    {
                                        PpathNames.Add(filepath, code);
                                    }
                                    catch { }
                                }
                                //ParentPath 
                            }
                        }
                        try
                        {
                            string[] readText = File.ReadAllLines(filepath);

                            File.WriteAllText(filepath, String.Empty);

                            using (StreamWriter writer = new StreamWriter(filepath))
                            {
                                foreach (string s in readText)
                                {
                                    if (s.Contains("#") == false)
                                    {
                                        writer.WriteLine(s);
                                    }
                                    else if (s.Contains("$Global:") == true && s[0] == '#')
                                    {
                                        writer.WriteLine(s.Replace("#", string.Empty));
                                    }
                                }
                            }
                            pathValues.Add(filepath.Substring(path.Length + 1), File.ReadAllText(filepath));
                        }
                        catch { }
                    }
                    //ScriptPath (working)
                    try
                    {
                        foreach (KeyValuePair<string, string> item in pathNames)
                        {
                            string text = File.ReadAllText(item.Key);
                            text = text.Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                            text = text.Replace(". \"$scriptPath\\" + item.Value, pathValues[item.Value]);
                            string pathSave = System.IO.Path.Combine(path, item.Key.Substring(item.Key.LastIndexOf('\\') + 1));
                            File.WriteAllText(pathSave, text);
                        }

                        //ScriptPath (working)

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

                }
                Console.WriteLine("---------------------");
                foreach (KeyValuePair<string, string> item in PpathNames)
                {
                    Console.WriteLine(item);
                }
                Console.WriteLine();
                foreach (KeyValuePair<string, string> item in pathNames)
                {
                    Console.WriteLine(item);
                }
                Console.WriteLine( );
                foreach (var item in pathValues)
                {
                    Console.WriteLine(item.Key);
                }
                pathNames.Clear();
                PpathNames.Clear();
                pathValues.Clear();
            }
        }
    }
}