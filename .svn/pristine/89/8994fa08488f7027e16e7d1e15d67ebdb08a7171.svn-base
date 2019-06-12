<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="脚本管理管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 脚本管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="form:formScript:edit">
				<a href="${ctx}/form/formScript/form" class="btn btn-default btn-sm btnTool" title="新增脚本"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formScript" action="${ctx}/form/formScript/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">脚本语言：</label>
				<div class="input-inline">
					<form:select path="scriptLanguage" class="form-control input-sm width-120">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('form_entity_language')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">脚本类别：</label>
				<div class="input-inline">
					<form:select path="scriptType" class="form-control input-sm width-120">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('form_entity_script_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">脚本名称：</label>
				<div class="input-inline">
					<form:input path="scriptName" htmlEscape="false" maxlength="100" class="form-control input-sm width-120"/>
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
			{header:'脚本语言', name:'scriptLanguage', index:'a.script_language', width:120, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_entity_language')},val,'',true);
			}},
			{header:'脚本类别', name:'scriptType', index:'a.script_type', width:120, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_entity_script_type')},val,'',true);
			}},
			{header:'脚本名称', name:'scriptName', index:'a.script_name', width:360, align:"left", formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formScript/form?id='+row.id+'" class="btnList" data-title="编辑脚本">'+(val ? val : row.id)+'</a>';
			}},
			{header:'脚本描述', name:'remarks', index:'a.remarks', width:300, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="form:formScript:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/formScript/form?id='+row.id+'" class="btnList" title="编辑脚本"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formScript/delete?id='+row.id+'" class="btnList" title="删除该脚本" data-confirm="确认要删除该脚本管理吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
</script>