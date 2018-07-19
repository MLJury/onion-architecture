using System;
using System.Collections.Generic;

namespace Onion.ApiClient
{
    class OnionClient : Library.ApiClient.Client, Interface.IOnionClient
    {
        public OnionClient(AppCore.IObjectSerializer objectSerializer, string host)
            :base(objectSerializer, host)
        {
        }

        public OnionClient(AppCore.IObjectSerializer objectSerializer, string host, Func<IDictionary<string, string>> defaultHeaders)
            :base(objectSerializer, host, defaultHeaders)
        {
        }
    }
}
