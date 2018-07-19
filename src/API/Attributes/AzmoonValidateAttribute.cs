using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Auth.Attributes
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
    public class AzmoonValidateAttribute : Attribute
    {
    }
}