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

        //methods to add all paths in folders

        //method to add all paths in single folder
        private static List<string> Init_List(string folder)
        {
            List<string> folderContent = new List<string>();

            folderContent.Add(folder);
            foreach (var directory in Directory.GetDirectories(folder))
            {
                //folderContent.Add(directory);
                folderContent.AddRange(Init_List(directory));;
            }
            return folderContent;
        }
        //method to find  all folders
        private static List<string> Init_Dict(string folder)
        {
             List<string> folderContent = new  List<string> ();
            foreach (var directory in Directory.GetDirectories(folder))
            {

                    folderContent.AddRange(Init_List(directory));

            }
            return folderContent;
        }
        static void Main(string[] args)
        {
            //global path MUST BE CHANGE FOR OTHER DEVICES
            string basePath = @"C:\Users\paco\Desktop\scripts\";

            List<string> folderContent = Init_Dict(basePath);
            var ps1 = new Ps1Files();
            ps1.successorRowSearcher(folderContent,basePath);
            //ps1.commonVariables(folderContent);//
        }
    }
}