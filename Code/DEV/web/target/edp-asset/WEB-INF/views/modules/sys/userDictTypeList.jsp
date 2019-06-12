<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="字典管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-notebook"></i> 用户字典管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:userDictType:edit">
				<a href="${ctx}/sys/userDictType/form" class="btn btn-default btn-sm btnTool" title="新增字典类型"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="userDictType" action="${ctx}/sys/userDictType/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">字典类型名称：</label>
				<div class="input-inline">
					<form:input path="dictTypeName" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">字典类型：</label>
				<div class="input-inline">
					<form:input path="dictTypeCode" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
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
			{header:'字典类型名称', name:'dictTypeName', index:'a.dict_type_name', width:80, align:"center", frozen:true, formatter: function(val, obj, row, act){
				//<shiro:hasPermission name="sys:userDict:edit">
				return '<a href="${ctx}/sys/userDict/list?dictTypeCode='+row.dictTypeCode+'&dictTypeName='+row.dictTypeName+'" class="btnList" data-title="编辑字典数据">'+(val ? val : row.id)+'</a>';
				//</shiro:hasPermission><shiro:lacksPermission name="sys:userDict:edit">
				return '<a href="${ctx}/sys/userDictType/form?dictTypeCode='+row.dictTypeCode+'" class="btnList" data-title="编辑字典类型">'+(val ? val : row.id)+'</a>';
				//</shiro:lacksPermission>
			}},
			{header:'字典类型', name:'dictTypeCode', index:'a.dict_type_code', width:80, align:"center"},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200},
			{header:'创建时间', name:'createDate', index:'a.create_date', width:150, fixed:true, align:'center'}
			//<shiro:hasPermission name="sys:userDictType:edit">
			,{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/userDictType/form?dictTypeCode='+row.dictTypeCode+'" class="btnList" title="编辑字典类型"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/userDictType/delete?dictTypeCode='+row.dictTypeCode+'" class="btnList" title="删除该字典类型" data-confirm="确认要删除该字典类型吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
// 					actions.push('<a href="${ctx}/sys/userDict/list?dictTypeCode='+row.dictTypeCode+'" class="btnList" title="编辑字典键值"><i class="fa fa-bars"></i></a>&nbsp;');
				}
				return actions.join('');
			}}//</shiro:hasPermission>
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>