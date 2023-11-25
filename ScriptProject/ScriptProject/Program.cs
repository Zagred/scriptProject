using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScriptProject
{
    internal class Program
    {
        static void Main(string[] args)
        {
            List<string> paths = new List<string>();
            //cadcloud
            /*
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\cadcloud");
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\cadcloud\Test");
            */
            //common
            paths.Add(@"C:\Users\paco\Desktop\Project\scriptProject\common");
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
                    using (var reader=new StreamReader(file))
                    {
                        string lineRead;
                        while ((lineRead = reader.ReadLine()) != null)
                        {                    
                            Console.WriteLine( lineRead);
                            if (lineRead.Contains(". \"$scriptPath\\")==true)
                            {
                                Console.WriteLine(file);
                                // dictonary kudeto se zapazva path kato key i koi file tryabva da se pastne kato value
                            }
                        }
                    }
                }
            }
        }
    }
}
