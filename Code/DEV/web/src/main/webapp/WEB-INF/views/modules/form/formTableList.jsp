<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="物理实体管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 物理实体管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="form:formTable:edit">
				<a href="${ctx}/form/formTable/form" class="btn btn-default btn-sm btnTool" title="新增物理实体"><i class="fa fa-plus"></i> 新增</a>
				<a href="${ctx}/form/formTable/initImport" class="btn btn-default btn-sm btnTool" title="导入物理实体"><i class="fa fa-mail-forward"></i> 导入</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="formTable" action="${ctx}/form/formTable/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">表描述：</label>
				<div class="input-inline">
					<form:input path="tableComment" htmlEscape="false" maxlength="200" class="form-control input-sm width-160"/>
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
			{header:'表描述', name:'tableComment', index:'a.table_comment', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				if (row.tableType == Global.YES){
					return '<a href="${ctx}/form/formTable/initImport?tableName='+row.tableName+'" class="btnList" data-title="编辑数据字典">'+(val ? val : row.tableName)+'</a>';
				}else{
					return '<a href="${ctx}/form/formTable/form?tableName='+row.tableName+'" class="btnList" data-title="编辑数据字典">'+(val ? val : row.tableName)+'</a>';
				}
			}},
			{header:'表名', name:'tableName', index:'a.table_name', width:200, align:"left"},
			{header:'表单分类', name:'formCategory.categoryName', index:'a.form_category', width:140, align:"center"},
			{header:'最后修改时间', name:'updateDate', index:'a.update_date', width:160, align:"center"},
			{header:'表格类型', name:'tableType', index:'a.table_type', width:100, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('form_table_type')}, val, '未知', true);
			}},
			{header:'<span title="是否已同步到数据库">是否已同步</span>', name:'isWaitSync', index:'a.is_wait_sync', width:100, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('yes_no')}, val, '未知', true);
			}},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'操作', name:'actions', width:130, fixed:true, sortable:false,align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="form:formTable:edit">
				if (row.status == Global.STATUS_NORMAL){
					if (row.tableType == Global.YES){
						actions.push('<a href="${ctx}/form/formTable/initImport?tableName='+row.tableName+'" class="btnList" title="编辑物理实体"><i class="fa fa-pencil"></i></a>&nbsp;');
					}else {
						actions.push('<a href="${ctx}/form/formTable/form?tableName='+row.tableName+'" class="btnList" title="编辑物理实体"><i class="fa fa-pencil"></i></a>&nbsp;');
					}
					actions.push('<a href="${ctx}/form/formTable/delete?tableName='+row.tableName+'" class="btnList" title="删除该物理实体" data-confirm="确认要删除该数据字典吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
					if (row.tableType != Global.YES){
						actions.push('<a href="${ctx}/form/formTable/syncToDb?tableName='+row.tableName+'" class="btnList" title="同步到数据库" data-confirm="确认要同步到数据库吗？"><i class="fa fa-database"></i></a>&nbsp;');
					}
					if (row.isWaitSync == Global.YES){
						actions.push('<a href="${ctx}/form/formTableData/list?tableName='+row.tableName+'" class="btnList" title="查询数据"><i class="fa fa-search"></i></a>&nbsp;');
					}
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>