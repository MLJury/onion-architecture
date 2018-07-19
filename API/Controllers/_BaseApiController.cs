using Core.Service;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Reflection;
using System.Linq;

namespace API.Controllers
{
    public class BaseApiController<T> : ApiController
        where T : IService
    {
        public BaseApiController(T service)
        {
            _service = service;
        }

        protected readonly T _service;

        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);

            GetType().GetFields(BindingFlags.NonPublic | BindingFlags.Instance)
                            .Where(w => w.GetValue(this) is IService)
                            .ToList()
                            .ForEach(f => ((IService)f.GetValue(this)).RequestInfo = RequestInfo);
        }

        protected string GetHedaerValue(string key)
        {
            IEnumerable<string> values = new string[] { };
            Request.Headers.TryGetValues(key, out values);
            if (values == null)
                return null;
            return string.Join(",", values);
        }

        protected AppCore.RequestInfo RequestInfo
        {
            get
            {
                Guid positionId = Guid.Empty;
                if (!string.IsNullOrEmpty(GetHedaerValue("User-Current-Position-ID")))
                    positionId = Guid.Parse(GetHedaerValue("User-Current-Position-ID"));

                Guid applicationId = Guid.Empty;
                var strApplicationId = System.Web.Configuration.WebConfigurationManager.AppSettings["ApplicationID"];
                if (!string.IsNullOrEmpty(strApplicationId))
                    applicationId = Guid.Parse(strApplicationId);

                return new AppCore.RequestInfo
                (
                    applicationId: applicationId,
                    applicationName: "",
                    positionId: positionId,
                    userId: User.Identity.GetUserId<Guid>(),
                    username: User.Identity.Name,
                    remoteIP: GetHedaerValue("X-Forwarded-For"),
                    appURL: GetHedaerValue("App-URL")
                );

            }
        }
    }
}
