<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<link href="${ctxStaticTheme}/css/style.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
<div class="main">
	<div class="cont">
		<p>欢迎使用</p>
		<p>资产管理系统</p>
	</div>
	<div class="bg">
		<img src="${ctxStatic}/modules/desktop/images/desktop-bg.jpg" style="height:100%;"/>
	</div>
  	<div class="copyright">Copyright &copy; 2013-${fns:getConfig('copyrightYear')}&nbsp;${fns:getConfig('companyName')}</div>
</div>
<script>
function setHeight(){
	var height = $(".main").height()-27;
	$(".bg").css("height", height+"px");
}
setHeight();
window.onresize=setHeight;
</script>