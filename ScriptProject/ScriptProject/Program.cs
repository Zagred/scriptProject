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
            
           //list ot listove s vseki folder i ptahofe v nego, taka shte vurti vseki folder po otdelno i shte resetvame dictonaryto da nyama poftorenie
            List<string> paths = new List<string>();
            Dictionary<string,string> pathNames= new Dictionary<string,string>();// dictonary kudeto se zapazva path kato key i koi file tryabva da se pastne kato value
            Dictionary<string,string>pathValues= new Dictionary<string,string>(); // dictorny kudeto key=imae na file i value=texta koito ima
            string basePath = @"C:\Users\paco\Desktop\Project\scriptProject\";//uses in every path below

            //chast s otkrivane na common virable v vsichki failove
            //dictonary key-file value-vsichki variables
            //sravnyava koi variables se povtaryat v vseki file i tozi koito se povtarya v vsichki se pravi nov za nego i se dobavya script path za nego v drugite filove


            //cadcloud
            /*
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\cadcloud");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\cadcloud\Test");
            */
            //common
            paths.Add(basePath+@"common");
            /*
            //gearsix
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\gearsix");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\gearsix\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\gearsix\Test");
            //loggedin
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\loggedin");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\loggedin\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\loggedin\Life\LifeFromPreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\loggedin\Life\LifeFromTrunk");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\loggedin\PreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\loggedin\Test");
            //office.usd
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\Office.USD");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\Office.USD\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\Office.USD\Test");
            //reefr
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\reefr");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\reefr\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\reefr\Life\LifeFromPreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\reefr\Life\LifeFromTrunk");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\reefr\PreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\reefr\Test");
            //safeco
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\safeco");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\safeco\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\safeco\Life\LifeFromPreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\safeco\Life\LifeFromTrunk");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\safeco\PreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\safeco\Test");
            //shooger
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger\HotFix");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger\Life\LifeFromHotFix");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger\Life\LifeFromPreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger\Life\LifeFromTrunk");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger\PreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\shooger\Test");
            //sugarshackanimation
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\SugarshackAnimation");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\SugarshackAnimation\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\SugarshackAnimation\Test");
            //test
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\Test");
            //uncut
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut\Life\LifeFromPreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut\Life\LifeFromStage");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut\Life\LifeFromTrunk");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut\PreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut\Stage");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\uncut\Test");
            //usdirectory
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory\HotFix");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory\Life");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory\Life\LifeFromHotFix");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory\Life\LifeFromPreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory\Life\LifeFromTrunk");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory\PreLife");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\usdirectory\Test");
            */
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
                            if (lineRead.Contains(". \"$scriptPath\\") == true)
                            {
                                Console.WriteLine(file);
                                string search = lineRead;
                                string code = search.Substring(15);
                                code = code.Trim('"');
                                Console.WriteLine(code);
                                try
                                {
                                    pathNames.Add(file, code);
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
            }
            //pathName key=path na fail ,value=koi file tryabva da se dobavi
            //pathValues key=ime na fail , value=content na file

            foreach (KeyValuePair<string, string> item in pathNames)
            {
                string text = File.ReadAllText(item.Key);
                text = text.Replace(". \"$scriptPath\\" + item.Value, pathValues[item.Value]);
                string path = System.IO.Path.Combine(@"C:\Users\paco\Desktop\", item.Key.Substring(item.Key.LastIndexOf('\\')+1));
                File.WriteAllText(path, text);
            }             
            /*
            foreach (var path in pathNames)
            {
                Console.WriteLine(path);
            }
            foreach (var path in pathValues)
            {
                Console.WriteLine(path.Key);
            }*/
        }
    }
}
