using Core.Model;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.DataSource
{
    public interface IDocumentDataSource : IDataSource
    {
        Task<AppCore.Result<IEnumerable<Model.DocumentStatistics>>> ListStatisticsAsync();

        Task<AppCore.Result> DeleteAsync(Guid id, AppCore.IActivityLog log);
    }
}
