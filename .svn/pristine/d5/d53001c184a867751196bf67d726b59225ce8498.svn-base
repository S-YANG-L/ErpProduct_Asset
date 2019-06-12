<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="工作流模板管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 工作流模板管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="eflow:flowTemplate:edit">
				<a href="${ctx}/eflow/flowTemplate/form" class="btn btn-default btn-sm btnTool" title="新增工作流模板"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="flowTemplate" action="${ctx}/eflow/flowTemplate/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">工作流名称：</label>
				<div class="input-inline">
					<form:input path="flowName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">适用单据：</label>
				<form:select path="billType" class="form-control width-120 input-sm"  >
					<form:option  value="">全部</form:option>
					<form:options items="${fns:getDictList('eflow_bill_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
			{header:'工作流名称', name:'flowName', index:'a.flow_name', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/eflow/flowTemplate/form?id='+row.id+'" class="btnList" data-title="编辑工作流模板">'+(val ? val : row.id)+'</a>';
			}},
			{header:'工作流程描述', name:'flowDes', index:'a.flow_des', width:200, align:"left"},
			{header:'适用单据', name:'billtypeNames', index:'a.billtype_names', width:200, align:"left"},
			{header:'适用范围', name:'scopeNames', index:'a.scope_names', width:200, align:"left"},
			{header:'当前版本', name:'version', index:'a.version', width:80, align:"center"},
			{header:'启用日期', name:'enableDate', index:'a.enable_date', width:100, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, align:"center", sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//<shiro:hasPermission name="eflow:flowTemplate:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/eflow/flowTemplate/form?id='+row.id+'" class="btnList" title="编辑工作流模板"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/eflow/flowTemplate/delete?id='+row.id+'" class="btnList" title="删除该工作流模板" data-confirm="确认要删除该工作流模板吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>