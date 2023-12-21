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
        2.da zameni kodovete kato glodea po vajnost PURVO ROOTHPATH,PARENTPATH,SCRIPPATH,LOCALSCRIPTPATH(done BEZ ROOTH PATH)
        3.da se suzdade file  za vseki foulder kudeto subira vsichki GLOBAL  promenlivi i da se nasledyava ot vseki drug file s SCRIPTPATH(done no bez posochenite pathove)
         */
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
        public static string[] RemoveComments(string[] content)
        {
             //string indexToRemove = "#";
             //content=content.Where(x => x.Contains(indexToRemove)==false).ToArray();//maha vseki red koito sudurja #
            content = content.Where(arg => !string.IsNullOrWhiteSpace(arg)).ToArray();//maha vseki red koito ne sudurja nishto
            return content;
        }
        /// <summary>
        /// 3-te metoda rabotat kato izpolzvam fileContent da mahant nasledyavashtite redove i da trimne file-a koito nasledya i go obedinayva s path i go dobavya v folecontet i go zapisva kato nov file
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="path"></param> path ot koya papka e file
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
            string[] contentWithOutDuplicate = RemoveComments(content);
            File.WriteAllLines(filepath, contentWithOutDuplicate);
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
            string[] contentWithOutDuplicate = RemoveComments(content);
            File.WriteAllLines(filepath, contentWithOutDuplicate);
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
            string[] contentWithOutDuplicate = RemoveComments(content);
            File.WriteAllLines(filepath, contentWithOutDuplicate);
        }
        /// <summary>
        /// metoda ne raboti po razlichno ot drugite edinstvenata razlika e che  izpolzva base path a ne patha na papkata
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="basePath"></param> tova e glavnia ni path na nashia komp tryabva ni specifichno za rootPath poradi izpozlvaneto na izcyalo druga papka
        // da vzema 3te koda da vida kakvo e obshtoto v tyah (tova shte e login file) i da go mahan ot 2 i 3tia file i da go ostava samo v 1via i da gi zapisha taka da izpolzvame dictionaryto key pozicia value teksta
        public static void rootPath(string filepath, string fileContent, string basePath)
        {
            string[] content = fileContent.Split('\r', '\n');
            Dictionary<int, string> keyValuePairs = new Dictionary<int, string>();//key= pozcia v masiva value teksta na file
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$rootPath"))
                {
                    string text = basePath + Trim(content[i].Substring(content[i].IndexOf('\\')), '\"');

                    keyValuePairs.Add(i, text);
                }
            }

            string[] contentWithOutDuplicate = RemoveComments(content);
            File.WriteAllLines(filepath, contentWithOutDuplicate);
        }
        /// <summary>
        /// poneje parent path vzima file po nazad ot segashanta papka prosto mahame edna papka i tova ni e noviat path
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="path"></param> path ot koya papka e file
        public static void parentPath(string filepath, string fileContent, string path)
        {
            path = path.Substring(0, path.LastIndexOf('\\'));
            string[] content = fileContent.Split('\r', '\n');
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$parentPath"))
                {
                    content[i] = path + Trim(content[i].Substring(14), '\"');
                    try
                    {
                        content[i] = File.ReadAllText(content[i]);
                        string[] contentWithOutDuplicate = RemoveComments(content);
                        File.WriteAllLines(filepath, contentWithOutDuplicate);
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
                        string[] contentWithOutDuplicate = RemoveComments(content);
                        File.WriteAllLines(filepath, contentWithOutDuplicate);
                    }
                    catch
                    {
                        Console.WriteLine($"The following file those not exist: {content[i]} ");
                    }
                }
            }

        }
        public Dictionary<string, List<string>> files = new Dictionary<string, List<string>>();
        //za . "$ourPath\ primer otvori C:\Users\paco\Desktop\scripts\reefr\Life\LifeFromPreLife
        // za . "$LocalScriptPath otvori  C:\Users\paco\Desktop\scripts\shooger\HotFix

        //ROOTHPAH FIX IDEAS
        // 2 idei za fix
        //1: filovete v common da im se napravi scriptPath na rukaza da moje da ima loop za root>parent>script,our,local
        //2: da se hardcodne po nyakuv nachin da napravi samo i edinstveno na common file script purvo i da si produlji natatuk normalno
        //3(random):da prekrusta papkata taka che da  e purva i taka shte izpozlva podredbata si normalno MAI NE E SIGORNO
        //4: poneje i 3te common file nasledyavat login v novata papka variables osven globalnite promenlivi shte se nasledyava i login(kod i shte se premahne poneje shte go iam  3 puti) 
        //5; mojebi nai dobra da naprava dictonary koeto ima key= koe tryabva da se smeni(parent,rooth ect...) i value=path na file
        public string[] array = { "\"$rootPath\\", "\"$parentPath\\", "\"$parent\\" ,"\"$scriptPath\\", "\"$ourPath\\", "\"$LocalScriptPath\\" };
        // C:\Users\paco\Desktop\scripts\shooger  i C:\Users\paco\Desktop\scripts\uncut  i C:\Users\paco\Desktop\scripts\usdirectory
        // e mazalo(sushtia problem s rooth path ma za parent path(svurzano e s script path) ) ne raboti i za variables metoda
        public void successorRowSearcher(List<string> folderContent, string basePath)
        {
            foreach (string path in folderContent)//path na vseki folder
            {
                for (int i = 0; i < array.Length; i++)//proveryava prez glavnite path funkcii vseki file koe sudurja 
                {
                    foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// vsichki file-ve na vseki folder
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
                                //case "\"$rootPath\\"://roothpath does not work
                                //    fileContent = fileContent.Replace("$rootPath  = (Get-Item $PSScriptRoot).Parent.FullName", null);
                                //    rootPath(filepath, fileContent, basePath);
                                //break;
                                case "\"$ourPath\\":
                                    fileContent = fileContent.Replace("$ourPath =  (Get-Item $PSScriptRoot).FullName", null);
                                    ourPath(filepath, fileContent, path);
                                    break;
                                case "\"$LocalScriptPath\\":
                                    fileContent = fileContent.Replace("$LocalScriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                                    LocalScriptPath(filepath, fileContent, path);
                                    break;
                                case "\"$parent\\":
                                    fileContent = fileContent.Replace("$parent =  (Get-Item $PSScriptRoot).Parent.FullName", null);
                                    parent(filepath, fileContent, path);
                                    break;

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
                if (i > 1)//ako ima poveche ot 1 file samo togava da suzdade variables 
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
                }
                //adding extend row for  every file for variables.ps1
                foreach (string filepath in Directory.GetFiles(path, "*.ps1"))// vsichki file-ve na vseki folder
                {
                    if (filepath!= path + "\\Variables.ps1") {
                        string[] conten = File.ReadAllLines(filepath);
                        foreach (string item in valuesOfVariables)// vsichki promenlivi koito tryabva da se mahnat
                        {
                            conten = conten.Where(s => s != item).ToArray();
                        }
                        File.WriteAllLines(filepath, conten);
                    }
                }
            }  
        }
    }
}