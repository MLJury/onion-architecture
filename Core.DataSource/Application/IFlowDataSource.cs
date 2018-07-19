using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.DataSource
{
    public interface IFlowDataSource: IDataSource
    {
        Task<AppCore.Result> AddAsync<T>(Model.Flow<T> flow, AppCore.IActivityLog log);

        Task<AppCore.Result> AddFlowsAsync<T>(IEnumerable<Model.Flow<T>> flows, AppCore.IActivityLog log);

        Task<AppCore.Result> RejectAsync(Model.Flow flow, AppCore.IActivityLog log);

        Task<AppCore.Result> SetAsReadAsync(Guid documentID, Guid userPositionID, AppCore.IActivityLog log);

        Task<AppCore.Result> SetAsUnReadAsync(Guid documentID, Guid userPositionID, AppCore.IActivityLog log);

        Task<AppCore.Result<IEnumerable<Model.Flow>>> ListAsync(Guid documentId);
            //where T : class, new();

    }
}
