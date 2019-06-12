<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<title>测试页面</title>

<script type="text/javascript">
	var apptoken;
	var ipadderss = "http://127.0.0.1:8080${ctxPath}";
	//JSON.stringify(result);
	function clearout() {
		$("#out").html("");
	}
	function changevalue(value) {
		ipadderss = value;
	}
	
	function push(){
		clearout();
		$.ajax({
			async : false,
			type : "post",
			url : ipadderss + "/test/push",
			contentType : "application/json",
			data : JSON.stringify({

			}),
			success : function(result) {
				$("#out").html(JSON.stringify(result));
			},
			dataType : "json",
		});
	}
</script>

<style type="text/css">
input[type=button] {
	width: 160px;
	height: 30px;
	font-size: 12px;
}
</style>
</head>
<body style="size: 12px">
	<div style="margin-bottom: 20px; border: 1px solid #F44336; padding: 10px; background: #FADAD7">
		登录名：<input type="text" id="name" value="" /> &nbsp;&nbsp; 密码：<input type="text" id="pwd" value="123456" /> <input name="提交"
			type="button" id="提交" title="提交" value="客户登录" onClick="javascript:login();"> <input type="text" id="wxOpenID" value=""
			style="display: none;" /> &nbsp;&nbsp;
	</div>
	<div>
		<input name="test" class="type" type="radio" title="type" value="http://127.0.0.1:8080${ctxPath}" checked="checked"
			onClick="javascript:changevalue(this.value)">本机测试 <input name="test" class="type" type="radio" title="type"
			value="http://testhaier.jushanghui.com/${ctxPath}" onClick="javascript:changevalue(this.value)">服务器测试
	</div>
	<div style="overflow-y: scroll; border: 1px solid; width: 300px; height: 500px; float: left; padding-left: 20px">
		<h4>客户端按钮</h4>
		<input name="提交" type="button" title="推送测试" value="推送测试" onClick="javascript:push();"><br />
	</div>
	<div id="out"
		style="overflow-y: scroll; border: 1px solid; width: 600px; height: 500px; float: left; margin-left: 20px; padding: 20px; word-break: break-all; white-space: normal"></div>
</body>
</html>