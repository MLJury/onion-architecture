using System.Collections.Generic;
using WebConfig = System.Web.Configuration.WebConfigurationManager;

namespace API.ServiceHost
{
    public class SmsServiceHost : SmsService.ApiClient.Interface.ISmsServiceHostInfo
    {
        public string Host
            => WebConfig.AppSettings["SmsServiceHost"];

        public IDictionary<string, string> GetDefaultHeaders()
            => new Dictionary<string, string>();
    }
}