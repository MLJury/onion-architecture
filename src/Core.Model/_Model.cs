using System;

namespace Core.Model
{
    public abstract class Model
    {
        public Guid ID { get; set; }

    }

    public abstract class FileModel : Model
    {
        public override string ToString() => FileName;

        public string FileName { get; set; }

        public string Comment { get; set; }

        public byte[] Data { get; set; }
    }
}