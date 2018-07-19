using DryIoc;
using DryIoc.WebApi;
using System;
using DryContainer = DryIoc.Container;
using IDryContainer = DryIoc.IContainer;

namespace API.IOC
{
    public class Activator
    {
        private Activator()
        {
        }

        private static readonly Lazy<Activator> _instance = new Lazy<Activator>(() => new Activator());

        private static IDryContainer _container;

        public static AppCore.IOC.IContainer Container { get; private set; }

        public static Activator Instance => _instance.Value;

        public AppCore.IOC.IContainer ActiveWebApi(System.Web.Http.HttpConfiguration httpConfig, System.Reflection.Assembly[] webApiAssemblies)
        {
            _container = new DryContainer().WithWebApi(httpConfig, webApiAssemblies);
            _container.RegisterInstance<AppCore.IOC.IContainer>(new Container(_container), reuse: Reuse.Singleton);
            Container = _container.Resolve<AppCore.IOC.IContainer>();
            return Container;
        }

        public void Deactivate() => _container.Dispose();
    }
}