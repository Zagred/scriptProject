using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using HtmlAgilityPack;

namespace ConsoleApp7
{
    class Program
    {
        static void Main(string[] args)
        {
            string shoogerPath = @"C:\Users\ppandev\Desktop\Shooger.csv";
            string usdPath = @"C:\Users\ppandev\Desktop\UsD.csv";
            string save = @"C:\Users\ppandev\Desktop\NotMatched.csv";
            var csv = new StringBuilder();


            using (StreamReader shooger = new StreamReader(shoogerPath))
            {
                string currentLine;
                while ((currentLine = shooger.ReadLine()) != null)
                {
                    try {

                            while ((lineRead = reader.ReadLine()) != null)
                            {
                                //ScriptPath (working)
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
                                //ScriptPath (working)

                                //ParentPath (not working)
                                
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
                                //ParentPath (not working)

                            }
                        }
                        try
                        {
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

                        //ParentPath (not working)
                        
                        foreach (KeyValuePair<string, string> item in PpathNames)
                        {
                            string text = File.ReadAllText(item.Key);
                            text= text.Replace("$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName", null);
                            text = text.Replace(". \"$parentPath\\" + item.Value, pathValues[item.Value]);
                            string pathSave = System.IO.Path.Combine(path, item.Key.Substring(item.Key.LastIndexOf('\\') + 1));
                            File.WriteAllText(pathSave, text);
                        }
                        
                        //ParentPath (not working)
                    }
                    catch { }

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
            File.WriteAllText(save, csv.ToString());


        }
    }
}
//part2 idea: zabpazva vsichki v string(obshtoto) i sled tova suzdava fail s nekvo ima s danni tozi string preglejdat se failvoete pak i replace na vseki file s script ili parent path