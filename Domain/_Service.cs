using Core.Service;
using Core.DataSource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    abstract class Service
    {
        public Service(AppCore.IOC.IContainer container)
        {
            _container = container;
        }

        protected readonly AppCore.IOC.IContainer _container;
    }

    abstract class Service<TDataSource> : Service
        where TDataSource : Core.DataSource.IDataSource
    {
        public Service(AppCore.IOC.IContainer container)
            : base(container)
        {
            try
            {
                _dataSource = _container.Resolve<TDataSource>();
            }
            catch
            {
            }
        }

        private AppCore.RequestInfo requestInfo;

        public AppCore.RequestInfo RequestInfo
        {
            get { return requestInfo; }
            set
            {
                requestInfo = value;

                GetType().GetFields(BindingFlags.NonPublic | BindingFlags.Instance)
                    .ToList().ForEach(f =>
                    {
                        var obj = f.GetValue(this);
                        if (obj is IDataSource)
                            ((IDataSource)obj).RequestInfo = requestInfo;
                        else if (obj is IService)
                            ((IService)obj).RequestInfo = requestInfo;
                    });
            }
        }

        protected readonly TDataSource _dataSource;
    }
}