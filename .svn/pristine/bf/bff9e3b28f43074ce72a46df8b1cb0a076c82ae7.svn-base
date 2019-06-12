<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="custom,jquery,fonts,jeesite,validate"/>
<sys:header title="${fns:text('登录')}" extLibs="${extLibs}" useTheme="true"/>
<link rel="stylesheet" href="${ctxStaticTheme}/css/select2.css?${_version}" />
<link rel="stylesheet" href="${ctxStaticTheme}/css/ecode-login.css?${_version}" />
<link rel="stylesheet" href="${ctxStatic}/jquery-toastr/2.0/toastr.css?${_version}"/>
<%@ include file="/upbw/upgrade.jsp" %>
</head>
<body style="background:#fff;">
<div class="login-header">
	<div style="font-size:24px;color:#3B80E5;padding:20px;font-family:微软雅黑;">
		资产管理系统
	</div>
</div>
<div class="login-body">
	<div class="content">
		<div class="home-main">
			<div class="login">
				<form id="loginForm" class="fm-v clearfix" action="" method="post">
					<div class="login-tt">
						<img src="${ctxStaticTheme}/images/user.png" /><span>用户登录</span>
					</div>
					<div class="login-cont">
						<div class="login-cont1">
							<div class="item item1">
								<label for="" class="login-label label-name"></label>
								<input type="text" name="username" value="${not empty cookie.rememberUserCode.value ? cookie.rememberUserCode.value : ''}"
									class="input required" data-msg-required="请填写登录账号." placeholder="请输入用户名" />
							</div>
							<div class="item item2">
								<label for="" class="login-label label-pwd" onmousedown="$('#password').attr('type','text')" onmouseup="$('#password').attr('type','password')"></label>
								<input id="password" name="password" class="input required" data-msg-required="请填写登录密码." placeholder="请输入密码" type="password" value="" autocomplete="off">
							</div>
							<!-- 集团选择 -->
							<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
								<div class="item item3">
									<select name="params" class="form-control">
										<c:forEach items="${fns:findCorpUserList()}" var="user">
											<option value="{corpCode:'${user.corpCode}'}">(${user.corpCode}) ${user.corpName}</option>
										</c:forEach>
									</select>
								</div>
							</c:if>
							<div class="item item3" id="isValidateCodeLogin" style="display:${isValidateCodeLogin?'blank':'none'}">
								<label class="block clearfix">
									<span class="block input-icon input-icon-right">
										验证码： <sys:validateCode name="validateCode" isRequired="true" isRemote="true" inputCssStyle="width:90px;" linkCssStyle="display:none;"/>
									</span>
								</label>
							</div>
							<div class="item item3" >
								<label class="inline">
									<input type="checkbox" name="rememberUserCode" ${not empty cookie.rememberUserCode.value ? 'checked' : ''} class="ace" />
									<span class="lbl" title="公共场所慎用,下次不需要再填写帐号"> 记住账号</span>
								</label>
								&nbsp;
								<label class="inline">
									<input type="checkbox" name="rememberMe" ${rememberMe ? 'checked' : ''} class="ace" />
									<span class="lbl" title="公共场所慎用,下次不需要再填写帐号和密码"> 记住密码</span>
								</label>
								<a href="${ctxPath}/forgetPwd" class="textblue right">忘记密码?</a>
							</div>
							<div class="item item4">
								<input type="submit" class="login-btn" id="loginBtn" value="立即登录">
							</div>
							<div id="errmsg" class="item item3 error hide"></div>
						</div>
						<c:if test="${fns:getConfig('user.registerUser') eq 'true'}">
						<div class="item item5">
							<span>没有账号？</span>&nbsp; <a href="${ctxPath}/registerUser" class="textblue">立即注册</a>&nbsp;
						</div>
						</c:if>
<!-- 							<div class="item item6"> -->
<!-- 								<span>您若有其他疑问，请联系客服人员</span> -->
<!-- 							</div> -->
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="copyright">Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}</div>
<sys:footer extLibs="${extLibs}" useTheme="true"/>
<script src="${ctxStatic}/jquery-toastr/2.0/toastr.js?${_version}" type="text/javascript"></script>
<script src="${ctxStatic}/common/des.min.js?${_version}" type="text/javascript"></script>
<script src="${ctxStaticTheme}/js/jquery.backstretch.min.js"></script>
<script>
	function setHeight(){
		var height = $(window).height() > 610 ? $(window).height()-162 : 610-162;
		$(".login-body").css("height", height+"px");
	}
	setHeight();
	window.onresize=setHeight;
	// 用户名、密码输入框获取焦点、失去焦点时的样式切换
	$(".login").find(".item1,.item2").click(function(){
		$(this).removeClass("item-hover").addClass("item-focus").siblings().removeClass("item-focus");
		$(this).find(".input").focus();
		$(this).find(".input").blur(function () {
			$(this).closest(".item").removeClass("item-focus");
		});
	});
	$('#loginForm').validate({
		submitHandler: function (form) {
			var pwd = $('#password').val(),
				pwdKey = '${fns:getConfig("shiro.loginPassword.secretKey")}';
			if (pwdKey != ''){
				$('#password').val(DesUtils.encode(pwd, pwdKey));
			}
			ajaxSubmitForm($(form), function(data, status, xhr){
				if (data.isValidateCodeLogin == true){
					$('#isValidateCodeLogin').show();
					$('#validateCodeRefresh').click();
				}
				if(data.result == "false" && data.message.length > 0){
// 					$('#errmsg').removeClass("hide");
// 					$('#errmsg').html(data.message);
					showMessage(data.message);
				}else {
					loading('${fns:text("登录验证成功，正在进入")}...');
					location = "${ctx}/index";
				}
			}, 'json', true, '${fns:text("正在验证登录，请稍后")}...');
			$('#password').val(pwd).select().focus();
		}
	});
	$(function(){
		$(".login-body").backstretch("${ctxStaticTheme}/images/login-bg.png");//兼容IE8，背景图片按比例缩放，铺满div
	})
</script>
</body>
</html>