using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;

namespace MagfaHttpServiceSamples
{
    class RequestHandler
    {
        private String proxyHostAddress;
        private int proxyHostPort;
        private String proxyUsername;
        private String proxyPassword;
        private Boolean useProxy;
        public RequestHandler(String proxyHostAddress, int proxyHostPort, String proxyUsername, String proxyPassword)
        {
            this.proxyHostAddress = proxyHostAddress;
            this.proxyHostPort = proxyHostPort;
            this.proxyUsername = proxyUsername;
            this.proxyPassword = proxyPassword;
            this.useProxy = true;
        }

        public RequestHandler()
        {
            this.useProxy = false;
        }
        public String get(String urlString) 
        {
            System.Console.WriteLine("sending url: " + urlString);
            // used to build entire input
            StringBuilder sb = new StringBuilder();

            // used on each read operation
            byte[] buf = new byte[8192];

            // prepare the web page we will be asking for
            HttpWebRequest request = (HttpWebRequest)
                WebRequest.Create(urlString);
            
            //setting proxy settings
            if (useProxy)
            {
                WebProxy localProxy = new WebProxy(proxyHostAddress, proxyHostPort);
                localProxy.BypassProxyOnLocal = true;
                localProxy.Credentials = new System.Net.NetworkCredential(proxyUsername, proxyPassword);
                request.Proxy = localProxy;
            }
            
            // execute the request
            HttpWebResponse response = (HttpWebResponse)
                request.GetResponse();

            // we will read data via the response stream
            Stream resStream = response.GetResponseStream();

            string tempString = null;
            int count = 0;

            do
            {
                // fill the buffer with data
                count = resStream.Read(buf, 0, buf.Length);

                // make sure we read some data
                if (count != 0)
                {
                    // translate from bytes to ASCII text
                    tempString = Encoding.ASCII.GetString(buf, 0, count);

                    // continue building the string
                    sb.Append(tempString);
                }
            }
            while (count > 0); // any more data to read?

            // print out page source
            return sb.ToString();
        }
    }
}
