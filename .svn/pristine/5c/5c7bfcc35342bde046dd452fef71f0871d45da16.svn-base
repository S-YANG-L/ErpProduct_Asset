<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="jbox,ztree,grid,validate"/>
<sys:header title="集团管理员管理 - ${user.isNewRecord ? '新增' : '编辑'}集团管理员" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} tabbable autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-user-md"></i>${user.isNewRecord ? '新增' : '编辑'}集团管理员
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/corpAdminUser/save?op=${param.op}" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="col-sm-4 control-label"><span class="required">*</span> 登录账号：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:hidden path="userCode"/>
								<form:input path="loginCode" onchange="var e=$('#corpCode');if(e.val()=='')e.val(this.value);"
									 htmlEscape="false" placeholder="请输入登录账号" maxlength="30" readonly="${!user.isNewRecord}" class="form-control abc required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 用户名称：</label>
							<div class="col-sm-8">
								<form:input path="userName" onchange="var e=$('#corpName');if(e.val()=='')e.val(this.value);"
									 htmlEscape="false" placeholder="请输入用户名称" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="col-sm-4 control-label"><span class="required">*</span> 集团代码：</label>
							<div class="col-sm-8">
								<form:input path="corpCode" htmlEscape="false" placeholder="请输入集团代码" maxlength="30" readonly="${!user.isNewRecord}" class="form-control abc required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 集团名称：</label>
							<div class="col-sm-8">
								<form:input path="corpName" htmlEscape="false" placeholder="请输入集团名称" maxlength="100" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				</c:if>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">手机号码：</label>
							<div class="col-sm-8">
								<div class="input-group">
									<span class="input-group-addon"> <i class="fa fa-mobile-phone"></i> </span>
									<form:input path="mobile" htmlEscape="false" placeholder="请输入手机" maxlength="100" class="form-control mobile"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">电话号码：</label>
							<div class="col-sm-8">
								<div class="input-group">
									<span class="input-group-addon"> <i class="fa fa-phone"></i> </span>
									<form:input path="phone" htmlEscape="false" placeholder="请输入电话" maxlength="100" class="form-control "/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">电子邮箱：</label>
							<div class="col-sm-8">
								<div class="input-group">
									<span class="input-group-addon"> <i class="fa fa-envelope"></i> </span>
									<form:input path="email" htmlEscape="false" placeholder="请输入邮箱" maxlength="100" class="form-control email"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">手机串号：</label>
							<div class="col-sm-8">
								<div class="input-group">
									<span class="input-group-addon"> <i class="fa fa-ticket"></i> </span>
									<form:input path="imei" htmlEscape="false" placeholder="请输入手机串号" maxlength="100" class="form-control "/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:corpAdminUser:edit">
							<c:if test="${user.status eq '0'}">
								<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
							</c:if>
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>	
		</form:form>
	</div>				
</div>
<sys:footer extLibs="${extLibs}" />
<script>	
	jQuery(document).ready(function() {  
		$("#inputForm").validate({
// 			rules: {
// 				userCode: {remote: "${ctx}/sys/corpAdminUser/checkUserCode?oldUserCode=" + encodeURIComponent("${user.userCode}")},
// 			},
// 			messages: {
// 				userCode: {remote: "用户账号已存在"},
// 			},
// 			ignore: "",
			submitHandler: function(form){
				//提交表单
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
	});
</script>
	