using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Service
{
    public interface IAttachmentService : IService
    {
        Task<AppCore.Result<Model.Attachment>> AddAsync(Model.Attachment attachment);

        Task<AppCore.Result<Model.Attachment>> EditAsync(Model.Attachment attachment);

        Task<AppCore.Result> DeleteAsync(Model.Attachment attachment);

        Task<AppCore.Result<IEnumerable<Model.Attachment>>> ListAsync(Model.AttachmentListVM model);

        Task<AppCore.Result<Model.Attachment>> GetAsync(Guid id);
    }
}
