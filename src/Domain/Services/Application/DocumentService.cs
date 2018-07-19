using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using AppCore;
using ds = Core.DataSource;
using Core.Model;

namespace Domain.Services
{
    class DocumentService : Service<ds.IDocumentDataSource>, Core.Service.IDocumentService
    {
        public DocumentService(
            AppCore.IOC.IContainer container
            )  
            : base(container)
        {
        }

        public Task<AppCore.Result<IEnumerable<Core.Model.DocumentStatistics>>> ListStatisticsAsync()
            => _dataSource.ListStatisticsAsync();
    }
}
