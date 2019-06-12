<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload"/>
<c:set var="extHead">
<style type="text/css">
	.form-group.has-error{position:relative;} label.has-error{top:auto;right:0;}
</style>
<link href="${ctxStatic}/jquery-plugin/jquery.strength.css" type="text/css" rel="stylesheet"/>
</c:set>
<sys:header title="${fns:text('个人信息')}" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${fns:text('个人信息')}</div>
	</div>
	<div class="portlet-body form">
		<div class="form-body" style="margin-top:10px;">
				<div class="row profile-account">
					<div class="col-sm-3">
						<ul class="ver-inline-menu tabbable margin-bottom-10" id="uuid">
							<li class="${qtype==0?'active':'' }">
								<a data-toggle="tab" href="#tab_1-1">
								<i class="fa fa-user"></i> ${fns:text('基本信息')}</a>
								<span class="after"></span>
							</li>
							<li class="${qtype==1?'active':'' }">
								<a data-toggle="tab" href="#tab_2-2" onclick="setTimeout('$(window).resize()',300);">
								<i class="fa fa-picture-o"></i> ${fns:text('更改头像')} </a>
							</li>
							<li class="${qtype==2?'active':'' }">
								<a data-toggle="tab" href="#tab_3-3">
								<i class="fa fa-key"></i> ${fns:text('修改密码')} </a>
							</li>
							<li class="${qtype==3?'active':'' }">
								<a data-toggle="tab" href="#tab_4-4">
								<i class="fa fa-eye"></i> ${fns:text('密保问题')} </a>
							</li>
						</ul>
					</div>
					<div class="col-sm-9">
						<div class="tab-content">
							<sys:message content="${not empty param.message ? param.message : message}"/>
							<div id="tab_1-1" class="tab-pane ${qtype==0?'active':'' }">
								<form:form id="inputFormBasicMsg" modelAttribute="user" action="${ctx}/sys/user/info" method="post">
									<input type="hidden" name="qtype" value="0" />
									<input type="hidden" name="__url" value="${__url}" />
									<div class="form-group">
										<label class="control-label">${fns:text('用户账号')}</label>
										<form:input path="userCode" htmlEscape="false" disabled="true" class="form-control abc required"/>
									</div>
									<div class="form-group">
										<label class="control-label">${fns:text('昵称')}</label>
										<form:input path="userName" htmlEscape="false" placeholder="${fns:text('请输入昵称')}" maxlength="100" class="form-control required"/>
									</div>
									<div class="form-group">
										<label class="control-label">${fns:text('手机号码')}</label>
										<form:input path="mobile" htmlEscape="false" placeholder="${fns:text('请输入手机')}" maxlength="100" class="form-control required mobile"/>
									</div>
									<div class="form-group">
										<label class="control-label">${fns:text('电话号码')}</label>
										<form:input path="phone" htmlEscape="false" placeholder="${fns:text('请输入电话')}" maxlength="100" class="form-control simplePhone"/>
									</div>
									<div class="form-group">
										<label class="control-label">${fns:text('邮箱地址')}</label>
										<form:input path="email" htmlEscape="false" placeholder="${fns:text('请输入邮箱')}" maxlength="100" class="form-control required email"/>
									</div>
									<div class="form-group">
										<label class="control-label">${fns:text('备注')}</label>
										<form:textarea path="remarks" htmlEscape="false" class="form-control" rows="3" placeholder=""></form:textarea>
									</div>
									<div class="margiv-top-10">
										<button id="btnSubmitBasicMsg" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保存修改')}</button>
									</div>
								</form:form>
							</div>
							<div id="tab_2-2" class="tab-pane ${qtype==1?'active':'' }">
								<form:form id="inputFormPhoto" modelAttribute="user" action="${ctx}/sys/user/info" method="post" enctype="multipart/form-data" >
									<input type="hidden" name="qtype" value="1" />
									<input type="hidden" name="__url" value="${__url}" />
									<div class="form-group">
