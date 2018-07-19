using System;

namespace Core.Model
{
    public class Attachment : FileModel
    {
        public Guid ParentID { get; set; }

        public AttachmentType Type { get; set; }
    }
}
