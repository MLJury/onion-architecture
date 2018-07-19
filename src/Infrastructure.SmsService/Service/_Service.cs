using Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.SmsService
{
    internal abstract class DataSource
    {
        public DataSource()
        {
        }

        public AppCore.RequestInfo RequestInfo { get; set; }
    }
}
