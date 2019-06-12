<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- #section:basics/sidebar -->
<div id="sidebar" class="sidebar ${menuStyle eq '3' ? 'h-sidebar navbar-collapse collapse' : 'responsive sidebar-fixed' }" data-sidebar-scroll="true" data-sidebar-hover="true">
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
	</script>

	<div class="row" style="margin:0">
		<div class="userinfo">
			<c:set var="user" value="${fns:getUser()}" /> 
			<c:if test="${not empty user.photo}">
				<img class="sidebar-user-photo" src="${user.photo}" />
			</c:if>
			<c:if test="${empty user.photo}">
				<img class="sidebar-user-photo"
					src="${ctxStatic}/images/userinfo.jpg" />
			</c:if> 
			<span class="user-info"> &nbsp; ${user.userName}
			</span> 
			<div class="user-info">
				<span class="user-btn">
					 &nbsp; <i class="ace-icon fa fa-circle green"></i> 在线
				</span> 
				<span class="user-btn" onclick="location='${ctx}/logout'" style="cursor:pointer;">
					<i class="ace-icon fa fa-sign-out red"></i> 注销
				</span> 
			</div>
		</div>	
					
<!-- 		<div class="dropdown-menu dropdown-danger side-drop"> -->
<!-- 			<div class="dropdown"> -->
<!-- 				<a href="#" class="dropdown-toggle" id="personMenu" data-toggle="dropdown">  -->
<%-- 					<c:set var="user" value="${fns:getUser()}" />  --%>
<%-- 					<c:if test="${not empty user.photo}"> --%>
<%-- 						<img class="sidebar-user-photo" src="${user.photo}" /> --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${empty user.photo}"> --%>
<!-- 						<img class="sidebar-user-photo" -->
<%-- 							src="${ctxStatic}/images/userinfo.jpg" /> --%>
<%-- 					</c:if>  --%>
<%-- 					<span class="user-info"> ${user.userName}<br />  --%>
<!-- 					<i class="ace-icon fa fa-circle online"></i>Online -->
<!-- 					</span>  -->
<!-- 					<i class="ace-icon fa fa-caret-right pull-right sidebar-icon"></i> -->
<!-- 				</a> -->
<!-- 				<ul class="dropdown-menu dropdown-danger" aria-labelledby="personMenu"> -->
<!-- 					<li><a id="userInfo" href="javascript:" -->
<%-- 						data-href="${ctx}/sys/user/info?qtype=0" class="addTab"> <i --%>
<!-- 							class="ace-icon fa fa-user"></i> 个人信息 -->
<!-- 					</a></li> -->
<!-- 					<li><a id="modifyPassword" href="javascript:" -->
<%-- 						data-href="${ctx}/sys/user/info?qtype=2" class="addTab"> <i --%>
<!-- 							class="ace-icon fa fa-key"></i> 修改密码 -->
<!-- 					</a></li> -->
<!-- 					<li class="divider"></li> -->
<%-- 					<li><a href="${ctx}/logout"> <i --%>
<!-- 							class="ace-icon fa fa-sign-out"></i> 退出登录 -->
<!-- 					</a></li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
		
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