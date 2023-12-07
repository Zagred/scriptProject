using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ps1FilesLibrary;
using static System.Net.Mime.MediaTypeNames;
namespace ScriptProject
{
    internal class Program
    {

        //method to add all paths in folders
        private Dictionary<string, List<string>> Init(string basePath)
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
            gearsix.Add(basePath + @"gearsix\Life");
            gearsix.Add(basePath + @"gearsix\Test");
            gearsix.Add(basePath + @"gearsix");
            folderContent.Add(basePath + @"gearsix", gearsix);

            List<string> loggedin = new List<string>();
            loggedin.Add(basePath + @"loggedin\Life");
            loggedin.Add(basePath + @"loggedin\Life\LifeFromPreLife");
            loggedin.Add(basePath + @"loggedin\Life\LifeFromTrunk");
            loggedin.Add(basePath + @"loggedin\PreLife");
            loggedin.Add(basePath + @"loggedin\Test");
            loggedin.Add(basePath + @"loggedin");
            folderContent.Add(basePath + @"loggedin", loggedin);

            List<string> Office = new List<string>();
            Office.Add(basePath + @"Office.USD\Life");
            Office.Add(basePath + @"Office.USD\Test");
            Office.Add(basePath + @"Office.USD");
            folderContent.Add(basePath + @"Office.USD", Office);

            List<string> reefr = new List<string>();
            reefr.Add(basePath + @"reefr\Life");
            reefr.Add(basePath + @"reefr\Life\LifeFromPreLife");
            reefr.Add(basePath + @"reefr\Life\LifeFromTrunk");
            reefr.Add(basePath + @"reefr\PreLife");
            reefr.Add(basePath + @"reefr\Test");
            reefr.Add(basePath + @"reefr");
            folderContent.Add(basePath + @"reefr", reefr);

            List<string> safeco = new List<string>();
            safeco.Add(basePath + @"safeco\Life");
            safeco.Add(basePath + @"safeco\Life\LifeFromPreLife");
            safeco.Add(basePath + @"safeco\Life\LifeFromTrunk");
            safeco.Add(basePath + @"safeco\PreLife");
            safeco.Add(basePath + @"safeco\Test");
            safeco.Add(basePath + @"safeco");
            folderContent.Add(basePath + @"safeco", safeco);

            List<string> shooger = new List<string>();
            shooger.Add(basePath + @"shooger\HotFix");
            shooger.Add(basePath + @"shooger\Life");
            shooger.Add(basePath + @"shooger\Life\LifeFromHotFix");
            shooger.Add(basePath + @"shooger\Life\LifeFromPreLife");
            shooger.Add(basePath + @"shooger\Life\LifeFromTrunk");
            shooger.Add(basePath + @"shooger\PreLife");
            shooger.Add(basePath + @"shooger\Test");
            shooger.Add(basePath + @"shooger");
            folderContent.Add(basePath + @"shooger", shooger);

            List<string> SugarshackAnimation = new List<string>();
            SugarshackAnimation.Add(basePath + @"SugarshackAnimation\Life");
            SugarshackAnimation.Add(basePath + @"SugarshackAnimation\Test");
            SugarshackAnimation.Add(basePath + @"SugarshackAnimation");
            folderContent.Add(basePath + @"SugarshackAnimation", SugarshackAnimation);

            List<string> Test = new List<string>();
            Test.Add(basePath + @"Test");
            folderContent.Add(basePath + @"Test", Test);

            List<string> uncut = new List<string>();
            uncut.Add(basePath + @"uncut\Life");
            uncut.Add(basePath + @"uncut\Life\LifeFromPreLife");
            uncut.Add(basePath + @"uncut\Life\LifeFromStage");
            uncut.Add(basePath + @"uncut\Life\LifeFromTrunk");
            uncut.Add(basePath + @"uncut\PreLife");
            uncut.Add(basePath + @"uncut\Stage");
            uncut.Add(basePath + @"uncut\Test");
            uncut.Add(basePath + @"uncut");
            folderContent.Add(basePath + @"uncut", uncut);

            List<string> usdirectory = new List<string>();
            usdirectory.Add(basePath + @"usdirectory\HotFix");
            usdirectory.Add(basePath + @"usdirectory\Life");
            usdirectory.Add(basePath + @"usdirectory\Life\LifeFromHotFix");
            usdirectory.Add(basePath + @"usdirectory\Life\LifeFromPreLife");
            usdirectory.Add(basePath + @"usdirectory\Life\LifeFromTrunk");
            usdirectory.Add(basePath + @"usdirectory\PreLife");
            usdirectory.Add(basePath + @"usdirectory\Test");
            usdirectory.Add(basePath + @"usdirectory");
            folderContent.Add(basePath + @"usdirectory", usdirectory);

            return folderContent;
        }
        static void Main(string[] args)
        {
            //global path MUST BE CHANGE FOR OTHER DEVICES
            string basePath = @"C:\Users\paco\Desktop\scripts\";

            Program obj = new Program();

            Dictionary<string, List<string>> folderContent = obj.Init(basePath);

            var ps1 = new Ps1Files();

            ps1.successorRowSearcher(folderContent);
            ps1.commonVariables(folderContent);
        }
    }
}