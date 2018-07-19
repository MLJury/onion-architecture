using System;

namespace Core.Model
{
    public class Flow : Flow<DocState>
    {
        public T ToOtherFLowType<T>()
        {
            var str = Newtonsoft.Json.JsonConvert.SerializeObject(this);
            return Newtonsoft.Json.JsonConvert.DeserializeObject<T>(str);
        }
    }

    public class Flow<TDocState>: Model
    {
        public Guid DocumentID { get; set; }

        public Guid FromUserID { get; set; }

        public Guid FromPositionID { get; set; }

        public Guid ToPositionID { get; set; }

        public DateTime Date { get; set; }

        public string FromUserFullName { get; set; }

        public string ToUserFullName { get; set; }

        //public Organization.Core.Model.AzmoonPositionType FromUserPositionType { get; set; }

        //public Organization.Core.Model.AzmoonPositionType ToUserPositionType { get; set; }

        public TDocState FromDocState { get; set; }

        public TDocState ToDocState { get; set; }

        public SendType SendType { get; set; }

        public string Comment { get; set; }

        public DateTime? ReadDate { get; set; }

        public DateTime? ActionDate { get; set; }

        public bool IsRead { get; set; }


    }
}
