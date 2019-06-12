<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html><html><head><meta charset="utf-8"/><meta content="webkit" name="renderer"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/><meta http-equiv="Expires" content="0"/>
<meta http-equiv="Cache-Control" content="no-cache"/><meta http-equiv="Cache-Control" content="no-store"/>
<meta content="width=device-width, initial-scale=1, user-scalable=1" name="viewport"/>
<meta content="${fns:getConfig('productName')}" name="description"/>
<meta content="http://www.ecode.net.cn" name="author"/>
<title>找回密码 - 资产管理系统</title>
<link rel="shortcut icon" href="${ctxPath}/favicon.ico"/>
<%@ include file="/upbw/upgrade.jsp" %>
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctxStaticTheme}/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace.css" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/select2.css" />
<!--[if lte IE 9]><link rel="stylesheet" href="${ctxStaticTheme}/css/ace-part2.css" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace-ie.css" /><![endif]-->
<link href="${ctxStatic}/fonts/fonts-common.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-toastr/2.0/toastr.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.css?${_version}" type="text/css" rel="stylesheet"/>
<!--[if lte IE 8]><script src="${ctxStatic}/common/respond.min.js"></script><![endif]-->
<link rel="stylesheet" href="${ctxStaticTheme}/css/ecode-forgetpwd.css" />
</head>
<body style="background:#fff;">
<div class="portlet box ${boxStyleColor} autoHeight">
		<div class="forget-pwd">
		<div class="pageheader"><a href="${ctxPath}"><img src="${ctxStaticTheme}/images/logo3.png"/></a></div>
		<div class="fullpage">
			<div class="content">
				<div class="step">
					<ul>
						<li id="li_step1" class="blue both-radius">
							<div class="step-num">1</div>
							<div class="step-text">输入账号</div>
						</li>
						<li id="li_step2" class="">
							<div class="step-num">2</div>
							<div class="step-text">身份验证</div>
						</li>
						<li id="li_step3" class="">
							<div class="step-num">3</div>
							<div class="step-text">重置密码</div>
						</li>
						<li id="li_step4" class="right-radius">
							<div class="step-num">4</div>
							<div class="step-text">成功</div>
						</li>
					</ul>
				</div>
				<div class="step-content">
						<c:choose>
							<c:when test="${fns:getConfig('user.useCorpModel') eq 'true'}">
							<div id="div_step1" class="step1_corp">
							</c:when>
							<c:otherwise>
							<div id="div_step1" class="step1">
							</c:otherwise>
						</c:choose>
						<form id="form_step1" class="form-horizontal">
							<input type="hidden" name="isFirst" value="1">
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">登录账号</label>
										<div class="col-sm-9">
											<input type="text" id="fp_loginCode" name="loginCode" placeholder="" htmlEscape="false" maxlength="100" class="form-control required"/>
										</div>
									</div>
								</div>
							</div>
							<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">企业名称</label>
										<div class="col-sm-9">
											<select id="fp_corpCode" name="corpCode" class="form-control">
												<c:forEach items="${fns:findCorpUserList()}" var="user">
													<option value="${user.corpCode}">(${user.corpCode}) ${user.corpName}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
							</div>
							</c:if>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">找回方式</label>
										<div class="col-sm-9">
											<select id="fp_op" name="validType" class="form-control">
												<option value="mobile">使用手机号码找回您的密码</option>
												<option value="email">使用电子邮箱找回您的密码</option>
												<option value="question">使用密保问题找回您的密码</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">验证码</label>
										<sys:validateCode name="validateCode" isRequired="true" isRemote="true" inputCssStyle="height:36px;width:200px;margin-left:12px;padding:6px 12px;"/>
									</div>
								</div>
							</div>
											
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-6">
											<input type="submit" value="下一步" class="btn-next" />
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div id="div_step2_mobile" class="step2 hide">
						<form id="form_step2_mobile" action="${ctxPath}/checkSmsValidCode" method="post" class="form-horizontal">
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-9">
											验证码已发送至：<span id="spn_mobile"></span>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">短信验证码</label>
										<div class="col-sm-6">
											<input id="smsValidCode" name="smsValidCode" htmlEscape="false" maxlength="100" class="form-control required"/>
										</div>
										<label id="label_resend_mobile" class="control-label col-sm-3" style="text-align:left;padding-left:0;font-size:14px;padding-top:9px;">35s后重新发送</label>
										<div id="div_resend_mobile" class="col-sm-3 ">
											<input type="button" id="fp_sendValidCode_mobile" value="重新获取验证码" class="btn" >
										</div>
										
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-6">
											<input type="submit" value="下一步" class="btn-next" />
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div id="div_step2_email" class="step2 hide">
						<form id="form_step2_email" class="form-horizontal">
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-9">
											验证码已发送至：<span id="spn_email"></span>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">邮件验证码</label>
										<div class="col-sm-6">
											<input id="emailValidCode" name="smsValidCode" htmlEscape="false" maxlength="100" class="form-control required"/>
										</div>
										<label id="label_resend_email" class="control-label col-sm-3" style="text-align:left;padding-left:0;font-size:14px;padding-top:9px;">35s后重新发送</label>
										<div id="div_resend_email" class="col-sm-3 ">
											<input type="button" id="fp_sendValidCode_email" value="重新获取验证码" class="btn" >
										</div>
										
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-6">
											<input type="submit" value="下一步" class="btn-next" />
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div id="div_step2_ques" class="step2_ques hide">
						<form id="form_step2_ques" action="${ctxPath}/validateQuestionAnswer" class="form-horizontal">
							<input type="hidden" id="ques_loginCode" name="loginCode">
							<input type="hidden" id="ques_corpCode" name="corpCode">
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">问题1</label>
										<label id="fp-q1" class="control-label col-sm-9" style="text-align:left"></label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">答案</label>
										<div class="col-sm-6">
											<input name="pwdQuestionAnswer" htmlEscape="false" maxlength="100" class="form-control required"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">问题2</label>
										<label id="fp-q2" class="control-label col-sm-9" style="text-align:left"></label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">答案</label>
										<div class="col-sm-6">
											<input name="pwdQuestionAnswer2" htmlEscape="false" maxlength="100" class="form-control required"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">问题3</label>
										<label id="fp-q3" class="control-label col-sm-9" style="text-align:left"></label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">答案</label>
										<div class="col-sm-6">
											<input name="pwdQuestionAnswer3" htmlEscape="false" maxlength="100" class="form-control required"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-6">
											<input type="submit" value="下一步" class="btn-next" />
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div id="div_step3" class="step3 hide">
						<form id="form_step3" class="form-horizontal">
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">新密码</label>
										<div class="col-sm-9">
											<input id="password" name="password" type="password" htmlEscape="false" maxlength="100" style="padding:6px 12px" class="form-control required"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12" style="height: 40px;margin-top: -20px;">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-9">
											<ul id="strength"><li class="bg-gray" style="margin-left:0px;">弱</li><li class="bg-gray">中</li><li class="bg-gray">强</li></ul>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3">确认密码</label>
										<div class="col-sm-9">
											<input name="password1" type="password" htmlEscape="false" maxlength="100" style="padding:6px 12px" class="form-control required" equalto="#password"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-3"></label>
										<div class="col-sm-6">
											<input type="submit" value="下一步" class="btn-next" />
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div id="div_step4" class="step4 hide">
						<form id="form_step4" class="form-horizontal">
							<div class="row">
								<div class="col-xs-4 done"><img src="${ctxStaticTheme}/images/done.png"/>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<div class="form-control">
											<h4>恭喜您，密码设置成功</h4>
										</div>
										<div class="form-control">
											您可以使用新密码登录网站
										</div>
										<div class="form-control">
											<input type="button" value="立即登录" onclick="window.location='${ctx}/login'" class="btn-next" />
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="copyright">Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}</div>
	</div>
