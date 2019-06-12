<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>微信绑定</title>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
<meta http-equiv="Pragma" content="no-cache"/><meta http-equiv="Expires" content="0"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
<link href="${ctxStatic}/mui/css/mui.min.css" rel="stylesheet" />
</head>
<body>
	<div class="wxapi_container">
		<header class="mui-bar mui-bar-nav">
			<p class="mui-title">账号绑定 &nbsp;</p>
		</header>
		<div class="mui-content">
			<div class="mui-card">
				<form class="mui-input-group mui-form" style="margin:0">
					<div class="mui-input-row">
						<label>昵　称</label>
						<input id="userCode" type="text" class="mui-input-clear mui-input" 
							disabled="disabled" value="${wxUser.nickName}" />
					</div>
					<div class="mui-input-row">
						<label>用户名</label>
						<input id="username" name="username" type="text" value="${user.loginCode}" 
							class="mui-input-clear mui-input" placeholder="请输入用户名">
					</div>
					<div class="mui-input-row">
						<label>密　码</label>
						<input id="password" type="password" autocomplete="off" class="mui-input-clear mui-input" placeholder="请输入密码">
					</div>
					<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
						<div class="mui-input-row">
							<label>集　团</label>
							<select id="params" name="params" class="form-control">
								<option value="{corpCode:'0'}">易科德软件</option>
								<c:forEach items="${fns:findCorpUserList()}" var="user">
									<option value="{corpCode:'${user.corpCode}'}">(${user.corpCode}) ${user.corpName}</option>
								</c:forEach>
							</select>
						</div>
					</c:if>
				</form>
			</div>
			<div class="mui-table-view  mui-content-padded" style="margin:10px 15px;">
				<button id="wxBind" data-type="1" class="mui-btn mui-btn-block mui-btn-primary">确认绑定</button>
			</div>
			<div class="mui-table-view  mui-content-padded" style="margin:10px 15px;">
				<button id="wxCleanBind" data-type="2" class="mui-btn mui-btn-block mui-btn-primary">解除绑定</button>
			</div>
		</div>
	</div>
</body>
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/mui/js/mui.min.js" type="text/javascript"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	/*
	 * 注意：
	 * 1. 所有的JS接口只能在公众号绑定的域名下调用，公众号开发者需要先登录微信公众平台进入“公众号设置”的“功能设置”里填写“JS接口安全域名”。
	 * 2. 如果发现在 Android 不能分享自定义内容，请到官网下载最新的包覆盖安装，Android 自定义分享接口需升级至 6.0.2.58 版本及以上。
	 * 3. 常见问题及完整 JS-SDK 文档地址：http://mp.weixin.qq.com/wiki/7/aaa137b55fb2e0456bf8dd9148dd613f.html
	 */
	wx.config(${jsapiSetting});
	wx.ready(function () {
		$("#wxBind,#wxCleanBind").click(function(){
			var username = $("#username").val();
			var password = $("#password").val();
			var params = $("#params").val();
			var type = $(this).data("type");
			if(username != "" && password != ""){
				$.ajax({ 
	  	    		 url: "${ctxPath}/weixin/binder",
	  	    		 data: {
	  	    			username: username,
	  	    			password: password,
	  	    			params: params,
	  	    			type: type
	  	    		 },
	  	    		 success: function(data){
	  	    			alert(data.message);
	  	    			$("#password").val("");
	  	    			if (data.result == 'true'){
	 	  	    			//WeixinJSBridge.call('closeWindow');
	 	  	    			location = '${ctxPath}/weixin/login';
	  	    			}
	  	    	     },
	  	    		 error: function(data) {
	  	    			 if (data.responseText && data.responseText != ''){
	  	    				alert('操作失败！ ' + data.responseText + '！');
		  	    		 }
	  	    		 }
				});
			}else{
				alert("用户名或密码不能为空！");
			}
		});
	})
</script>
</html>