using Microsoft.Owin.Security.OAuth;
using Owin;
using System.Web.Http;
using API.Auth.Filters;
using API.Exceptions.Filters;
using System.Web.Http.ExceptionHandling;

[assembly: WebActivatorEx.PostApplicationStartMethod(typeof(API.Startup), "Started")]
[assembly: WebActivatorEx.ApplicationShutdownMethod(typeof(API.Startup), "Stop")]

[assembly: Microsoft.Owin.OwinStartup(typeof(API.Startup))]
namespace API
{
    using asm = System.Reflection.Assembly;
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            HttpConfiguration config = new HttpConfiguration();

            ConfigureOAuth(app);

            ConfigureIoC(config);

            WebApiConfig.Register(config);
            app.UseCors(Microsoft.Owin.Cors.CorsOptions.AllowAll);
            app.UseWebApi(config);

        }

        private void ConfigureOAuth(IAppBuilder app)
        {
            //Token Consumption
            app.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions
            {
            });
        }

        private static void RegisterTools(AppCore.IOC.IContainer container)
        {
            container.RegisterType<AppCore.IObjectSerializer, Tools.ObjectSerializer>();
            container.RegisterType<Core.IEventLogger, Tools.Logger>();
            container.RegisterType<SmsService.ApiClient.Interface.ISmsServiceHostInfo, API.ServiceHost.SmsServiceHost>();
        }

        private static void RegisterFilters(AppCore.IOC.IContainer container, HttpConfiguration httpConfig)
        {
            //regsiter Filters
            container.RegisterType(typeof(AuthFilter));
            container.RegisterType(typeof(ValidationFilter));
            container.RegisterType(typeof(KamaExceptionHandler));
            
            //register command filters in httConfig
            httpConfig.Filters.Add(container.Resolve<AuthFilter>());
            httpConfig.Filters.Add(container.Resolve<ValidationFilter>());
            //Register Exception Loggers and Exception Handler
            httpConfig.Services.Replace(typeof(IExceptionHandler), container.Resolve<KamaExceptionHandler>());
            //httpConfig.Services.Replace(typeof(IExceptionLogger), container.Resolve<KamaExceptionLogger>());
        }

        public void ConfigureIoC(HttpConfiguration httpConfig)
        {
            var container = IOC.Activator.Instance.ActiveWebApi(httpConfig, new System.Reflection.Assembly[] { System.Reflection.Assembly.GetExecutingAssembly() });

            RegisterTools(container);

            AppCore.IOC.Loader.Load(container, System.Web.Hosting.HostingEnvironment.MapPath("~/Libs"));

            RegisterFilters(container, httpConfig);
        }

        public static void Started()
        {
        }

        public static void Stop()
            => IOC.Activator.Instance.Deactivate();
    }
}