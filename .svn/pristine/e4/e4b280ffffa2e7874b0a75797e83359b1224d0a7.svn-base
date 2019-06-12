<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="模板管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 模板管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:msgTemplate:edit">
				<a href="${ctx}/sys/msgTemplate/form" class="btn btn-default btn-sm btnTool" title="新增模板"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="msgTemplate" action="${ctx}/sys/msgTemplate/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">归属模块：</label>
				<div class="input-inline">
					<form:select path="moduleCode" class="form-control input-sm width-90">
						<form:option value="" label="全部"/>
						<form:options items="${moduleList}" itemLabel="moduleName" itemValue="moduleCode" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">模板键值：</label>
				<div class="input-inline">
					<form:input path="tplKey" htmlEscape="false" maxlength="100" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">模板名称：</label>
				<div class="input-inline">
					<form:input path="tplName" htmlEscape="false" maxlength="100" class="form-control input-sm width-90"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">模板类型：</label>
				<div class="input-inline">
					<form:select path="tplType" class="form-control input-sm width-90">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('sys_msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
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
			{header:'模板键值', name:'tplKey', index:'a.tpl_key', width:200, align:"left", formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/msgTemplate/form?id='+row.id+'" class="btnList" data-title="编辑模板">'+(val ? val : row.id)+'</a>';
			}},
			{header:'模板名称', name:'tplName', index:'a.tpl_name', width:200, align:"left"},
			{header:'模板类型', name:'tplType', index:'a.tpl_type', width:200, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('sys_msg_type')}, val, '未知', true);
			}},
			{header:'模板内容', name:'tplContent', index:'a.tpl_content', width:200, align:"left"},
			{header:'归属模块', name:'moduleCode', index:'a.module_code', width:200, align:"center", frozen:true},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:msgTemplate:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/msgTemplate/form?id='+row.id+'" class="btnList" title="编辑模板"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/msgTemplate/delete?id='+row.id+'" class="btnList" title="删除该模板" data-confirm="确认要删除该模板吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>