using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using @MailServiceModel = Kama.MailService.Core.Model;

namespace Core.MailService
{
    public interface IMailService : IService
    {
        Task<Kama.AppCore.Result> SendAsync(MailServiceModel.Mail mail);
        Task<Kama.AppCore.Result> SendAsync(List<MailServiceModel.Mail> mails);
    }
}
