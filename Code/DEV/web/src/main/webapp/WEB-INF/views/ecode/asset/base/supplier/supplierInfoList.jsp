<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="供货商管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 供货商管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="supplier:supplierInfo:edit">
				<a href="${ctx}/supplier/supplierInfo/form" class="btn btn-default btn-sm btnTool" title="新增供货商"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="supplierInfo" action="${ctx}/supplier/supplierInfo/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">供货商名称：</label>
				<div class="input-inline">
					<form:input path="supplierName" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
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
            {header:'纳税人识别号', name:'supplierCode', index:'a.supplier_code', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
                    return '<a href="${ctx}/supplier/supplierInfo/form?id='+row.id+'" class="btnList" data-title="编辑供货商">'+(val ? val : row.id)+'</a>';
                }},
			{header:'供货商名称', name:'supplierName', index:'a.supplier_name', width:200, align:"left"},
            {header:'创建时间', name:'createDate', index:'a.create_date', width:100, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false,align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="supplier:supplierInfo:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/supplier/supplierInfo/form?id='+row.id+'" class="btnList" title="编辑供货商"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/supplier/supplierInfo/delete?id='+row.id+'" class="btnList" title="删除该供货商" data-confirm="确认要删除该供货商吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>