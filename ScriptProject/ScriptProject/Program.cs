using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace ScriptProject
{
    internal class Program
    {
        static void Main(string[] args)
        {
               
            List<string> paths = new List<string>();
            //scriptPath
            Dictionary<string,string> pathNames= new Dictionary<string,string>();// dictonary kudeto se zapazva path kato key i koi file tryabva da se pastne kato value
            Dictionary<string,string>pathValues= new Dictionary<string,string>(); // dictorny kudeto key=imae na file i value=texta koito ima
            string basePath = @"C:\Users\paco\Desktop\scripts\";//osven che se polzva ot kude da chete failove se izpozlva i kude da gi zapisva zashtoto realno promenya faila 
            //parentPath
            Dictionary<string, string> PpathNames = new Dictionary<string, string>();// dictonary kudeto se zapazva path kato key i koi file tryabva da se pastne kato value
            Dictionary<string, string> PpathValues = new Dictionary<string, string>(); // dictorny kudeto key=imae na file i value=texta koito ima
            //cadcloud

            //NEED TO DELETE ROW BEFORE SCRIPTPATH {$scriptPath  = (Get-Item $PSScriptRoot).FullName}

            //paths.Add(basePath+@"cadcloud");
            //paths.Add(basePath+@"cadcloud\Test");

            //common
            paths.Add(basePath+@"common");
            
            //gearsix         
            paths.Add(basePath+@"gearsix\Life");
            paths.Add(basePath+@"gearsix\Test");
            paths.Add(basePath + @"gearsix");
            //loggedin
            paths.Add(basePath+@"loggedin\Life");
            paths.Add(basePath+@"loggedin\Life\LifeFromPreLife");
            paths.Add(basePath+@"loggedin\Life\LifeFromTrunk");
            paths.Add(basePath+@"loggedin\PreLife");
            paths.Add(basePath+@"loggedin\Test");
            paths.Add(basePath + @"loggedin");
            //office.usd
            paths.Add(basePath+@"Office.USD\Life");
            paths.Add(basePath+@"Office.USD\Test");
            paths.Add(basePath + @"Office.USD");
            //reefr
            paths.Add(basePath+@"reefr\Life");
            paths.Add(basePath+@"reefr\Life\LifeFromPreLife");
            paths.Add(basePath+@"reefr\Life\LifeFromTrunk");
            paths.Add(basePath+@"reefr\PreLife");
            paths.Add(basePath+@"reefr\Test");
            paths.Add(basePath + @"reefr");
            //safeco
            paths.Add(basePath+@"safeco\Life");
            paths.Add(basePath+@"safeco\Life\LifeFromPreLife");
            paths.Add(basePath+@"safeco\Life\LifeFromTrunk");
            paths.Add(basePath+@"safeco\PreLife");
            paths.Add(basePath+@"safeco\Test");
            paths.Add(basePath + @"safeco");
            //shooger
            paths.Add(basePath+@"shooger\HotFix");
            paths.Add(basePath+@"shooger\Life");
            paths.Add(basePath+@"shooger\Life\LifeFromHotFix");
            paths.Add(basePath+@"shooger\Life\LifeFromPreLife");
            paths.Add(basePath+@"shooger\Life\LifeFromTrunk");
            paths.Add(basePath+@"shooger\PreLife");
            paths.Add(basePath+@"shooger\Test");
            paths.Add(basePath + @"shooger");
            //sugarshackanimation
            paths.Add(basePath+@"SugarshackAnimation\Life");
            paths.Add(basePath+@"SugarshackAnimation\Test");
            paths.Add(basePath + @"SugarshackAnimation");
            //test
            paths.Add(basePath+@"Test");
            //uncut
            paths.Add(basePath+@"uncut\Life");
            paths.Add(basePath+@"uncut\Life\LifeFromPreLife");
            paths.Add(basePath+@"uncut\Life\LifeFromStage");
            paths.Add(basePath+@"uncut\Life\LifeFromTrunk");
            paths.Add(basePath+@"uncut\PreLife");
            paths.Add(basePath+@"uncut\Stage");
            paths.Add(basePath+@"uncut\Test");
            paths.Add(basePath + @"uncut");
            //usdirectory
            paths.Add(basePath+@"usdirectory\HotFix");
            paths.Add(basePath+@"usdirectory\Life");
            paths.Add(basePath+@"usdirectory\Life\LifeFromHotFix");
            paths.Add(basePath+@"usdirectory\Life\LifeFromPreLife");
            paths.Add(basePath+@"usdirectory\Life\LifeFromTrunk");
            paths.Add(basePath+@"usdirectory\PreLife");
            paths.Add(basePath+@"usdirectory\Test");
            paths.Add(basePath + @"usdirectory");

            foreach (var path in paths)
            {
                foreach (string file in Directory.EnumerateFiles(path, "*.ps1"))
                {
                    using (var reader = new StreamReader(file))
                    {
                        string lineRead;
                        while ((lineRead = reader.ReadLine()) != null)
                        {
                            //Console.WriteLine( lineRead);
                            if (lineRead.Contains(". \"$scriptPath\\") == true  )
                            {
                               // Console.WriteLine(file);
                                string search = lineRead;
                                string code = search.Substring(15);
                                code = code.Trim('"');
                               // Console.WriteLine(code);
                                try
                                {
                                    pathNames.Add(file, code);
                                }
                                catch { }

                            }else if(lineRead.Contains(". \"$parentPath\\") == true)
                            {
                               // Console.WriteLine(file);
                                string search = lineRead;
                                string code = search.Substring(15);
                                code = code.Trim('"');
                                //Console.WriteLine(code);
                                try
                                {
                                    PpathNames.Add(file, code);
                                }
                                catch { }
                            }
                        }
                    }
                    try
                    {
                        pathValues.Add(file.Substring(path.Length+1), File.ReadAllText(file));
                    }catch { }                   
                }

                foreach (KeyValuePair<string, string> item in pathNames)
                {
                    string text = File.ReadAllText(item.Key);
                    text = text.Replace(". \"$scriptPath\\" + item.Value, pathValues[item.Value]);
                    //string pathSave = System.IO.Path.Combine(@"C:\Users\paco\Desktop\", item.Key.Substring(item.Key.LastIndexOf('\\') + 1));
                    string pathSave = System.IO.Path.Combine(path, item.Key.Substring(item.Key.LastIndexOf('\\') + 1));
                    File.WriteAllText(pathSave, text);
                    Console.WriteLine(pathSave);
                }
                /*
                foreach (KeyValuePair<string, string> item in PpathNames)
                {
                    string text = File.ReadAllText(item.Key);
                    text = text.Replace(". \"$parentPath\\" + item.Value, pathValues[item.Value]);
                    //string pathSave = System.IO.Path.Combine(@"C:\Users\paco\Desktop\", item.Key.Substring(item.Key.LastIndexOf('\\') + 1));
                    string pathSave = System.IO.Path.Combine(path, item.Key.Substring(item.Key.LastIndexOf('\\') + 1));
                    File.WriteAllText(pathSave, text);
                }*/
                pathNames.Clear();
                pathValues.Clear();
            }
            
           
        }
    }
}