<%-- 										<form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/> --%>
<%-- 										<sys:ckfinder input="photo" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/> --%>
										<sys:fileupload id="photo" bizCategory="photo" bizKey="${user.photo}" returnPath="true" uploadType="image" maxUploadNum="1"/>
									</div>
									<div class="margin-top-10">
										<button id="btnSubmitPhtot" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保存修改')}</button>
									</div>
								</form:form>
							</div>
							<div id="tab_3-3" class="tab-pane ${qtype==2?'active':'' }">
								<form:form id="inputFormPassword" modelAttribute="user" action="${ctx}/sys/user/info" method="post">
									<input type="hidden" name="qtype" value="2" />
									<input type="hidden" name="__url" value="${__url}" />
									<div class="form-group">
										<label class="control-label">${fns:text('旧密码')}</label>
										<input id="oldPassword" name="oldPassword" type="password" autocomplete="off" value="" maxlength="50" minlength="3" class="form-control required"/>
									</div>
									<div class="form-group">
										<label class="control-label">${fns:text('新密码')}</label>
										<div class="strength">
											<input id="newPassword" name="newPassword" type="password" autocomplete="off" value="" maxlength="50" minlength="3" class="form-control required"/>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label">${fns:text('确认新密码')}</label>
										<input id="confirmNewPassword" name="confirmNewPassword" type="password" autocomplete="off" value="" maxlength="50" minlength="3" class="form-control required" equalTo="#newPassword"/>
									</div>
									<div class="margin-top-10">
										<button id="btnSubmitPassword" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保存修改')}</button>
									</div>
								</form:form>
							</div>
							<div id="tab_4-4" class="tab-pane ${qtype==3?'active':'' }">
								<form:form id="inputFormQuestion" modelAttribute="user" action="${ctx}/sys/user/info" method="post">
									<input type="hidden" name="qtype" value="3" />
									<input type="hidden" name="__url" value="${__url}" />
									<div id="messageBox2" class="alert alert-success hide"><button data-dismiss="alert" class="close">×</button></div> 
									<c:if test="${(empty user.pwdQuestion && empty user.pwdQuestion2 && empty user.pwdQuestion3)}">
										<div id="messageBox3" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>
											${fns:text('您还未设置过密保问题，请设置新的密保问题及答案')}。
										</div>
									</c:if>
									<c:if test="${!(empty user.pwdQuestion && empty user.pwdQuestion2 && empty user.pwdQuestion3)}">
										<div class="portlet">
											<div class="portlet-title">
												<div class="caption">
													<i class="fa fa-gift"></i>${fns:text('旧的密保问题及答案')}
												</div>
												<div class="tools">
													<a href="javascript:;" class="collapse"></a>
												</div>
											</div>
											<div class="portlet-body">
												<div class="form-group">
													<label class="control-label">${fns:text('旧保密问题（一）')}</label>
													<input id="oldPwdQuestion" name="oldPwdQuestion" type="text" value="${user.pwdQuestion }" maxlength="50" minlength="3" class="form-control required"/>
												</div>
												<div class="form-group">
													<label class="control-label">${fns:text('旧保密问题答案（一）')}</label>
													<input id="oldPwdQuestionAnswer" name="oldPwdQuestionAnswer" type="text" value="${oldPwdQuestionAnswer }" maxlength="50" minlength="1" class="form-control required"/>
												</div>
												<div class="form-group">
													<label class="control-label">${fns:text('旧保密问题（二）')}</label>
													<input id="oldPwdQuestion2" name="oldPwdQuestion2" type="text" value="${user.pwdQuestion2 }" maxlength="50" minlength="3" class="form-control required"/>
												</div>
												<div class="form-group">
													<label class="control-label">${fns:text('旧保密问题答案（二）')}</label>
													<input id="oldPwdQuestionAnswer2" name="oldPwdQuestionAnswer2" type="text" value="${oldPwdQuestionAnswer2 }" maxlength="50" minlength="1" class="form-control required"/>
												</div>
												<div class="form-group">
													<label class="control-label">${fns:text('旧保密问题（三）')}</label>
													<input id="oldPwdQuestion3" name="oldPwdQuestion3" type="text" value="${user.pwdQuestion3 }" maxlength="50" minlength="3" class="form-control required"/>
												</div>
												<div class="form-group">
													<label class="control-label">${fns:text('旧保密问题答案（三）')}</label>
													<input id="oldPwdQuestionAnswer3" name="oldPwdQuestionAnswer3" type="text" value="${oldPwdQuestionAnswer3 }" maxlength="50" minlength="1" class="form-control required"/>
												</div>
											</div>
										</div>
									</c:if>
									<div class="portlet">
										<div class="portlet-title">
											<div class="caption">
												<i class="fa fa-gift"></i>${fns:text('新的密保问题及答案')}
											</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a>
											</div>
										</div>
										<div class="portlet-body">
											<div class="form-group">
												<label class="control-label">${fns:text('新保密问题（一）')}</label>
												<input id="pwdQuestion" name="pwdQuestion" type="text" value="${newUser.pwdQuestion }" maxlength="50" minlength="3" class="form-control required"/>
											</div>
											<div class="form-group">
												<label class="control-label">${fns:text('新保密问题答案（一）')}</label>
												<input id="pwdQuestionAnswer" name="pwdQuestionAnswer" type="text" value="${newUser.pwdQuestionAnswer }" maxlength="50" minlength="1" class="form-control required"/>
											</div>
											<div class="form-group">
												<label class="control-label">${fns:text('新保密问题（二）')}</label>
												<input id="pwdQuestion2" name="pwdQuestion2" type="text" value="${newUser.pwdQuestion2 }" maxlength="50" minlength="3" class="form-control required"/>
											</div>
											<div class="form-group">
												<label class="control-label">${fns:text('新保密问题答案（二）')}</label>
												<input id="pwdQuestionAnswer2" name="pwdQuestionAnswer2" type="text" value="${newUser.pwdQuestionAnswer2 }" maxlength="50" minlength="1" class="form-control required"/>
											</div>
											<div class="form-group">
												<label class="control-label">${fns:text('新保密问题（三）')}</label>
												<input id="pwdQuestion3" name="pwdQuestion3" type="text" value="${newUser.pwdQuestion3 }" maxlength="50" minlength="3" class="form-control required"/>
											</div>
											<div class="form-group">
												<label class="control-label">${fns:text('新保密问题答案（三）')}</label>
												<input id="pwdQuestionAnswer3" name="pwdQuestionAnswer3" type="text" value="${newUser.pwdQuestionAnswer3 }" maxlength="50" minlength="1" class="form-control required"/>
											</div>
											<div class="margin-top-10">
												<!-- <button type="button" class="btn btn-primary check"><i class="fa fa-check"></i>校验密保问题</button> -->
												<button type="submit" class="btn btn-primary submit"><i class="fa fa-check"></i> ${fns:text('保存修改')}</button>
											</div>
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</div>
					<!--end col-md-9-->
				</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/jquery-plugin/jquery.strength.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/des.min.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#newPassword').strength();
		$("#inputFormBasicMsg").validate({
			submitHandler: function(form){
				loading('${fns:text("正在提交，请稍后")}...');
				form.submit();
			}
		});
		$("#inputFormPhoto").validate({
			submitHandler: function(form){
				loading('fns:text("正在提交，请稍后")}...');
				form.submit();
			}
		});
		$("#inputFormPassword").validate({
			submitHandler: function(form){
				loading('fns:text("正在提交，请稍后")}...');
				var pwdKey = '${fns:getConfig("shiro.loginPassword.secretKey")}';
				if (pwdKey != ''){
					$('#oldPassword').val(DesUtils.encode($('#oldPassword').val(), pwdKey));
					$('#newPassword').val(DesUtils.encode($('#newPassword').val(), pwdKey));
					$('#confirmNewPassword').val(DesUtils.encode($('#confirmNewPassword').val(), pwdKey));
				}
				form.submit();
			}
		});
		$("#inputFormQuestion").validate({
			submitHandler: function(form){
				loading('fns:text("正在提交，请稍后")}...');
				var pwdKey = '${fns:getConfig("shiro.loginPassword.secretKey")}';
				if (pwdKey != ''){
					$('#oldPwdQuestionAnswer').val(DesUtils.encode($('#oldPwdQuestionAnswer').val(), pwdKey));
					$('#oldPwdQuestionAnswer2').val(DesUtils.encode($('#oldPwdQuestionAnswer2').val(), pwdKey));
					$('#oldPwdQuestionAnswer3').val(DesUtils.encode($('#oldPwdQuestionAnswer3').val(), pwdKey));
					$('#pwdQuestionAnswer').val(DesUtils.encode($('#pwdQuestionAnswer').val(), pwdKey));
					$('#pwdQuestionAnswer2').val(DesUtils.encode($('#pwdQuestionAnswer2').val(), pwdKey));
					$('#pwdQuestionAnswer3').val(DesUtils.encode($('#pwdQuestionAnswer3').val(), pwdKey));
				}
				form.submit();
			}
		});
// 		$('#tab_4-4 .portlet-body').removeAttr('style'); // autoHeight 时修正
	});
</script>