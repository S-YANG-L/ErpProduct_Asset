<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="字典类型管理 - ${userDictType.isNewRecord ? '新增' : '编辑'}字典类型" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-notebook"></i>${userDictType.isNewRecord ? '新增' : '编辑'}字典类型</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="sys:userDictType:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="userDictType" action="${ctx}/sys/userDictType/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 字典类型：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:input path="dictTypeCode" htmlEscape="false" maxlength="100" readonly="${!userDictType.isNewRecord}" class="form-control required"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 类型名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="dictTypeName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注信息：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:userDictType:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}
			}, "json");
	    }
	});
</script>