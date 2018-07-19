using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using AppCore;
using ds = Core.DataSource;

namespace Domain.Services
{
    class AuthService : Service<ds.IAuthDataSource>, Core.Service.IAuthService
    {
        public AuthService(
            AppCore.IOC.IContainer container
            )
            : base(container)
        {
        }

        public Task<AppCore.Result<Core.Model.Auth>> IsUserAuthenticated(Guid userID, Guid commandID)
            => _dataSource.IsUserAuthenticated(userID, commandID);
    }
}
