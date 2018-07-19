using Core.Model;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Service
{
    public interface IDocumentService : IService
    {
        Task<AppCore.Result<IEnumerable<Model.DocumentStatistics>>> ListStatisticsAsync();
    }
}
