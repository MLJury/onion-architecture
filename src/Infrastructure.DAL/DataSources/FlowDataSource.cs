using Library.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using mdl = Core.Model;
using AppCore;

namespace Infrastructure.DAL
{
    class FlowDataSource : DataSource, Core.DataSource.IFlowDataSource
    {
        public FlowDataSource(AppCore.IOC.IContainer container)
            : base(container)
        {
        }

        public async Task<AppCore.Result> AddAsync<T>(mdl.Flow<T> flow, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.AddFlowAsync(
                //    _documentID: flow.DocumentID,
                //    _fromPositionID: flow.FromPositionID,
                //    _toPositionID: flow.ToPositionID,
                //    _toDocState: Convert.ToByte(flow.ToDocState),
                //    _fromDocState: Convert.ToByte(flow.FromDocState),
                //    _sendType: (byte)flow.SendType,
                //    _comment: flow.Comment,
                //    _log: log?.Value
                //    )).ToActionResult();

                //return result;
                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result> AddFlowsAsync<T>(IEnumerable<mdl.Flow<T>> flows, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.AddFlowsAsync(
                //    _flows: Newtonsoft.Json.JsonConvert.SerializeObject(flows),
                //    _log: log?.Value
                //    )).ToActionResult();

                //return result;

                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result> RejectAsync(mdl.Flow flow, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.RejectFlowAsync(
                //    _documentID: flow.DocumentID,
                //    _fromUserID: flow.FromUserID,
                //    _fromPositionID: flow.FromPositionID,
                //    _comment: flow.Comment,
                //    _log: log?.Value
                //    )).ToActionResult();

                //return result;

                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result> SetAsReadAsync(Guid documentID, Guid userPositionID, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.SetFlowReadStateAsync(
                //    _documentID: documentID,
                //    _userPositionID: userPositionID,
                //    _isRead: true,
                //    _log: log?.Value
                //    )).ToActionResult();

                //return result;
                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result> SetAsUnReadAsync(Guid documentID, Guid userPositionID, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.SetFlowReadStateAsync(
                //    _documentID: documentID,
                //    _userPositionID: userPositionID,
                //    _isRead: false,
                //    _log: log?.Value
                //    )).ToActionResult();

                //return result;

                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result<IEnumerable<mdl.Flow>>> ListAsync(Guid documentId)
        //where Tdocs : class, new()
        {
            try
            {
                //var result = (await _dbPBL.GetFlowsAsync(
                //    _documentID: documentId
                //    )).ToListActionResult<mdl.Flow>();

                //return result;

                //return AppCore.Result.Successful();

                return AppCore.Result<IEnumerable<mdl.Flow>>.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
