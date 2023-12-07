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
        //findign rows with script and parent paths in files
        public void successorRowSearcher(Dictionary<string, List<string>> folderContent)
        {
            //scriptPath key=path of file value=which file need to be added
            Dictionary<string, string> pathNames = new Dictionary<string, string>();

            //parentPath key=path of file value=which file need to be added
            Dictionary<string, string> PpathNames = new Dictionary<string, string>();

            //key=name of file, value=content of file
            Dictionary<string, string> pathValues = new Dictionary<string, string>();

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
                }

                //ScriptPath + ParentPath replacement
                try
                {
                    foreach (KeyValuePair<string, string> item in PpathNames)
                    {
                        string text = File.ReadAllText(item.Key);
                        text = text.Replace("$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName", null);
                        text = text.Replace(". \"$parentPath\\" + item.Value, pathValues[item.Value]);
                        File.WriteAllText(item.Key, text);
                    }
                    foreach (KeyValuePair<string, string> item in pathNames)
                    {
                        string text = File.ReadAllText(item.Key);
                        text = text.Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                        text = text.Replace(". \"$scriptPath\\" + item.Value, pathValues[item.Value]);
                        File.WriteAllText(item.Key, text);
                    }
                }
                catch { }
                //ScriptPath + ParentPath replacement

                pathNames.Clear();
                PpathNames.Clear();
                pathValues.Clear();
            }
        }

        // add new files for common virablees in every folder
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
        }
    }
}
