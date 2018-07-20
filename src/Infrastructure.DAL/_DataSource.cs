using Core;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;

namespace Infrastructure.DAL
{
    abstract class DataSource
    {
        public AppCore.RequestInfo RequestInfo { get; set; }

        public DataSource(AppCore.IOC.IContainer container)
        {

            _container = container;
            _objSerializer = _container.TryResolve<AppCore.IObjectSerializer>(); 

            var connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Azmoon"]?.ConnectionString;
        }

        protected readonly AppCore.IOC.IContainer _container;
        protected readonly AppCore.IObjectSerializer _objSerializer;
        //protected readonly USR _dbUser;
    }
}
