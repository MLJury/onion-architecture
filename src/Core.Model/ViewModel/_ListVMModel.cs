using System;

namespace Core.Model
{
    public abstract class ListVMModel : Model
    {
        public int PageSize { get; set; }
        public int PageIndex { get; set; }
    }
}