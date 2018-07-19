using Core.Model;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http;
using mdl = Core.Model;
using srv = Core.Service;

/// <summary>
/// سرویس کارتابل
/// </summary>
namespace API.Controllers
{
    [RoutePrefix("api/v1/document")]
    public class DocumentController : BaseApiController<srv.IDocumentService>
    {
        public DocumentController(srv.IDocumentService service) : base(service)
        {
        }

        [HttpPost, Route("list-statistics")]
        public Task<AppCore.Result<IEnumerable<mdl.DocumentStatistics>>> ListStatistics()
           => _service.ListStatisticsAsync();
    }
}