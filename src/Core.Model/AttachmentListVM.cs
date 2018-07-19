using System;

namespace Core.Model
{
    public class AttachmentListVM
    {
        public Guid ParentID { get; set; }

        public AttachmentType Type { get; set; }
    }
}
