using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Service
{
    public interface IAuthService : IService
    {
        Task<AppCore.Result<Core.Model.Auth>> IsUserAuthenticated(Guid userId, Guid commandID);
    }
}
