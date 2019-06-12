<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<c:set var="extHead">
	<link href="${ctxStatic}/assets/admin/pages/css/login-soft.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript">
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</c:set>
<sys:header title="登录" extLibs="${extLibs}" extHead="${extHead}" bodyClass="login"/>
<body class="login">
<!-- BEGIN LOGO -->
<div class="logo">
	<%-- <a href="index.html">
		<img src="${ctxStatic}/assets/admin/layout/img/logo-big.png" alt=""/>
	</a> --%>
	<h1>${fns:getConfig('productName')}</h1>
</div>
<!-- END LOGO -->
<!-- BEGIN LOGIN -->
<div class="content">
	<!-- BEGIN LOGIN FORM -->
	<form class="login-form" action="${ctx}/login" method="post">
		<h3 class="form-title">登录您的账号</h3>
		<div id="messageBox" class="alert alert-danger ${empty message ? 'hide' : ''}">
			<button data-dismiss="alert" class="close">×</button>
			<span id="loginError" >${message}</span>
		</div>
		<div class="form-group">
			<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
<!-- 			<label class="control-label visible-ie8 visible-ie9">登录账号</label> -->
			<div class="input-icon">
				<i class="fa fa-user"></i>
				<input class="form-control" type="text" autocomplete="off" placeholder="登录账号" name="username" value="${rememberUserCode  ? username : ( not empty cookie.rememberUserCode.value ? cookie.rememberUserCode.value : '') }"/>
			</div>
		</div>
		<div class="form-group">
<!-- 			<label class="control-label visible-ie8 visible-ie9">登录密码</label> -->
			<div class="input-icon">
				<i class="fa fa-lock"></i>
				<input id="password" class="form-control" type="password" autocomplete="off" placeholder="登录密码" name="password"/>
			</div>
		</div>
		<c:if test="${isValidateCodeLogin}">
			<div class="form-group">
				<div class="input-icon">
					<div class="validateCode"><label class="input-label" for="validateCode">验证码 </label>
						<sys:validateCode name="validateCode" inputCssStyle="" linkCssStyle="color:#fff"/>
					</div>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<label for="rememberUserCode" title="记住用户名"><input type="checkbox" id="rememberUserCode" name="rememberUserCode" ${not empty cookie.rememberUserCode.value ? 'checked' : ''}/> 记住用户名</label>
			&nbsp;&nbsp;
			<label for="rememberMe" title="公共场所慎用,下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}/> 记住密码</label>
			<button type="submit" class="btn blue pull-right">
			登 录 <i class="m-icon-swapright m-icon-white"></i>
			</button>
		</div>
		<div class="forget-password create-account">
<!-- 			<p><a href="javascript:;" id="forget-password" style="color:#fff;">忘记密码？ </a> -->
<!-- 			<a href="javascript:;" id="register-btn" style="color:#fff;">申请账号。</a></p> -->
		</div>
	</form>
	<!-- END LOGIN FORM -->
</div>
<!-- END LOGIN -->
<!-- BEGIN COPYRIGHT -->
<div class="copyright">
	 Copyright &copy; 2013-${fns:getConfig('copyrightYear')} ${fns:getConfig('companyName')}
</div>
<!-- END COPYRIGHT -->
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/assets/global/plugins/jquery-backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/assets/admin/pages/scripts/login-soft.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/des.min.js?${_version}" type="text/javascript"></script>
<script type="text/javascript">
	var pwdKey = '${fns:getConfig("shiro.loginPassword.secretKey")}';
	$(document).ready(function() {
		Login.init();
	});
</script>