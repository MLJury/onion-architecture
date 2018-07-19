using System.Threading.Tasks;
using System.Net.Http;
using System.Threading;
using System.Net;
using System.Web.Http.ExceptionHandling;
using System.Web.Http.Results;
using Config = System.Configuration.ConfigurationManager;
using System.Data.SqlClient;
using System;
using System.Web.Http;
using AppCore;

namespace API.Exceptions.Filters
{
    //A global exception handler that will be used to catch any error
    public class KamaExceptionHandler : IExceptionHandler
    {
        public virtual Task HandleAsync(ExceptionHandlerContext context, CancellationToken cancellationToken)
        {
            string exceptionMessage = GenerateExceptionMessageText.Instance[context.Exception, Config.AppSettings["DeploymentMode"]];
            context.Result = new ResponseMessageResult(context.Request.CreateResponse(HttpStatusCode.OK, AppCore.Result.Failure(code: -1, message: exceptionMessage)));
            return Task.FromResult(0);
        }
    }
}