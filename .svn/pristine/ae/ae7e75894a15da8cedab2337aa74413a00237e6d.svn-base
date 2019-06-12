<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('角色管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-users"></i>${role.isSys eq '1' ? fns:text('系统角色') : fns:text('角色管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="sys:role:edit">
				<a href="${ctx}/sys/role/form?type=0" class="btn btn-default btn-sm btnTool" title="${fns:text('新增角色')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
			</shiro:hasPermission>
			<div class="btn-group">
				<!-- <a class="btn btn-default btn-sm" href="#" data-toggle="dropdown"><i class="fa fa-cogs"></i> 工具 <i class="fa fa-angle-down"></i></a>
				<ul class="dropdown-menu pull-right" style="width:100px;">
					<li><a href="#"> <i class="fa fa-pencil"></i> 导出</a></li>
					<li><a href="#"> <i class="fa fa-trash-o"></i> 导入</a></li>
				</ul> -->
			</div>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="role" action="${ctx}/sys/role/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('角色名称')}：</label>
				<div class="input-inline width-160" >
					<form:input path="roleName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="control-label">英文名称：</label>
				<div class="input-inline width-160" >
					<form:input path="nameEn" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
				</div>
			</div> --%>
			<div class="form-group">
				<label class="control-label">${fns:text('状态')}：</label>
				<form:select path="isShow" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
					<form:options items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>	
			<div class="form-group" > &nbsp; &nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
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
			{header:'${fns:text("角色名称")}', name:'roleName', index:'role_name', width:80, align:"center", formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/role/form?roleCode='+row.id+'&type=1" class="btnList" data-title="${fns:text("编辑角色")}">'+val+'</a>';
			}},
			//<c:if test="${role.currentUser.admin}">
  			{header:'${fns:text("角色编码")}', name:'roleCode', index:'a.role_code', width:80, align:"center"},//</c:if>
			/* {header:'英文名称', name:'nameEn', index:'name_en', width:100}, */
			{header:'${fns:text("数据范围")}', name:'dataScope', index:'a.status', width:80, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('role_data_scope')}, val, '未设置', true);
			}},
			{header:'${fns:text("备注")}', name:'remarks', index:'remarks', width:100, sortable:false},
			{header:'${fns:text("系统内置")}', name:'isSys', width:50, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('yes_no')}, val, '未知', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:200, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:role:edit">
				actions.push('<a href="${ctx}/sys/role/form?roleCode='+row.id+'&type=1" class="btnList" title="${fns:text("编辑角色")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				if (row.isShow == Global.SHOW){
					actions.push('<a href="${ctx}/sys/role/hide?roleCode='+row.id+'" class="btnList" title="${fns:text("隐藏角色")}" data-confirm="${fns:text("确认要隐藏该角色吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}else{
					actions.push('<a href="${ctx}/sys/role/show?roleCode='+row.id+'" class="btnList" title="${fns:text("显示角色")}" data-confirm="${fns:text("确认要显示该角色吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}
				if (row.isSys != Global.YES){
					actions.push('<a href="${ctx}/sys/role/delete?roleCode='+row.id+'" class="btnList" title="${fns:text("删除角色")}" data-confirm="${fns:text("确认要删除该角色吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				//</shiro:hasPermission><shiro:hasPermission name="sys:role:grant">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/role/form?roleCode='+row.id+'&type=2" class="btnList" title="${fns:text("角色授权")}"><i class="fa fa-check-square-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/role/formDataScope?roleCode='+row.id+'" class="btnList" title="${fns:text("角色数据授权")}"><i class="fa fa-check-circle-o"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:authorize">
				if (row.isSys != Global.YES && row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/roleAuth?roleCode='+row.id+'&mul=true" class="btnList" title="${fns:text("用户授权角色")}"><i class="fa fa-check-square"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:view">
				if (row.isSys != Global.YES){
					actions.push('<a href="${ctx}/sys/empUser/list?loginInfo.roleCode='+row.id+'" class="btnList" title="查找'+row.roleName+'角色的用户"><i class="fa fa-user"></i></a>&nbsp;');
				}
				//</shiro:hasPermission>
				
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
</script>