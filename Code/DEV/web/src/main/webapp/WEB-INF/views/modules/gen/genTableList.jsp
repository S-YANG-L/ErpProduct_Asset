<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="代码生成" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-code"></i> 代码生成<c:if test="${not empty genTable.parentTableName}">（父表：${genTable.parentTableName}）</c:if></div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="gen:genTable:edit">
				<a href="${ctx}/gen/genTable/form" class="btn btn-default btn-sm btnTool" title="新增表"><i class="fa fa-plus"></i> 新增</a>
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
		<form:form id="searchForm" modelAttribute="genTable" action="${ctx}/gen/genTable/listData" method="post" class="breadcrumb form-inline "
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="parentTableName"/>
			<div class="form-group">
				<label class="control-label">表名：</label>
				<div class="input-inline width-160" >
					<form:input path="nameLike" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">表说明：</label>
				<div class="input-inline width-160" >
					<form:input path="comments" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="control-label">父表名：</label>
				<div class="input-inline width-160" >
					<form:input path="parentTableNameLike" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
				</div>
			</div> --%>
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
var dataGrid; // 定义全局表格对象。
$(document).ready(function() {
	
	// 初始化DataGrid对象
	dataGrid = new DataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'表名', name:'tableName', index:'table_name', width:150, frozen:true , formatter: function(val, obj, row, act){
				return '<a href="${ctx}/gen/genTable/form?tableName='+row.id+'" class="btnList" data-title="编辑配置">'+val+'</a>';
			}},
			{header:'表说明', name:'comments', index:'comments', width:150},
			{header:'父表名', name:'parentTableName', hidden:${empty genTable.parentTableName}, index:'parent_table_name', width:150/* , formatter: function(val, obj, row, act){
				return !val ? '' : '<a href="javascript:" onclick="$(\'#parentTableName\').val(\''+row.parentTableName+'\');$(\'#searchForm\').submit()">'+val+'</a>';
			} */},
// 			{header:'模块名', name:'packageName', index:'module_name', width:260, formatter: function(val, obj, row, act){
// 				return !(row.packageName && row.moduleName) ? '' : row.packageName + '.' + row.moduleName 
// 						+ (row.subModuleName && row.subModuleName != '' ? '.' + row.subModuleName : '');
// 			}},
// 			{header:'功能名', name:'functionName', index:'function_name', width:260},
			{header:'功能作者', name:'functionAuthor', index:'function_author', width:100, align:"center"},
			{header:'创建时间', name:'createDate', index:'create_date', width:150, fixed:true, align:"center"},
			{header:'操作', name:'actions', width:120, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="gen:genTable:edit">
				actions.push('<a href="${ctx}/gen/genTable/form?tableName='+row.id+'" class="btnList" title="编辑配置"><i class="fa fa-pencil"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/gen/genTable/delete?tableName='+row.id+'" class="btnList" title="删除表" data-confirm="确认要删除该表吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				if (!row.parentExists){
					actions.push('<a href="${ctx}/gen/genTable/form?tableName='+row.id+'&op=gen" class="btnList" title="生成代码"><i class="fa fa-bug"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/gen/genTable/list?parentTableName='+row.id+'" class="btnList" title="查询子表"><i class="fa fa-external-link-square"></i></a>&nbsp;');
				}
				//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			if ($('#nameLike').val() == '' && $('#comments').val() == ''){
				$('#dataGrid').dataGrid('hideCol', 'parentTableName'); //隐藏列
			}else{
				$('#dataGrid').dataGrid('showCol', 'parentTableName'); //显示列
			}
		}
	});
	
});
</script>