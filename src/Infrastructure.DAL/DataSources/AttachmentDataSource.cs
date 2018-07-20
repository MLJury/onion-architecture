using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using m = Core.Model;

namespace Infrastructure.DAL
{
    class AttachmentDataSource : DataSource, Core.DataSource.IAttachmentDataSource
    {
        public AttachmentDataSource(AppCore.IOC.IContainer container)
            : base(container)
        {
        }

        private async Task<AppCore.Result<m.Attachment>> ModifyAsync(bool isNewRecord, m.Attachment attachment, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.ModifyAttachmentAsync(
                //_isNewRecord: isNewRecord,
                //_id: attachment.ID,
                //_parentID: attachment.ParentID,
                //_type: (byte)attachment.Type,
                //_fileName: attachment.FileName,
                //_comment: attachment.Comment,
                //_data: attachment.Data,
                //_log: log?.Value
                //)).ToActionResult<m.Attachment>();

                //if (result.Success)
                //    return await this.GetAsync(attachment.ID);

                //return result;
                return AppCore.Result<m.Attachment>.Successful();

            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Task<AppCore.Result<m.Attachment>> CreateAsync(m.Attachment attachment, AppCore.IActivityLog log)
            => ModifyAsync(true, attachment, log);

        public Task<AppCore.Result<m.Attachment>> UpdateAsync(m.Attachment attachment, AppCore.IActivityLog log)
            => ModifyAsync(false, attachment, log);

        public async Task<AppCore.Result> DeleteAsync(Guid id, AppCore.IActivityLog log)
        {
            try
            {
                //var result = (await _dbPBL.DeleteAttachmentAsync(_id: id, _log: log?.Value)).ToActionResult();
                //return result;

                return AppCore.Result.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result<m.Attachment>> GetAsync(Guid id)
        {
            try
            {
                //var result = (await _dbPBL.GetAttachmentAsync(id)).ToActionResult<m.Attachment>();
                //return result;

                return AppCore.Result<m.Attachment>.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result<IEnumerable<m.Attachment>>> ListAsync(m.AttachmentListVM model)
        {
            try
            {
                //var result = (await _dbPBL.GetAttachmentsAsync(
                //        _parentID: model.ParentID,
                //        _type: (byte)model.Type
                //        )).ToListActionResult<m.Attachment>();

                //return result;

                return AppCore.Result<IEnumerable<m.Attachment>>.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public async Task<AppCore.Result<IEnumerable<m.Attachment>>> GetAttachmentsByParentIDsAsync(List<Guid> parentIDs)
        {
            try
            {
                //var s = Newtonsoft.Json.JsonConvert.SerializeObject(parentIDs);
                //var result = (await _dbPBL.GetAttachmentsByParentIDsAsync(s)).ToListActionResult<m.Attachment>();
                //return result;

                return AppCore.Result<IEnumerable<m.Attachment>>.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
