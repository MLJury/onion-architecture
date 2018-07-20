using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    static class Extensions
    {
        /// <summary>
        /// Render string of row template with default convention '[MODELPROPERTYNAME]'
        /// </summary>
        /// <param name="template">Row Template</param>
        /// <param name="model">Object of Template Model</param>
        /// <returns>Rendered Template</returns>
        public static string RenderTemplateWithModel(this string template, object model)
        {
            foreach (var prop in model.GetType().GetProperties())
            {
                template = template.Replace($"[{prop.Name}]", prop.GetValue(model)?.ToString() ?? string.Empty);
            }

            return template;
        }

        public static bool IsNullOrEmpty(this Guid guid)
            => guid == null || guid == Guid.Empty;
    }
}
