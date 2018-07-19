using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.DataSource
{
    public interface IMessageDataSource : IDataSource
    {
        Task<AppCore.Result> CreateAsync(AppCore.IActivityLog log);
    }
}
