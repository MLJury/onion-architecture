using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.DataSource
{
    public interface IAttachmentDataSource:IDataSource
    {
        Task<AppCore.Result<Model.Attachment>> CreateAsync(Model.Attachment attachment, AppCore.IActivityLog log);

        Task<AppCore.Result<Model.Attachment>> UpdateAsync(Model.Attachment attachment, AppCore.IActivityLog log);

        Task<AppCore.Result> DeleteAsync(Guid id, AppCore.IActivityLog log);

        Task<AppCore.Result<Model.Attachment>> GetAsync(Guid id);

        Task<AppCore.Result<IEnumerable<Model.Attachment>>> ListAsync(Model.AttachmentListVM model);

        Task<AppCore.Result<IEnumerable<Model.Attachment>>> GetAttachmentsByParentIDsAsync(List<Guid> parentIDs);
    }
}
