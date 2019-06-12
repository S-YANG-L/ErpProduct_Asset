<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="业务实体管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 业务实体管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="form:formEntity:edit">
				<a href="${ctx}/form/formEntity/form" class="btn btn-default btn-sm btnTool" title="新增业务实体"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formEntity" action="${ctx}/form/formEntity/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">业务实体名：</label>
				<div class="input-inline">
					<form:input path="entityName" htmlEscape="false" maxlength="200" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">物理表名：</label>
				<div class="input-inline">
					<form:input path="tableName" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">表单分类：</label>
				<div class="input-inline width-160">
					<sys:treeselect id="formCategory" name="formCategory.categoryCode" value="${formTable.formCategory.categoryCode}"
						labelName="formCategory.categoryName" labelValue="${formTable.formCategory.categoryName}" controlSize="sm"
						title="表单分类" url="/form/formCategory/treeData" cssClass="form-control required" allowClear="false"/>
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
			{header:'业务实体名称', name:'entityName', index:'a.entity_name', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formEntity/form?entityId='+row.entityId+'" class="btnList" data-title="编辑业务实体">'+(val ? val : row.entityId)+'</a>';
			}},
			{header:'物理表名', name:'tableName', index:'a.table_name', width:200, align:"left"},
			{header:'表单分类', name:'formCategory.categoryName', index:'a.form_category', width:130, align:"center"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"left"},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'操作', name:'actions', width:130, fixed:true, sortable:false,align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="form:formEntity:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/formEntity/form?entityId='+row.entityId+'" class="btnList" title="编辑业务实体"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formEntity/delete?entityId='+row.entityId+'" class="btnList" title="删除该业务实体" data-confirm="确认要删除该业务实体吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formEntityColumn/list?entityId='+row.entityId+'" class="btnList" title="业务实体字段"><i class="fa fa-list-ul"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formPermi/list?entityId='+row.entityId+'" class="btnList" title="表单权限配置"><i class="fa icon-key"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>