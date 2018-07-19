using Core.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using m = Core.Model;

namespace Kama.Mefa.Azmoon.Infrastructure.DAL
{
    class AuthDataSource : DataSource, Core.DataSource.IAuthDataSource
    {
        public AuthDataSource(AppCore.IOC.IContainer container)
            : base(container)
        {
        }

        public async Task<AppCore.Result<m.Auth>> IsUserAuthenticated(Guid userID, Guid commandID)
        {
            try
            {
                //var result = (await _dbPBL.IsUserAuthenticatedAsync(
                //_userID: userID,
                //_commandID: commandID)).ToActionResult<m.Auth>();
                //return result;

                return AppCore.Result<m.Auth>.Successful();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
