using System;
using DatabaseModel;
using System.Threading.Tasks;

namespace Infrastructure.DAL
{
class PBL: Database
{
#region Constructors
public PBL(string connectionString)
	:base(connectionString){}

public PBL(string connectionString, IModelValueBinder modelValueBinder)
	:base(connectionString, modelValueBinder){}
#endregion

#region ModifyAttachment

public System.Data.SqlClient.SqlCommand GetCommand_ModifyAttachment(bool? _isNewRecord, Guid? _id, Guid? _parentID, byte? _type, string _fileName, string _comment, byte[] _data, string _log)
{
return base.CreateCommand("pbl.spModifyAttachment", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AParentID", IsOutput = false, Value = _parentID == null ? DBNull.Value : (object)_parentID }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AFileName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_fileName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_fileName) }, 
					new Parameter { Name = "@AComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_comment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_comment) }, 
					new Parameter { Name = "@AData", IsOutput = false, Value = _data == null ? DBNull.Value : (object)_data }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyAttachmentAsync(bool? _isNewRecord, Guid? _id, Guid? _parentID, byte? _type, string _fileName, string _comment, byte[] _data, string _log)
{
	using(var cmd = GetCommand_ModifyAttachment(_isNewRecord, _id, _parentID, _type, _fileName, _comment, _data, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyAttachment(bool? _isNewRecord, Guid? _id, Guid? _parentID, byte? _type, string _fileName, string _comment, byte[] _data, string _log)
{
	using(var cmd = GetCommand_ModifyAttachment(_isNewRecord, _id, _parentID, _type, _fileName, _comment, _data, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetCommandsByUser

public System.Data.SqlClient.SqlCommand GetCommand_GetCommandsByUser(Guid? _userID)
{
return base.CreateCommand("pbl.spGetCommandsByUser", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
	});

}

public async Task<ResultSet> GetCommandsByUserAsync(Guid? _userID)
{
	using(var cmd = GetCommand_GetCommandsByUser(_userID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetCommandsByUser(Guid? _userID)
{
	using(var cmd = GetCommand_GetCommandsByUser(_userID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region IsUserAuthenticated

public System.Data.SqlClient.SqlCommand GetCommand_IsUserAuthenticated(Guid? _userID, Guid? _commandID)
{
return base.CreateCommand("pbl.spIsUserAuthenticated", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ACommandID", IsOutput = false, Value = _commandID == null ? DBNull.Value : (object)_commandID }, 
	});

}

public async Task<ResultSet> IsUserAuthenticatedAsync(Guid? _userID, Guid? _commandID)
{
	using(var cmd = GetCommand_IsUserAuthenticated(_userID, _commandID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet IsUserAuthenticated(Guid? _userID, Guid? _commandID)
{
	using(var cmd = GetCommand_IsUserAuthenticated(_userID, _commandID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyWorkPlace

public System.Data.SqlClient.SqlCommand GetCommand_ModifyWorkPlace(bool? _isNewRecord, Guid? _id, string _name, byte? _type, bool? _nameNeeded, bool? _enable, int? _order, string _log)
{
return base.CreateCommand("pbl.spModifyWorkPlace", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_name) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_name) }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@ANameNeeded", IsOutput = false, Value = _nameNeeded == null ? DBNull.Value : (object)_nameNeeded }, 
					new Parameter { Name = "@AEnable", IsOutput = false, Value = _enable == null ? DBNull.Value : (object)_enable }, 
					new Parameter { Name = "@AOrder", IsOutput = false, Value = _order == null ? DBNull.Value : (object)_order }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyWorkPlaceAsync(bool? _isNewRecord, Guid? _id, string _name, byte? _type, bool? _nameNeeded, bool? _enable, int? _order, string _log)
{
	using(var cmd = GetCommand_ModifyWorkPlace(_isNewRecord, _id, _name, _type, _nameNeeded, _enable, _order, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyWorkPlace(bool? _isNewRecord, Guid? _id, string _name, byte? _type, bool? _nameNeeded, bool? _enable, int? _order, string _log)
{
	using(var cmd = GetCommand_ModifyWorkPlace(_isNewRecord, _id, _name, _type, _nameNeeded, _enable, _order, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetWorkPlace

public System.Data.SqlClient.SqlCommand GetCommand_GetWorkPlace(Guid? _id)
{
return base.CreateCommand("pbl.spGetWorkPlace", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetWorkPlaceAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetWorkPlace(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetWorkPlace(Guid? _id)
{
	using(var cmd = GetCommand_GetWorkPlace(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetWorkPlaces

public System.Data.SqlClient.SqlCommand GetCommand_GetWorkPlaces(string _name, string _code, byte? _enableOrDisable, byte? _type, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("pbl.spGetWorkPlaces", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_name) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_name) }, 
					new Parameter { Name = "@ACode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_code) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_code) }, 
					new Parameter { Name = "@AEnableOrDisable", IsOutput = false, Value = _enableOrDisable == null ? DBNull.Value : (object)_enableOrDisable }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetWorkPlacesAsync(string _name, string _code, byte? _enableOrDisable, byte? _type, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetWorkPlaces(_name, _code, _enableOrDisable, _type, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetWorkPlaces(string _name, string _code, byte? _enableOrDisable, byte? _type, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetWorkPlaces(_name, _code, _enableOrDisable, _type, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteWorkPlace

public System.Data.SqlClient.SqlCommand GetCommand_DeleteWorkPlace(Guid? _id, string _log)
{
return base.CreateCommand("pbl.spDeleteWorkPlace", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteWorkPlaceAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteWorkPlace(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteWorkPlace(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteWorkPlace(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetFlows

public System.Data.SqlClient.SqlCommand GetCommand_GetFlows(Guid? _documentID)
{
return base.CreateCommand("pbl.spGetFlows", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ADocumentID", IsOutput = false, Value = _documentID == null ? DBNull.Value : (object)_documentID }, 
	});

}

public async Task<ResultSet> GetFlowsAsync(Guid? _documentID)
{
	using(var cmd = GetCommand_GetFlows(_documentID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetFlows(Guid? _documentID)
{
	using(var cmd = GetCommand_GetFlows(_documentID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyPoll

public System.Data.SqlClient.SqlCommand GetCommand_ModifyPoll(bool? _isNewRecord, string _userOpinions, Guid? _admissionID, Guid? _userID, string _log)
{
return base.CreateCommand("pbl.spModifyPoll", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AUserOpinions", IsOutput = false, Value = string.IsNullOrWhiteSpace(_userOpinions) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_userOpinions) }, 
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyPollAsync(bool? _isNewRecord, string _userOpinions, Guid? _admissionID, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifyPoll(_isNewRecord, _userOpinions, _admissionID, _userID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyPoll(bool? _isNewRecord, string _userOpinions, Guid? _admissionID, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifyPoll(_isNewRecord, _userOpinions, _admissionID, _userID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetDocumentStatistics

public System.Data.SqlClient.SqlCommand GetCommand_GetDocumentStatistics(Guid? _userPositionID)
{
return base.CreateCommand("pbl.spGetDocumentStatistics", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
	});

}

public async Task<ResultSet> GetDocumentStatisticsAsync(Guid? _userPositionID)
{
	using(var cmd = GetCommand_GetDocumentStatistics(_userPositionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetDocumentStatistics(Guid? _userPositionID)
{
	using(var cmd = GetCommand_GetDocumentStatistics(_userPositionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifySurvey

public System.Data.SqlClient.SqlCommand GetCommand_ModifySurvey(bool? _isNewRecord, Guid? _id, Guid? _examRequestID, string _surveyDetail, Guid? _userID, string _log)
{
return base.CreateCommand("pbl.spModifySurvey", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AExamRequestID", IsOutput = false, Value = _examRequestID == null ? DBNull.Value : (object)_examRequestID }, 
					new Parameter { Name = "@ASurveyDetail", IsOutput = false, Value = string.IsNullOrWhiteSpace(_surveyDetail) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_surveyDetail) }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifySurveyAsync(bool? _isNewRecord, Guid? _id, Guid? _examRequestID, string _surveyDetail, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifySurvey(_isNewRecord, _id, _examRequestID, _surveyDetail, _userID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifySurvey(bool? _isNewRecord, Guid? _id, Guid? _examRequestID, string _surveyDetail, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifySurvey(_isNewRecord, _id, _examRequestID, _surveyDetail, _userID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetSurveys

public System.Data.SqlClient.SqlCommand GetCommand_GetSurveys(Guid? _admissionID)
{
return base.CreateCommand("pbl.spGetSurveys", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
	});

}

public async Task<ResultSet> GetSurveysAsync(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveys(_admissionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetSurveys(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveys(_admissionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetSurveyDetailByAdmission

public System.Data.SqlClient.SqlCommand GetCommand_GetSurveyDetailByAdmission(Guid? _admissionID)
{
return base.CreateCommand("pbl.spGetSurveyDetailByAdmission", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
	});

}

public async Task<ResultSet> GetSurveyDetailByAdmissionAsync(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveyDetailByAdmission(_admissionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetSurveyDetailByAdmission(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveyDetailByAdmission(_admissionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyUniversity

public System.Data.SqlClient.SqlCommand GetCommand_ModifyUniversity(bool? _isNewRecord, Guid? _id, string _name, byte? _type, bool? _enable, int? _order, bool? _isInternal, string _log)
{
return base.CreateCommand("pbl.spModifyUniversity", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_name) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_name) }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AEnable", IsOutput = false, Value = _enable == null ? DBNull.Value : (object)_enable }, 
					new Parameter { Name = "@AOrder", IsOutput = false, Value = _order == null ? DBNull.Value : (object)_order }, 
					new Parameter { Name = "@AIsInternal", IsOutput = false, Value = _isInternal == null ? DBNull.Value : (object)_isInternal }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyUniversityAsync(bool? _isNewRecord, Guid? _id, string _name, byte? _type, bool? _enable, int? _order, bool? _isInternal, string _log)
{
	using(var cmd = GetCommand_ModifyUniversity(_isNewRecord, _id, _name, _type, _enable, _order, _isInternal, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyUniversity(bool? _isNewRecord, Guid? _id, string _name, byte? _type, bool? _enable, int? _order, bool? _isInternal, string _log)
{
	using(var cmd = GetCommand_ModifyUniversity(_isNewRecord, _id, _name, _type, _enable, _order, _isInternal, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetUniversity

public System.Data.SqlClient.SqlCommand GetCommand_GetUniversity(Guid? _id)
{
return base.CreateCommand("pbl.spGetUniversity", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetUniversityAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetUniversity(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetUniversity(Guid? _id)
{
	using(var cmd = GetCommand_GetUniversity(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetEducationFields

public System.Data.SqlClient.SqlCommand GetCommand_GetEducationFields(string _name, string _code, byte? _enableOrDisable, byte? _educationFieldType, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("pbl.spGetEducationFields", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_name) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_name) }, 
					new Parameter { Name = "@ACode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_code) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_code) }, 
					new Parameter { Name = "@AEnableOrDisable", IsOutput = false, Value = _enableOrDisable == null ? DBNull.Value : (object)_enableOrDisable }, 
					new Parameter { Name = "@AEducationFieldType", IsOutput = false, Value = _educationFieldType == null ? DBNull.Value : (object)_educationFieldType }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetEducationFieldsAsync(string _name, string _code, byte? _enableOrDisable, byte? _educationFieldType, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetEducationFields(_name, _code, _enableOrDisable, _educationFieldType, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetEducationFields(string _name, string _code, byte? _enableOrDisable, byte? _educationFieldType, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetEducationFields(_name, _code, _enableOrDisable, _educationFieldType, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetSurveyByRequest

public System.Data.SqlClient.SqlCommand GetCommand_GetSurveyByRequest(Guid? _examRequestID)
{
return base.CreateCommand("pbl.spGetSurveyByRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamRequestID", IsOutput = false, Value = _examRequestID == null ? DBNull.Value : (object)_examRequestID }, 
	});

}

public async Task<ResultSet> GetSurveyByRequestAsync(Guid? _examRequestID)
{
	using(var cmd = GetCommand_GetSurveyByRequest(_examRequestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetSurveyByRequest(Guid? _examRequestID)
{
	using(var cmd = GetCommand_GetSurveyByRequest(_examRequestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region AddLog

public System.Data.SqlClient.SqlCommand GetCommand_AddLog(string _log)
{
return base.CreateCommand("pbl.spAddLog", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> AddLogAsync(string _log)
{
	using(var cmd = GetCommand_AddLog(_log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet AddLog(string _log)
{
	using(var cmd = GetCommand_AddLog(_log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteSurvey

public System.Data.SqlClient.SqlCommand GetCommand_DeleteSurvey(Guid? _id, string _log)
{
return base.CreateCommand("pbl.spDeleteSurvey", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteSurveyAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteSurvey(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteSurvey(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteSurvey(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifySurveyTemplate

public System.Data.SqlClient.SqlCommand GetCommand_ModifySurveyTemplate(bool? _isNewRecord, Guid? _id, Guid? _admissionID, byte? _questionType, string _title, Guid? _userID, string _log)
{
return base.CreateCommand("pbl.spModifySurveyTemplate", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AQuestionType", IsOutput = false, Value = _questionType == null ? DBNull.Value : (object)_questionType }, 
					new Parameter { Name = "@ATitle", IsOutput = false, Value = string.IsNullOrWhiteSpace(_title) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_title) }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifySurveyTemplateAsync(bool? _isNewRecord, Guid? _id, Guid? _admissionID, byte? _questionType, string _title, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifySurveyTemplate(_isNewRecord, _id, _admissionID, _questionType, _title, _userID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifySurveyTemplate(bool? _isNewRecord, Guid? _id, Guid? _admissionID, byte? _questionType, string _title, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifySurveyTemplate(_isNewRecord, _id, _admissionID, _questionType, _title, _userID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetSurveyTemplates

public System.Data.SqlClient.SqlCommand GetCommand_GetSurveyTemplates(Guid? _admissionID)
{
return base.CreateCommand("pbl.spGetSurveyTemplates", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
	});

}

public async Task<ResultSet> GetSurveyTemplatesAsync(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveyTemplates(_admissionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetSurveyTemplates(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveyTemplates(_admissionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteBaseDocument

public System.Data.SqlClient.SqlCommand GetCommand_DeleteBaseDocument(Guid? _id, Guid? _removerID, string _log)
{
return base.CreateCommand("pbl.spDeleteBaseDocument", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARemoverID", IsOutput = false, Value = _removerID == null ? DBNull.Value : (object)_removerID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteBaseDocumentAsync(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteBaseDocument(_id, _removerID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteBaseDocument(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteBaseDocument(_id, _removerID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteSurveyTemplate

public System.Data.SqlClient.SqlCommand GetCommand_DeleteSurveyTemplate(Guid? _id, string _log)
{
return base.CreateCommand("pbl.spDeleteSurveyTemplate", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteSurveyTemplateAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteSurveyTemplate(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteSurveyTemplate(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteSurveyTemplate(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region RejectFlow

public System.Data.SqlClient.SqlCommand GetCommand_RejectFlow(Guid? _documentID, Guid? _fromUserID, Guid? _fromPositionID, string _comment, string _log)
{
return base.CreateCommand("pbl.spRejectFlow", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ADocumentID", IsOutput = false, Value = _documentID == null ? DBNull.Value : (object)_documentID }, 
					new Parameter { Name = "@AFromUserID", IsOutput = false, Value = _fromUserID == null ? DBNull.Value : (object)_fromUserID }, 
					new Parameter { Name = "@AFromPositionID", IsOutput = false, Value = _fromPositionID == null ? DBNull.Value : (object)_fromPositionID }, 
					new Parameter { Name = "@AComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_comment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_comment) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
					new Parameter { Name = "@AResult", IsOutput = true }, 
	});

}

public async Task<ResultSet> RejectFlowAsync(Guid? _documentID, Guid? _fromUserID, Guid? _fromPositionID, string _comment, string _log)
{
	using(var cmd = GetCommand_RejectFlow(_documentID, _fromUserID, _fromPositionID, _comment, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet RejectFlow(Guid? _documentID, Guid? _fromUserID, Guid? _fromPositionID, string _comment, string _log)
{
	using(var cmd = GetCommand_RejectFlow(_documentID, _fromUserID, _fromPositionID, _comment, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetSurveyTemplate

public System.Data.SqlClient.SqlCommand GetCommand_GetSurveyTemplate(Guid? _id)
{
return base.CreateCommand("pbl.spGetSurveyTemplate", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetSurveyTemplateAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetSurveyTemplate(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetSurveyTemplate(Guid? _id)
{
	using(var cmd = GetCommand_GetSurveyTemplate(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetPollsByUser

public System.Data.SqlClient.SqlCommand GetCommand_GetPollsByUser(Guid? _userID)
{
return base.CreateCommand("pbl.spGetPollsByUser", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
	});

}

public async Task<ResultSet> GetPollsByUserAsync(Guid? _userID)
{
	using(var cmd = GetCommand_GetPollsByUser(_userID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetPollsByUser(Guid? _userID)
{
	using(var cmd = GetCommand_GetPollsByUser(_userID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAttachment

public System.Data.SqlClient.SqlCommand GetCommand_GetAttachment(Guid? _id)
{
return base.CreateCommand("pbl.spGetAttachment", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetAttachmentAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetAttachment(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAttachment(Guid? _id)
{
	using(var cmd = GetCommand_GetAttachment(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteAttachment

public System.Data.SqlClient.SqlCommand GetCommand_DeleteAttachment(Guid? _id, string _log)
{
return base.CreateCommand("pbl.spDeleteAttachment", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteAttachmentAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteAttachment(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteAttachment(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteAttachment(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetSurveysStatistics

public System.Data.SqlClient.SqlCommand GetCommand_GetSurveysStatistics(Guid? _admissionID)
{
return base.CreateCommand("pbl.spGetSurveysStatistics", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
	});

}

public async Task<ResultSet> GetSurveysStatisticsAsync(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveysStatistics(_admissionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetSurveysStatistics(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetSurveysStatistics(_admissionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region AddFlows

public System.Data.SqlClient.SqlCommand GetCommand_AddFlows(string _flows, string _log)
{
return base.CreateCommand("pbl.spAddFlows", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AFlows", IsOutput = false, Value = string.IsNullOrWhiteSpace(_flows) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_flows) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
					new Parameter { Name = "@AResult", IsOutput = true }, 
	});

}

public async Task<ResultSet> AddFlowsAsync(string _flows, string _log)
{
	using(var cmd = GetCommand_AddFlows(_flows, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet AddFlows(string _flows, string _log)
{
	using(var cmd = GetCommand_AddFlows(_flows, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyEducationField

public System.Data.SqlClient.SqlCommand GetCommand_ModifyEducationField(bool? _isNewRecord, Guid? _id, string _name, byte? _educationFieldType, bool? _enable, int? _order, string _log)
{
return base.CreateCommand("pbl.spModifyEducationField", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_name) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_name) }, 
					new Parameter { Name = "@AEducationFieldType", IsOutput = false, Value = _educationFieldType == null ? DBNull.Value : (object)_educationFieldType }, 
					new Parameter { Name = "@AEnable", IsOutput = false, Value = _enable == null ? DBNull.Value : (object)_enable }, 
					new Parameter { Name = "@AOrder", IsOutput = false, Value = _order == null ? DBNull.Value : (object)_order }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyEducationFieldAsync(bool? _isNewRecord, Guid? _id, string _name, byte? _educationFieldType, bool? _enable, int? _order, string _log)
{
	using(var cmd = GetCommand_ModifyEducationField(_isNewRecord, _id, _name, _educationFieldType, _enable, _order, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyEducationField(bool? _isNewRecord, Guid? _id, string _name, byte? _educationFieldType, bool? _enable, int? _order, string _log)
{
	using(var cmd = GetCommand_ModifyEducationField(_isNewRecord, _id, _name, _educationFieldType, _enable, _order, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetEducationField

public System.Data.SqlClient.SqlCommand GetCommand_GetEducationField(Guid? _id)
{
return base.CreateCommand("pbl.spGetEducationField", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetEducationFieldAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetEducationField(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetEducationField(Guid? _id)
{
	using(var cmd = GetCommand_GetEducationField(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteEducationField

public System.Data.SqlClient.SqlCommand GetCommand_DeleteEducationField(Guid? _id, string _log)
{
return base.CreateCommand("pbl.spDeleteEducationField", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteEducationFieldAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteEducationField(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteEducationField(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteEducationField(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region SetFlowReadState

public System.Data.SqlClient.SqlCommand GetCommand_SetFlowReadState(Guid? _documentID, Guid? _userPositionID, bool? _isRead, string _log)
{
return base.CreateCommand("pbl.spSetFlowReadState", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ADocumentID", IsOutput = false, Value = _documentID == null ? DBNull.Value : (object)_documentID }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@AIsRead", IsOutput = false, Value = _isRead == null ? DBNull.Value : (object)_isRead }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> SetFlowReadStateAsync(Guid? _documentID, Guid? _userPositionID, bool? _isRead, string _log)
{
	using(var cmd = GetCommand_SetFlowReadState(_documentID, _userPositionID, _isRead, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet SetFlowReadState(Guid? _documentID, Guid? _userPositionID, bool? _isRead, string _log)
{
	using(var cmd = GetCommand_SetFlowReadState(_documentID, _userPositionID, _isRead, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAttachments

public System.Data.SqlClient.SqlCommand GetCommand_GetAttachments(Guid? _parentID, byte? _type)
{
return base.CreateCommand("pbl.spGetAttachments", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AParentID", IsOutput = false, Value = _parentID == null ? DBNull.Value : (object)_parentID }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
	});

}

public async Task<ResultSet> GetAttachmentsAsync(Guid? _parentID, byte? _type)
{
	using(var cmd = GetCommand_GetAttachments(_parentID, _type))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAttachments(Guid? _parentID, byte? _type)
{
	using(var cmd = GetCommand_GetAttachments(_parentID, _type))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetSurveyDetail

public System.Data.SqlClient.SqlCommand GetCommand_GetSurveyDetail(Guid? _surveyID)
{
return base.CreateCommand("pbl.spGetSurveyDetail", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ASurveyID", IsOutput = false, Value = _surveyID == null ? DBNull.Value : (object)_surveyID }, 
	});

}

public async Task<ResultSet> GetSurveyDetailAsync(Guid? _surveyID)
{
	using(var cmd = GetCommand_GetSurveyDetail(_surveyID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetSurveyDetail(Guid? _surveyID)
{
	using(var cmd = GetCommand_GetSurveyDetail(_surveyID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteUniversity

public System.Data.SqlClient.SqlCommand GetCommand_DeleteUniversity(Guid? _id, string _log)
{
return base.CreateCommand("pbl.spDeleteUniversity", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteUniversityAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteUniversity(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteUniversity(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteUniversity(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region AddFlow

public System.Data.SqlClient.SqlCommand GetCommand_AddFlow(Guid? _documentID, Guid? _fromPositionID, Guid? _toPositionID, short? _fromDocState, short? _toDocState, byte? _sendType, string _comment, string _log)
{
return base.CreateCommand("pbl.spAddFlow", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ADocumentID", IsOutput = false, Value = _documentID == null ? DBNull.Value : (object)_documentID }, 
					new Parameter { Name = "@AFromPositionID", IsOutput = false, Value = _fromPositionID == null ? DBNull.Value : (object)_fromPositionID }, 
					new Parameter { Name = "@AToPositionID", IsOutput = false, Value = _toPositionID == null ? DBNull.Value : (object)_toPositionID }, 
					new Parameter { Name = "@AFromDocState", IsOutput = false, Value = _fromDocState == null ? DBNull.Value : (object)_fromDocState }, 
					new Parameter { Name = "@AToDocState", IsOutput = false, Value = _toDocState == null ? DBNull.Value : (object)_toDocState }, 
					new Parameter { Name = "@ASendType", IsOutput = false, Value = _sendType == null ? DBNull.Value : (object)_sendType }, 
					new Parameter { Name = "@AComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_comment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_comment) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
					new Parameter { Name = "@AResult", IsOutput = true }, 
	});

}

public async Task<ResultSet> AddFlowAsync(Guid? _documentID, Guid? _fromPositionID, Guid? _toPositionID, short? _fromDocState, short? _toDocState, byte? _sendType, string _comment, string _log)
{
	using(var cmd = GetCommand_AddFlow(_documentID, _fromPositionID, _toPositionID, _fromDocState, _toDocState, _sendType, _comment, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet AddFlow(Guid? _documentID, Guid? _fromPositionID, Guid? _toPositionID, short? _fromDocState, short? _toDocState, byte? _sendType, string _comment, string _log)
{
	using(var cmd = GetCommand_AddFlow(_documentID, _fromPositionID, _toPositionID, _fromDocState, _toDocState, _sendType, _comment, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAttachmentsByParentIDs

public System.Data.SqlClient.SqlCommand GetCommand_GetAttachmentsByParentIDs(string _parentIDs)
{
return base.CreateCommand("pbl.spGetAttachmentsByParentIDs", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AParentIDs", IsOutput = false, Value = string.IsNullOrWhiteSpace(_parentIDs) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_parentIDs) }, 
	});

}

public async Task<ResultSet> GetAttachmentsByParentIDsAsync(string _parentIDs)
{
	using(var cmd = GetCommand_GetAttachmentsByParentIDs(_parentIDs))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAttachmentsByParentIDs(string _parentIDs)
{
	using(var cmd = GetCommand_GetAttachmentsByParentIDs(_parentIDs))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

}

class REQ: Database
{
#region Constructors
public REQ(string connectionString)
	:base(connectionString){}

public REQ(string connectionString, IModelValueBinder modelValueBinder)
	:base(connectionString, modelValueBinder){}
#endregion

#region DeleteWorkExperience

public System.Data.SqlClient.SqlCommand GetCommand_DeleteWorkExperience(Guid? _id, string _log)
{
return base.CreateCommand("req.spDeleteWorkExperience", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteWorkExperienceAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteWorkExperience(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteWorkExperience(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteWorkExperience(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteConditional

public System.Data.SqlClient.SqlCommand GetCommand_DeleteConditional(Guid? _id, string _log)
{
return base.CreateCommand("req.spDeleteConditional", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteConditionalAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteConditional(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteConditional(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteConditional(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetConditional

public System.Data.SqlClient.SqlCommand GetCommand_GetConditional(Guid? _id)
{
return base.CreateCommand("req.spGetConditional", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetConditionalAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetConditional(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetConditional(Guid? _id)
{
	using(var cmd = GetCommand_GetConditional(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region SetInterviewExemptionRequestID

public System.Data.SqlClient.SqlCommand GetCommand_SetInterviewExemptionRequestID(Guid? _id, Guid? _exemptionRequestID, string _log)
{
return base.CreateCommand("req.spSetInterviewExemptionRequestID", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AExemptionRequestID", IsOutput = false, Value = _exemptionRequestID == null ? DBNull.Value : (object)_exemptionRequestID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> SetInterviewExemptionRequestIDAsync(Guid? _id, Guid? _exemptionRequestID, string _log)
{
	using(var cmd = GetCommand_SetInterviewExemptionRequestID(_id, _exemptionRequestID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet SetInterviewExemptionRequestID(Guid? _id, Guid? _exemptionRequestID, string _log)
{
	using(var cmd = GetCommand_SetInterviewExemptionRequestID(_id, _exemptionRequestID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyEducationDegree

public System.Data.SqlClient.SqlCommand GetCommand_ModifyEducationDegree(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _grade, byte? _issuanceCountryType, Guid? _universityID, string _universityName, string _universityUnitName, Guid? _educationFieldID, DateTime? _graduateDate, string _educationFieldName, int? _relatedCurricula, string _log)
{
return base.CreateCommand("req.spModifyEducationDegree", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
					new Parameter { Name = "@AGrade", IsOutput = false, Value = _grade == null ? DBNull.Value : (object)_grade }, 
					new Parameter { Name = "@AIssuanceCountryType", IsOutput = false, Value = _issuanceCountryType == null ? DBNull.Value : (object)_issuanceCountryType }, 
					new Parameter { Name = "@AUniversityID", IsOutput = false, Value = _universityID == null ? DBNull.Value : (object)_universityID }, 
					new Parameter { Name = "@AUniversityName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_universityName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_universityName) }, 
					new Parameter { Name = "@AUniversityUnitName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_universityUnitName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_universityUnitName) }, 
					new Parameter { Name = "@AEducationFieldID", IsOutput = false, Value = _educationFieldID == null ? DBNull.Value : (object)_educationFieldID }, 
					new Parameter { Name = "@AGraduateDate", IsOutput = false, Value = _graduateDate == null ? DBNull.Value : (object)_graduateDate }, 
					new Parameter { Name = "@AEducationFieldName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_educationFieldName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_educationFieldName) }, 
					new Parameter { Name = "@ARelatedCurricula", IsOutput = false, Value = _relatedCurricula == null ? DBNull.Value : (object)_relatedCurricula }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyEducationDegreeAsync(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _grade, byte? _issuanceCountryType, Guid? _universityID, string _universityName, string _universityUnitName, Guid? _educationFieldID, DateTime? _graduateDate, string _educationFieldName, int? _relatedCurricula, string _log)
{
	using(var cmd = GetCommand_ModifyEducationDegree(_isNewRecord, _id, _requestID, _grade, _issuanceCountryType, _universityID, _universityName, _universityUnitName, _educationFieldID, _graduateDate, _educationFieldName, _relatedCurricula, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyEducationDegree(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _grade, byte? _issuanceCountryType, Guid? _universityID, string _universityName, string _universityUnitName, Guid? _educationFieldID, DateTime? _graduateDate, string _educationFieldName, int? _relatedCurricula, string _log)
{
	using(var cmd = GetCommand_ModifyEducationDegree(_isNewRecord, _id, _requestID, _grade, _issuanceCountryType, _universityID, _universityName, _universityUnitName, _educationFieldID, _graduateDate, _educationFieldName, _relatedCurricula, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetConditionals

public System.Data.SqlClient.SqlCommand GetCommand_GetConditionals(Guid? _admissionID, string _firstName, string _lastName, string _nationalCode, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetConditionals", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AFirstName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_firstName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_firstName) }, 
					new Parameter { Name = "@ALastName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_lastName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_lastName) }, 
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetConditionalsAsync(Guid? _admissionID, string _firstName, string _lastName, string _nationalCode, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetConditionals(_admissionID, _firstName, _lastName, _nationalCode, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetConditionals(Guid? _admissionID, string _firstName, string _lastName, string _nationalCode, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetConditionals(_admissionID, _firstName, _lastName, _nationalCode, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetEducationDegrees

public System.Data.SqlClient.SqlCommand GetCommand_GetEducationDegrees(Guid? _requestID)
{
return base.CreateCommand("req.spGetEducationDegrees", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
	});

}

public async Task<ResultSet> GetEducationDegreesAsync(Guid? _requestID)
{
	using(var cmd = GetCommand_GetEducationDegrees(_requestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetEducationDegrees(Guid? _requestID)
{
	using(var cmd = GetCommand_GetEducationDegrees(_requestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyConditional

public System.Data.SqlClient.SqlCommand GetCommand_ModifyConditional(bool? _isNewRecord, Guid? _id, Guid? _admissionID, string _firstName, string _lastName, string _fatherName, string _nationalCode, short? _examYear, short? _testType1, short? _testType2, short? _testType4, short? _testType8, string _log)
{
return base.CreateCommand("req.spModifyConditional", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AFirstName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_firstName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_firstName) }, 
					new Parameter { Name = "@ALastName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_lastName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_lastName) }, 
					new Parameter { Name = "@AFatherName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_fatherName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_fatherName) }, 
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
					new Parameter { Name = "@AExamYear", IsOutput = false, Value = _examYear == null ? DBNull.Value : (object)_examYear }, 
					new Parameter { Name = "@ATestType1", IsOutput = false, Value = _testType1 == null ? DBNull.Value : (object)_testType1 }, 
					new Parameter { Name = "@ATestType2", IsOutput = false, Value = _testType2 == null ? DBNull.Value : (object)_testType2 }, 
					new Parameter { Name = "@ATestType4", IsOutput = false, Value = _testType4 == null ? DBNull.Value : (object)_testType4 }, 
					new Parameter { Name = "@ATestType8", IsOutput = false, Value = _testType8 == null ? DBNull.Value : (object)_testType8 }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyConditionalAsync(bool? _isNewRecord, Guid? _id, Guid? _admissionID, string _firstName, string _lastName, string _fatherName, string _nationalCode, short? _examYear, short? _testType1, short? _testType2, short? _testType4, short? _testType8, string _log)
{
	using(var cmd = GetCommand_ModifyConditional(_isNewRecord, _id, _admissionID, _firstName, _lastName, _fatherName, _nationalCode, _examYear, _testType1, _testType2, _testType4, _testType8, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyConditional(bool? _isNewRecord, Guid? _id, Guid? _admissionID, string _firstName, string _lastName, string _fatherName, string _nationalCode, short? _examYear, short? _testType1, short? _testType2, short? _testType4, short? _testType8, string _log)
{
	using(var cmd = GetCommand_ModifyConditional(_isNewRecord, _id, _admissionID, _firstName, _lastName, _fatherName, _nationalCode, _examYear, _testType1, _testType2, _testType4, _testType8, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetProfessionalDegree

public System.Data.SqlClient.SqlCommand GetCommand_GetProfessionalDegree(Guid? _id)
{
return base.CreateCommand("req.spGetProfessionalDegree", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetProfessionalDegreeAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetProfessionalDegree(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetProfessionalDegree(Guid? _id)
{
	using(var cmd = GetCommand_GetProfessionalDegree(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteExamRequest

public System.Data.SqlClient.SqlCommand GetCommand_DeleteExamRequest(Guid? _id, Guid? _removerID, string _log)
{
return base.CreateCommand("req.spDeleteExamRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARemoverID", IsOutput = false, Value = _removerID == null ? DBNull.Value : (object)_removerID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteExamRequestAsync(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteExamRequest(_id, _removerID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteExamRequest(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteExamRequest(_id, _removerID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamFlowPrerequisite

public System.Data.SqlClient.SqlCommand GetCommand_GetExamFlowPrerequisite(Guid? _examRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
return base.CreateCommand("req.spGetExamFlowPrerequisite", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamRequestID", IsOutput = false, Value = _examRequestID == null ? DBNull.Value : (object)_examRequestID }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@AApplicationID", IsOutput = false, Value = _applicationID == null ? DBNull.Value : (object)_applicationID }, 
	});

}

public async Task<ResultSet> GetExamFlowPrerequisiteAsync(Guid? _examRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
	using(var cmd = GetCommand_GetExamFlowPrerequisite(_examRequestID, _userPositionID, _userID, _applicationID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamFlowPrerequisite(Guid? _examRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
	using(var cmd = GetCommand_GetExamFlowPrerequisite(_examRequestID, _userPositionID, _userID, _applicationID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExamRequest

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExamRequest(bool? _isNewRecord, Guid? _id, Guid? _admissionID, Guid? _applicantUserID, byte? _agreementType, bool? _agreementAccepted, byte? _demandedTestType, Guid? _creatorID, string _log)
{
return base.CreateCommand("req.spModifyExamRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AApplicantUserID", IsOutput = false, Value = _applicantUserID == null ? DBNull.Value : (object)_applicantUserID }, 
					new Parameter { Name = "@AAgreementType", IsOutput = false, Value = _agreementType == null ? DBNull.Value : (object)_agreementType }, 
					new Parameter { Name = "@AAgreementAccepted", IsOutput = false, Value = _agreementAccepted == null ? DBNull.Value : (object)_agreementAccepted }, 
					new Parameter { Name = "@ADemandedTestType", IsOutput = false, Value = _demandedTestType == null ? DBNull.Value : (object)_demandedTestType }, 
					new Parameter { Name = "@ACreatorID", IsOutput = false, Value = _creatorID == null ? DBNull.Value : (object)_creatorID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyExamRequestAsync(bool? _isNewRecord, Guid? _id, Guid? _admissionID, Guid? _applicantUserID, byte? _agreementType, bool? _agreementAccepted, byte? _demandedTestType, Guid? _creatorID, string _log)
{
	using(var cmd = GetCommand_ModifyExamRequest(_isNewRecord, _id, _admissionID, _applicantUserID, _agreementType, _agreementAccepted, _demandedTestType, _creatorID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExamRequest(bool? _isNewRecord, Guid? _id, Guid? _admissionID, Guid? _applicantUserID, byte? _agreementType, bool? _agreementAccepted, byte? _demandedTestType, Guid? _creatorID, string _log)
{
	using(var cmd = GetCommand_ModifyExamRequest(_isNewRecord, _id, _admissionID, _applicantUserID, _agreementType, _agreementAccepted, _demandedTestType, _creatorID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExamRequestChairNumbers

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExamRequestChairNumbers(Guid? _examAdmissionID, string _chairNumbers, Guid? _userID)
{
return base.CreateCommand("req.spModifyExamRequestChairNumbers", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamAdmissionID", IsOutput = false, Value = _examAdmissionID == null ? DBNull.Value : (object)_examAdmissionID }, 
					new Parameter { Name = "@AChairNumbers", IsOutput = false, Value = string.IsNullOrWhiteSpace(_chairNumbers) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_chairNumbers) }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
	});

}

public async Task<ResultSet> ModifyExamRequestChairNumbersAsync(Guid? _examAdmissionID, string _chairNumbers, Guid? _userID)
{
	using(var cmd = GetCommand_ModifyExamRequestChairNumbers(_examAdmissionID, _chairNumbers, _userID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExamRequestChairNumbers(Guid? _examAdmissionID, string _chairNumbers, Guid? _userID)
{
	using(var cmd = GetCommand_ModifyExamRequestChairNumbers(_examAdmissionID, _chairNumbers, _userID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAdmissionExamTests

public System.Data.SqlClient.SqlCommand GetCommand_GetAdmissionExamTests(Guid? _admissionID)
{
return base.CreateCommand("req.spGetAdmissionExamTests", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
	});

}

public async Task<ResultSet> GetAdmissionExamTestsAsync(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetAdmissionExamTests(_admissionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAdmissionExamTests(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetAdmissionExamTests(_admissionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteExemptionRequest

public System.Data.SqlClient.SqlCommand GetCommand_DeleteExemptionRequest(Guid? _id, Guid? _removerID, string _log)
{
return base.CreateCommand("req.spDeleteExemptionRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARemoverID", IsOutput = false, Value = _removerID == null ? DBNull.Value : (object)_removerID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteExemptionRequestAsync(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteExemptionRequest(_id, _removerID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteExemptionRequest(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteExemptionRequest(_id, _removerID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamTestByApplicant

public System.Data.SqlClient.SqlCommand GetCommand_GetExamTestByApplicant(Guid? _applicantID)
{
return base.CreateCommand("req.spGetExamTestByApplicant", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AApplicantID", IsOutput = false, Value = _applicantID == null ? DBNull.Value : (object)_applicantID }, 
	});

}

public async Task<ResultSet> GetExamTestByApplicantAsync(Guid? _applicantID)
{
	using(var cmd = GetCommand_GetExamTestByApplicant(_applicantID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamTestByApplicant(Guid? _applicantID)
{
	using(var cmd = GetCommand_GetExamTestByApplicant(_applicantID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExamTest

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExamTest(Guid? _id, Guid? _examRequestID, byte? _type, byte? _state, Guid? _qualifiedExamTestID, int? _testRawScore, float? _testScore, float? _descriptiveScore, float? _totalScore, byte? _testResult, byte? _totalResult, short? _conditionalAdmissionYear, string _log)
{
return base.CreateCommand("req.spModifyExamTest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AExamRequestID", IsOutput = false, Value = _examRequestID == null ? DBNull.Value : (object)_examRequestID }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AState", IsOutput = false, Value = _state == null ? DBNull.Value : (object)_state }, 
					new Parameter { Name = "@AQualifiedExamTestID", IsOutput = false, Value = _qualifiedExamTestID == null ? DBNull.Value : (object)_qualifiedExamTestID }, 
					new Parameter { Name = "@ATestRawScore", IsOutput = false, Value = _testRawScore == null ? DBNull.Value : (object)_testRawScore }, 
					new Parameter { Name = "@ATestScore", IsOutput = false, Value = _testScore == null ? DBNull.Value : (object)_testScore }, 
					new Parameter { Name = "@ADescriptiveScore", IsOutput = false, Value = _descriptiveScore == null ? DBNull.Value : (object)_descriptiveScore }, 
					new Parameter { Name = "@ATotalScore", IsOutput = false, Value = _totalScore == null ? DBNull.Value : (object)_totalScore }, 
					new Parameter { Name = "@ATestResult", IsOutput = false, Value = _testResult == null ? DBNull.Value : (object)_testResult }, 
					new Parameter { Name = "@ATotalResult", IsOutput = false, Value = _totalResult == null ? DBNull.Value : (object)_totalResult }, 
					new Parameter { Name = "@AConditionalAdmissionYear", IsOutput = false, Value = _conditionalAdmissionYear == null ? DBNull.Value : (object)_conditionalAdmissionYear }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyExamTestAsync(Guid? _id, Guid? _examRequestID, byte? _type, byte? _state, Guid? _qualifiedExamTestID, int? _testRawScore, float? _testScore, float? _descriptiveScore, float? _totalScore, byte? _testResult, byte? _totalResult, short? _conditionalAdmissionYear, string _log)
{
	using(var cmd = GetCommand_ModifyExamTest(_id, _examRequestID, _type, _state, _qualifiedExamTestID, _testRawScore, _testScore, _descriptiveScore, _totalScore, _testResult, _totalResult, _conditionalAdmissionYear, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExamTest(Guid? _id, Guid? _examRequestID, byte? _type, byte? _state, Guid? _qualifiedExamTestID, int? _testRawScore, float? _testScore, float? _descriptiveScore, float? _totalScore, byte? _testResult, byte? _totalResult, short? _conditionalAdmissionYear, string _log)
{
	using(var cmd = GetCommand_ModifyExamTest(_id, _examRequestID, _type, _state, _qualifiedExamTestID, _testRawScore, _testScore, _descriptiveScore, _totalScore, _testResult, _totalResult, _conditionalAdmissionYear, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetOpinion

public System.Data.SqlClient.SqlCommand GetCommand_GetOpinion(Guid? _admissionRequestID)
{
return base.CreateCommand("req.spGetOpinion", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
	});

}

public async Task<ResultSet> GetOpinionAsync(Guid? _admissionRequestID)
{
	using(var cmd = GetCommand_GetOpinion(_admissionRequestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetOpinion(Guid? _admissionRequestID)
{
	using(var cmd = GetCommand_GetOpinion(_admissionRequestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyProtectionUnitOpinion

public System.Data.SqlClient.SqlCommand GetCommand_ModifyProtectionUnitOpinion(Guid? _admissionRequestID, byte? _protectionUnitConfirmType, string _log)
{
return base.CreateCommand("req.spModifyProtectionUnitOpinion", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
					new Parameter { Name = "@AProtectionUnitConfirmType", IsOutput = false, Value = _protectionUnitConfirmType == null ? DBNull.Value : (object)_protectionUnitConfirmType }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyProtectionUnitOpinionAsync(Guid? _admissionRequestID, byte? _protectionUnitConfirmType, string _log)
{
	using(var cmd = GetCommand_ModifyProtectionUnitOpinion(_admissionRequestID, _protectionUnitConfirmType, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyProtectionUnitOpinion(Guid? _admissionRequestID, byte? _protectionUnitConfirmType, string _log)
{
	using(var cmd = GetCommand_ModifyProtectionUnitOpinion(_admissionRequestID, _protectionUnitConfirmType, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetPayments

public System.Data.SqlClient.SqlCommand GetCommand_GetPayments(Guid? _admissionID, short? _admissionYear, string _applicantName, string _applicantNational, DateTime? _transactionDateFrom, DateTime? _transactionDateTo, byte? _transactionResult, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetPayments", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AAdmissionYear", IsOutput = false, Value = _admissionYear == null ? DBNull.Value : (object)_admissionYear }, 
					new Parameter { Name = "@AApplicantName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantName) }, 
					new Parameter { Name = "@AApplicantNational", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantNational) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantNational) }, 
					new Parameter { Name = "@ATransactionDateFrom", IsOutput = false, Value = _transactionDateFrom == null ? DBNull.Value : (object)_transactionDateFrom }, 
					new Parameter { Name = "@ATransactionDateTo", IsOutput = false, Value = _transactionDateTo == null ? DBNull.Value : (object)_transactionDateTo }, 
					new Parameter { Name = "@ATransactionResult", IsOutput = false, Value = _transactionResult == null ? DBNull.Value : (object)_transactionResult }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetPaymentsAsync(Guid? _admissionID, short? _admissionYear, string _applicantName, string _applicantNational, DateTime? _transactionDateFrom, DateTime? _transactionDateTo, byte? _transactionResult, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetPayments(_admissionID, _admissionYear, _applicantName, _applicantNational, _transactionDateFrom, _transactionDateTo, _transactionResult, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetPayments(Guid? _admissionID, short? _admissionYear, string _applicantName, string _applicantNational, DateTime? _transactionDateFrom, DateTime? _transactionDateTo, byte? _transactionResult, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetPayments(_admissionID, _admissionYear, _applicantName, _applicantNational, _transactionDateFrom, _transactionDateTo, _transactionResult, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExamTests

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExamTests(Guid? _examRequestID, string _examTests, string _log)
{
return base.CreateCommand("req.spModifyExamTests", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamRequestID", IsOutput = false, Value = _examRequestID == null ? DBNull.Value : (object)_examRequestID }, 
					new Parameter { Name = "@AExamTests", IsOutput = false, Value = string.IsNullOrWhiteSpace(_examTests) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_examTests) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyExamTestsAsync(Guid? _examRequestID, string _examTests, string _log)
{
	using(var cmd = GetCommand_ModifyExamTests(_examRequestID, _examTests, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExamTests(Guid? _examRequestID, string _examTests, string _log)
{
	using(var cmd = GetCommand_ModifyExamTests(_examRequestID, _examTests, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyApplicant

public System.Data.SqlClient.SqlCommand GetCommand_ModifyApplicant(Guid? _id, byte? _gender, DateTime? _birthDate, string _tel, string _bCNumber, string _bCSerial, string _bCSeries, string _bCLetter, string _issuancePlace, string _fatherName, byte? _religion, byte? _faith, Guid? _addressProvinceID, Guid? _addressCountyID, Guid? _addressCityID, string _postalCode, string _address, Guid? _workProvinceID, Guid? _workCountyID, Guid? _workCityID, string _workAddress, string _workPostalCode, string _workTel, byte? _militaryServiceType, DateTime? _militaryServiceStartDate, DateTime? _militaryServiceEndDate, string _taaminPassword, string _firstName, string _lastName, string _email, string _log)
{
return base.CreateCommand("req.spModifyApplicant", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AGender", IsOutput = false, Value = _gender == null ? DBNull.Value : (object)_gender }, 
					new Parameter { Name = "@ABirthDate", IsOutput = false, Value = _birthDate == null ? DBNull.Value : (object)_birthDate }, 
					new Parameter { Name = "@ATel", IsOutput = false, Value = string.IsNullOrWhiteSpace(_tel) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_tel) }, 
					new Parameter { Name = "@ABCNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_bCNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_bCNumber) }, 
					new Parameter { Name = "@ABCSerial", IsOutput = false, Value = string.IsNullOrWhiteSpace(_bCSerial) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_bCSerial) }, 
					new Parameter { Name = "@ABCSeries", IsOutput = false, Value = string.IsNullOrWhiteSpace(_bCSeries) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_bCSeries) }, 
					new Parameter { Name = "@ABCLetter", IsOutput = false, Value = string.IsNullOrWhiteSpace(_bCLetter) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_bCLetter) }, 
					new Parameter { Name = "@AIssuancePlace", IsOutput = false, Value = string.IsNullOrWhiteSpace(_issuancePlace) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_issuancePlace) }, 
					new Parameter { Name = "@AFatherName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_fatherName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_fatherName) }, 
					new Parameter { Name = "@AReligion", IsOutput = false, Value = _religion == null ? DBNull.Value : (object)_religion }, 
					new Parameter { Name = "@AFaith", IsOutput = false, Value = _faith == null ? DBNull.Value : (object)_faith }, 
					new Parameter { Name = "@AAddressProvinceID", IsOutput = false, Value = _addressProvinceID == null ? DBNull.Value : (object)_addressProvinceID }, 
					new Parameter { Name = "@AAddressCountyID", IsOutput = false, Value = _addressCountyID == null ? DBNull.Value : (object)_addressCountyID }, 
					new Parameter { Name = "@AAddressCityID", IsOutput = false, Value = _addressCityID == null ? DBNull.Value : (object)_addressCityID }, 
					new Parameter { Name = "@APostalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_postalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_postalCode) }, 
					new Parameter { Name = "@AAddress", IsOutput = false, Value = string.IsNullOrWhiteSpace(_address) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_address) }, 
					new Parameter { Name = "@AWorkProvinceID", IsOutput = false, Value = _workProvinceID == null ? DBNull.Value : (object)_workProvinceID }, 
					new Parameter { Name = "@AWorkCountyID", IsOutput = false, Value = _workCountyID == null ? DBNull.Value : (object)_workCountyID }, 
					new Parameter { Name = "@AWorkCityID", IsOutput = false, Value = _workCityID == null ? DBNull.Value : (object)_workCityID }, 
					new Parameter { Name = "@AWorkAddress", IsOutput = false, Value = string.IsNullOrWhiteSpace(_workAddress) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_workAddress) }, 
					new Parameter { Name = "@AWorkPostalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_workPostalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_workPostalCode) }, 
					new Parameter { Name = "@AWorkTel", IsOutput = false, Value = string.IsNullOrWhiteSpace(_workTel) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_workTel) }, 
					new Parameter { Name = "@AMilitaryServiceType", IsOutput = false, Value = _militaryServiceType == null ? DBNull.Value : (object)_militaryServiceType }, 
					new Parameter { Name = "@AMilitaryServiceStartDate", IsOutput = false, Value = _militaryServiceStartDate == null ? DBNull.Value : (object)_militaryServiceStartDate }, 
					new Parameter { Name = "@AMilitaryServiceEndDate", IsOutput = false, Value = _militaryServiceEndDate == null ? DBNull.Value : (object)_militaryServiceEndDate }, 
					new Parameter { Name = "@ATaaminPassword", IsOutput = false, Value = string.IsNullOrWhiteSpace(_taaminPassword) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_taaminPassword) }, 
					new Parameter { Name = "@AFirstName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_firstName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_firstName) }, 
					new Parameter { Name = "@ALastName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_lastName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_lastName) }, 
					new Parameter { Name = "@AEmail", IsOutput = false, Value = string.IsNullOrWhiteSpace(_email) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_email) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyApplicantAsync(Guid? _id, byte? _gender, DateTime? _birthDate, string _tel, string _bCNumber, string _bCSerial, string _bCSeries, string _bCLetter, string _issuancePlace, string _fatherName, byte? _religion, byte? _faith, Guid? _addressProvinceID, Guid? _addressCountyID, Guid? _addressCityID, string _postalCode, string _address, Guid? _workProvinceID, Guid? _workCountyID, Guid? _workCityID, string _workAddress, string _workPostalCode, string _workTel, byte? _militaryServiceType, DateTime? _militaryServiceStartDate, DateTime? _militaryServiceEndDate, string _taaminPassword, string _firstName, string _lastName, string _email, string _log)
{
	using(var cmd = GetCommand_ModifyApplicant(_id, _gender, _birthDate, _tel, _bCNumber, _bCSerial, _bCSeries, _bCLetter, _issuancePlace, _fatherName, _religion, _faith, _addressProvinceID, _addressCountyID, _addressCityID, _postalCode, _address, _workProvinceID, _workCountyID, _workCityID, _workAddress, _workPostalCode, _workTel, _militaryServiceType, _militaryServiceStartDate, _militaryServiceEndDate, _taaminPassword, _firstName, _lastName, _email, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyApplicant(Guid? _id, byte? _gender, DateTime? _birthDate, string _tel, string _bCNumber, string _bCSerial, string _bCSeries, string _bCLetter, string _issuancePlace, string _fatherName, byte? _religion, byte? _faith, Guid? _addressProvinceID, Guid? _addressCountyID, Guid? _addressCityID, string _postalCode, string _address, Guid? _workProvinceID, Guid? _workCountyID, Guid? _workCityID, string _workAddress, string _workPostalCode, string _workTel, byte? _militaryServiceType, DateTime? _militaryServiceStartDate, DateTime? _militaryServiceEndDate, string _taaminPassword, string _firstName, string _lastName, string _email, string _log)
{
	using(var cmd = GetCommand_ModifyApplicant(_id, _gender, _birthDate, _tel, _bCNumber, _bCSerial, _bCSeries, _bCLetter, _issuancePlace, _fatherName, _religion, _faith, _addressProvinceID, _addressCountyID, _addressCityID, _postalCode, _address, _workProvinceID, _workCountyID, _workCityID, _workAddress, _workPostalCode, _workTel, _militaryServiceType, _militaryServiceStartDate, _militaryServiceEndDate, _taaminPassword, _firstName, _lastName, _email, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetInterviews

public System.Data.SqlClient.SqlCommand GetCommand_GetInterviews(Guid? _exemptionRequestID, string _applicantName, string _applicantNationalCode, DateTime? _dateFrom, DateTime? _dateTo, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetInterviews", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExemptionRequestID", IsOutput = false, Value = _exemptionRequestID == null ? DBNull.Value : (object)_exemptionRequestID }, 
					new Parameter { Name = "@AApplicantName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantName) }, 
					new Parameter { Name = "@AApplicantNationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantNationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantNationalCode) }, 
					new Parameter { Name = "@ADateFrom", IsOutput = false, Value = _dateFrom == null ? DBNull.Value : (object)_dateFrom }, 
					new Parameter { Name = "@ADateTo", IsOutput = false, Value = _dateTo == null ? DBNull.Value : (object)_dateTo }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetInterviewsAsync(Guid? _exemptionRequestID, string _applicantName, string _applicantNationalCode, DateTime? _dateFrom, DateTime? _dateTo, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetInterviews(_exemptionRequestID, _applicantName, _applicantNationalCode, _dateFrom, _dateTo, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetInterviews(Guid? _exemptionRequestID, string _applicantName, string _applicantNationalCode, DateTime? _dateFrom, DateTime? _dateTo, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetInterviews(_exemptionRequestID, _applicantName, _applicantNationalCode, _dateFrom, _dateTo, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyBossOpinion

public System.Data.SqlClient.SqlCommand GetCommand_ModifyBossOpinion(Guid? _admissionRequestID, byte? _bossConfirmType, string _log)
{
return base.CreateCommand("req.spModifyBossOpinion", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
					new Parameter { Name = "@ABossConfirmType", IsOutput = false, Value = _bossConfirmType == null ? DBNull.Value : (object)_bossConfirmType }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyBossOpinionAsync(Guid? _admissionRequestID, byte? _bossConfirmType, string _log)
{
	using(var cmd = GetCommand_ModifyBossOpinion(_admissionRequestID, _bossConfirmType, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyBossOpinion(Guid? _admissionRequestID, byte? _bossConfirmType, string _log)
{
	using(var cmd = GetCommand_ModifyBossOpinion(_admissionRequestID, _bossConfirmType, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExpertOpinion

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExpertOpinion(Guid? _admissionRequestID, byte? _expertConfirmType, byte? _eligibleReasonType, string _expertComment, byte? _applicantVerifyState, string _applicantVerifyComment, byte? _educationDegreeVerifyState, string _educationDegreeVerifyComment, byte? _workExperienceVerifyState, string _workExperienceVerifyComment, byte? _professionalDegreeVerifyState, string _professionalDegreeVerifyComment, byte? _managementHistoryVerifyState, string _managementHistoryVerifyComment, string _reasons, string _log)
{
return base.CreateCommand("req.spModifyExpertOpinion", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
					new Parameter { Name = "@AExpertConfirmType", IsOutput = false, Value = _expertConfirmType == null ? DBNull.Value : (object)_expertConfirmType }, 
					new Parameter { Name = "@AEligibleReasonType", IsOutput = false, Value = _eligibleReasonType == null ? DBNull.Value : (object)_eligibleReasonType }, 
					new Parameter { Name = "@AExpertComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_expertComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_expertComment) }, 
					new Parameter { Name = "@AApplicantVerifyState", IsOutput = false, Value = _applicantVerifyState == null ? DBNull.Value : (object)_applicantVerifyState }, 
					new Parameter { Name = "@AApplicantVerifyComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantVerifyComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantVerifyComment) }, 
					new Parameter { Name = "@AEducationDegreeVerifyState", IsOutput = false, Value = _educationDegreeVerifyState == null ? DBNull.Value : (object)_educationDegreeVerifyState }, 
					new Parameter { Name = "@AEducationDegreeVerifyComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_educationDegreeVerifyComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_educationDegreeVerifyComment) }, 
					new Parameter { Name = "@AWorkExperienceVerifyState", IsOutput = false, Value = _workExperienceVerifyState == null ? DBNull.Value : (object)_workExperienceVerifyState }, 
					new Parameter { Name = "@AWorkExperienceVerifyComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_workExperienceVerifyComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_workExperienceVerifyComment) }, 
					new Parameter { Name = "@AProfessionalDegreeVerifyState", IsOutput = false, Value = _professionalDegreeVerifyState == null ? DBNull.Value : (object)_professionalDegreeVerifyState }, 
					new Parameter { Name = "@AProfessionalDegreeVerifyComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_professionalDegreeVerifyComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_professionalDegreeVerifyComment) }, 
					new Parameter { Name = "@AManagementHistoryVerifyState", IsOutput = false, Value = _managementHistoryVerifyState == null ? DBNull.Value : (object)_managementHistoryVerifyState }, 
					new Parameter { Name = "@AManagementHistoryVerifyComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_managementHistoryVerifyComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_managementHistoryVerifyComment) }, 
					new Parameter { Name = "@AReasons", IsOutput = false, Value = string.IsNullOrWhiteSpace(_reasons) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_reasons) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyExpertOpinionAsync(Guid? _admissionRequestID, byte? _expertConfirmType, byte? _eligibleReasonType, string _expertComment, byte? _applicantVerifyState, string _applicantVerifyComment, byte? _educationDegreeVerifyState, string _educationDegreeVerifyComment, byte? _workExperienceVerifyState, string _workExperienceVerifyComment, byte? _professionalDegreeVerifyState, string _professionalDegreeVerifyComment, byte? _managementHistoryVerifyState, string _managementHistoryVerifyComment, string _reasons, string _log)
{
	using(var cmd = GetCommand_ModifyExpertOpinion(_admissionRequestID, _expertConfirmType, _eligibleReasonType, _expertComment, _applicantVerifyState, _applicantVerifyComment, _educationDegreeVerifyState, _educationDegreeVerifyComment, _workExperienceVerifyState, _workExperienceVerifyComment, _professionalDegreeVerifyState, _professionalDegreeVerifyComment, _managementHistoryVerifyState, _managementHistoryVerifyComment, _reasons, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExpertOpinion(Guid? _admissionRequestID, byte? _expertConfirmType, byte? _eligibleReasonType, string _expertComment, byte? _applicantVerifyState, string _applicantVerifyComment, byte? _educationDegreeVerifyState, string _educationDegreeVerifyComment, byte? _workExperienceVerifyState, string _workExperienceVerifyComment, byte? _professionalDegreeVerifyState, string _professionalDegreeVerifyComment, byte? _managementHistoryVerifyState, string _managementHistoryVerifyComment, string _reasons, string _log)
{
	using(var cmd = GetCommand_ModifyExpertOpinion(_admissionRequestID, _expertConfirmType, _eligibleReasonType, _expertComment, _applicantVerifyState, _applicantVerifyComment, _educationDegreeVerifyState, _educationDegreeVerifyComment, _workExperienceVerifyState, _workExperienceVerifyComment, _professionalDegreeVerifyState, _professionalDegreeVerifyComment, _managementHistoryVerifyState, _managementHistoryVerifyComment, _reasons, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetWorkExperiences

public System.Data.SqlClient.SqlCommand GetCommand_GetWorkExperiences(Guid? _requestID)
{
return base.CreateCommand("req.spGetWorkExperiences", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
	});

}

public async Task<ResultSet> GetWorkExperiencesAsync(Guid? _requestID)
{
	using(var cmd = GetCommand_GetWorkExperiences(_requestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetWorkExperiences(Guid? _requestID)
{
	using(var cmd = GetCommand_GetWorkExperiences(_requestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetObjections

public System.Data.SqlClient.SqlCommand GetCommand_GetObjections(Guid? _admissionID, Guid? _admissionRequestID, byte? _type, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetObjections", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetObjectionsAsync(Guid? _admissionID, Guid? _admissionRequestID, byte? _type, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetObjections(_admissionID, _admissionRequestID, _type, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetObjections(Guid? _admissionID, Guid? _admissionRequestID, byte? _type, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetObjections(_admissionID, _admissionRequestID, _type, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetWorkExperience

public System.Data.SqlClient.SqlCommand GetCommand_GetWorkExperience(Guid? _id)
{
return base.CreateCommand("req.spGetWorkExperience", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetWorkExperienceAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetWorkExperience(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetWorkExperience(Guid? _id)
{
	using(var cmd = GetCommand_GetWorkExperience(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetInterview

public System.Data.SqlClient.SqlCommand GetCommand_GetInterview(Guid? _id)
{
return base.CreateCommand("req.spGetInterview", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetInterviewAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetInterview(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetInterview(Guid? _id)
{
	using(var cmd = GetCommand_GetInterview(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAdmissionRequests

public System.Data.SqlClient.SqlCommand GetCommand_GetAdmissionRequests(short? _lastDocState, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetAdmissionRequests", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ALastDocState", IsOutput = false, Value = _lastDocState == null ? DBNull.Value : (object)_lastDocState }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetAdmissionRequestsAsync(short? _lastDocState, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetAdmissionRequests(_lastDocState, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAdmissionRequests(short? _lastDocState, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetAdmissionRequests(_lastDocState, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region SetInterviewConfirmerID

public System.Data.SqlClient.SqlCommand GetCommand_SetInterviewConfirmerID(Guid? _id, Guid? _userID, string _log)
{
return base.CreateCommand("req.spSetInterviewConfirmerID", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> SetInterviewConfirmerIDAsync(Guid? _id, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_SetInterviewConfirmerID(_id, _userID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet SetInterviewConfirmerID(Guid? _id, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_SetInterviewConfirmerID(_id, _userID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExemptionRequestsForCartable

public System.Data.SqlClient.SqlCommand GetCommand_GetExemptionRequestsForCartable(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, string _applicantName, string _applicantNationalCode, string _documentNumber, string _trackingCode, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetExemptionRequestsForCartable", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AActionState", IsOutput = false, Value = _actionState == null ? DBNull.Value : (object)_actionState }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@ALastDocState", IsOutput = false, Value = _lastDocState == null ? DBNull.Value : (object)_lastDocState }, 
					new Parameter { Name = "@ALastSendType", IsOutput = false, Value = _lastSendType == null ? DBNull.Value : (object)_lastSendType }, 
					new Parameter { Name = "@ACreationDateFrom", IsOutput = false, Value = _creationDateFrom == null ? DBNull.Value : (object)_creationDateFrom }, 
					new Parameter { Name = "@ACreationDateTo", IsOutput = false, Value = _creationDateTo == null ? DBNull.Value : (object)_creationDateTo }, 
					new Parameter { Name = "@ALastFlowDateFrom", IsOutput = false, Value = _lastFlowDateFrom == null ? DBNull.Value : (object)_lastFlowDateFrom }, 
					new Parameter { Name = "@ALastFlowDateTo", IsOutput = false, Value = _lastFlowDateTo == null ? DBNull.Value : (object)_lastFlowDateTo }, 
					new Parameter { Name = "@AApplicantName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantName) }, 
					new Parameter { Name = "@AApplicantNationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantNationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantNationalCode) }, 
					new Parameter { Name = "@ADocumentNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_documentNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_documentNumber) }, 
					new Parameter { Name = "@ATrackingCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_trackingCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_trackingCode) }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetExemptionRequestsForCartableAsync(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, string _applicantName, string _applicantNationalCode, string _documentNumber, string _trackingCode, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExemptionRequestsForCartable(_actionState, _userPositionID, _lastDocState, _lastSendType, _creationDateFrom, _creationDateTo, _lastFlowDateFrom, _lastFlowDateTo, _applicantName, _applicantNationalCode, _documentNumber, _trackingCode, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExemptionRequestsForCartable(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, string _applicantName, string _applicantNationalCode, string _documentNumber, string _trackingCode, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExemptionRequestsForCartable(_actionState, _userPositionID, _lastDocState, _lastSendType, _creationDateFrom, _creationDateTo, _lastFlowDateFrom, _lastFlowDateTo, _applicantName, _applicantNationalCode, _documentNumber, _trackingCode, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamRequestsForCartable

public System.Data.SqlClient.SqlCommand GetCommand_GetExamRequestsForCartable(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, byte? _demandedTestType, string _applicantName, string _applicantNationalCode, string _documentNumber, string _trackingCode, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetExamRequestsForCartable", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AActionState", IsOutput = false, Value = _actionState == null ? DBNull.Value : (object)_actionState }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@ALastDocState", IsOutput = false, Value = _lastDocState == null ? DBNull.Value : (object)_lastDocState }, 
					new Parameter { Name = "@ALastSendType", IsOutput = false, Value = _lastSendType == null ? DBNull.Value : (object)_lastSendType }, 
					new Parameter { Name = "@ACreationDateFrom", IsOutput = false, Value = _creationDateFrom == null ? DBNull.Value : (object)_creationDateFrom }, 
					new Parameter { Name = "@ACreationDateTo", IsOutput = false, Value = _creationDateTo == null ? DBNull.Value : (object)_creationDateTo }, 
					new Parameter { Name = "@ALastFlowDateFrom", IsOutput = false, Value = _lastFlowDateFrom == null ? DBNull.Value : (object)_lastFlowDateFrom }, 
					new Parameter { Name = "@ALastFlowDateTo", IsOutput = false, Value = _lastFlowDateTo == null ? DBNull.Value : (object)_lastFlowDateTo }, 
					new Parameter { Name = "@ADemandedTestType", IsOutput = false, Value = _demandedTestType == null ? DBNull.Value : (object)_demandedTestType }, 
					new Parameter { Name = "@AApplicantName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantName) }, 
					new Parameter { Name = "@AApplicantNationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantNationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantNationalCode) }, 
					new Parameter { Name = "@ADocumentNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_documentNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_documentNumber) }, 
					new Parameter { Name = "@ATrackingCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_trackingCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_trackingCode) }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetExamRequestsForCartableAsync(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, byte? _demandedTestType, string _applicantName, string _applicantNationalCode, string _documentNumber, string _trackingCode, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExamRequestsForCartable(_actionState, _userPositionID, _lastDocState, _lastSendType, _creationDateFrom, _creationDateTo, _lastFlowDateFrom, _lastFlowDateTo, _demandedTestType, _applicantName, _applicantNationalCode, _documentNumber, _trackingCode, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamRequestsForCartable(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, byte? _demandedTestType, string _applicantName, string _applicantNationalCode, string _documentNumber, string _trackingCode, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExamRequestsForCartable(_actionState, _userPositionID, _lastDocState, _lastSendType, _creationDateFrom, _creationDateTo, _lastFlowDateFrom, _lastFlowDateTo, _demandedTestType, _applicantName, _applicantNationalCode, _documentNumber, _trackingCode, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetObjectionsForApplicant

public System.Data.SqlClient.SqlCommand GetCommand_GetObjectionsForApplicant(Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetObjectionsForApplicant", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AApplicantUserID", IsOutput = false, Value = _applicantUserID == null ? DBNull.Value : (object)_applicantUserID }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetObjectionsForApplicantAsync(Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetObjectionsForApplicant(_applicantUserID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetObjectionsForApplicant(Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetObjectionsForApplicant(_applicantUserID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region SetInquiryState

public System.Data.SqlClient.SqlCommand GetCommand_SetInquiryState(Guid? _id, byte? _state, DateTime? _sendDate, DateTime? _receivedDate, string _log)
{
return base.CreateCommand("req.spSetInquiryState", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AState", IsOutput = false, Value = _state == null ? DBNull.Value : (object)_state }, 
					new Parameter { Name = "@ASendDate", IsOutput = false, Value = _sendDate == null ? DBNull.Value : (object)_sendDate }, 
					new Parameter { Name = "@AReceivedDate", IsOutput = false, Value = _receivedDate == null ? DBNull.Value : (object)_receivedDate }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> SetInquiryStateAsync(Guid? _id, byte? _state, DateTime? _sendDate, DateTime? _receivedDate, string _log)
{
	using(var cmd = GetCommand_SetInquiryState(_id, _state, _sendDate, _receivedDate, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet SetInquiryState(Guid? _id, byte? _state, DateTime? _sendDate, DateTime? _receivedDate, string _log)
{
	using(var cmd = GetCommand_SetInquiryState(_id, _state, _sendDate, _receivedDate, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamRequest

public System.Data.SqlClient.SqlCommand GetCommand_GetExamRequest(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
return base.CreateCommand("req.spGetExamRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
	});

}

public async Task<ResultSet> GetExamRequestAsync(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
	using(var cmd = GetCommand_GetExamRequest(_id, _userPositionID, _userID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamRequest(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
	using(var cmd = GetCommand_GetExamRequest(_id, _userPositionID, _userID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetObjectionTests

public System.Data.SqlClient.SqlCommand GetCommand_GetObjectionTests(Guid? _objectionID)
{
return base.CreateCommand("req.spGetObjectionTests", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AObjectionID", IsOutput = false, Value = _objectionID == null ? DBNull.Value : (object)_objectionID }, 
	});

}

public async Task<ResultSet> GetObjectionTestsAsync(Guid? _objectionID)
{
	using(var cmd = GetCommand_GetObjectionTests(_objectionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetObjectionTests(Guid? _objectionID)
{
	using(var cmd = GetCommand_GetObjectionTests(_objectionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteProfessionalDegree

public System.Data.SqlClient.SqlCommand GetCommand_DeleteProfessionalDegree(Guid? _id, string _log)
{
return base.CreateCommand("req.spDeleteProfessionalDegree", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteProfessionalDegreeAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteProfessionalDegree(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteProfessionalDegree(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteProfessionalDegree(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExemptionFlowPrerequisite

public System.Data.SqlClient.SqlCommand GetCommand_GetExemptionFlowPrerequisite(Guid? _exemptionRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
return base.CreateCommand("req.spGetExemptionFlowPrerequisite", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExemptionRequestID", IsOutput = false, Value = _exemptionRequestID == null ? DBNull.Value : (object)_exemptionRequestID }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@AApplicationID", IsOutput = false, Value = _applicationID == null ? DBNull.Value : (object)_applicationID }, 
	});

}

public async Task<ResultSet> GetExemptionFlowPrerequisiteAsync(Guid? _exemptionRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
	using(var cmd = GetCommand_GetExemptionFlowPrerequisite(_exemptionRequestID, _userPositionID, _userID, _applicationID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExemptionFlowPrerequisite(Guid? _exemptionRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
	using(var cmd = GetCommand_GetExemptionFlowPrerequisite(_exemptionRequestID, _userPositionID, _userID, _applicationID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteEducationDegree

public System.Data.SqlClient.SqlCommand GetCommand_DeleteEducationDegree(Guid? _id, string _log)
{
return base.CreateCommand("req.spDeleteEducationDegree", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteEducationDegreeAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteEducationDegree(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteEducationDegree(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteEducationDegree(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamTests

public System.Data.SqlClient.SqlCommand GetCommand_GetExamTests(Guid? _examRequestID, Guid? _admissionID, string _nationalCode, int? _year, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetExamTests", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamRequestID", IsOutput = false, Value = _examRequestID == null ? DBNull.Value : (object)_examRequestID }, 
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
					new Parameter { Name = "@AYear", IsOutput = false, Value = _year == null ? DBNull.Value : (object)_year }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetExamTestsAsync(Guid? _examRequestID, Guid? _admissionID, string _nationalCode, int? _year, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExamTests(_examRequestID, _admissionID, _nationalCode, _year, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamTests(Guid? _examRequestID, Guid? _admissionID, string _nationalCode, int? _year, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExamTests(_examRequestID, _admissionID, _nationalCode, _year, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetApplicant

public System.Data.SqlClient.SqlCommand GetCommand_GetApplicant(Guid? _id)
{
return base.CreateCommand("req.spGetApplicant", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetApplicantAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetApplicant(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetApplicant(Guid? _id)
{
	using(var cmd = GetCommand_GetApplicant(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetInquiries

public System.Data.SqlClient.SqlCommand GetCommand_GetInquiries(Guid? _admissionRequestID)
{
return base.CreateCommand("req.spGetInquiries", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
	});

}

public async Task<ResultSet> GetInquiriesAsync(Guid? _admissionRequestID)
{
	using(var cmd = GetCommand_GetInquiries(_admissionRequestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetInquiries(Guid? _admissionRequestID)
{
	using(var cmd = GetCommand_GetInquiries(_admissionRequestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetManagementHistories

public System.Data.SqlClient.SqlCommand GetCommand_GetManagementHistories(Guid? _requestID)
{
return base.CreateCommand("req.spGetManagementHistories", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
	});

}

public async Task<ResultSet> GetManagementHistoriesAsync(Guid? _requestID)
{
	using(var cmd = GetCommand_GetManagementHistories(_requestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetManagementHistories(Guid? _requestID)
{
	using(var cmd = GetCommand_GetManagementHistories(_requestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamRequestFlowPrerequisite

public System.Data.SqlClient.SqlCommand GetCommand_GetExamRequestFlowPrerequisite(Guid? _examRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
return base.CreateCommand("req.spGetExamRequestFlowPrerequisite", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamRequestID", IsOutput = false, Value = _examRequestID == null ? DBNull.Value : (object)_examRequestID }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@AApplicationID", IsOutput = false, Value = _applicationID == null ? DBNull.Value : (object)_applicationID }, 
	});

}

public async Task<ResultSet> GetExamRequestFlowPrerequisiteAsync(Guid? _examRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
	using(var cmd = GetCommand_GetExamRequestFlowPrerequisite(_examRequestID, _userPositionID, _userID, _applicationID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamRequestFlowPrerequisite(Guid? _examRequestID, Guid? _userPositionID, Guid? _userID, Guid? _applicationID)
{
	using(var cmd = GetCommand_GetExamRequestFlowPrerequisite(_examRequestID, _userPositionID, _userID, _applicationID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyInterview

public System.Data.SqlClient.SqlCommand GetCommand_ModifyInterview(bool? _isNewRecord, Guid? _id, Guid? _exemptionRequestID, DateTime? _interviewDate, int? _interviewTime, byte? _interviewResult, string _recordNumber, string _firstName, string _lastName, string _nationalCode, string _proceedingsNumber, DateTime? _proceedingsDate, Guid? _userID, string _log)
{
return base.CreateCommand("req.spModifyInterview", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AExemptionRequestID", IsOutput = false, Value = _exemptionRequestID == null ? DBNull.Value : (object)_exemptionRequestID }, 
					new Parameter { Name = "@AInterviewDate", IsOutput = false, Value = _interviewDate == null ? DBNull.Value : (object)_interviewDate }, 
					new Parameter { Name = "@AInterviewTime", IsOutput = false, Value = _interviewTime == null ? DBNull.Value : (object)_interviewTime }, 
					new Parameter { Name = "@AInterviewResult", IsOutput = false, Value = _interviewResult == null ? DBNull.Value : (object)_interviewResult }, 
					new Parameter { Name = "@ARecordNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_recordNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_recordNumber) }, 
					new Parameter { Name = "@AFirstName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_firstName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_firstName) }, 
					new Parameter { Name = "@ALastName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_lastName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_lastName) }, 
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
					new Parameter { Name = "@AProceedingsNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_proceedingsNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_proceedingsNumber) }, 
					new Parameter { Name = "@AProceedingsDate", IsOutput = false, Value = _proceedingsDate == null ? DBNull.Value : (object)_proceedingsDate }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyInterviewAsync(bool? _isNewRecord, Guid? _id, Guid? _exemptionRequestID, DateTime? _interviewDate, int? _interviewTime, byte? _interviewResult, string _recordNumber, string _firstName, string _lastName, string _nationalCode, string _proceedingsNumber, DateTime? _proceedingsDate, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifyInterview(_isNewRecord, _id, _exemptionRequestID, _interviewDate, _interviewTime, _interviewResult, _recordNumber, _firstName, _lastName, _nationalCode, _proceedingsNumber, _proceedingsDate, _userID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyInterview(bool? _isNewRecord, Guid? _id, Guid? _exemptionRequestID, DateTime? _interviewDate, int? _interviewTime, byte? _interviewResult, string _recordNumber, string _firstName, string _lastName, string _nationalCode, string _proceedingsNumber, DateTime? _proceedingsDate, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifyInterview(_isNewRecord, _id, _exemptionRequestID, _interviewDate, _interviewTime, _interviewResult, _recordNumber, _firstName, _lastName, _nationalCode, _proceedingsNumber, _proceedingsDate, _userID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region FinalizeObjectionScores

public System.Data.SqlClient.SqlCommand GetCommand_FinalizeObjectionScores(Guid? _objectionID, string _log)
{
return base.CreateCommand("req.spFinalizeObjectionScores", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AObjectionID", IsOutput = false, Value = _objectionID == null ? DBNull.Value : (object)_objectionID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> FinalizeObjectionScoresAsync(Guid? _objectionID, string _log)
{
	using(var cmd = GetCommand_FinalizeObjectionScores(_objectionID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet FinalizeObjectionScores(Guid? _objectionID, string _log)
{
	using(var cmd = GetCommand_FinalizeObjectionScores(_objectionID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyWorkExperience

public System.Data.SqlClient.SqlCommand GetCommand_ModifyWorkExperience(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _workExperienceType, byte? _countryType, Guid? _workPlaceID, string _workPlaceName, string _jobTitle, DateTime? _fromDate, DateTime? _toDate, string _insuranceNumber, string _insuranceWorkCode, string _taxScopeCode, byte? _workActivityType, int? _totalWorkExperience, int? _inCountryWorkExperience, int? _relatedWorkExperience, int? _irrelevantWorkExperience, byte? _workPlaceGovernmentalType, string _workPlaceGovernmental, string _log)
{
return base.CreateCommand("req.spModifyWorkExperience", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
					new Parameter { Name = "@AWorkExperienceType", IsOutput = false, Value = _workExperienceType == null ? DBNull.Value : (object)_workExperienceType }, 
					new Parameter { Name = "@ACountryType", IsOutput = false, Value = _countryType == null ? DBNull.Value : (object)_countryType }, 
					new Parameter { Name = "@AWorkPlaceID", IsOutput = false, Value = _workPlaceID == null ? DBNull.Value : (object)_workPlaceID }, 
					new Parameter { Name = "@AWorkPlaceName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_workPlaceName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_workPlaceName) }, 
					new Parameter { Name = "@AJobTitle", IsOutput = false, Value = string.IsNullOrWhiteSpace(_jobTitle) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_jobTitle) }, 
					new Parameter { Name = "@AFromDate", IsOutput = false, Value = _fromDate == null ? DBNull.Value : (object)_fromDate }, 
					new Parameter { Name = "@AToDate", IsOutput = false, Value = _toDate == null ? DBNull.Value : (object)_toDate }, 
					new Parameter { Name = "@AInsuranceNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_insuranceNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_insuranceNumber) }, 
					new Parameter { Name = "@AInsuranceWorkCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_insuranceWorkCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_insuranceWorkCode) }, 
					new Parameter { Name = "@ATaxScopeCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_taxScopeCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_taxScopeCode) }, 
					new Parameter { Name = "@AWorkActivityType", IsOutput = false, Value = _workActivityType == null ? DBNull.Value : (object)_workActivityType }, 
					new Parameter { Name = "@ATotalWorkExperience", IsOutput = false, Value = _totalWorkExperience == null ? DBNull.Value : (object)_totalWorkExperience }, 
					new Parameter { Name = "@AInCountryWorkExperience", IsOutput = false, Value = _inCountryWorkExperience == null ? DBNull.Value : (object)_inCountryWorkExperience }, 
					new Parameter { Name = "@ARelatedWorkExperience", IsOutput = false, Value = _relatedWorkExperience == null ? DBNull.Value : (object)_relatedWorkExperience }, 
					new Parameter { Name = "@AIrrelevantWorkExperience", IsOutput = false, Value = _irrelevantWorkExperience == null ? DBNull.Value : (object)_irrelevantWorkExperience }, 
					new Parameter { Name = "@AWorkPlaceGovernmentalType", IsOutput = false, Value = _workPlaceGovernmentalType == null ? DBNull.Value : (object)_workPlaceGovernmentalType }, 
					new Parameter { Name = "@AWorkPlaceGovernmental", IsOutput = false, Value = string.IsNullOrWhiteSpace(_workPlaceGovernmental) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_workPlaceGovernmental) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyWorkExperienceAsync(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _workExperienceType, byte? _countryType, Guid? _workPlaceID, string _workPlaceName, string _jobTitle, DateTime? _fromDate, DateTime? _toDate, string _insuranceNumber, string _insuranceWorkCode, string _taxScopeCode, byte? _workActivityType, int? _totalWorkExperience, int? _inCountryWorkExperience, int? _relatedWorkExperience, int? _irrelevantWorkExperience, byte? _workPlaceGovernmentalType, string _workPlaceGovernmental, string _log)
{
	using(var cmd = GetCommand_ModifyWorkExperience(_isNewRecord, _id, _requestID, _workExperienceType, _countryType, _workPlaceID, _workPlaceName, _jobTitle, _fromDate, _toDate, _insuranceNumber, _insuranceWorkCode, _taxScopeCode, _workActivityType, _totalWorkExperience, _inCountryWorkExperience, _relatedWorkExperience, _irrelevantWorkExperience, _workPlaceGovernmentalType, _workPlaceGovernmental, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyWorkExperience(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _workExperienceType, byte? _countryType, Guid? _workPlaceID, string _workPlaceName, string _jobTitle, DateTime? _fromDate, DateTime? _toDate, string _insuranceNumber, string _insuranceWorkCode, string _taxScopeCode, byte? _workActivityType, int? _totalWorkExperience, int? _inCountryWorkExperience, int? _relatedWorkExperience, int? _irrelevantWorkExperience, byte? _workPlaceGovernmentalType, string _workPlaceGovernmental, string _log)
{
	using(var cmd = GetCommand_ModifyWorkExperience(_isNewRecord, _id, _requestID, _workExperienceType, _countryType, _workPlaceID, _workPlaceName, _jobTitle, _fromDate, _toDate, _insuranceNumber, _insuranceWorkCode, _taxScopeCode, _workActivityType, _totalWorkExperience, _inCountryWorkExperience, _relatedWorkExperience, _irrelevantWorkExperience, _workPlaceGovernmentalType, _workPlaceGovernmental, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamRequests

public System.Data.SqlClient.SqlCommand GetCommand_GetExamRequests(Guid? _admissionID, byte? _lastDocState, Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetExamRequests", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@ALastDocState", IsOutput = false, Value = _lastDocState == null ? DBNull.Value : (object)_lastDocState }, 
					new Parameter { Name = "@AApplicantUserID", IsOutput = false, Value = _applicantUserID == null ? DBNull.Value : (object)_applicantUserID }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetExamRequestsAsync(Guid? _admissionID, byte? _lastDocState, Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExamRequests(_admissionID, _lastDocState, _applicantUserID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamRequests(Guid? _admissionID, byte? _lastDocState, Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExamRequests(_admissionID, _lastDocState, _applicantUserID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyProfessionalDegree

public System.Data.SqlClient.SqlCommand GetCommand_ModifyProfessionalDegree(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _degreeType, string _degreeTypeName, Guid? _countryID, DateTime? _date, string _number, string _log)
{
return base.CreateCommand("req.spModifyProfessionalDegree", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
					new Parameter { Name = "@ADegreeType", IsOutput = false, Value = _degreeType == null ? DBNull.Value : (object)_degreeType }, 
					new Parameter { Name = "@ADegreeTypeName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_degreeTypeName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_degreeTypeName) }, 
					new Parameter { Name = "@ACountryID", IsOutput = false, Value = _countryID == null ? DBNull.Value : (object)_countryID }, 
					new Parameter { Name = "@ADate", IsOutput = false, Value = _date == null ? DBNull.Value : (object)_date }, 
					new Parameter { Name = "@ANumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_number) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_number) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyProfessionalDegreeAsync(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _degreeType, string _degreeTypeName, Guid? _countryID, DateTime? _date, string _number, string _log)
{
	using(var cmd = GetCommand_ModifyProfessionalDegree(_isNewRecord, _id, _requestID, _degreeType, _degreeTypeName, _countryID, _date, _number, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyProfessionalDegree(bool? _isNewRecord, Guid? _id, Guid? _requestID, byte? _degreeType, string _degreeTypeName, Guid? _countryID, DateTime? _date, string _number, string _log)
{
	using(var cmd = GetCommand_ModifyProfessionalDegree(_isNewRecord, _id, _requestID, _degreeType, _degreeTypeName, _countryID, _date, _number, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExemptionRequests

public System.Data.SqlClient.SqlCommand GetCommand_GetExemptionRequests(Guid? _admissionID, Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetExemptionRequests", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AApplicantUserID", IsOutput = false, Value = _applicantUserID == null ? DBNull.Value : (object)_applicantUserID }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetExemptionRequestsAsync(Guid? _admissionID, Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExemptionRequests(_admissionID, _applicantUserID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExemptionRequests(Guid? _admissionID, Guid? _applicantUserID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetExemptionRequests(_admissionID, _applicantUserID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifySecretaryOpinion

public System.Data.SqlClient.SqlCommand GetCommand_ModifySecretaryOpinion(Guid? _admissionRequestID, byte? _secretaryConfirmType, string _log)
{
return base.CreateCommand("req.spModifySecretaryOpinion", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
					new Parameter { Name = "@ASecretaryConfirmType", IsOutput = false, Value = _secretaryConfirmType == null ? DBNull.Value : (object)_secretaryConfirmType }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifySecretaryOpinionAsync(Guid? _admissionRequestID, byte? _secretaryConfirmType, string _log)
{
	using(var cmd = GetCommand_ModifySecretaryOpinion(_admissionRequestID, _secretaryConfirmType, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifySecretaryOpinion(Guid? _admissionRequestID, byte? _secretaryConfirmType, string _log)
{
	using(var cmd = GetCommand_ModifySecretaryOpinion(_admissionRequestID, _secretaryConfirmType, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetEducationDegree

public System.Data.SqlClient.SqlCommand GetCommand_GetEducationDegree(Guid? _id)
{
return base.CreateCommand("req.spGetEducationDegree", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetEducationDegreeAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetEducationDegree(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetEducationDegree(Guid? _id)
{
	using(var cmd = GetCommand_GetEducationDegree(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetObjectionsForCartable

public System.Data.SqlClient.SqlCommand GetCommand_GetObjectionsForCartable(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, byte? _type, byte? _testType, byte? _result, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetObjectionsForCartable", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AActionState", IsOutput = false, Value = _actionState == null ? DBNull.Value : (object)_actionState }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@ALastDocState", IsOutput = false, Value = _lastDocState == null ? DBNull.Value : (object)_lastDocState }, 
					new Parameter { Name = "@ALastSendType", IsOutput = false, Value = _lastSendType == null ? DBNull.Value : (object)_lastSendType }, 
					new Parameter { Name = "@ACreationDateFrom", IsOutput = false, Value = _creationDateFrom == null ? DBNull.Value : (object)_creationDateFrom }, 
					new Parameter { Name = "@ACreationDateTo", IsOutput = false, Value = _creationDateTo == null ? DBNull.Value : (object)_creationDateTo }, 
					new Parameter { Name = "@ALastFlowDateFrom", IsOutput = false, Value = _lastFlowDateFrom == null ? DBNull.Value : (object)_lastFlowDateFrom }, 
					new Parameter { Name = "@ALastFlowDateTo", IsOutput = false, Value = _lastFlowDateTo == null ? DBNull.Value : (object)_lastFlowDateTo }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@ATestType", IsOutput = false, Value = _testType == null ? DBNull.Value : (object)_testType }, 
					new Parameter { Name = "@AResult", IsOutput = false, Value = _result == null ? DBNull.Value : (object)_result }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetObjectionsForCartableAsync(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, byte? _type, byte? _testType, byte? _result, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetObjectionsForCartable(_actionState, _userPositionID, _lastDocState, _lastSendType, _creationDateFrom, _creationDateTo, _lastFlowDateFrom, _lastFlowDateTo, _type, _testType, _result, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetObjectionsForCartable(int? _actionState, Guid? _userPositionID, byte? _lastDocState, byte? _lastSendType, DateTime? _creationDateFrom, DateTime? _creationDateTo, DateTime? _lastFlowDateFrom, DateTime? _lastFlowDateTo, byte? _type, byte? _testType, byte? _result, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetObjectionsForCartable(_actionState, _userPositionID, _lastDocState, _lastSendType, _creationDateFrom, _creationDateTo, _lastFlowDateFrom, _lastFlowDateTo, _type, _testType, _result, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetApplicantFromMemaran

public System.Data.SqlClient.SqlCommand GetCommand_GetApplicantFromMemaran(string _nationalCode)
{
return base.CreateCommand("req.spGetApplicantFromMemaran", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
	});

}

public async Task<ResultSet> GetApplicantFromMemaranAsync(string _nationalCode)
{
	using(var cmd = GetCommand_GetApplicantFromMemaran(_nationalCode))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetApplicantFromMemaran(string _nationalCode)
{
	using(var cmd = GetCommand_GetApplicantFromMemaran(_nationalCode))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetReasons

public System.Data.SqlClient.SqlCommand GetCommand_GetReasons(Guid? _admissionRequestID)
{
return base.CreateCommand("req.spGetReasons", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
	});

}

public async Task<ResultSet> GetReasonsAsync(Guid? _admissionRequestID)
{
	using(var cmd = GetCommand_GetReasons(_admissionRequestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetReasons(Guid? _admissionRequestID)
{
	using(var cmd = GetCommand_GetReasons(_admissionRequestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyObjection

public System.Data.SqlClient.SqlCommand GetCommand_ModifyObjection(bool? _isNewRecord, Guid? _id, Guid? _admissionRequestID, byte? _type, string _applicantComment, string _expertComment, string _secretaryComment, byte? _result, byte? _secretaryConfirmType, Guid? _userID, string _tests, string _log)
{
return base.CreateCommand("req.spModifyObjection", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AApplicantComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_applicantComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_applicantComment) }, 
					new Parameter { Name = "@AExpertComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_expertComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_expertComment) }, 
					new Parameter { Name = "@ASecretaryComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_secretaryComment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_secretaryComment) }, 
					new Parameter { Name = "@AResult", IsOutput = false, Value = _result == null ? DBNull.Value : (object)_result }, 
					new Parameter { Name = "@ASecretaryConfirmType", IsOutput = false, Value = _secretaryConfirmType == null ? DBNull.Value : (object)_secretaryConfirmType }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ATests", IsOutput = false, Value = string.IsNullOrWhiteSpace(_tests) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_tests) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyObjectionAsync(bool? _isNewRecord, Guid? _id, Guid? _admissionRequestID, byte? _type, string _applicantComment, string _expertComment, string _secretaryComment, byte? _result, byte? _secretaryConfirmType, Guid? _userID, string _tests, string _log)
{
	using(var cmd = GetCommand_ModifyObjection(_isNewRecord, _id, _admissionRequestID, _type, _applicantComment, _expertComment, _secretaryComment, _result, _secretaryConfirmType, _userID, _tests, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyObjection(bool? _isNewRecord, Guid? _id, Guid? _admissionRequestID, byte? _type, string _applicantComment, string _expertComment, string _secretaryComment, byte? _result, byte? _secretaryConfirmType, Guid? _userID, string _tests, string _log)
{
	using(var cmd = GetCommand_ModifyObjection(_isNewRecord, _id, _admissionRequestID, _type, _applicantComment, _expertComment, _secretaryComment, _result, _secretaryConfirmType, _userID, _tests, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region SetInterviewDate

public System.Data.SqlClient.SqlCommand GetCommand_SetInterviewDate(Guid? _id, DateTime? _interviewDate, int? _interviewTime, string _log)
{
return base.CreateCommand("req.spSetInterviewDate", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AInterviewDate", IsOutput = false, Value = _interviewDate == null ? DBNull.Value : (object)_interviewDate }, 
					new Parameter { Name = "@AInterviewTime", IsOutput = false, Value = _interviewTime == null ? DBNull.Value : (object)_interviewTime }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> SetInterviewDateAsync(Guid? _id, DateTime? _interviewDate, int? _interviewTime, string _log)
{
	using(var cmd = GetCommand_SetInterviewDate(_id, _interviewDate, _interviewTime, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet SetInterviewDate(Guid? _id, DateTime? _interviewDate, int? _interviewTime, string _log)
{
	using(var cmd = GetCommand_SetInterviewDate(_id, _interviewDate, _interviewTime, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetObjection

public System.Data.SqlClient.SqlCommand GetCommand_GetObjection(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
return base.CreateCommand("req.spGetObjection", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
	});

}

public async Task<ResultSet> GetObjectionAsync(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
	using(var cmd = GetCommand_GetObjection(_id, _userPositionID, _userID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetObjection(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
	using(var cmd = GetCommand_GetObjection(_id, _userPositionID, _userID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region SetInterviewResult

public System.Data.SqlClient.SqlCommand GetCommand_SetInterviewResult(Guid? _id, byte? _interviewResult, string _recordNumber, string _log)
{
return base.CreateCommand("req.spSetInterviewResult", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AInterviewResult", IsOutput = false, Value = _interviewResult == null ? DBNull.Value : (object)_interviewResult }, 
					new Parameter { Name = "@ARecordNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_recordNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_recordNumber) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> SetInterviewResultAsync(Guid? _id, byte? _interviewResult, string _recordNumber, string _log)
{
	using(var cmd = GetCommand_SetInterviewResult(_id, _interviewResult, _recordNumber, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet SetInterviewResult(Guid? _id, byte? _interviewResult, string _recordNumber, string _log)
{
	using(var cmd = GetCommand_SetInterviewResult(_id, _interviewResult, _recordNumber, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyManagementHistory

public System.Data.SqlClient.SqlCommand GetCommand_ModifyManagementHistory(bool? _isNewRecord, Guid? _id, Guid? _requestID, string _organizationName, byte? _type, string _jobTitle, DateTime? _fromDate, DateTime? _toDate, string _log)
{
return base.CreateCommand("req.spModifyManagementHistory", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
					new Parameter { Name = "@AOrganizationName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_organizationName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_organizationName) }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AJobTitle", IsOutput = false, Value = string.IsNullOrWhiteSpace(_jobTitle) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_jobTitle) }, 
					new Parameter { Name = "@AFromDate", IsOutput = false, Value = _fromDate == null ? DBNull.Value : (object)_fromDate }, 
					new Parameter { Name = "@AToDate", IsOutput = false, Value = _toDate == null ? DBNull.Value : (object)_toDate }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyManagementHistoryAsync(bool? _isNewRecord, Guid? _id, Guid? _requestID, string _organizationName, byte? _type, string _jobTitle, DateTime? _fromDate, DateTime? _toDate, string _log)
{
	using(var cmd = GetCommand_ModifyManagementHistory(_isNewRecord, _id, _requestID, _organizationName, _type, _jobTitle, _fromDate, _toDate, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyManagementHistory(bool? _isNewRecord, Guid? _id, Guid? _requestID, string _organizationName, byte? _type, string _jobTitle, DateTime? _fromDate, DateTime? _toDate, string _log)
{
	using(var cmd = GetCommand_ModifyManagementHistory(_isNewRecord, _id, _requestID, _organizationName, _type, _jobTitle, _fromDate, _toDate, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetManagementHistory

public System.Data.SqlClient.SqlCommand GetCommand_GetManagementHistory(Guid? _id)
{
return base.CreateCommand("req.spGetManagementHistory", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetManagementHistoryAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetManagementHistory(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetManagementHistory(Guid? _id)
{
	using(var cmd = GetCommand_GetManagementHistory(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamTest

public System.Data.SqlClient.SqlCommand GetCommand_GetExamTest(Guid? _id)
{
return base.CreateCommand("req.spGetExamTest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetExamTestAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetExamTest(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamTest(Guid? _id)
{
	using(var cmd = GetCommand_GetExamTest(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteManagementHistory

public System.Data.SqlClient.SqlCommand GetCommand_DeleteManagementHistory(Guid? _id, string _log)
{
return base.CreateCommand("req.spDeleteManagementHistory", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteManagementHistoryAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteManagementHistory(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteManagementHistory(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteManagementHistory(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExemptionRequest

public System.Data.SqlClient.SqlCommand GetCommand_GetExemptionRequest(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
return base.CreateCommand("req.spGetExemptionRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AUserPositionID", IsOutput = false, Value = _userPositionID == null ? DBNull.Value : (object)_userPositionID }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
	});

}

public async Task<ResultSet> GetExemptionRequestAsync(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
	using(var cmd = GetCommand_GetExemptionRequest(_id, _userPositionID, _userID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExemptionRequest(Guid? _id, Guid? _userPositionID, Guid? _userID)
{
	using(var cmd = GetCommand_GetExemptionRequest(_id, _userPositionID, _userID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExemptionRequest

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExemptionRequest(bool? _isNewRecord, Guid? _id, Guid? _admissionID, Guid? _applicantUserID, byte? _agreementType, bool? _agreementAccepted, string _panelProceedingsNumber, DateTime? _panelProceedingsDate, Guid? _creatorID, string _log)
{
return base.CreateCommand("req.spModifyExemptionRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AApplicantUserID", IsOutput = false, Value = _applicantUserID == null ? DBNull.Value : (object)_applicantUserID }, 
					new Parameter { Name = "@AAgreementType", IsOutput = false, Value = _agreementType == null ? DBNull.Value : (object)_agreementType }, 
					new Parameter { Name = "@AAgreementAccepted", IsOutput = false, Value = _agreementAccepted == null ? DBNull.Value : (object)_agreementAccepted }, 
					new Parameter { Name = "@APanelProceedingsNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_panelProceedingsNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_panelProceedingsNumber) }, 
					new Parameter { Name = "@APanelProceedingsDate", IsOutput = false, Value = _panelProceedingsDate == null ? DBNull.Value : (object)_panelProceedingsDate }, 
					new Parameter { Name = "@ACreatorID", IsOutput = false, Value = _creatorID == null ? DBNull.Value : (object)_creatorID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyExemptionRequestAsync(bool? _isNewRecord, Guid? _id, Guid? _admissionID, Guid? _applicantUserID, byte? _agreementType, bool? _agreementAccepted, string _panelProceedingsNumber, DateTime? _panelProceedingsDate, Guid? _creatorID, string _log)
{
	using(var cmd = GetCommand_ModifyExemptionRequest(_isNewRecord, _id, _admissionID, _applicantUserID, _agreementType, _agreementAccepted, _panelProceedingsNumber, _panelProceedingsDate, _creatorID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExemptionRequest(bool? _isNewRecord, Guid? _id, Guid? _admissionID, Guid? _applicantUserID, byte? _agreementType, bool? _agreementAccepted, string _panelProceedingsNumber, DateTime? _panelProceedingsDate, Guid? _creatorID, string _log)
{
	using(var cmd = GetCommand_ModifyExemptionRequest(_isNewRecord, _id, _admissionID, _applicantUserID, _agreementType, _agreementAccepted, _panelProceedingsNumber, _panelProceedingsDate, _creatorID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyPayment

public System.Data.SqlClient.SqlCommand GetCommand_ModifyPayment(bool? _isNewRecord, Guid? _id, Guid? _admissionRequestID, int? _amount, DateTime? _transactionDate, byte? _transactionResult, Guid? _refID, long? _saleReferenceID, string _log)
{
return base.CreateCommand("req.spModifyPayment", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AAdmissionRequestID", IsOutput = false, Value = _admissionRequestID == null ? DBNull.Value : (object)_admissionRequestID }, 
					new Parameter { Name = "@AAmount", IsOutput = false, Value = _amount == null ? DBNull.Value : (object)_amount }, 
					new Parameter { Name = "@ATransactionDate", IsOutput = false, Value = _transactionDate == null ? DBNull.Value : (object)_transactionDate }, 
					new Parameter { Name = "@ATransactionResult", IsOutput = false, Value = _transactionResult == null ? DBNull.Value : (object)_transactionResult }, 
					new Parameter { Name = "@ARefID", IsOutput = false, Value = _refID == null ? DBNull.Value : (object)_refID }, 
					new Parameter { Name = "@ASaleReferenceID", IsOutput = false, Value = _saleReferenceID == null ? DBNull.Value : (object)_saleReferenceID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyPaymentAsync(bool? _isNewRecord, Guid? _id, Guid? _admissionRequestID, int? _amount, DateTime? _transactionDate, byte? _transactionResult, Guid? _refID, long? _saleReferenceID, string _log)
{
	using(var cmd = GetCommand_ModifyPayment(_isNewRecord, _id, _admissionRequestID, _amount, _transactionDate, _transactionResult, _refID, _saleReferenceID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyPayment(bool? _isNewRecord, Guid? _id, Guid? _admissionRequestID, int? _amount, DateTime? _transactionDate, byte? _transactionResult, Guid? _refID, long? _saleReferenceID, string _log)
{
	using(var cmd = GetCommand_ModifyPayment(_isNewRecord, _id, _admissionRequestID, _amount, _transactionDate, _transactionResult, _refID, _saleReferenceID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetProfessionalDegrees

public System.Data.SqlClient.SqlCommand GetCommand_GetProfessionalDegrees(Guid? _requestID)
{
return base.CreateCommand("req.spGetProfessionalDegrees", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ARequestID", IsOutput = false, Value = _requestID == null ? DBNull.Value : (object)_requestID }, 
	});

}

public async Task<ResultSet> GetProfessionalDegreesAsync(Guid? _requestID)
{
	using(var cmd = GetCommand_GetProfessionalDegrees(_requestID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetProfessionalDegrees(Guid? _requestID)
{
	using(var cmd = GetCommand_GetProfessionalDegrees(_requestID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetPayment

public System.Data.SqlClient.SqlCommand GetCommand_GetPayment(Guid? _id, long? _orderID)
{
return base.CreateCommand("req.spGetPayment", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AOrderID", IsOutput = false, Value = _orderID == null ? DBNull.Value : (object)_orderID }, 
	});

}

public async Task<ResultSet> GetPaymentAsync(Guid? _id, long? _orderID)
{
	using(var cmd = GetCommand_GetPayment(_id, _orderID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetPayment(Guid? _id, long? _orderID)
{
	using(var cmd = GetCommand_GetPayment(_id, _orderID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAdmissionRequestsByApplicant

public System.Data.SqlClient.SqlCommand GetCommand_GetAdmissionRequestsByApplicant(Guid? _applicantID, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetAdmissionRequestsByApplicant", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AApplicantID", IsOutput = false, Value = _applicantID == null ? DBNull.Value : (object)_applicantID }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetAdmissionRequestsByApplicantAsync(Guid? _applicantID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetAdmissionRequestsByApplicant(_applicantID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAdmissionRequestsByApplicant(Guid? _applicantID, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetAdmissionRequestsByApplicant(_applicantID, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAdmissionRequest

public System.Data.SqlClient.SqlCommand GetCommand_GetAdmissionRequest(Guid? _id)
{
return base.CreateCommand("req.spGetAdmissionRequest", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetAdmissionRequestAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetAdmissionRequest(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAdmissionRequest(Guid? _id)
{
	using(var cmd = GetCommand_GetAdmissionRequest(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetApplicants

public System.Data.SqlClient.SqlCommand GetCommand_GetApplicants(byte? _type, Guid? _admissionID, string _nationalCode, string _firstName, string _lastName, string _email, string _tel, string _bCNumber, string _fatherName, int? _pageSize, int? _pageIndex)
{
return base.CreateCommand("req.spGetApplicants", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
					new Parameter { Name = "@AFirstName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_firstName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_firstName) }, 
					new Parameter { Name = "@ALastName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_lastName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_lastName) }, 
					new Parameter { Name = "@AEmail", IsOutput = false, Value = string.IsNullOrWhiteSpace(_email) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_email) }, 
					new Parameter { Name = "@ATel", IsOutput = false, Value = string.IsNullOrWhiteSpace(_tel) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_tel) }, 
					new Parameter { Name = "@ABCNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_bCNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_bCNumber) }, 
					new Parameter { Name = "@AFatherName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_fatherName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_fatherName) }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
	});

}

public async Task<ResultSet> GetApplicantsAsync(byte? _type, Guid? _admissionID, string _nationalCode, string _firstName, string _lastName, string _email, string _tel, string _bCNumber, string _fatherName, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetApplicants(_type, _admissionID, _nationalCode, _firstName, _lastName, _email, _tel, _bCNumber, _fatherName, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetApplicants(byte? _type, Guid? _admissionID, string _nationalCode, string _firstName, string _lastName, string _email, string _tel, string _bCNumber, string _fatherName, int? _pageSize, int? _pageIndex)
{
	using(var cmd = GetCommand_GetApplicants(_type, _admissionID, _nationalCode, _firstName, _lastName, _email, _tel, _bCNumber, _fatherName, _pageSize, _pageIndex))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

}

class ADM: Database
{
#region Constructors
public ADM(string connectionString)
	:base(connectionString){}

public ADM(string connectionString, IModelValueBinder modelValueBinder)
	:base(connectionString, modelValueBinder){}
#endregion

#region ModifyDivisionOfLabor

public System.Data.SqlClient.SqlCommand GetCommand_ModifyDivisionOfLabor(bool? _isNewRecord, Guid? _id, Guid? _positionID, byte? _fromLetterType, byte? _toLetterType, string _log)
{
return base.CreateCommand("adm.spModifyDivisionOfLabor", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@APositionID", IsOutput = false, Value = _positionID == null ? DBNull.Value : (object)_positionID }, 
					new Parameter { Name = "@AFromLetterType", IsOutput = false, Value = _fromLetterType == null ? DBNull.Value : (object)_fromLetterType }, 
					new Parameter { Name = "@AToLetterType", IsOutput = false, Value = _toLetterType == null ? DBNull.Value : (object)_toLetterType }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyDivisionOfLaborAsync(bool? _isNewRecord, Guid? _id, Guid? _positionID, byte? _fromLetterType, byte? _toLetterType, string _log)
{
	using(var cmd = GetCommand_ModifyDivisionOfLabor(_isNewRecord, _id, _positionID, _fromLetterType, _toLetterType, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyDivisionOfLabor(bool? _isNewRecord, Guid? _id, Guid? _positionID, byte? _fromLetterType, byte? _toLetterType, string _log)
{
	using(var cmd = GetCommand_ModifyDivisionOfLabor(_isNewRecord, _id, _positionID, _fromLetterType, _toLetterType, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteDivisionOfLabor

public System.Data.SqlClient.SqlCommand GetCommand_DeleteDivisionOfLabor(Guid? _id, string _log)
{
return base.CreateCommand("adm.spDeleteDivisionOfLabor", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteDivisionOfLaborAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteDivisionOfLabor(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteDivisionOfLabor(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteDivisionOfLabor(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyAbsentsList

public System.Data.SqlClient.SqlCommand GetCommand_ModifyAbsentsList(Guid? _examAdmissionID, string _examExcelList, string _log)
{
return base.CreateCommand("adm.spModifyAbsentsList", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamAdmissionID", IsOutput = false, Value = _examAdmissionID == null ? DBNull.Value : (object)_examAdmissionID }, 
					new Parameter { Name = "@AExamExcelList", IsOutput = false, Value = string.IsNullOrWhiteSpace(_examExcelList) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_examExcelList) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyAbsentsListAsync(Guid? _examAdmissionID, string _examExcelList, string _log)
{
	using(var cmd = GetCommand_ModifyAbsentsList(_examAdmissionID, _examExcelList, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyAbsentsList(Guid? _examAdmissionID, string _examExcelList, string _log)
{
	using(var cmd = GetCommand_ModifyAbsentsList(_examAdmissionID, _examExcelList, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExemptionAdmission

public System.Data.SqlClient.SqlCommand GetCommand_GetExemptionAdmission(Guid? _id)
{
return base.CreateCommand("adm.spGetExemptionAdmission", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetExemptionAdmissionAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetExemptionAdmission(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExemptionAdmission(Guid? _id)
{
	using(var cmd = GetCommand_GetExemptionAdmission(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExemptionAdmission

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExemptionAdmission(bool? _isNewRecord, Guid? _id, byte? _type, short? _year, string _title, DateTime? _registerStartDate, DateTime? _registerEndDate, DateTime? _registerExtendDate, DateTime? _verifyStartDate, DateTime? _verifyEndDate, DateTime? _verifyExtendDate, DateTime? _objectionStartDate, DateTime? _objectionEndDate, DateTime? _objectionExtendDate, DateTime? _completeRecordsStartDate, DateTime? _completeRecordsEndDate, int? _registrationFee, Guid? _creatorID)
{
return base.CreateCommand("adm.spModifyExemptionAdmission", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AYear", IsOutput = false, Value = _year == null ? DBNull.Value : (object)_year }, 
					new Parameter { Name = "@ATitle", IsOutput = false, Value = string.IsNullOrWhiteSpace(_title) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_title) }, 
					new Parameter { Name = "@ARegisterStartDate", IsOutput = false, Value = _registerStartDate == null ? DBNull.Value : (object)_registerStartDate }, 
					new Parameter { Name = "@ARegisterEndDate", IsOutput = false, Value = _registerEndDate == null ? DBNull.Value : (object)_registerEndDate }, 
					new Parameter { Name = "@ARegisterExtendDate", IsOutput = false, Value = _registerExtendDate == null ? DBNull.Value : (object)_registerExtendDate }, 
					new Parameter { Name = "@AVerifyStartDate", IsOutput = false, Value = _verifyStartDate == null ? DBNull.Value : (object)_verifyStartDate }, 
					new Parameter { Name = "@AVerifyEndDate", IsOutput = false, Value = _verifyEndDate == null ? DBNull.Value : (object)_verifyEndDate }, 
					new Parameter { Name = "@AVerifyExtendDate", IsOutput = false, Value = _verifyExtendDate == null ? DBNull.Value : (object)_verifyExtendDate }, 
					new Parameter { Name = "@AObjectionStartDate", IsOutput = false, Value = _objectionStartDate == null ? DBNull.Value : (object)_objectionStartDate }, 
					new Parameter { Name = "@AObjectionEndDate", IsOutput = false, Value = _objectionEndDate == null ? DBNull.Value : (object)_objectionEndDate }, 
					new Parameter { Name = "@AObjectionExtendDate", IsOutput = false, Value = _objectionExtendDate == null ? DBNull.Value : (object)_objectionExtendDate }, 
					new Parameter { Name = "@ACompleteRecordsStartDate", IsOutput = false, Value = _completeRecordsStartDate == null ? DBNull.Value : (object)_completeRecordsStartDate }, 
					new Parameter { Name = "@ACompleteRecordsEndDate", IsOutput = false, Value = _completeRecordsEndDate == null ? DBNull.Value : (object)_completeRecordsEndDate }, 
					new Parameter { Name = "@ARegistrationFee", IsOutput = false, Value = _registrationFee == null ? DBNull.Value : (object)_registrationFee }, 
					new Parameter { Name = "@ACreatorID", IsOutput = false, Value = _creatorID == null ? DBNull.Value : (object)_creatorID }, 
	});

}

public async Task<ResultSet> ModifyExemptionAdmissionAsync(bool? _isNewRecord, Guid? _id, byte? _type, short? _year, string _title, DateTime? _registerStartDate, DateTime? _registerEndDate, DateTime? _registerExtendDate, DateTime? _verifyStartDate, DateTime? _verifyEndDate, DateTime? _verifyExtendDate, DateTime? _objectionStartDate, DateTime? _objectionEndDate, DateTime? _objectionExtendDate, DateTime? _completeRecordsStartDate, DateTime? _completeRecordsEndDate, int? _registrationFee, Guid? _creatorID)
{
	using(var cmd = GetCommand_ModifyExemptionAdmission(_isNewRecord, _id, _type, _year, _title, _registerStartDate, _registerEndDate, _registerExtendDate, _verifyStartDate, _verifyEndDate, _verifyExtendDate, _objectionStartDate, _objectionEndDate, _objectionExtendDate, _completeRecordsStartDate, _completeRecordsEndDate, _registrationFee, _creatorID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExemptionAdmission(bool? _isNewRecord, Guid? _id, byte? _type, short? _year, string _title, DateTime? _registerStartDate, DateTime? _registerEndDate, DateTime? _registerExtendDate, DateTime? _verifyStartDate, DateTime? _verifyEndDate, DateTime? _verifyExtendDate, DateTime? _objectionStartDate, DateTime? _objectionEndDate, DateTime? _objectionExtendDate, DateTime? _completeRecordsStartDate, DateTime? _completeRecordsEndDate, int? _registrationFee, Guid? _creatorID)
{
	using(var cmd = GetCommand_ModifyExemptionAdmission(_isNewRecord, _id, _type, _year, _title, _registerStartDate, _registerEndDate, _registerExtendDate, _verifyStartDate, _verifyEndDate, _verifyExtendDate, _objectionStartDate, _objectionEndDate, _objectionExtendDate, _completeRecordsStartDate, _completeRecordsEndDate, _registrationFee, _creatorID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetDivisionOfLabor

public System.Data.SqlClient.SqlCommand GetCommand_GetDivisionOfLabor(Guid? _id)
{
return base.CreateCommand("adm.spGetDivisionOfLabor", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetDivisionOfLaborAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetDivisionOfLabor(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetDivisionOfLabor(Guid? _id)
{
	using(var cmd = GetCommand_GetDivisionOfLabor(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyPresentsList

public System.Data.SqlClient.SqlCommand GetCommand_ModifyPresentsList(Guid? _examAdmissionID, string _examExcelList, string _log)
{
return base.CreateCommand("adm.spModifyPresentsList", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamAdmissionID", IsOutput = false, Value = _examAdmissionID == null ? DBNull.Value : (object)_examAdmissionID }, 
					new Parameter { Name = "@AExamExcelList", IsOutput = false, Value = string.IsNullOrWhiteSpace(_examExcelList) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_examExcelList) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyPresentsListAsync(Guid? _examAdmissionID, string _examExcelList, string _log)
{
	using(var cmd = GetCommand_ModifyPresentsList(_examAdmissionID, _examExcelList, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyPresentsList(Guid? _examAdmissionID, string _examExcelList, string _log)
{
	using(var cmd = GetCommand_ModifyPresentsList(_examAdmissionID, _examExcelList, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamAdmission

public System.Data.SqlClient.SqlCommand GetCommand_GetExamAdmission(Guid? _id)
{
return base.CreateCommand("adm.spGetExamAdmission", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetExamAdmissionAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetExamAdmission(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamAdmission(Guid? _id)
{
	using(var cmd = GetCommand_GetExamAdmission(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyChairNumber

public System.Data.SqlClient.SqlCommand GetCommand_ModifyChairNumber(Guid? _admissionID, string _chairNumbers, Guid? _creatorID)
{
return base.CreateCommand("adm.spModifyChairNumber", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
					new Parameter { Name = "@AChairNumbers", IsOutput = false, Value = string.IsNullOrWhiteSpace(_chairNumbers) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_chairNumbers) }, 
					new Parameter { Name = "@ACreatorID", IsOutput = false, Value = _creatorID == null ? DBNull.Value : (object)_creatorID }, 
	});

}

public async Task<ResultSet> ModifyChairNumberAsync(Guid? _admissionID, string _chairNumbers, Guid? _creatorID)
{
	using(var cmd = GetCommand_ModifyChairNumber(_admissionID, _chairNumbers, _creatorID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyChairNumber(Guid? _admissionID, string _chairNumbers, Guid? _creatorID)
{
	using(var cmd = GetCommand_ModifyChairNumber(_admissionID, _chairNumbers, _creatorID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyExamAdmission

public System.Data.SqlClient.SqlCommand GetCommand_ModifyExamAdmission(bool? _isNewRecord, Guid? _id, byte? _type, short? _year, string _title, DateTime? _registerStartDate, DateTime? _registerEndDate, DateTime? _registerExtendDate, DateTime? _verifyStartDate, DateTime? _verifyEndDate, DateTime? _verifyExtendDate, DateTime? _objectionStartDate, DateTime? _objectionEndDate, DateTime? _objectionExtendDate, DateTime? _completeRecordsStartDate, DateTime? _completeRecordsEndDate, int? _registrationFee, int? _firstChairNumber, DateTime? _examDate, DateTime? _resultsAnnouncementDate, byte? _conditionalYears, DateTime? _printDate, bool? _showChairNumberButton, Guid? _creatorID, string _log)
{
return base.CreateCommand("adm.spModifyExamAdmission", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AYear", IsOutput = false, Value = _year == null ? DBNull.Value : (object)_year }, 
					new Parameter { Name = "@ATitle", IsOutput = false, Value = string.IsNullOrWhiteSpace(_title) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_title) }, 
					new Parameter { Name = "@ARegisterStartDate", IsOutput = false, Value = _registerStartDate == null ? DBNull.Value : (object)_registerStartDate }, 
					new Parameter { Name = "@ARegisterEndDate", IsOutput = false, Value = _registerEndDate == null ? DBNull.Value : (object)_registerEndDate }, 
					new Parameter { Name = "@ARegisterExtendDate", IsOutput = false, Value = _registerExtendDate == null ? DBNull.Value : (object)_registerExtendDate }, 
					new Parameter { Name = "@AVerifyStartDate", IsOutput = false, Value = _verifyStartDate == null ? DBNull.Value : (object)_verifyStartDate }, 
					new Parameter { Name = "@AVerifyEndDate", IsOutput = false, Value = _verifyEndDate == null ? DBNull.Value : (object)_verifyEndDate }, 
					new Parameter { Name = "@AVerifyExtendDate", IsOutput = false, Value = _verifyExtendDate == null ? DBNull.Value : (object)_verifyExtendDate }, 
					new Parameter { Name = "@AObjectionStartDate", IsOutput = false, Value = _objectionStartDate == null ? DBNull.Value : (object)_objectionStartDate }, 
					new Parameter { Name = "@AObjectionEndDate", IsOutput = false, Value = _objectionEndDate == null ? DBNull.Value : (object)_objectionEndDate }, 
					new Parameter { Name = "@AObjectionExtendDate", IsOutput = false, Value = _objectionExtendDate == null ? DBNull.Value : (object)_objectionExtendDate }, 
					new Parameter { Name = "@ACompleteRecordsStartDate", IsOutput = false, Value = _completeRecordsStartDate == null ? DBNull.Value : (object)_completeRecordsStartDate }, 
					new Parameter { Name = "@ACompleteRecordsEndDate", IsOutput = false, Value = _completeRecordsEndDate == null ? DBNull.Value : (object)_completeRecordsEndDate }, 
					new Parameter { Name = "@ARegistrationFee", IsOutput = false, Value = _registrationFee == null ? DBNull.Value : (object)_registrationFee }, 
					new Parameter { Name = "@AFirstChairNumber", IsOutput = false, Value = _firstChairNumber == null ? DBNull.Value : (object)_firstChairNumber }, 
					new Parameter { Name = "@AExamDate", IsOutput = false, Value = _examDate == null ? DBNull.Value : (object)_examDate }, 
					new Parameter { Name = "@AResultsAnnouncementDate", IsOutput = false, Value = _resultsAnnouncementDate == null ? DBNull.Value : (object)_resultsAnnouncementDate }, 
					new Parameter { Name = "@AConditionalYears", IsOutput = false, Value = _conditionalYears == null ? DBNull.Value : (object)_conditionalYears }, 
					new Parameter { Name = "@APrintDate", IsOutput = false, Value = _printDate == null ? DBNull.Value : (object)_printDate }, 
					new Parameter { Name = "@AShowChairNumberButton", IsOutput = false, Value = _showChairNumberButton == null ? DBNull.Value : (object)_showChairNumberButton }, 
					new Parameter { Name = "@ACreatorID", IsOutput = false, Value = _creatorID == null ? DBNull.Value : (object)_creatorID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyExamAdmissionAsync(bool? _isNewRecord, Guid? _id, byte? _type, short? _year, string _title, DateTime? _registerStartDate, DateTime? _registerEndDate, DateTime? _registerExtendDate, DateTime? _verifyStartDate, DateTime? _verifyEndDate, DateTime? _verifyExtendDate, DateTime? _objectionStartDate, DateTime? _objectionEndDate, DateTime? _objectionExtendDate, DateTime? _completeRecordsStartDate, DateTime? _completeRecordsEndDate, int? _registrationFee, int? _firstChairNumber, DateTime? _examDate, DateTime? _resultsAnnouncementDate, byte? _conditionalYears, DateTime? _printDate, bool? _showChairNumberButton, Guid? _creatorID, string _log)
{
	using(var cmd = GetCommand_ModifyExamAdmission(_isNewRecord, _id, _type, _year, _title, _registerStartDate, _registerEndDate, _registerExtendDate, _verifyStartDate, _verifyEndDate, _verifyExtendDate, _objectionStartDate, _objectionEndDate, _objectionExtendDate, _completeRecordsStartDate, _completeRecordsEndDate, _registrationFee, _firstChairNumber, _examDate, _resultsAnnouncementDate, _conditionalYears, _printDate, _showChairNumberButton, _creatorID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyExamAdmission(bool? _isNewRecord, Guid? _id, byte? _type, short? _year, string _title, DateTime? _registerStartDate, DateTime? _registerEndDate, DateTime? _registerExtendDate, DateTime? _verifyStartDate, DateTime? _verifyEndDate, DateTime? _verifyExtendDate, DateTime? _objectionStartDate, DateTime? _objectionEndDate, DateTime? _objectionExtendDate, DateTime? _completeRecordsStartDate, DateTime? _completeRecordsEndDate, int? _registrationFee, int? _firstChairNumber, DateTime? _examDate, DateTime? _resultsAnnouncementDate, byte? _conditionalYears, DateTime? _printDate, bool? _showChairNumberButton, Guid? _creatorID, string _log)
{
	using(var cmd = GetCommand_ModifyExamAdmission(_isNewRecord, _id, _type, _year, _title, _registerStartDate, _registerEndDate, _registerExtendDate, _verifyStartDate, _verifyEndDate, _verifyExtendDate, _objectionStartDate, _objectionEndDate, _objectionExtendDate, _completeRecordsStartDate, _completeRecordsEndDate, _registrationFee, _firstChairNumber, _examDate, _resultsAnnouncementDate, _conditionalYears, _printDate, _showChairNumberButton, _creatorID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetDepriveds

public System.Data.SqlClient.SqlCommand GetCommand_GetDepriveds(byte? _type, string _firstName, string _lastName, string _nationalCode, int? _pageIndex, int? _pageSize)
{
return base.CreateCommand("adm.spGetDepriveds", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AFirstName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_firstName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_firstName) }, 
					new Parameter { Name = "@ALastName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_lastName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_lastName) }, 
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
	});

}

public async Task<ResultSet> GetDeprivedsAsync(byte? _type, string _firstName, string _lastName, string _nationalCode, int? _pageIndex, int? _pageSize)
{
	using(var cmd = GetCommand_GetDepriveds(_type, _firstName, _lastName, _nationalCode, _pageIndex, _pageSize))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetDepriveds(byte? _type, string _firstName, string _lastName, string _nationalCode, int? _pageIndex, int? _pageSize)
{
	using(var cmd = GetCommand_GetDepriveds(_type, _firstName, _lastName, _nationalCode, _pageIndex, _pageSize))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetDeprivedsByNationalCode

public System.Data.SqlClient.SqlCommand GetCommand_GetDeprivedsByNationalCode(string _nationalCode)
{
return base.CreateCommand("adm.spGetDeprivedsByNationalCode", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
	});

}

public async Task<ResultSet> GetDeprivedsByNationalCodeAsync(string _nationalCode)
{
	using(var cmd = GetCommand_GetDeprivedsByNationalCode(_nationalCode))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetDeprivedsByNationalCode(string _nationalCode)
{
	using(var cmd = GetCommand_GetDeprivedsByNationalCode(_nationalCode))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyDescriptiveScores

public System.Data.SqlClient.SqlCommand GetCommand_ModifyDescriptiveScores(Guid? _examAdmissionID, string _examExcelList, string _log)
{
return base.CreateCommand("adm.spModifyDescriptiveScores", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamAdmissionID", IsOutput = false, Value = _examAdmissionID == null ? DBNull.Value : (object)_examAdmissionID }, 
					new Parameter { Name = "@AExamExcelList", IsOutput = false, Value = string.IsNullOrWhiteSpace(_examExcelList) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_examExcelList) }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyDescriptiveScoresAsync(Guid? _examAdmissionID, string _examExcelList, string _log)
{
	using(var cmd = GetCommand_ModifyDescriptiveScores(_examAdmissionID, _examExcelList, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyDescriptiveScores(Guid? _examAdmissionID, string _examExcelList, string _log)
{
	using(var cmd = GetCommand_ModifyDescriptiveScores(_examAdmissionID, _examExcelList, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetDeprived

public System.Data.SqlClient.SqlCommand GetCommand_GetDeprived(Guid? _id)
{
return base.CreateCommand("adm.spGetDeprived", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetDeprivedAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetDeprived(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetDeprived(Guid? _id)
{
	using(var cmd = GetCommand_GetDeprived(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region EnableDeprived

public System.Data.SqlClient.SqlCommand GetCommand_EnableDeprived(Guid? _id, bool? _enable, string _log)
{
return base.CreateCommand("adm.spEnableDeprived", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@AEnable", IsOutput = false, Value = _enable == null ? DBNull.Value : (object)_enable }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> EnableDeprivedAsync(Guid? _id, bool? _enable, string _log)
{
	using(var cmd = GetCommand_EnableDeprived(_id, _enable, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet EnableDeprived(Guid? _id, bool? _enable, string _log)
{
	using(var cmd = GetCommand_EnableDeprived(_id, _enable, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteDeprived

public System.Data.SqlClient.SqlCommand GetCommand_DeleteDeprived(Guid? _id, string _log)
{
return base.CreateCommand("adm.spDeleteDeprived", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteDeprivedAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteDeprived(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteDeprived(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteDeprived(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyDeprived

public System.Data.SqlClient.SqlCommand GetCommand_ModifyDeprived(bool? _isNewRecord, Guid? _id, string _nationalCode, string _firstName, string _lastName, byte? _type, short? _fromYear, short? _toYear, DateTime? _proceedingsDate, string _proceedingsNumber, string _comment, Guid? _userID, string _log)
{
return base.CreateCommand("adm.spModifyDeprived", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AIsNewRecord", IsOutput = false, Value = _isNewRecord == null ? DBNull.Value : (object)_isNewRecord }, 
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ANationalCode", IsOutput = false, Value = string.IsNullOrWhiteSpace(_nationalCode) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_nationalCode) }, 
					new Parameter { Name = "@AFirstName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_firstName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_firstName) }, 
					new Parameter { Name = "@ALastName", IsOutput = false, Value = string.IsNullOrWhiteSpace(_lastName) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_lastName) }, 
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@AFromYear", IsOutput = false, Value = _fromYear == null ? DBNull.Value : (object)_fromYear }, 
					new Parameter { Name = "@AToYear", IsOutput = false, Value = _toYear == null ? DBNull.Value : (object)_toYear }, 
					new Parameter { Name = "@AProceedingsDate", IsOutput = false, Value = _proceedingsDate == null ? DBNull.Value : (object)_proceedingsDate }, 
					new Parameter { Name = "@AProceedingsNumber", IsOutput = false, Value = string.IsNullOrWhiteSpace(_proceedingsNumber) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_proceedingsNumber) }, 
					new Parameter { Name = "@AComment", IsOutput = false, Value = string.IsNullOrWhiteSpace(_comment) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_comment) }, 
					new Parameter { Name = "@AUserID", IsOutput = false, Value = _userID == null ? DBNull.Value : (object)_userID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyDeprivedAsync(bool? _isNewRecord, Guid? _id, string _nationalCode, string _firstName, string _lastName, byte? _type, short? _fromYear, short? _toYear, DateTime? _proceedingsDate, string _proceedingsNumber, string _comment, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifyDeprived(_isNewRecord, _id, _nationalCode, _firstName, _lastName, _type, _fromYear, _toYear, _proceedingsDate, _proceedingsNumber, _comment, _userID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyDeprived(bool? _isNewRecord, Guid? _id, string _nationalCode, string _firstName, string _lastName, byte? _type, short? _fromYear, short? _toYear, DateTime? _proceedingsDate, string _proceedingsNumber, string _comment, Guid? _userID, string _log)
{
	using(var cmd = GetCommand_ModifyDeprived(_isNewRecord, _id, _nationalCode, _firstName, _lastName, _type, _fromYear, _toYear, _proceedingsDate, _proceedingsNumber, _comment, _userID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetQuorums

public System.Data.SqlClient.SqlCommand GetCommand_GetQuorums(Guid? _examAdmissionID)
{
return base.CreateCommand("adm.spGetQuorums", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AExamAdmissionID", IsOutput = false, Value = _examAdmissionID == null ? DBNull.Value : (object)_examAdmissionID }, 
	});

}

public async Task<ResultSet> GetQuorumsAsync(Guid? _examAdmissionID)
{
	using(var cmd = GetCommand_GetQuorums(_examAdmissionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetQuorums(Guid? _examAdmissionID)
{
	using(var cmd = GetCommand_GetQuorums(_examAdmissionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region ModifyQuorum

public System.Data.SqlClient.SqlCommand GetCommand_ModifyQuorum(Guid? _id, int? _testQuorum, int? _descriptiveQuorum, int? _totalQuorum, string _log)
{
return base.CreateCommand("adm.spModifyQuorum", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ATestQuorum", IsOutput = false, Value = _testQuorum == null ? DBNull.Value : (object)_testQuorum }, 
					new Parameter { Name = "@ADescriptiveQuorum", IsOutput = false, Value = _descriptiveQuorum == null ? DBNull.Value : (object)_descriptiveQuorum }, 
					new Parameter { Name = "@ATotalQuorum", IsOutput = false, Value = _totalQuorum == null ? DBNull.Value : (object)_totalQuorum }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> ModifyQuorumAsync(Guid? _id, int? _testQuorum, int? _descriptiveQuorum, int? _totalQuorum, string _log)
{
	using(var cmd = GetCommand_ModifyQuorum(_id, _testQuorum, _descriptiveQuorum, _totalQuorum, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet ModifyQuorum(Guid? _id, int? _testQuorum, int? _descriptiveQuorum, int? _totalQuorum, string _log)
{
	using(var cmd = GetCommand_ModifyQuorum(_id, _testQuorum, _descriptiveQuorum, _totalQuorum, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetQuorum

public System.Data.SqlClient.SqlCommand GetCommand_GetQuorum(Guid? _id)
{
return base.CreateCommand("adm.spGetQuorum", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
	});

}

public async Task<ResultSet> GetQuorumAsync(Guid? _id)
{
	using(var cmd = GetCommand_GetQuorum(_id))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetQuorum(Guid? _id)
{
	using(var cmd = GetCommand_GetQuorum(_id))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteExamAdmission

public System.Data.SqlClient.SqlCommand GetCommand_DeleteExamAdmission(Guid? _id, string _log)
{
return base.CreateCommand("adm.spDeleteExamAdmission", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteExamAdmissionAsync(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteExamAdmission(_id, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteExamAdmission(Guid? _id, string _log)
{
	using(var cmd = GetCommand_DeleteExamAdmission(_id, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetAdmissions

public System.Data.SqlClient.SqlCommand GetCommand_GetAdmissions(byte? _type, string _title, int? _pageIndex, int? _pageSize)
{
return base.CreateCommand("adm.spGetAdmissions", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AType", IsOutput = false, Value = _type == null ? DBNull.Value : (object)_type }, 
					new Parameter { Name = "@ATitle", IsOutput = false, Value = string.IsNullOrWhiteSpace(_title) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_title) }, 
					new Parameter { Name = "@APageIndex", IsOutput = false, Value = _pageIndex == null ? DBNull.Value : (object)_pageIndex }, 
					new Parameter { Name = "@APageSize", IsOutput = false, Value = _pageSize == null ? DBNull.Value : (object)_pageSize }, 
	});

}

public async Task<ResultSet> GetAdmissionsAsync(byte? _type, string _title, int? _pageIndex, int? _pageSize)
{
	using(var cmd = GetCommand_GetAdmissions(_type, _title, _pageIndex, _pageSize))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetAdmissions(byte? _type, string _title, int? _pageIndex, int? _pageSize)
{
	using(var cmd = GetCommand_GetAdmissions(_type, _title, _pageIndex, _pageSize))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetChairNumbers

public System.Data.SqlClient.SqlCommand GetCommand_GetChairNumbers(Guid? _admissionID)
{
return base.CreateCommand("adm.spGetChairNumbers", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AAdmissionID", IsOutput = false, Value = _admissionID == null ? DBNull.Value : (object)_admissionID }, 
	});

}

public async Task<ResultSet> GetChairNumbersAsync(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetChairNumbers(_admissionID))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetChairNumbers(Guid? _admissionID)
{
	using(var cmd = GetCommand_GetChairNumbers(_admissionID))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region DeleteAdmission

public System.Data.SqlClient.SqlCommand GetCommand_DeleteAdmission(Guid? _id, Guid? _removerID, string _log)
{
return base.CreateCommand("adm.spDeleteAdmission", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
					new Parameter { Name = "@AID", IsOutput = false, Value = _id == null ? DBNull.Value : (object)_id }, 
					new Parameter { Name = "@ARemoverID", IsOutput = false, Value = _removerID == null ? DBNull.Value : (object)_removerID }, 
					new Parameter { Name = "@ALog", IsOutput = false, Value = string.IsNullOrWhiteSpace(_log) ? DBNull.Value : (object)ReplaceArabicWithPersianChars(_log) }, 
	});

}

public async Task<ResultSet> DeleteAdmissionAsync(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteAdmission(_id, _removerID, _log))
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet DeleteAdmission(Guid? _id, Guid? _removerID, string _log)
{
	using(var cmd = GetCommand_DeleteAdmission(_id, _removerID, _log))
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetDivisionOfLabors

public System.Data.SqlClient.SqlCommand GetCommand_GetDivisionOfLabors()
{
return base.CreateCommand("adm.spGetDivisionOfLabors", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
	});

}

public async Task<ResultSet> GetDivisionOfLaborsAsync()
{
	using(var cmd = GetCommand_GetDivisionOfLabors())
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetDivisionOfLabors()
{
	using(var cmd = GetCommand_GetDivisionOfLabors())
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExemptionAdmissions

public System.Data.SqlClient.SqlCommand GetCommand_GetExemptionAdmissions()
{
return base.CreateCommand("adm.spGetExemptionAdmissions", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
	});

}

public async Task<ResultSet> GetExemptionAdmissionsAsync()
{
	using(var cmd = GetCommand_GetExemptionAdmissions())
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExemptionAdmissions()
{
	using(var cmd = GetCommand_GetExemptionAdmissions())
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetExamAdmissions

public System.Data.SqlClient.SqlCommand GetCommand_GetExamAdmissions()
{
return base.CreateCommand("adm.spGetExamAdmissions", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
	});

}

public async Task<ResultSet> GetExamAdmissionsAsync()
{
	using(var cmd = GetCommand_GetExamAdmissions())
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetExamAdmissions()
{
	using(var cmd = GetCommand_GetExamAdmissions())
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

#region GetActiveAdmissions

public System.Data.SqlClient.SqlCommand GetCommand_GetActiveAdmissions()
{
return base.CreateCommand("adm.spGetActiveAdmissions", 
	System.Data.CommandType.StoredProcedure, 
	new Parameter[]{
	});

}

public async Task<ResultSet> GetActiveAdmissionsAsync()
{
	using(var cmd = GetCommand_GetActiveAdmissions())
{
	return new ResultSet(cmd, await ExecuteAsync(cmd), _modelValueBinder);
}
}

public ResultSet GetActiveAdmissions()
{
	using(var cmd = GetCommand_GetActiveAdmissions())
{
	return new ResultSet(cmd, Execute(cmd), _modelValueBinder);
}
}

#endregion

}

}
