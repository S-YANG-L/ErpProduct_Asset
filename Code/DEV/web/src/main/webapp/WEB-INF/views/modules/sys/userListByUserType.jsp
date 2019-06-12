<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="用户管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> 用户管理（
			<div class="dropdown input-inline">
				<div class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
					${fns:getDictLabel(user.userType, 'user_type', '全部用户')}<b class="caret"></b>
				</div>
				<ul class="dropdown-menu">
					<c:forEach items="${fns:getDictList('user_type')}" var="dict">
						<li><a href="${ctx}/sys/user/list?userType=${dict.value}">
							<i class="fa fa-angle-right"></i> ${dict.name}</a></li>
					</c:forEach>
				</ul>
			</div> ）
		</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="roleCode"/>
			<form:hidden path="userType"/>
			<div class="form-group">
				<label class="control-label">用户名称：</label>
					<form:input path="userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
			</div>
			<div class="form-group">
				<label class="control-label">登录账号：</label>
					<form:input path="loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
			</div>
			<div class="form-group"> &nbsp;&nbsp;
<!-- 				<label class="control-label">状态：</label> -->
				<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
				    <form:option  value="">全部</form:option>
					<form:options items="${fns:getDictList('user_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="form-group" > &nbsp;&nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	
	// 初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'用户名称', name:'userName', index:'user_name', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/user/form?userCode='+row.id+'&op=edit" class="btnList" data-title="编辑用户">'+val+'</a>';
			}},
			{header:'登录账号', name:'loginCode', index:'login_code', width:100, align:"center"},
			{header:'手机号码', name:'mobile', index:'a.mobile', width:80, align:"center", sortable:false},
			{header:'电子邮箱', name:'email', index:'a.email', width:100, sortable:false},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:110, align:"left"},
			{header:'最后登录时间', name:'loginDate', index:'a.login_date', width:90, align:"center"},
			{header:'状态', name:'status', index:'a.status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('user_status')}, val, '未知', true);
			}},
			{header:'操作', name:'actions', width:130, fixed:true, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/disable?userCode='+row.id+'" class="btnList" title="停用用户" data-confirm="确认要停用该用户吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//<shiro:hasPermission name="sys:user:activate">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/user/activate?userCode='+row.id+'" class="btnList" title="启用用户" data-confirm="确认要启用该用户吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:unfreeze">
				if (row.status == Global.STATUS_FREEZE){
					actions.push('<a href="${ctx}/sys/user/unfreeze?userCode='+row.id+'" class="btnList" title="解冻用户" data-confirm="确认要解冻该用户吗？"><i class="fa fa-unlock"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:resetpwd">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/resetpwd?userCode='+row.id+'" class="btnList" title="密码重置" data-confirm="确认要将该用户密码重置吗？"><i class="fa fa-retweet"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:authorize">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/form?userCode='+row.id+'&op=authorize" class="btnList" title="用户授权"><i class="fa fa-check-square-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});

	/* // 加载机构树结构
	$.getJSON("${ctx}/sys/office/treeData",function(data){
		$.fn.zTree.init($("#ztree"), {data:{simpleData:{
			enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
				$('#employeeOfficeCode').val(treeNode.id);
				$('#employeeOfficeName').val(treeNode.name);
				$('#searchForm').submit();
			}}
		}, data).expandAll(true);
	});
	$(window).resize(function(){
		$("#left").height($('.portlet-body').height());
	}).resize(); */
	
</script>