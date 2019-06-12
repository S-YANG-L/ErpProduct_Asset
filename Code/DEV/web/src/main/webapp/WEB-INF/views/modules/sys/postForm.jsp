<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<sys:header title="${fns:text('岗位管理')} - ${post.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('岗位')}" extLibs="validate"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${post.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('岗位')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="post" action="${ctx}/sys/post/save" method="post" class="form-horizontal">
			<sys:message content="${message}"/>
			<div class="form-body">
				<h4 class="form-section ">${fns:text('基本信息')}</h4>
				<c:choose><c:when test="${post.currentUser.admin}">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('岗位编码')}：</label>
								<div class="col-sm-8">
									<form:hidden path="isNewRecord"/>
									<form:input path="postCode" htmlEscape="false" maxlength="64" readonly="${!post.isNewRecord}" class="form-control abc required"/>
									<span class="help-block">&nbsp;</span>
								</div>
							</div>
						</div>
					</div>
				</c:when><c:otherwise>
					<form:hidden path="postCode"/>
				</c:otherwise></c:choose>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('岗位名称')}：</label>
							<div class="col-sm-8">
								<input id="oldName" name="oldName" type="hidden" value="${post.postName}">
								<form:input path="postName" htmlEscape="false" maxlength="50" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<%-- <div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 排序（升序）：</label>
							<div class="col-sm-8">
								<form:input path="sorts" htmlEscape="false" maxlength="50" class="form-control required digits"/>
							</div>
						</div>
					</div>
				</div> --%>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('备注')}：</label>
							<div class="col-sm-8">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:post:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="validate"/>
<script type="text/javascript">
		
	// 如果当前状态为停用，保存按钮不显示，输入框不允许输入
	if("${post.status}" == Global.STATUS_DISABLE){
		$('input').attr("disabled","disabled");
		$('textArea').attr("disabled","disabled");
		$('button[type="submit"]').addClass('display-none');
	}
	
	$("#inputForm").validate({
		rules: {
			postName: {remote: "${ctx}/sys/post/checkName?oldName=" + encodeURIComponent("${post.postName}")}
		},
		messages: {
			postName: {remote: "岗位名已存在"}
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