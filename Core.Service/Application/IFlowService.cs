using Core.Model;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Service
{
    public interface IFlowService : IService
    {
        Task<AppCore.Result> RejectAsync(Model.Flow flow);

        Task<AppCore.Result> SetAsReadAsync(Guid documentId);

        Task<AppCore.Result> SetAsUnReadAsync(Guid documentId);

        Task<AppCore.Result> SendDocument(Flow flow);
    }
}
