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

            Dictionary<string, string> cities = new Dictionary<string, string>();

            using (StreamReader shooger = new StreamReader(shoogerPath))
            {
                string currentLine;
                while ((currentLine = shooger.ReadLine()) != null)
                {
                    try {

                        cities.Add(currentLine, currentLine); } catch { }
                }
            }

            using (StreamReader usd = new StreamReader(usdPath))
            {

                string currentLine;
                while ((currentLine = usd.ReadLine()) != null)
                {
                    try
                    {

                        cities.Add(currentLine, currentLine);
                        csv.Append(currentLine+"\r\n");

                    }
                    catch { }

                }

            }
            File.WriteAllText(save, csv.ToString());


        }
    }
}