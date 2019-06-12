<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="${fns:text('员工管理')} - ${employee.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('员工')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="glyphicon glyphicon-user"></i>${employee.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('员工')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="employee" action="${ctx}/sys/employee/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group ">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('员工编码')}：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:hidden path="empCode"/>
								<form:input path="empNo" htmlEscape="false" maxlength="30" readonly="${!employee.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('员工姓名')}：</label>
							<div class="col-sm-8">
								<form:input path="empName" htmlEscape="false" maxlength="100" class="form-control   required "/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属公司')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="company" name="company.id" value="${employee.company.id}" labelName="company.companyNameSimple" labelValue="${employee.company.companyNameSimple}" 
									title="${fns:text('公司')}" url="/sys/company/treeData"  cssClass="required"  allowClear="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属机构')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="office" name="office.id" value="${employee.office.id}" labelName="office.officeName" labelValue="${employee.office.officeName}" 
									title="${fns:text('机构')}" url="/sys/office/treeData"  cssClass="required"  allowClear="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group ">
							<label class="control-label col-sm-4">${fns:text('所在岗位')}：</label>
							<div class="col-sm-8">
								<form:select path="postIdList" multiple="true" class="form-control input-sm"  >
									<form:options items="${allPosts}" itemLabel="postName" itemValue="postCode" htmlEscape="false"/>
								</form:select>
							</div>
							
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group ">
							<label class="control-label col-sm-4">${fns:text('电子邮箱')}：</label>
							<div class="col-sm-8">
								<form:input path="email" htmlEscape="false" maxlength="100" class="form-control email"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('手机号码')}：</label>
							<div class="col-sm-8">
								<form:input path="mobile" htmlEscape="false" maxlength="20" class="form-control mobile"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('办公电话')}：</label>
							<div class="col-sm-8">
								<form:input path="officePhone" htmlEscape="false" maxlength="255" class="form-control "/>
							</div>
						</div>
					</div>
				</div>
				<div class="${!employee.isNewRecord ? 'display-none' : ''}"> 
					<h4 class="form-section">${fns:text('登录信息')}</h4>
					<div class="row">
						<div class="col-xs-12">
							<div class="form-group">
								<label class="control-label col-sm-2">${fns:text('是否登录用户')}：</label>
								<div class="col-sm-10">
									<div class="radio-list">
										<form:radiobuttons  path="isLoginUser" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" 
											htmlEscape="false"  />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="loginInfoMsg display-none">
						<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('登录账号')}：</label>
									<div class="col-sm-8">
										<form:input path="loginInfo.loginCode" htmlEscape="false" maxlength="255" placeholder="${fns:text('请输入登录账号')}" class="form-control " />
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('用户名称')}：</label>
									<div class="col-sm-8">
										<form:input path="loginInfo.userName" htmlEscape="false" maxlength="255" placeholder="${fns:text('请输入用户名称')}" class="form-control " />
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4">${fns:text('授权角色')}：</label>
									<div class="col-sm-8">
										<form:select path="loginInfo.roleCodes" multiple="true" class="form-control input-sm">
											<form:options items="${allRoles}" itemLabel="roleName" itemValue="roleCode" htmlEscape="false" />
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:employee:edit">
							<c:if test="${employee.status eq '0'}">
								<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
							</c:if>
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
	$("#name").focus();
	$("#inputForm").validate({
// 		rules: {
// 			empCode: {remote: "${ctx}/sys/employee/checkEmpCode?oldEmpCode=" + encodeURIComponent("${employee.empCode}")},
// 			empNo: {remote: "${ctx}/sys/employee/checkEmpNo?oldEmpNo=" + encodeURIComponent("${employee.empNo}")}
// 		},
// 		messages: {
// 			empCode: {remote: "员工编码已存在"},
// 			empNo: {remote: "工号已存在"}
// 		},
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
	$("input[name='isLoginUser']").click(function(){
	   if($(this).val() == "0"){
		   $(".loginInfoMsg").addClass("display-none");
		   $("input[name='loginInfo.loginCode'],input[name='loginInfo.userName']").removeClass("required");
	   }else{
		   $(".loginInfoMsg").removeClass("display-none");
		   var uc = $("input[name='loginInfo.loginCode']").addClass("required");
		   var un = $("input[name='loginInfo.userName']").addClass("required");
		   if (uc.val() == ""){
			   uc.val($("#empNo").val());
		   }
		   if (un.val() == ""){
			   un.val($("#empName").val());
		   }
	   }		   
	});
</script>