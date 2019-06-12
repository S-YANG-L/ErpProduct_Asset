<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="群组管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 群组管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="user">
				<a href="${ctx}/msgim/msgImGroup/form" class="btn btn-default btn-sm btnTool" title="新增群组"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="msgImGroup" action="${ctx}/msgim/msgImGroup/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">群组名：</label>
				<div class="input-inline">
					<form:input path="groupName" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group" style="margin-left:10px;"> 
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
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'群组名', name:'groupName', index:'a.group_name', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/msgim/msgImGroup/form?groupId='+row.groupId+'" class="btnList" data-title="编辑群组">'+(val ? val : row.groupId)+'</a>';
			}},
			{header:'群组头像', name:'groupAvatar', index:'a.group_avatar', width:200, align:"left"},
			{header:'群主账号', name:'groupOwner', index:'a.group_owner', width:200, align:"left"},
			{header:'群介绍', name:'description', index:'a.description', width:200, align:"left"},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="user">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/msgim/msgImGroup/form?groupId='+row.groupId+'" class="btnList" title="编辑群组"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/msgim/msgImGroup/delete?groupId='+row.groupId+'" class="btnList" title="删除该群组" data-confirm="确认要删除该群组吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>