</div>
<script src="${ctxStatic}/jquery-toastr/2.0/toastr.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/jeesite.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">

	// 第一步 提交事件
	$('#form_step1').validate({
		submitHandler: function (form) {
			var fp_op = $("#fp_op").val();
			if(fp_op == "mobile" || fp_op == "email"){
				$("#form_step1").attr("action", "${ctxPath}/getValidCode");
			}else if(fp_op == "question"){
				$("#form_step1").attr("action", "${ctxPath}/getQuestion");
			}
			ajaxSubmitForm($(form), function(data){
				if(data.result == "true"){
					if(fp_op == "mobile"){
						// 显示第二步内容
						$("#div_step2_mobile").removeClass("hide").siblings().addClass("hide");
						// 第二步序号变色
						setCurStepStyle('2');
						// 显示已发送的手机号码
						$('#spn_mobile').text(data.message);
						// 显示倒计时
						sendTime("_mobile");
					} else if(fp_op == "email"){
						// 显示第二步内容
						$("#div_step2_email").removeClass("hide").siblings().addClass("hide");
						// 第二步序号变色
						setCurStepStyle('2');
						// 显示已发送的手机号码
						$('#spn_email').text(data.message);
						// 显示倒计时
						sendTime("_email");
					} else if(fp_op == "question"){
						// 显示密保问题
						if (data.q1 != '' && data.q2 != '' && data.q3 != ''){
							$('#fp-q1').text(data.q1);
							$('#fp-q2').text(data.q2);
							$('#fp-q3').text(data.q3);
							// 显示第二步内容
							$("#div_step2_ques").removeClass("hide").siblings().addClass("hide");
							// 第二步序号变色
							setCurStepStyle('2');
						}else{
							showMessage('该账号未设置密保问题！');
							$('#validateCodeRefresh').click();
						}
					}
				}else{
					showMessage(data.message);
					$('#validateCodeRefresh').click();
				}
			}, "json");
		}
	});
	// 第二步 手机验证码提交
	$('#form_step2_mobile').validate({
		submitHandler: function (form) {
			ajaxSubmit('${ctxPath}/checkValidCode', {
				corpCode : $('#fp_corpCode').val(),
				loginCode : $('#fp_loginCode').val(),
				validateCode : $('#smsValidCode').val()
			}, function(data){
				if (data.result == 'true'){
					// 显示第三步内容
					$("#div_step3").removeClass("hide").siblings().addClass("hide");
					// 第三步序号变色
					setCurStepStyle('3');
				}else{
					showMessage(data.message);
				}
			});
		}
	});
	// 第二步 邮箱验证码提交
	$('#form_step2_email').validate({
		submitHandler: function (form) {
			ajaxSubmit('${ctxPath}/checkValidCode', {
				corpCode : $('#fp_corpCode').val(),
				loginCode : $('#fp_loginCode').val(),
				validateCode : $('#emailValidCode').val()
			}, function(data){
				if (data.result == 'true'){
					// 显示第三步内容
					$("#div_step3").removeClass("hide").siblings().addClass("hide");
					// 第三步序号变色
					setCurStepStyle('3');
				}else{
					showMessage(data.message);
				}
			});
		}
	});
	// 第二步 密保答案提交
	$('#form_step2_ques').validate({
		submitHandler: function (form) {
			$("#ques_loginCode").val($('#fp_loginCode').val());
			$("#ques_corpCode").val($('#fp_corpCode').val());
			ajaxSubmitForm($(form), function(data){
				if (data.result == 'true'){
					// 显示第三步内容
					$("#div_step3").removeClass("hide").siblings().addClass("hide");
					// 第三步序号变色
					setCurStepStyle('3');
				}else{
					showMessage(data.message);
				}
			})
		}
	});
	// 第三步 新密码提交
	$('#form_step3').validate({
		submitHandler: function (form) {
			ajaxSubmit('${ctxPath}/savePassword', {
				password : $('#password').val()
			}, function(data){
				if (data.result == 'true'){
					// 显示第四步
					$("#div_step4").removeClass("hide").siblings().addClass("hide");
					// 第四步序号变色
					setCurStepStyle('4');
				}else{
					showMessage(data.message);
				}
			});
		}
	});
	// 设置当前步骤序号显示样式
	function setCurStepStyle(stepNum){
		if(stepNum == 2){
			$("#li_step1").removeClass("both-radius").addClass("left-radius");
			$("#li_step2").addClass("blue right-radius");
		}else if(stepNum == 3){
			$("#li_step2").removeClass("right-radius")
			$("#li_step3").addClass("blue right-radius");
		}else if(stepNum == 4){
			$("#li_step3").removeClass("right-radius")
			$("#li_step4").addClass("blue right-radius");
		}
	}
	// 验证码倒计时
	var waitTime = 60;
	function sendTime(type) {
		if (waitTime == 0) {
			$("#label_resend"+type).hide();
			$("#div_resend"+type).show();
			waitTime = 60;
		} else {
			$("#div_resend"+type).hide();
			$("#label_resend"+type).show();
			$("#label_resend"+type).text(waitTime + "s后重新发送");
			waitTime--;
			setTimeout(function() {
				sendTime(type);
			}, 1000);
		}
	}
	// 重新获取短信验证码
	$('#fp_sendValidCode_mobile').click(function() {
		var $this = this;
		ajaxSubmit('${ctxPath}/getValidCode', {
			corpCode : $('#fp_corpCode').val(),
			loginCode : $('#fp_loginCode').val(),
			validType : "mobile"
		}, function(data){
			if (data.result == 'true'){
				sendTime('_mobile');
			}else{
				showMessage(data.message);
			}
		});
	});
	// 重新获取邮件验证码
	$('#fp_sendValidCode_email').click(function() {
		var $this = this;
		ajaxSubmit('${ctxPath}/getValidCode', {
			corpCode : $('#fp_corpCode').val(),
			loginCode : $('#fp_loginCode').val(),
			validType : "email"
		}, function(data){
			if (data.result == 'true'){
				sendTime('_email');
			}else{
				showMessage(data.message);
			}
		});
	});
	// 显示密码强度
	$("#password").keyup(function(){
		var total = check_strength(this.value);
		if (total == 0) {
			$("#strength li:eq(0)").css("background","#ddd");
			$("#strength li:eq(1)").css("background","#ddd");
			$("#strength li:eq(2)").css("background","#ddd");
		} else if (total <= 2) {
			$("#strength li:eq(0)").css("background","#3c8dbc");
			$("#strength li:eq(1)").css("background","#ddd");
			$("#strength li:eq(2)").css("background","#ddd");
		} else if (total == 3 || total == 4) {
			$("#strength li:eq(0)").css("background","#3c8dbc");
			$("#strength li:eq(1)").css("background","#3c8dbc");
			$("#strength li:eq(2)").css("background","#ddd");
		} else if (total > 4){
			$("#strength li:eq(0)").css("background","#3c8dbc");
			$("#strength li:eq(1)").css("background","#3c8dbc");
			$("#strength li:eq(2)").css("background","#3c8dbc");
		}
	})
	// 获取密码强度	
	function check_strength(thisval) {
		var upperCaseExp = new RegExp("[A-Z]");
		var lowerCaseExp = new RegExp("[a-z]");
		var numberExp = new RegExp("[0-9]");
		var specialExp = new RegExp("[~!@#$%\\^&\\*()_+\\{\\}:\"\\|<>?`\\-=\\[\\];\\\'\\\\,\\./]");
		var charLength = thisval.length >= 8 ? 1 : 0;
		var upperCase = thisval.match(upperCaseExp) ? 1 : 0;
		var lowerCase = thisval.match(lowerCaseExp) ? 1 : 0;
		var number = thisval.match(numberExp) ? 1 : 0;
		var special = thisval.match(specialExp) ? 1 : 0;
		var total = charLength + upperCase + lowerCase + number + special;
		return total;
	}
</script>
</body>
</html>