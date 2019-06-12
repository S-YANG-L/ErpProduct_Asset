<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html><html><head><meta charset="utf-8"/><meta content="webkit" name="renderer"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/><meta http-equiv="Expires" content="0"/>
<meta http-equiv="Cache-Control" content="no-cache"/><meta http-equiv="Cache-Control" content="no-store"/>
<meta content="width=device-width, initial-scale=1, user-scalable=1" name="viewport"/>
<meta content="${fns:getConfig('productName')}" name="description"/>
<meta content="http://www.ecode.net.cn" name="author"/>
<title>登录 - 资产管理系统</title>
<link rel="shortcut icon" href="${ctxPath}/favicon.ico"/>
<%@ include file="/upbw/upgrade.jsp" %>
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctxStaticTheme}/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace-fonts.css" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace.css" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/select2.css" />
<!--[if lte IE 9]><link rel="stylesheet" href="${ctxStaticTheme}/css/ace-part2.css" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ace-ie.css" /><![endif]-->
<link href="${ctxStatic}/fonts/fonts-common.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-toastr/2.0/toastr.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.css?${_version}" type="text/css" rel="stylesheet"/>
<!--[if lte IE 8]><script src="${ctxStatic}/common/respond.min.js"></script><![endif]-->
</head>
<body class="login-layout light-login">
	<div class="main-container" id="main" style="margin-top:80px">
	<div class="main-content">
		<div class="row">
			<div class="col-sm-10 col-sm-offset-1">
				<div class="login-container">
					<div class="center">
