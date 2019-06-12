<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('栏目授权')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-gear"></i> ${fns:text('栏目授权')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="role" action="${ctx}/cms/categoryRole/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('角色名称')}：</label>
				<div class="input-inline width-160" >
					<form:input path="roleName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
				</div>
			</div>
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
var dataGrid; // 定义全局表格对象。
$(document).ready(function() {
	
	// 初始化DataGrid对象
	dataGrid = new DataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
		  	{header:'${fns:text("角色名称")}', name:'roleName', index:'role_name', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/cms/categoryRole/form?role.roleCode='+row.id+'" class="btnList" title="${fns:text("栏目授权")}">'+val+'</a>';
			}},
			//<c:if test="${role.currentUser.admin}">
  			{header:'${fns:text("角色编码")}', name:'roleCode', index:'a.role_code', width:60, align:"center"},//</c:if>
			{header:'${fns:text("备注")}', name:'remarks', index:'remarks', width:160, sortable:false},
			{header:'${fns:text("操作")}', name:'actions', width:100, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="cms:categoryRole:view">
				actions.push('<a href="${ctx}/cms/categoryRole/form?role.roleCode='+row.id+'" class="btnList" title="${fns:text("栏目授权")}"><i class="fa fa-check-square-o"></i></a>&nbsp;');
				//</shiro:hasPermission><shiro:hasPermission name="cms:categoryRole:edit">
				//actions.push('<a href="${ctx}/cms/categoryRole/delete?roleCode='+row.id+'" class="btnList" title="清空该角色下的授权" data-confirm="确认要清空该角色下的授权吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
});
</script>