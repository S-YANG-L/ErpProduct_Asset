<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- #section:basics/sidebar -->
<div id="sidebar" class="sidebar ${menuStyle eq '3' ? 'h-sidebar navbar-collapse collapse' : 'responsive sidebar-fixed' }" data-sidebar-scroll="true" data-sidebar-hover="true">
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
	</script>
	
	<!-- /section:basics/sidebar -->
	<div class="sidebar-shortcuts" id="sidebar-shortcuts">
		<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
			<button class="btn btn-success"
				onclick="$('a[data-href=\'${ctx}/sys/user/info?qtype=0\']').click()">
				<i class="ace-icon fa fa-user"></i>
			</button>
			<button class="btn btn-info"
				onclick="$('a[data-href=\'${ctx}/sys/user/info?qtype=2\']').click()">
				<i class="ace-icon fa fa-key"></i>
			</button>
			<button class="btn btn-warning" 
				onclick="if(${fns:getModule('msg').isEnable}){
					$('a[data-href=\'${ctx}/msg/message/list?status=6\']').click()
				}else{
					alertx('消息中心模块未配置')
				}">
				<i class="ace-icon fa fa-comments-o"></i>
			</button>
			<button class="btn btn-danger"
				onclick="confirmx('确认要退出登录吗？','${ctx}/logout')">
				<i class="ace-icon fa fa-sign-out"></i>
			</button>
		</div>
		<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
			<span class="btn btn-success"></span>
			<span class="btn btn-info"></span>
			<span class="btn btn-warning"></span>
			<span class="btn btn-danger"></span>
		</div>
	</div><!-- /.sidebar-shortcuts -->
	
	<c:if test="${menuStyle eq '1'}">
		<div class="sidebar-menu"><%@ include file="/WEB-INF/views/themes/ace/modules/sys/menuTree.jsp"%></div>
	</c:if>
	<c:if test="${menuStyle eq '2'}">
		<div class="sidebar-menu"></div>
	</c:if>
	<c:if test="${menuStyle eq '3'}">
		<%@ include file="/WEB-INF/views/themes/ace/modules/sys/menuTree.jsp"%>
	</c:if>
	
	<!-- #section:basics/sidebar.layout.minimize -->
	<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
		<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
	</div>
	<!-- /section:basics/sidebar.layout.minimize -->
	
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
	</script>
</div>