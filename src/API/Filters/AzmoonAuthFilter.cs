using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Controllers;
using Core.Service;
using System.Web.Http.Filters;
using System.Threading.Tasks;
using System.Net.Http;
using System.Threading;
using System.Net.Http.Headers;
using System.Web.Http;
using System.Net;
using API.Auth;
using API.Auth.Attributes;
using Core.Model;

namespace API.Auth.Filters
{
    public class AuthFilter : IAuthorizationFilter
    {
        public IAuthService _auth;

        public AuthFilter(IAuthService auth)
            => _auth = auth ?? throw new ArgumentNullException("azmoon auth is null");

        public async Task<HttpResponseMessage> ExecuteAuthorizationFilterAsync(HttpActionContext actionContext, CancellationToken cancellationToken, Func<Task<HttpResponseMessage>> continuation)
        {
            var azmoonAuthAttribute = actionContext
                .ActionDescriptor
                .GetCustomAttributes<AuthAttribute>()
                .SingleOrDefault();

            //check if azmoonAuthAttribute exists
            if (azmoonAuthAttribute == null)
                return await continuation();

            //if ((await _auth.IsUserAuthenticated(userId: userId, commandID: commandId)).Data.isAuthorized)
            //    return await continuation();

            return actionContext.Request.CreateResponse(HttpStatusCode.NonAuthoritativeInformation, AppCore.Result<Core.Model.Auth>.Failure(-1, "شما مجوز دسترسی ندارید."));
        }

        public bool AllowMultiple
        {
            get { return true; }
        }
    }
}