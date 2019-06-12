<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="${fns:text('模块管理')} - ${module.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('模块')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-puzzle-piece"></i>${module.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('模块')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="module" action="${ctx}/sys/module/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('模块编码')}：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:input path="moduleCode" htmlEscape="false" maxlength="64" readonly="${!module.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('模块名称')}：</label>
							<div class="col-sm-8">
								<form:input path="moduleName" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="${fns:text('类的全名称，根据类名检查该模块是否启用')}。">
								<span class="required">*</span> ${fns:text('关键类名称')}： <i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="className" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"> ${fns:text('描述')}：</label>
							<div class="col-sm-8">
								<form:textarea path="description" htmlEscape="false" rows="4" maxlength="2000" class="form-control "/>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${!module.isNewRecord}">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required hide">*</span> ${fns:text('当前版本')}：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10 control-text">
								${module.currentVersion} &nbsp; ${module.upgradeInfo}
							</div>
						</div>
					</div>
				</div>
				</c:if>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:module:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	$(document).ready(function() {
		// 如果当前状态为停用，保存按钮不显示，输入框不允许输入
		if("${module.status}" == Global.STATUS_DISABLE){
			$('input').attr("disabled","disabled");
			$('textArea').attr("disabled","disabled");
			$('button[type="submit"]').addClass('display-none');
		}
		$("#name").focus();
		$("#inputForm").validate({
			rules: {
				moduleCode: {remote: "${ctx}/sys/module/checkCode?oldCode=" + encodeURIComponent("${module.moduleCode}")},
			},
			messages: {
				moduleCode: {remote: "编码已存在"},
			},
			submitHandler: function(form){				
				ajaxSubmitForm($(form), function(data){
					if(data.result == Global.TRUE){
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}
					showMessage(data.message);
				}, "json");
		    }
		});
	});
</script>