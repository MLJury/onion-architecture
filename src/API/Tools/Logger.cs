namespace API.Tools
{
    public class Logger : AppCore.EventLogger.WindowsEventLogger, Core.IEventLogger
    {
        public Logger()
            : base("Onion")
        {
        }
    }
}