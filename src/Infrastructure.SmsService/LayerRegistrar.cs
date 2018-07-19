using System;
using System.Linq;
using AppCore.IOC;
using Service = Infrastructure.SmsService;

[assembly: Registrar(typeof(Service.LayerRegistrar))]

namespace Infrastructure.SmsService
{
    using ASM = System.Reflection.Assembly;
    using smsService = Core.SmsService;

    internal class LayerRegistrar : IRegistrar
    {
        private readonly Guid _layerID = Guid.NewGuid();

        public Guid ID => _layerID;

        public void Start(IContainer container)
        {
            ASM asmInterfaces = ASM.GetAssembly(typeof(smsService.IService)),
                asmClasses = ASM.GetAssembly(this.GetType());

            container.RegisterFromAssembly(
                servicesAssembly: asmInterfaces,
                implementationsAssembly: asmClasses,
                isService: t => t.IsInterface && !t.IsClass && typeof(smsService.IService).IsAssignableFrom(t),
                isServiceImplementation: t => !t.IsInterface && t.IsClass && t.IsSubclassOf(typeof(Service.DataSource))
                );
        }
    }
}