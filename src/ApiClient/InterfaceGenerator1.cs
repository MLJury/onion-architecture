

using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using model = Core.Model;

namespace Onion.ApiClient.Interface
{

	public interface IOnionClient : Library.ApiClient.IClient
	{
	}

	public interface IOnionHostInfo:Library.ApiClient.IHostInfo
	{
	}

	public interface IService
	{
	}

		 public interface IAttachmentService: IService
		 {
						 				Task<AppCore.Result<model.Attachment>> Add(model.Attachment model, IDictionary<string, string> httpHeaders = null);

						 				Task<AppCore.Result<model.Attachment>> Edit(model.Attachment model, IDictionary<string, string> httpHeaders = null);

						 				Task<AppCore.Result> Delete(model.Attachment model, IDictionary<string, string> httpHeaders = null);

						 				Task<AppCore.Result<IEnumerable<model.Attachment>>> List(model.AttachmentListVM model, IDictionary<string, string> httpHeaders = null);

						 				Task<AppCore.Result<model.Attachment>> Get(Guid id, IDictionary<string, string> httpHeaders = null);

					 }

  		 public interface IFlowService: IService
		 {
						 				Task<AppCore.Result> Reject(model.Flow flow, IDictionary<string, string> httpHeaders = null);

						 				Task<AppCore.Result> SetAsRead(Guid documentID, IDictionary<string, string> httpHeaders = null);

						 				Task<AppCore.Result> SetAsUnRead(Guid documentID, IDictionary<string, string> httpHeaders = null);

						 				Task<AppCore.Result> SendDocument(model.Flow flow, IDictionary<string, string> httpHeaders = null);

					 }

  		 public interface IDocumentService: IService
		 {
						 				Task<AppCore.Result<IEnumerable<model.DocumentStatistics>>> ListStatistics( IDictionary<string, string> httpHeaders = null);

					 }

  }