<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="${fns:text('参数管理')} - ${config.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('参数')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-qrcode"></i>${empty config.id ? fns:text('新增') : fns:text('编辑')}${fns:text('参数')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="config" action="${ctx}/sys/config/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('名称')}：</label>
							<div class="col-sm-8">
								<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('键名')}：</label>
							<div class="col-sm-8">
								<form:input path="keys" htmlEscape="false" maxlength="100" class="form-control required "/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"><span class="required">*</span> ${fns:text('键值')}：</label>
							<div class="col-sm-8">
								<form:textarea path="value" htmlEscape="false" rows="4" maxlength="2000" class="form-control required "/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"> ${fns:text('描述')}：</label>
							<div class="col-sm-8">
								<form:textarea path="description" htmlEscape="false" rows="6" maxlength="2000" class="form-control "/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:config:edit">
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
	$("#inputForm").validate({
		rules: {
			keys: {remote: "${ctx}/sys/config/checkKeys?oldKeys=" + encodeURIComponent("${config.keys}")},
		},
		messages: {
			keys: {remote: "${fns:text('关键字已存在')}"},
		},
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