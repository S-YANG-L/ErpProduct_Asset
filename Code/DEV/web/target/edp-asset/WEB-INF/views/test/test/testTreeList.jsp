<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="树表管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 树表管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefreshTree" title="刷新"><i class="fa fa-refresh"></i> 全部</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExpandTreeNode" title="展开一级"><i class="fa fa-angle-double-down"></i> 展开</a>
			<a href="#" class="btn btn-default btn-sm" id="btnCollapseTreeNode" title="折叠全部"><i class="fa fa-angle-double-up"></i> 折叠</a>
			<shiro:hasPermission name="test:testTree:edit">
				<a href="${ctx}/test/testTree/form" class="btn btn-default btn-sm btnTool" title="新增树表"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="testTree" action="${ctx}/test/testTree/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">名称：</label>
				<div class="input-inline">
					<form:input path="name" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
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
			{header:'名称', name:'name', index:'a.name', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/test/testTree/form?id='+row.id+'" class="btnList" data-title="编辑树表">'+(val ? val : row.id)+'</a>';
			}},
			{header:'排序（升序）', name:'sorts', index:'a.sorts', width:200, align:"left"},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"left"},
			{header:'状态（0正常 1删除 2停用）', name:'status', index:'a.status', width:200, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('search_status')}, val, '未知', true);
			}},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//<shiro:hasPermission name="test:testTree:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/test/testTree/form?id='+row.id+'" class="btnList" title="编辑树表"><i class="fa fa-pencil"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="test:testTree:enable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/test/testTree/disable?id='+row.id+'" class="btnList" title="停用树表" data-confirm="确认要停用该树表吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="test:testTree:disable">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/test/testTree/enable?id='+row.id+'" class="btnList" title="启用树表" data-confirm="确认要启用该树表吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="test:testTree:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/test/testTree/delete?id='+row.id+'"  class="btnList" title="删除树表" data-confirm="确认要删除该树表及所有子树表吗？" data-confirm-success="$(\'#dataGrid\').dataGrid(\'delTreeNode\',\''+row.id+'\');"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/test/testTree/form?parentCode='+row.id+'" class="btnList" title="新增下级树表"><i class="fa fa-plus-square"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		treeGrid: true,			// 启用树结构表格
		defaultExpandLevel: 0,	// 默认展开的层次
		ajaxSuccess: function(data){ // 加载成功后执行方法

		}
	});
</script>