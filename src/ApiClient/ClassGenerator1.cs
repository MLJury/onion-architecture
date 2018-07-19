using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Onion.ApiClient.Interface;
using model = Core.Model;

namespace Onion.ApiClient
{
	abstract class Service
    {
    }

		 partial class AttachmentService: Service, IAttachmentService
		 {
			public AttachmentService(IOnionClient client)
			{
				_client = client;
			}
			readonly IOnionClient _client;

			            public virtual Task<AppCore.Result<model.Attachment>> Add( model.Attachment model, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"model", model == null ? null : model.ToString()}};
			const string url = "api/v1/Attachment/Add";
							return _client.SendAsync<model.Attachment>(true, url, routeParamValues, httpHeaders, model);
						}

                        public virtual Task<AppCore.Result<model.Attachment>> Edit( model.Attachment model, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"model", model == null ? null : model.ToString()}};
			const string url = "api/v1/Attachment/Edit";
							return _client.SendAsync<model.Attachment>(true, url, routeParamValues, httpHeaders, model);
						}

                        public virtual Task<AppCore.Result> Delete( model.Attachment model, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"model", model == null ? null : model.ToString()}};
			const string url = "api/v1/Attachment/Delete";
							return _client.SendAsync(true, url, routeParamValues, httpHeaders, model);
						}

                        public virtual Task<AppCore.Result<IEnumerable<model.Attachment>>> List( model.AttachmentListVM model, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"model", model == null ? null : model.ToString()}};
			const string url = "api/v1/Attachment/List";
							return _client.SendAsync<IEnumerable<model.Attachment>>(true, url, routeParamValues, httpHeaders, model);
						}

                        public virtual Task<AppCore.Result<model.Attachment>> Get( Guid id, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"id", id == null ? null : id.ToString()}};
			const string url = "api/v1/Attachment/Get/{id:guid}";
							return _client.SendAsync<model.Attachment>(true, url, routeParamValues, httpHeaders);
						}

            		 }
  
		 partial class FlowService: Service, IFlowService
		 {
			public FlowService(IOnionClient client)
			{
				_client = client;
			}
			readonly IOnionClient _client;

			            public virtual Task<AppCore.Result> Reject( model.Flow flow, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"flow", flow == null ? null : flow.ToString()}};
			const string url = "api/v1/flow/reject";
							return _client.SendAsync(true, url, routeParamValues, httpHeaders, flow);
						}

                        public virtual Task<AppCore.Result> SetAsRead( Guid documentID, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"documentID", documentID == null ? null : documentID.ToString()}};
			const string url = "api/v1/flow/set-as-read/{documentID:guid}";
							return _client.SendAsync(true, url, routeParamValues, httpHeaders);
						}

                        public virtual Task<AppCore.Result> SetAsUnRead( Guid documentID, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"documentID", documentID == null ? null : documentID.ToString()}};
			const string url = "api/v1/flow/set-as-unread-read/{documentID:guid}";
							return _client.SendAsync(true, url, routeParamValues, httpHeaders);
						}

                        public virtual Task<AppCore.Result> SendDocument( model.Flow flow, IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{{"flow", flow == null ? null : flow.ToString()}};
			const string url = "api/v1/flow/SendDocument";
							return _client.SendAsync(true, url, routeParamValues, httpHeaders, flow);
						}

            		 }
  
		 partial class DocumentService: Service, IDocumentService
		 {
			public DocumentService(IOnionClient client)
			{
				_client = client;
			}
			readonly IOnionClient _client;

			            public virtual Task<AppCore.Result<IEnumerable<model.DocumentStatistics>>> ListStatistics( IDictionary<string, string> httpHeaders = null)
			{
						var routeParamValues = new Dictionary<string, string>{};
			const string url = "api/v1/document/list-statistics";
							return _client.SendAsync<IEnumerable<model.DocumentStatistics>>(true, url, routeParamValues, httpHeaders);
						}

            		 }
  }