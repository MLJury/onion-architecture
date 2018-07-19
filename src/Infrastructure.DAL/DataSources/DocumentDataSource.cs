using Core.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mdl = Core.Model;

namespace Kama.Mefa.Azmoon.Infrastructure.DAL
{
    class DocumentDataSource : DataSource, Core.DataSource.IDocumentDataSource
    {
        public DocumentDataSource(AppCore.IOC.IContainer container)
            : base(container)
        {
        }

        public async Task<AppCore.Result> DeleteAsync(Guid id, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.DeleteBaseDocumentAsync(_id: id, _removerID: RequestInfo.UserId, _log: null)).ToActionResult();
                //return result;

                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result<IEnumerable<mdl.DocumentStatistics>>> ListStatisticsAsync()
        {
            try
            {
                //var result = (await _dbPBL.GetDocumentStatisticsAsync(
                //    _userPositionID: RequestInfo.PositionId
                //    )).ToListActionResult<mdl.DocumentStatistics>();
                //return result;

                return AppCore.Result<IEnumerable<mdl.DocumentStatistics>>.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
