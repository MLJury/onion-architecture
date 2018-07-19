using Core.Model;
using System;
using System.Threading.Tasks;
using System.Web.Http;
using mdl = Core.Model;
using srv = Core.Service;

/// <summary>
/// سرویس فلو
/// </summary>
namespace API.Controllers
{
    [RoutePrefix("api/v1/flow")]
    public class FlowController : BaseApiController<srv.IFlowService>
    {
        public FlowController(srv.IFlowService service) : base(service)
        {
        }

        [HttpPost, Route("reject")]
        public Task<AppCore.Result> Reject(mdl.Flow flow)
           => _service.RejectAsync(flow);

        [HttpPost, Route("set-as-read/{documentID:guid}")]
        public Task<AppCore.Result> SetAsRead(Guid documentID)
           => _service.SetAsReadAsync(documentID);

        [HttpPost, Route("set-as-unread-read/{documentID:guid}")]
        public Task<AppCore.Result> SetAsUnRead(Guid documentID)
           => _service.SetAsUnReadAsync(documentID);

        [HttpPost, Route("SendDocument")]
        public Task<AppCore.Result> SendDocument(Flow flow)
            => _service.SendDocument(flow);
    }
}