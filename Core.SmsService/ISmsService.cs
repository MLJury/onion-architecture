using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using @SmsServiceModel = SmsService.Core.Model;

namespace Core.SmsService
{
    public interface ISmsService : IService
    {
        Task<AppCore.Result> SendAsync(SmsServiceModel.Message message);
        Task<AppCore.Result> SendAsync(List<SmsServiceModel.Message> messages);
    }
}
