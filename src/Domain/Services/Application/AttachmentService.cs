using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using model = Core.Model;

namespace Domain.Services
{
    class AttachmentService:Service<Core.DataSource.IAttachmentDataSource>, Core.Service.IAttachmentService
    {
        public AttachmentService(AppCore.IOC.IContainer container)
            :base(container)
        {
        }

        public Task<AppCore.Result<model.Attachment>> AddAsync(model.Attachment attachment)
        {
            var validation = _ValidateForSave(attachment);
            if (!validation.Result.Success)
                return AppCore.Result<model.Attachment>.FailureAsync(message: validation.Result.Message);

            attachment.ID = Guid.NewGuid();
            return _dataSource.CreateAsync(attachment, null);
        }

        public Task<AppCore.Result<model.Attachment>> EditAsync(model.Attachment attachment)
        {
            var validation = _ValidateForSave(attachment);
            if (!validation.Result.Success)
                return AppCore.Result<model.Attachment>.FailureAsync(message: validation.Result.Message);

            return _dataSource.UpdateAsync(attachment, null);
        }

        public Task<AppCore.Result> DeleteAsync(model.Attachment attachment)
            => _dataSource.DeleteAsync(attachment.ID, null);

        public Task<AppCore.Result<model.Attachment>> GetAsync(Guid id)
            => _dataSource.GetAsync(id);

        public Task<AppCore.Result<IEnumerable<model.Attachment>>> ListAsync(model.AttachmentListVM model)
            => _dataSource.ListAsync(model);

        private Task<AppCore.Result<model.Attachment>> _ValidateForSave(model.Attachment attachment)
        {
            //var validation = ValidateModel(attachment);
            //if (!validation.Success)
            //    return AppCore.Result<model.Attachment>.FailureAsync(message: validation.Message);

            return AppCore.Result<model.Attachment>.SuccessfulAsync();
        }
    }
}
