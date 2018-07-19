namespace API.Tools
{
    public class ObjectSerializer : AppCore.IObjectSerializer
    {
        public T Deserialize<T>(string serializedValue)
            => Newtonsoft.Json.JsonConvert.DeserializeObject<T>(serializedValue);

        public string Serialize(object obj)
            => Newtonsoft.Json.JsonConvert.SerializeObject(obj);
    }
}