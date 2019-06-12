<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid,ztree"/>
<sys:header title="权限审计" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}" style="padding-bottom:0!important;">
	<div class="portlet-title">
		<div class="caption"> <i class="fa fa-coffee"></i> 权限审计</div>
	</div>
	<div class="portlet-tabs">
		<ul class="nav nav-tabs">
			<li class=""><a href="#portlet_tab2" data-toggle="tab" onclick="userMenuFrame.window.page(); ">按用户查询权限</a></li>
			<li class="active"><a href="#portlet_tab1" data-toggle="tab" >按权限查询用户</a></li>
		</ul>
		<div class="tab-content" style="padding-bottom:0!important;">
			<!-- 按权限查用户 -->
			<div class="tab-pane active" id="portlet_tab1">
				<iframe src="${ctx}/sys/safetyAudit/permiAudit/menuUserList" width="100%" height="480px" frameborder="0"></iframe>
			</div>
			<!-- 按用户查权限 -->
			<div class="tab-pane " id="portlet_tab2">
				<iframe name="userMenuFrame" src="${ctx}/sys/safetyAudit/permiAudit/userMenuList" width="100%" height="480px" frameborder="0"></iframe>
			</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script>
	var iframe = $('iframe');
	$(window).resize(function(){
		iframe.height($(window).height() - $('.portlet-title').height() - 40);
	}).resize();
</script>