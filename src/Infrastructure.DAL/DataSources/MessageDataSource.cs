using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using m = Core.Model;

namespace Kama.Mefa.Azmoon.Infrastructure.DAL
{
    class MessageDataSource : DataSource, Core.DataSource.IMessageDataSource
    {
        public MessageDataSource(AppCore.IOC.IContainer container)
            : base(container)
        {
        }

        public async Task<AppCore.Result> CreateAsync(AppCore.IActivityLog log)
        {
            try
            {
                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