<!-- 					<div>&nbsp;</div> -->
						<h1 style="margin-top:20px">
							<i class="ace-icon fa fa-leaf green"></i>
							<span class="red">${fns:getConfig('productName')} &nbsp;</span>
							<span class="white" id="id-text2"></span>
						</h1>
						<div style="color:red;font-size:14px;height:20px;">
							<div id="messageBox">
								${message}
							</div>
						</div>
					</div>

					<div class="space-6"></div>

					<div class="position-relative">
						<div id="login-box" class="login-box visible widget-box no-border">
							<div class="widget-body">
								<div class="widget-main">
									<h4 class="header blue lighter bigger">
										<i class="ace-icon fa fa-coffee green"></i>
										请填写登录信息
									</h4>

									<div class="space-6"></div>

									<form id="loginForm" action="" method="post">
										<fieldset>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="text" name="username" value="${rememberUserCode ? username : (not empty cookie.rememberUserCode.value ? cookie.rememberUserCode.value : '')}"
														class="form-control required" data-msg-required="请填写登录账号." placeholder="登录账号" />
													<i class="ace-icon fa fa-user"></i>
												</span>
											</label>

											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input id="password" type="password" autocomplete="off" name="password" class="form-control required" data-msg-required="请填写登录密码." placeholder="登录密码" />
													<i class="ace-icon fa fa-lock"></i>
												</span>
											</label>
											
											<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
												<select name="params" class="form-control">
													<c:forEach items="${fns:findCorpUserList()}" var="user">
														<option value="{corpCode:'${user.corpCode}'}">(${user.corpCode}) ${user.corpName}</option>
													</c:forEach>
												</select>
											</c:if>
											
											<c:if test="${isValidateCodeLogin}">
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														验证码： <sys:validateCode name="validateCode" isRequired="true" isRemote="true" />
													</span>
												</label>
											</c:if>

											<div class="space"></div>

											<div class="clearfix">
											
												<label class="inline">
													<input type="checkbox" name="rememberUserCode" ${not empty cookie.rememberUserCode.value ? 'checked' : ''} class="ace" />
													<span class="lbl" title="公共场所慎用,下次不需要再填写用户名"> 记住账号</span>
												</label>
												&nbsp;
												<label class="inline">
													<input type="checkbox" name="rememberMe" ${rememberMe ? 'checked' : ''} class="ace" />
													<span class="lbl" title="公共场所慎用,下次不需要再登录"> 记住密码</span>
												</label>

												<button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
													<i class="ace-icon fa fa-key"></i>
													<span class="bigger-110">登录</span>
												</button>
											</div>

											<div class="space-4"></div>
											
										</fieldset>
										
									</form>

									<!-- <div class="social-or-login center">
										<span class="bigger-110">使用以下账号</span>
									</div>

									<div class="space-6"></div>

									<div class="social-login center">
										<a class="btn btn-primary">
											<i class="ace-icon fa fa-facebook"></i>
										</a>

										<a class="btn btn-info">
											<i class="ace-icon fa fa-twitter"></i>
										</a>

										<a class="btn btn-danger">
											<i class="ace-icon fa fa-google-plus"></i>
										</a>
									</div> -->
								</div><!-- /.widget-main -->

								<div class="toolbar clearfix">
									<div>
										<a href="#" data-target="#forgot-box" class="forgot-password-link">
											<i class="ace-icon fa fa-arrow-left"></i>
											&nbsp;忘记密码
										</a>
									</div>
									<c:if test="${fns:getConfig('user.registerUser') eq 'true'}">
									<div>
										<a href="#" data-target="#signup-box" class="user-signup-link">
											注册新账号&nbsp;
											<i class="ace-icon fa fa-arrow-right"></i>
										</a>
									</div>
									</c:if>
								</div>
							</div><!-- /.widget-body -->
						</div><!-- /.login-box -->

						<div id="forgot-box" class="forgot-box widget-box no-border">
							<div class="widget-body">
								<div class="widget-main">
									<h4 class="header red lighter bigger">
										<i class="ace-icon fa fa-key"></i>
										找回我的密码
									</h4>

									<div class="space-6"></div>
									<p>
										请选择找回方式和账号信息，找回您的密码。
									</p>

									<form id="forgotForm" action="${ctxPath}/forgotPassword" method="post">
										<fieldset>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<select id="fp_op" name="op" class="form-control">
														<option value="mobile">使用手机号码找回您的密码</option>
														<option value="email">使用电子邮箱找回您的密码</option>
														<option value="question">使用保密问题找回您的密码</option>
													</select>
													<script type="text/javascript">
														$(document).ready(function(){
															$('#fp_op').change(function(){
																$('.fp-element').addClass('hide').removeClass('block');
																$('.fp-'+$(this).val()).addClass('block').removeClass('hide');
																$('#fp_loginCode').focus();
																if ($(this).val() == 'question'){
																	$('#fp_validateCodeRefresh').click();
																}
															}).change();
														});
													</script>
												</span>
											</label>
											
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="text" id="fp_loginCode" name="loginCode" class="form-control required" data-msg-required="请填写登录账号." placeholder="登录账号" />
													<i class="ace-icon fa fa-user"></i>
												</span>
											</label>
											<label class="block clearfix fp-element fp-email">
												<span class="block input-icon input-icon-right">
													<input type="text" id="fp_email" name="email" class="form-control required" data-msg-required="请填写邮箱地址." placeholder="邮箱地址" />
													<i class="ace-icon fa fa-envelope"></i>
												</span>
											</label>
											<label class="block clearfix fp-element fp-mobile">
												<span class="block input-icon input-icon-right">
													<input type="text" id="fp_mobile" name="mobile" class="form-control required" data-msg-required="请填写手机号码." placeholder="手机号码" />
													<i class="ace-icon fa fa-phone-square"></i>
												</span>
											</label>
											
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="password" autocomplete="off" id="fp_password" name="password"
														class="form-control required" data-msg-required="请填写新密码."
														 rangelength="3,50" data-msg-rangelength="新密码长度不能小于3并大于50个字符."
														 placeholder="新密码" />
													<i class="ace-icon fa fa-lock"></i>
												</span>
											</label>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="password" autocomplete="off" id="fp_confirmPassword" name="confirmPassword"
														class="form-control required" data-msg-required="请填写确认新密码."
														rangelength="3,50" data-msg-rangelength="新密码长度不能小于3并大于50个字符."
														equalTo="#fp_password" data-msg-equalTo="新密码与确认新密码不同."
														placeholder="确认新密码" />
													<i class="ace-icon fa fa-lock"></i>
												</span>
											</label>
											<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
												<label class="block clearfix">
													<select id="fp_corpCode" name="corpCode" class="form-control">
														<option value="0">易科德软件</option>
														<c:forEach items="${fns:findCorpUserList()}" var="user">
															<option value="${user.corpCode}">(${user.corpCode}) ${user.corpName}</option>
														</c:forEach>
													</select>
												</label>
											</c:if>
											
											<div class="block clearfix fp-element fp-email fp-mobile">
												<div class="input-group">
													<input type="text" id="fp_validCode" name="validCode" class="form-control required" data-msg-required="请填写验证码." placeholder="验证码" />
													<span class="input-group-btn">
														<input type="button" id="fp_sendValidCode" value="获取验证码" class="btn btn-sm btn-inverse"/>
													</span>
												</div>
												<script type="text/javascript">
													var waitTime = 60;
													function sendTime(o) {
														if (waitTime == 0) {
															o.removeAttribute("disabled");
															o.value = "获取验证码";
															waitTime = 60;
														} else {
															o.setAttribute("disabled", true);
															o.value = "重新发送(" + waitTime + ")";
															waitTime--;
															setTimeout(function() {
																sendTime(o)
															}, 1000);
														}
													}
													$('#fp_sendValidCode').click(function() {
														var $this = this;
														ajaxSubmit('${ctxPath}/forgotPassword', {
															op: 'send_' + $('#fp_op').val(),
															corpCode : $('#fp_corpCode').val(),
															loginCode : $('#fp_loginCode').val(),
															email : $('#fp_email').val(),
															mobile : $('#fp_mobile').val()
														}, function(data){
															showMessage(data.message);
															if (data.result == 'true'){
																sendTime($this);
															}
														});
													});
												</script>
											</div>
											
											<label class="block clearfix fp-element fp-question">
												验证码： <sys:validateCode id="fp_validateCode" name="validateCode" isLazy="true" isRequired="true" isShowLink="false" inputCssStyle="height:30px"/>
												<input type="button" id="fp_getQuestion" value="获取保密问题" class="btn btn-xs btn-inverse pull-right"/>
												<script type="text/javascript">
													$('#fp_getQuestion').click(function() {
														ajaxSubmit('${ctxPath}/forgotPassword', {
															op: 'get_question',
															corpCode : $('#fp_corpCode').val(),
															loginCode : $('#fp_loginCode').val(),
															validateCode : $('#fp_validateCode').val()
														}, function(data){
															if (data.result == 'true'){
																if (data.q1 != '' && data.q2 != '' && data.q3 != ''){
																	$('#fp-q1').text(data.q1);
																	$('#fp-q2').text(data.q2);
																	$('#fp-q3').text(data.q3);
																	showMessage('获取密保问题成功，请再次填写验证码！');
																}else{
																	showMessage('该账号未设置密保问题！');
																}
															}else{
																showMessage(data.message);
															}
															$('#fp_validateCodeImg').click();
														});
													});
												</script>
											</label>
											<div class="space-6"></div>
											
											<label class="block clearfix fp-element fp-question">
												问题1：<span id="fp-q1"></span>
											</label>
											<label class="block clearfix fp-element fp-question">
												<span class="block input-icon input-icon-right">
													<input type="text" name="pwdQuestionAnswer" class="form-control required" data-msg-required="请填写答案1." placeholder="答案1 " />
													<i class="ace-icon fa fa-question-circle"></i>
												</span>
											</label>
											<label class="block clearfix fp-element fp-question">
												问题2：<span id="fp-q2"></span>
											</label>
											<label class="block clearfix fp-element fp-question">
												<span class="block input-icon input-icon-right">
													<input type="text" name="pwdQuestionAnswer2" class="form-control required" data-msg-required="请填写答案2." placeholder="答案2" />
													<i class="ace-icon fa fa-question-circle"></i>
												</span>
											</label>
											<label class="block clearfix fp-element fp-question">
												问题3：<span id="fp-q3"></span>
											</label>
											<label class="block clearfix fp-element fp-question">
												<span class="block input-icon input-icon-right">
													<input type="text" name="pwdQuestionAnswer3" class="form-control required" data-msg-required="请填写答案3." placeholder="答案3" />
													<i class="ace-icon fa fa-question-circle"></i>
												</span>
											</label>
											
											<div class="space-12"></div>
											
											<div class="clearfix">
												<button type="reset" class="width-30 pull-left btn btn-sm">
													<i class="ace-icon fa fa-refresh"></i>
													<span class="bigger-110">重置</span>
												</button>
												<button type="submit" class="width-65 pull-right btn btn-sm btn-danger">
													<i class="ace-icon fa fa-lightbulb-o"></i>
													<span class="bigger-110">提交</span>
												</button>
											</div>
										</fieldset>
									</form>
								</div><!-- /.widget-main -->

								<div class="toolbar center">
									<a href="#" data-target="#login-box" class="back-to-login-link">
										返回登录
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</div>
							</div><!-- /.widget-body -->
						</div><!-- /.forgot-box -->

						<c:if test="${fns:getConfig('user.registerUser') eq 'true'}">
						<div id="signup-box" class="signup-box widget-box no-border">
							<div class="widget-body">
								<div class="widget-main">
									<h4 class="header green lighter bigger">
										<i class="ace-icon fa fa-users blue"></i>
										新账号注册
									</h4>

									<div class="space-6"></div>
									<p> 请填写您的注册信息: </p>

									<form id="registerForm" action="${ctxPath}/registerUser" method="post">
										<fieldset>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<select id="reg_op" name="op" class="form-control">
														<option value="mobile">使用手机号码注册账号</option>
														<option value="email">使用电子邮箱注册账号</option>
													</select>
													<script type="text/javascript">
														$(document).ready(function(){
															$('#reg_op').change(function(){
																$('.reg-element').addClass('hide').removeClass('block');
																$('.reg-'+$(this).val()).addClass('block').removeClass('hide');
																$('#reg_loginCode').focus();
															}).change();
														});
													</script>
												</span>
											</label>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="text" id="reg_loginCode" name="loginCode" class="form-control required" data-msg-required="请填写登录账号." placeholder="登录账号" />
													<i class="ace-icon fa fa-user"></i>
												</span>
											</label>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="text" id="reg_userName" name="userName" class="form-control required" data-msg-required="请填写用户姓名." placeholder="用户姓名" />
													<i class="ace-icon fa fa-user"></i>
												</span>
											</label>
											<label class="block clearfix reg-element reg-email">
												<span class="block input-icon input-icon-right">
													<input type="text" id="reg_email" name="email" class="form-control required" data-msg-required="请填写邮箱地址." placeholder="邮箱地址" />
													<i class="ace-icon fa fa-envelope"></i>
												</span>
											</label>
											<label class="block clearfix reg-element reg-mobile">
												<span class="block input-icon input-icon-right">
													<input type="text" id="reg_mobile" name="mobile" class="form-control required" data-msg-required="请填写手机号码." placeholder="手机号码" />
													<i class="ace-icon fa fa-phone-square"></i>
												</span>
											</label>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="password" autocomplete="off" id="reg_password" name="password"
														class="form-control required" data-msg-required="请填写密码."
														 rangelength="3,50" data-msg-rangelength="新密码长度不能小于3并大于50个字符."
														 placeholder="密码" />
													<i class="ace-icon fa fa-lock"></i>
												</span>
											</label>
											<label class="block clearfix">
												<span class="block input-icon input-icon-right">
													<input type="password" autocomplete="off" id="reg_confirmPassword" name="confirmPassword"
														class="form-control required" data-msg-required="请填写确认密码."
														rangelength="3,50" data-msg-rangelength="新密码长度不能小于3并大于50个字符."
														equalTo="#reg_password" data-msg-equalTo="新密码与确认新密码不同."
														placeholder="确认密码" />
													<i class="ace-icon fa fa-lock"></i>
												</span>
											</label>
											<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
												<label class="block clearfix">
													<select id="reg_corpCode" name="corpCode" class="form-control">
														<option value="0">易科德软件</option>
														<c:forEach items="${fns:findCorpUserList()}" var="user">
															<option value="${user.corpCode}">(${user.corpCode}) ${user.corpName}</option>
														</c:forEach>
													</select>
												</label>
											</c:if>
											
											<div class="block clearfix">
												<div class="input-group">
													<input type="text" id="fp_validCode" name="validCode" class="form-control required" data-msg-required="请填写验证码." placeholder="验证码" />
													<span class="input-group-btn">
														<input type="button" id="reg_sendValidCode" value="获取验证码" class="btn btn-sm btn-inverse"/>
													</span>
												</div>
												<script type="text/javascript">
													var waitTime2 = 60;
													function sendTime2(o) {
														if (waitTime2 == 0) {
															o.removeAttribute("disabled");
															o.value = "获取验证码";
															waitTime2 = 60;
														} else {
															o.setAttribute("disabled", true);
															o.value = "重新发送(" + waitTime2 + ")";
															waitTime2--;
															setTimeout(function() {
																sendTime2(o)
															}, 1000);
														}
													}
													$('#reg_sendValidCode').click(function() {
														var $this = this;
														ajaxSubmit('${ctxPath}/registerUser', {
															op: 'send_' + $('#reg_op').val(),
															corpCode : $('#reg_corpCode').val(),
															corpName : $.trim($('#reg_corpCode').text()),
															loginCode : $('#reg_loginCode').val(),
															userName : $('#reg_userName').val(),
															email : $('#reg_email').val(),
															mobile : $('#reg_mobile').val()
														}, function(data){
															showMessage(data.message);
															if (data.result == 'true'){
																sendTime2($this);
															}
														});
													});
												</script>
											</div>
											<div class="space-12"></div>

											<label class="block">
												<input type="checkbox" id="reg_xieyi" class="ace" />
												<span class="lbl">
													我已阅读并同意协议内容 &nbsp; <a href="#">查看协议</a>
												</span>
											</label>

											<div class="space-12"></div>

											<div class="clearfix">
												<button type="reset" class="width-30 pull-left btn btn-sm">
													<i class="ace-icon fa fa-refresh"></i>
													<span class="bigger-110">重置</span>
												</button>
												<button type="submit" class="width-65 pull-right btn btn-sm btn-success">
													<span class="bigger-110">注册</span>
													<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
												</button>
											</div>
										</fieldset>
									</form>
								</div>

								<div class="toolbar center">
									<a href="#" data-target="#login-box" class="back-to-login-link">
										<i class="ace-icon fa fa-arrow-left"></i>
										返回登录
									</a>
								</div>
							</div><!-- /.widget-body -->
						</div><!-- /.signup-box -->
						</c:if>
						
					</div><!-- /.position-relative -->
					<div class="copyright" style="margin:20px auto;text-align:center;">
						 Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}
					</div>
					<div class="navbar-fixed-top align-right">
						<br />
						&nbsp;
						<a id="btn-login-light" href="#">默认</a>
						&nbsp;
						<span class="blue">/</span>
						&nbsp;
						<a id="btn-login-blur" href="#">蓝色</a>
						&nbsp;
						<span class="blue">/</span>
						&nbsp;
						<a id="btn-login-dark" href="#">黑色</a>
						&nbsp; &nbsp; &nbsp;
					</div>
				</div>
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.main-content -->
</div><!-- /.main-container -->
<!-- basic scripts -->
<script src="${ctxStatic}/jquery-toastr/2.0/toastr.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/assets/global/plugins/jquery-select2/select2.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/jeesite.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/common/des.min.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(document).on('click', '.toolbar a[data-target]', function(e) {
			e.preventDefault();
			var target = $(this).data('target');
			$('.widget-box.visible').removeClass('visible');//hide others
			$(target).addClass('visible');//show target
			$('input[placeholder],textarea[placeholder]').placeholder();
		});
		$('#btn-login-dark').on('click', function(e) {
			$('body').attr('class', 'login-layout');
			$('#id-text2').attr('class', 'white');
			$('#id-company-text').attr('class', 'blue');
			e.preventDefault();
		});
		$('#btn-login-light').on('click', function(e) {
			$('body').attr('class', 'login-layout light-login');
			$('#id-text2').attr('class', 'grey');
			$('#id-company-text').attr('class', 'blue');
			e.preventDefault();
		});
		$('#btn-login-blur').on('click', function(e) {
			$('body').attr('class', 'login-layout blur-login');
			$('#id-text2').attr('class', 'white');
			$('#id-company-text').attr('class', 'light-blue');
			e.preventDefault();
		});
	});
	$('#loginForm').validate({
		submitHandler: function (form) {
			var pwdKey = '${fns:getConfig("shiro.loginPassword.secretKey")}';
			if (pwdKey != ''){
				$('#password').val(DesUtils.encode($('#password').val(), pwdKey));
			}
			form.submit();
// 			ajaxSubmitForm($(form), function(data){
// 				showMessage(data.message);
// 				if (data.isValidateCodeLogin == true){
// 					$('#isValidateCodeLogin').show();
// 					$('#validateCodeRefresh').click();
// 				}
// 				if (data.result == "true"){
// 					location = "${ctx}";
// 				}
// 			}, 'json', true, "正在验证登录信息...")
		}
	});
	$('#forgotForm').validate({
		ignore: ":hidden",
	    submitHandler: function(form) {
			ajaxSubmitForm($(form), function(data){
				if (data.result == "true"){
					alert(data.message);
					location = "${ctx}";
				}else{
					showMessage(data.message);
				}
			});
        }
	});
	<c:if test="${fns:getConfig('user.registerUser') eq 'true'}">
	$('#registerForm').validate({
		ignore: ":hidden",
	    submitHandler: function(form) {
	    	if (!$('#reg_xieyi').is(':checked')){
	    		showMessage('确认是否已阅读并同意注册协议内容。', null, 'warning');
	    		return false;
	    	}
			ajaxSubmitForm($(form), function(data){
				if (data.result == "true"){
					alert(data.message);
					location = "${ctx}";
				}else{
					showMessage(data.message);
				}
			});
        }
	});
	</c:if>
	$(window).resize(function(){
		var top = ($(window).height()-$('#main').height())/2-20;
		$('#main').css('margin-top', top < 0 ? 0 : top);//水平居中
	}).resize();
</script>
</body>
</html>