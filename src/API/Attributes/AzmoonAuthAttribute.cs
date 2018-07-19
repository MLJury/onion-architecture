using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Core.Model;

namespace API.Auth.Attributes
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
    public class AuthAttribute : Attribute
    {
    }
}