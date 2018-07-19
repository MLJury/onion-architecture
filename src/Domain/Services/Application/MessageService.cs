using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using model = Core.Model;
using System.Linq;

namespace Domain.Services
{
    class MessageService : Service<Core.DataSource.IMessageDataSource>, Core.Service.IMessageService
    {
        public MessageService(AppCore.IOC.IContainer container
                              , Core.SmsService.ISmsService smsService
                              , Core.MailService.IMailService mailService)
            : base(container)
        {
            _smsService = smsService;
            _mailService = mailService;
        }
        Core.MailService.IMailService _mailService;
        Core.SmsService.ISmsService _smsService;

        public async Task<AppCore.Result> SendAsync(SmsService.Core.Model.Message message)
        {
            message.SourceAccount = message.SourceAccount == SmsService.Core.Model.SmsServiceAccounts.Unknown 
                                    ? message.SourceAccount = SmsService.Core.Model.SmsServiceAccounts.Azmoon : message.SourceAccount;

            message.Priority = message.Priority == SmsService.Core.Model.Priority.Unknown
                                ? SmsService.Core.Model.Priority.Normal : message.Priority;
                                
            var smsResult = await _smsService.SendAsync(message);
            if (!smsResult.Success)
               return AppCore.Result.Failure(message: smsResult.Message);

            return AppCore.Result.Successful();
        }

        public async Task<AppCore.Result> SendAsync(List<SmsService.Core.Model.Message> message)
        {
            message.ForEach(f => f.SourceAccount = SmsService.Core.Model.SmsServiceAccounts.Azmoon);
            var smsResult = await _smsService.SendAsync(message);
            if (!smsResult.Success)
                return AppCore.Result.Failure(message: smsResult.Message);

            return AppCore.Result.Successful();
        }
    }
}
