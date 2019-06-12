<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="流水号规则管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 流水号规则管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="form:formSerialNum:edit">
				<a href="${ctx}/form/formSerialNum/form" class="btn btn-default btn-sm btnTool" title="新增流水号规则"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formSerialNum" action="${ctx}/form/formSerialNum/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">生成类型：</label>
				<div class="input-inline">
					<form:select path="genType" class="form-control">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('form_serial_gen_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">流水号名称：</label>
				<div class="input-inline">
					<form:input path="serialName" htmlEscape="false" maxlength="50" class="form-control input-sm width-120"/>
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
			{header:'流水号名称', name:'serialName', index:'a.serial_name', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formSerialNum/form?id='+row.id+'" class="btnList" data-title="编辑流水号规则">'+(val ? val : row.id)+'</a>';
			}},
			{header:'流水号标识', name:'serialKey', index:'a.serial_key', width:200, align:"left"},
			{header:'流水号规则', name:'serialRule', index:'a.serial_rule', width:200, align:"left"},
			{header:'生成类型', name:'genType', index:'a.gen_type', width:200, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_serial_gen_type')}, val, '未知', true);
			}},
			{header:'流水号长度', name:'serialLength', index:'a.serial_length', width:200, align:"center"},
			{header:'流水号初始值', name:'initNum', index:'a.init_num', width:200, align:"center"},
			{header:'流水号步长', name:'step', index:'a.step', width:200, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="form:formSerialNum:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/formSerialNum/form?id='+row.id+'" class="btnList" title="编辑流水号规则"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formSerialNum/delete?id='+row.id+'" class="btnList" title="删除该流水号规则" data-confirm="确认要删除该流水号规则吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>