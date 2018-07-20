using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    /// <summary>
    /// این کلاس برای بازگرداندن تعداد اقلام موجود در کارتابل مورد استفاده قرار می گیرد
    /// </summary>
    public class DocumentStatistics
    {
        public int UnReadCount { get; set; }

        public int InActionCount { get; set; }
    }
}
