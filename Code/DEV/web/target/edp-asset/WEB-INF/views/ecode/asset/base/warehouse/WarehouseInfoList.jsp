<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="仓库管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 仓库管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			
				<a href="${ctx}/warehouse/WarehouseInfo/form" class="btn btn-default btn-sm btnTool" title="新增仓库"><i class="fa fa-plus"></i> 新增</a>
			
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="WarehouseInfo" action="${ctx}/warehouse/WarehouseInfo/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			
			<div class="form-group">
				<label class="control-label">仓库编码：</label>
				<div class="input-inline">
					<form:input path="warehouseCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
				</div>
			</div>
	
			<div class="form-group">
				<label class="control-label">仓库名称：</label>
				<div class="input-inline">
					<form:input path="warehouseName" htmlEscape="false" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
						<label class="control-label">${fns:text('状态')}：</label>
						<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
						    <form:option  value="">${fns:text('全部')}</form:option>
							<form:options items="${fns:getDictList('user_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
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
			{header:'仓库编码', name:'warehouseCode', index:'a.warehouse_code', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/warehouse/WarehouseInfo/form?id='+row.id+'" class="btnList" data-title="编辑仓库">'+(val ? val : row.id)+'</a>';
			}},
			{header:'仓库名称', name:'warehouseName', index:'a.warehouse_name', width:200, align:"left"},
			{header:'创建时间', name:'createDate', index:'a.create_date', width:120, align:"center"},
			{header:'${fns:text("状态")}', name:'status', index:'a.status', width:100, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('user_status')}, val, '${fns:text("未知")}', true);
			}},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/warehouse/WarehouseInfo/form?id='+row.id+'" class="btnList" title="编辑仓库"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/warehouse/WarehouseInfo/delete?id='+row.id+'" class="btnList" title="删除该仓库" data-confirm="确认要删除该仓库吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/warehouse/WarehouseInfo/disable?id='+row.id+'" class="btnList" title="${fns:text("停用仓库")}" data-confirm="${fns:text("确认要停用该仓库吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/warehouse/WarehouseInfo/form?id='+row.id+'" class="btnList" title="编辑仓库"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/warehouse/WarehouseInfo/delete?id='+row.id+'" class="btnList" title="删除该仓库" data-confirm="确认要删除该仓库吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/warehouse/WarehouseInfo/activate?id='+row.id+'" class="btnList" title="${fns:text("启用仓库")}" data-confirm="${fns:text("确认要启用该仓库吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>