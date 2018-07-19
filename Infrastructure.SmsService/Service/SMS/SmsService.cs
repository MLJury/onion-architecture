using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using @SmsServiceModel = SmsService.Core.Model;
using @SmsServices = SmsService.ApiClient.Interface;

namespace Infrastructure.SmsService
{
    class SmsService : DataSource, Core.SmsService.ISmsService
    {
        public SmsService(AppCore.IOC.IContainer container
                            , SmsServices.IMessageService messageService)
        {
            _messageService = messageService;
        }
        SmsServices.IMessageService _messageService;

        public async Task<AppCore.Result> SendAsync(SmsServiceModel.Message msg)
        {
            try
            {
                var result = await _messageService.Send(msg);

                return AppCore.Result<SmsServiceModel.Message>.Set(success: result.Success, code: result.Code, data: msg, message: result.Message);
            }
            catch (Exception e)
            {
                return AppCore.Result<SmsServiceModel.Message>.Failure();
            }
        }

        public async Task<AppCore.Result> SendAsync(List<SmsServiceModel.Message> msg)
        {
            try
            {
                var result = await _messageService.Send(msg.ToArray());

                return AppCore.Result<SmsServiceModel.Message>.Set(success: result.Success, code: result.Code, message: result.Message);
            }
            catch (Exception e)
            {
                return AppCore.Result<SmsServiceModel.Message>.Failure();
            }
        }

        //public async Task<AppCore.Result<Core.Model.Sms>> CreditAsync(Core.Model.SmsConfig config)
        //{
        //    try
        //    {
        //        float result = await _sms.getCreditAsync(
        //            userName: config.UserName
        //            , password: config.Password
        //            , domain: config.Domain
        //            , useProxy: config.UseProxy
        //            , proxyAddress: config.ProxyAddress
        //            , proxyUsername: config.ProxyUsername
        //            , proxyPassword: config.ProxyPassword);

        //        string finalResult;
        //        if (result < ErrorCodes.MAX_VALUE)
        //        {
        //            finalResult = "You may have caught an error, value: " + result + ", " + ErrorCodes.getDescriptionForCode((int)result);
        //            return AppCore.Result<Core.Model.Sms>.Failure(code: (int)result, message: finalResult, data: null);
        //        }
        //        else
        //            finalResult = "your credit: " + result;

        //        return AppCore.Result<Core.Model.Sms>.Set(success: true, code: (int)result, data: null, message: finalResult);
        //    }
        //    catch (Exception e)
        //    {
        //        return AppCore.Result<Core.Model.Sms>.Failure();
        //    }
        //}

        //public async Task<AppCore.Result<Core.Model.Sms>> GetMessageByIDAsync(Core.Model.Sms sms, Core.Model.SmsConfig config)
        //{
        //    try
        //    {
        //        long result = await _sms.getMessageByIdAsync(
        //            userName: config.UserName
        //            , password: config.Password
        //            , domain: config.Domain
        //            , useProxy: config.UseProxy
        //            , proxyAddress: config.ProxyAddress
        //            , proxyUsername: config.ProxyUsername
        //            , proxyPassword: config.ProxyPassword
        //            , checkingMessageId: sms.ID);

        //        return AppCore.Result<Core.Model.Sms>.Set(true, data: sms);
        //    }
        //    catch (Exception e)
        //    {
        //        return AppCore.Result<Core.Model.Sms>.Failure();
        //    }
        //}

        //public async Task<AppCore.Result<Core.Model.Sms>> GetMessageStatusAsync(Core.Model.Sms sms, Core.Model.SmsConfig config)
        //{
        //    try
        //    {
        //        int statusResults = (await _sms.getMessageStatusesAsync(
        //            userName: config.UserName
        //            , password: config.Password
        //            , domain: config.Domain
        //            , useProxy: config.UseProxy
        //            , proxyAddress: config.ProxyAddress
        //            , proxyUsername: config.ProxyUsername
        //            , proxyPassword: config.ProxyPassword
        //            , messageIds: new long[] { sms.ID }))[0];

        //        string statusResultFinal;
        //        if (statusResults <= -1)
        //            statusResultFinal = "Error. code: " + statusResults + ", " + ErrorCodes.getDescriptionForCode(statusResults);
        //        else
        //            statusResultFinal = "Results: " + statusResults;

        //        return AppCore.Result<Core.Model.Sms>.Set(true, data: sms, message: statusResultFinal);
        //    }
        //    catch (Exception e)
        //    {
        //        return AppCore.Result<Core.Model.Sms>.Failure();
        //    }
        //}

        //public async Task<AppCore.Result<IEnumerable<Core.Model.Sms>>> GetAllMessageAsync(Core.Model.Sms sms, Core.Model.SmsConfig config)
        //{
        //    try
        //    {
        //        CustomerReturnIncomingFormat[] returnValues = await _sms.getAllMessagesAsync(
        //            userName: config.UserName
        //            , password: config.Password
        //            , domain: config.Domain
        //            , useProxy: config.UseProxy
        //            , proxyAddress: config.ProxyAddress
        //            , proxyUsername: config.ProxyUsername
        //            , proxyPassword: config.ProxyPassword
        //            , numberOfMessages: sms.MessageNumber);

        //        string FinalResult;
        //        if (returnValues.Length == 0)
        //            FinalResult = "Results: " + "No new incoming messages were found...";
        //        else if (returnValues.Length == 1)
        //            FinalResult = "Results: " + "#1\n" + returnValues[0].ToString();
        //        else
        //            FinalResult = "Results: " + "#1\n" + returnValues[0].ToString() + "\n#2\n" + returnValues[1].ToString();

        //        return AppCore.Result<IEnumerable<Core.Model.Sms>>.Set(true, data: null);
        //    }
        //    catch (Exception e)
        //    {
        //        return AppCore.Result<IEnumerable<Core.Model.Sms>>.Failure();
        //    }
        //}

        //public async Task<AppCore.Result<IEnumerable<Core.Model.Sms>>> GetAllMessagesByNumberAsync(Core.Model.Sms sms, Core.Model.SmsConfig config)
        //{
        //    try
        //    {
        //        CustomerReturnIncomingFormat[] returnValues = await _sms.getAllMessagesWithNumberAsync(
        //            userName: config.UserName
        //            , password: config.Password
        //            , domain: config.Domain
        //            , useProxy: config.UseProxy
        //            , proxyAddress: config.ProxyAddress
        //            , proxyUsername: config.ProxyUsername
        //            , proxyPassword: config.ProxyPassword
        //            , numberOfMessages: sms.MessageNumber
        //            , destNumber: sms.RecipientNumber);

        //        string finalResult;
        //        if (returnValues.Length == 0)
        //            finalResult = "Results: " + "No new incoming messages were found...";
        //        else if (returnValues.Length == 1)
        //            finalResult = "Results: " + "#1\n" + returnValues[0].ToString();
        //        else
        //            finalResult = "Results: " + "#1\n" + returnValues[0].ToString() + "\n#2\n" + returnValues[1].ToString();

        //        return AppCore.Result<IEnumerable<Core.Model.Sms>>.Set(true, data: null, message: finalResult);
        //    }
        //    catch (Exception e)
        //    {
        //        return AppCore.Result<IEnumerable<Core.Model.Sms>>.Failure();
        //    }
        //}
    }
}
