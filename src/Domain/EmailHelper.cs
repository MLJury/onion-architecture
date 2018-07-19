using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Domain
{
    public static class EmailHelper
    {
        public static string GetTemplateFromFile(string fileName, string appURL)
            => File.ReadAllText(Path.Combine(System.Web.HttpRuntime.AppDomainAppPath, $@"Files\MessageTemplates\{fileName}.txt")).Replace("[App-URL]", appURL);

        public static string GetSenderEmail()
            => System.Configuration.ConfigurationManager.AppSettings["SenderEMail"].ToString();
    }
}
