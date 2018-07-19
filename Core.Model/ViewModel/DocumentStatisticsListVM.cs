using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Core.Model
{
    public class DocumentStatisticsListVM : Model
    {
        public DocumentType DocumentType { get; set; }

        public Guid? UserPositionID { get; set; }
    }
}
