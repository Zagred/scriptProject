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
        public static string[] RemoveComments(string[] content)
        {
            content = content.Where(arg => !string.IsNullOrWhiteSpace(arg)).ToArray();//maha vseki red koito ne sudurja nishto
            return content;
        }
        /// <summary>
        /// 2-te metoda rabotat kato izpolzvam fileContent da mahant nasledyavashtite redove i da trimne file-a koito nasledya i go obedinayva s path i go dobavya v folecontet i go zapisva kato nov file
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
        /// <summary>
        /// metoda ne raboti po razlichno ot drugite edinstvenata razlika e che  izpolzva base path a ne patha na papkata
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="basePath"></param> tova e glavnia ni path na nashia komp tryabva ni specifichno za rootPath poradi izpozlvaneto na izcyalo druga papka
        public static void rootPath(string filepath, string fileContent, string basePath)
        {
            string[] content = fileContent.Split('\r', '\n');
            List<string> roothPathPaths = new List<string>();
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$rootPath"))
                {
                    string path = basePath + Trim(content[i].Replace(". \"$rootPath\\", null), '\"');// da nameri ot koya papka e roothpath (v sluchyaa common papkata i file)
                    roothPathPaths.Add(path);
                }
            }
            roothScriptPath(roothPathPaths,filepath, content,basePath);
        }
        /// <summary>
        /// zamesta roothPathovete(te viangi sa ot 1 -3 ) i ponjee vsichki imat scriptpath kum login pravim taka che samo purviat da nasledyava login file 
        /// </summary>
        /// <param name="roothPathPaths"></param> list s vsichki rooth pathove koito se izpolzvat
        /// <param name="filepath"></param>path na file koito izpolzva v momenta
        /// <param name="content"></param> teksta koito shte dobavim na file
        /// <param name="basePath"></param> tova e glavnia ni path na nashia komp tryabva ni specifichno za rootPath poradi izpozlvaneto na izcyalo druga papka
        public static void roothScriptPath(List<string> roothPathPaths, string filepath, string[] content, string basePath)
        {
            string combineText = "";//poneje content e array i nie zamenyame array-a saamo 1 red s vsichkite roothpaths izpozlvame edin string koito gi obediniyava
            int i = 0;
            foreach (string path in roothPathPaths)
            {
                if (i == 0)//tova shte e purviat roothpath taka che pri nego ne mahame loggin reda
                {
                    combineText = File.ReadAllText(path).Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null);
                    i++;
                }
                else// vseki drug shte mahnem i dvata reda za scripth path poneje ne ni tryabvat
                {
                    string text = File.ReadAllText(path).Replace("$scriptPath  = (Get-Item $PSScriptRoot).FullName", null).Replace(". \"$scriptPath\\Logging.ps1\"", null);
                    combineText += text;
                }
            }

            for (int j = 0; j < content.Length; j++)// ot content maha vsichki rooth patove osven 1 koito shte sudurja scriptpath
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
            for ( int k = 0; k < content.Length; k++)// funkcia za script path
            {
                if (content[k] != null)
                {
                    if (content[k].Contains(". \"$scriptPath"))
                    {
                        content[k] = content[k].Replace(". \"$scriptPath\\Logging.ps1\"", File.ReadAllText(basePath));
                    }
                }

            }
            string[] contentWithOutDuplicate = RemoveComments(content);
            File.WriteAllLines(filepath, contentWithOutDuplicate);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="filepath"></param> path na file koito izpolzva v momenta
        /// <param name="fileContent"></param> teksta na file koito polzvame
        /// <param name="path"></param> path ot koya papka e file
        public static void LocalScript(string filepath, string fileContent, string path)
        {
            string[] content = fileContent.Split('\r', '\n');
            List<string> localPathPaths = new List<string>();//vsichko filove koito imat localscriptpath
            for (int i = 0; i < content.Length; i++)
            {
                if (content[i].Contains(". \"$LocalScriptPath"))
                {
                    string basePath= path + Trim(content[i].Substring(content[i].IndexOf('\\')), '\"');
                    localPathPaths.Add(basePath);
                }
            }
            localScripPath(localPathPaths, filepath, content, path);
        }
        /// <summary>
        /// preglejda vsichkite filove s scriptpath ot papkata i premaha scriptpath redovete i zamesta vseki uniqe scriptpath  s teksta koito tryabva(v sluchaya e samo common variables)
        /// </summary>
        /// <param name="localPathPaths"></param> vsichki putishta koito se izpolzvat
        /// <param name="filepath"></param>path na file koito izpolzva v momenta
        /// <param name="content"></param>teksta na file koito polzvame
        /// <param name="path"></param>path ot koya papka e file
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

            for (int j=0; j < content.Length; j++)
            {
                if (content[j].Contains(". \"$LocalScriptPath") && i==1)
                {
                    content[j] = combineText;
                    i++;
                }
                else if(content[j].Contains(". \"$LocalScriptPath") && i != 1)
                {
                    content[j] = null;
                }
            }
            string basePath = path + "\\CommonVariables.ps1";
            for (int k = 0; k < content.Length; k++)// funkcia za script path
            {
                if (content[k] != null)
                {
                    if (content[k].Contains(". \"$scriptPath"))
                    {
                        content[k] = content[k].Replace(". \"$scriptPath\\CommonVariables.ps1\"", File.ReadAllText(basePath));
                    }
                }

            }
            string[] contentWithOutDuplicate = RemoveComments(content);
            File.WriteAllLines(filepath, contentWithOutDuplicate);
        }
        public string[] array = { "\"$rootPath\\", "\"$parentPath\\", "\"$parent\\" ,"\"$scriptPath\\", "\"$ourPath\\", "\"$LocalScriptPath\\" };

        //ZA RESHENIE V SCHEDULEtASK, WEBSERVICE I WINDOWSERVICE SE MAHAT REDOVETE ZA ROOTHPATH
        // poneje te nasledyavat cherz scriptpath drug ifle koito sudurja roothpath kum sushtie elementi
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