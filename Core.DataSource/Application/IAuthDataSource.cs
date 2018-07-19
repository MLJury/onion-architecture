using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.DataSource
{
    public interface IAuthDataSource : IDataSource
    {
        Task<AppCore.Result<Core.Model.Auth>> IsUserAuthenticated(Guid userID, Guid commandID);
    }
}
