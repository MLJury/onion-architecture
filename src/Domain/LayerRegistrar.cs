using System;
using System.Linq;
using Core.Service;
using ioc = AppCore.IOC;

[assembly: ioc.Registrar(typeof(Domain.LayerRegistrar), Order = 1)]
namespace Domain
{
    using asm = System.Reflection.Assembly;
    using svc = Core.Service;

    class LayerRegistrar : ioc.IRegistrar
    {
        private readonly Guid _layerId = Guid.NewGuid();

        public Guid ID => _layerId;

        public void Start(ioc.IContainer container)
        {
            var svcInterfaces = asm.GetAssembly(typeof(svc.IService))
                           .GetTypes()
                           .Where(t => t.IsInterface && t != typeof(svc.IService));

            var svcClasses = asm.GetAssembly(this.GetType())
                             .GetTypes()
                             .Where(t => t.IsClass && t.IsSubclassOf(typeof(Service)));

            foreach (var svcInterface in svcInterfaces)
            {
                var svcClass = svcClasses.FirstOrDefault(e => svcInterface.IsAssignableFrom(e));
                if (svcClass != null)
                    container.RegisterType(from: svcInterface, to: svcClass);
            }
        }
    }
}