using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Service
{
    public interface IMessageService : IService
    {
        Task<AppCore.Result> SendAsync(SmsService.Core.Model.Message message);
        Task<AppCore.Result> SendAsync(List<SmsService.Core.Model.Message> messages);
    }
}
