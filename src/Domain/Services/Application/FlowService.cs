using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using AppCore;
using ds = Core.DataSource;
using mdl = Core.Model;
using Core.Model;

namespace Domain.Services
{
    class FlowService : Service<ds.IFlowDataSource>, Core.Service.IFlowService
    {
        public FlowService(
            AppCore.IOC.IContainer container
            )
            : base(container)
        {
        }

        public Task<AppCore.Result> RejectAsync(Flow flow)
            => _dataSource.RejectAsync(flow, null);

        public Task<AppCore.Result> SetAsReadAsync(Guid documentID)
            => _dataSource.SetAsReadAsync(documentID, (Guid)RequestInfo.PositionId, null);

        public Task<Result> SetAsUnReadAsync(Guid documentID)
            => _dataSource.SetAsReadAsync(documentID, (Guid)RequestInfo.PositionId, null);

        public async Task<Result> SendDocument(Flow flow)
        {
            var flowList = await _dataSource.ListAsync(flow.DocumentID);
            if (!flowList.Success)
                return flowList;
            var lastFlow = flowList.Data.Where(w => w.ActionDate == null).FirstOrDefault();

            if (flow.ToPositionID == lastFlow.ToPositionID)
                return Result.Failure(message: "ارسال پرونده به همان کاربر  قبلی امکان پذیر نیست.");

            if (flowList.Data.Any())
            {
                lastFlow.ToPositionID = flow.ToPositionID;
                var FlowResult = await _dataSource.AddAsync(lastFlow, null);
                if (!FlowResult.Success)
                    return FlowResult;
            }
            return Result.Successful();
        }
    }
}
