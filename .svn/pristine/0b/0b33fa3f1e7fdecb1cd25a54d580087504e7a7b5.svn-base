<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="工作流模板子表管理 - ${flowTemplates.isNewRecord ? '新增' : '编辑'}工作流模板子表" extLibs="${extLibs}"/>
<style>
.form .form-body .row {
    margin: 0 5px 0 -15px;
}
</style>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="flowTemplates" action="${ctx}/eflow/flowTemplates/save" method="post" class="form-horizontal">
			<div class="form-body">
				<form:hidden path="id"/>
				<form:hidden path="flowId"/>
				<input type="hidden" id="oldStep" value="${flowTemplates.step}" />
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 步骤：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="step" htmlEscape="false" maxlength="20" class="form-control required digits"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 步骤名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="stepName" htmlEscape="false" maxlength="200" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								审批对象类型：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="radio" name="approvalObjType" id="approvalObjType1" value="1" htmlEscape="false" maxlength="1" class="form-control" checked="checked"/><label for="approvalObjType1">岗位</label>
								<input type="radio" name="approvalObjType" id="approvalObjType2" value="2" htmlEscape="false" maxlength="1" class="form-control" /><label for="approvalObjType2">角色</label>
								<input type="radio" name="approvalObjType" id="approvalObjType3" value="3" htmlEscape="false" maxlength="1" class="form-control" /><label for="approvalObjType3">人员</label>
								<input type="radio" name="approvalObjType" id="approvalObjType4" value="4" htmlEscape="false" maxlength="1" class="form-control" /><label for="approvalObjType4">发起人</label>
							</div>
						</div>
					</div>
					<div class="col-xs-6" id="div_approvalObj">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 审批对象：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<div id="approvalobj_post">
									<%-- <form:hidden path="approvalPostName" id="approvalPostName"/> --%>
									<form:select path="approvalPostCode" multiple="false" class="form-control input-sm"  >
										<form:option value=""></form:option>
										<form:options items="${allPosts}" itemLabel="postName" itemValue="postCode" htmlEscape="false"/>
									</form:select>
								</div>
								<div id="approvalobj_role" style="display: none;">
									<%-- <form:hidden path="approvalRoleName" id="approvalRoleName"/> --%>
									<form:select path="approvalRoleCode" multiple="false" class="form-control input-sm"  >
										<form:option value=""></form:option>
										<form:options items="${allRoles}" itemLabel="roleName" itemValue="roleCode" htmlEscape="false"/>
									</form:select>
								</div>
								<div id="approvalobj_emp" style="display: none;">
									<sys:listselect id="approvalUser" name="approvalObjCode" value="${flowTemplates.approvalObjCode}" labelName="approvalObjName" labelValue="${flowTemplates.approvalObjName}"
									title="审批人" url="${ctx}/sys/user/userSelect" returnCodeAttr="userCode" returnNameAttr="userName" isAll="true" multiple="false" cssClass="form-control"  />
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								分支判定最小值：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="minValue" htmlEscape="false" class="form-control number"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								分支判定最大值：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="maxValue" htmlEscape="false" class="form-control number"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								不可跳过：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="radio" name="notSkip" id="notSkip1" value="1" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.notSkip eq '1'}"> checked="checked"</c:if> /><label for="notSkip1">是</label>
								<input type="radio" name="notSkip" id="notSkip2" value="0" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.notSkip eq '0'}"> checked="checked"</c:if> /><label for="notSkip2">否</label>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								审批不通过时：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="radio" name="backFlag" id="backFlag1" value="1" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.backFlag eq '1'}"> checked="checked"</c:if> /><label for="backFlag1">退回到上一步</label>
								<input type="radio" name="backFlag" id="backFlag2" value="0" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.backFlag eq '0'}"> checked="checked"</c:if> /><label for="backFlag2">退回到申请人</label>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="下一步骤序号，有分支时多个步骤序号用英文逗号隔开，不填时按序号大小决定步骤顺序">
								下一步骤：<i class="fa icon-question "></i></label>
							<div class="col-sm-8">
								<form:input path="nextStep" htmlEscape="false" class="form-control "/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="指定审批人：提交到当前步骤时，必须指定审批人；&#10;不指定审批人：由当前步骤审批对象的任意审批人进行审批；">
								审批类型：<i class="fa icon-question "></i></label>
							<div class="col-sm-8">
								<input type="radio" name="approvalType" id="approvalType1" value="0" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.approvalType eq '0'}"> checked="checked"</c:if> /><label for="approvalType1" title="">指定审批人</label>
								<input type="radio" name="approvalType" id="approvalType2" value="1" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.approvalType eq '1'}"> checked="checked"</c:if> /><label for="approvalType2" title="">不指定审批人 </label>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="checkbox" name="isCsign" id="isCsign" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.isCsign eq '1'}"> checked="checked"</c:if> /><label for="isCsign" title="">包含会签</label>&nbsp;
								<input type="checkbox" name="isJoint" id="isJoint" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.isJoint eq '1'}"> checked="checked"</c:if> /><label for="isJoint" title="">包含会审 </label>&nbsp;
								<input type="checkbox" name="isNotify" id="isNotify" htmlEscape="false" maxlength="1" class="form-control" <c:if test="${flowTemplates.isNotify eq '1'}"> checked="checked"</c:if> /><label for="isNotify" title="">包含知会 </label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/eflow/eflow-templates.js?${_version}"></script>
<script type="text/javascript">
    var dataMap = {}; // 获取数据MAP
    // 保存方式，saveTemp：不报存到数据库，最后一起保存，save：直接保存到数据库
    var saveFlag = "saveTemp";
    var result;
	$(function () {
	    initApprovalObjType('${flowTemplates.approvalObjType}');
	})
    // 保存模板子表数据
	function saveTemplates(){
		saveFlag = "save";
    	$("#inputForm").submit();
    	return result;
    }
	$("#inputForm").validate({
		rules: { 
			step: { min: 1 }
		},
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					if(saveFlag == "saveTemp"){
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}else{
						result = data.flowTemplates;
					}
				}
			}, "json",false);
	    }
	});
</script>