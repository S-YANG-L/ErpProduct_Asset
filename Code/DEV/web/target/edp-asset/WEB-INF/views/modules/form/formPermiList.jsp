<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="表单权限配置管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 表单权限配置</div>
		<div class="actions hide">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-tabs">
		<ul class="nav nav-tabs">
			<li class="active"><a id="btn_portlet_tab3" href="#portlet_tab3">权限配置</a></li>
			<li><a id="btn_portlet_tab2" href="${ctx}/form/formEntityColumn/list?entityId=${formPermi.entityId}">字段配置</a></li>
			<li><a id="btn_portlet_tab1" href="${ctx}/form/formEntity/form?entityId=${formPermi.entityId}">业务实体 </a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="portlet_tab3">
				<div class="portlet-body list">
					<form:form id="searchForm" modelAttribute="formPermi" action="${ctx}/form/formPermi/listData" method="post" class="breadcrumb form-inline hide"
							data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
						<form:hidden path="entityId"/>
						<div class="form-group">
							<label class="control-label">权限Key：</label>
							<div class="input-inline">
								<form:input path="permiKey" htmlEscape="false" maxlength="64" class="form-control input-sm width-120"/>
							</div>
						</div>
						<div class="form-group" style="margin-left:10px;"> 
							<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
							<input class="btn default btn-sm" type="reset" value="重置"/>
						</div>
					</form:form>
					<table id="dataGrid"></table>
				</div>
				<a id="btnAddPermi" href="${ctx}/form/formPermi/form?entityId=${formPermi.entityId}&tableName=${formEntity.tableName}" class="btn btn-default btn-sm btnTool hide" title="新增表单权限"></a>
				<button type="button" class="btn btn-primary" style="margin-top: 7px;" onclick="javascript:$('#btnAddPermi').click();"><i class="fa fa-plus"></i> 新增</button>&nbsp;
			</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		autoGridHeight: function(){return 'auto'},
		// 设置数据表格列
		columnModel: [
			/* {header:'表单编号', name:'formId', index:'a.form_id', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formPermi/form?permiId='+row.permiId+'" class="btnList" data-title="编辑表单权限配置">'+(val ? val : row.permiId)+'</a>';
			}}, */
			{header:'权限名称', name:'permiName', index:'a.permi_name', width:200, align:"left"},
			{header:'权限Key', name:'permiKey', index:'a.permi_key', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/formPermi/form?permiId='+row.permiId+'&formDef.entityId=${formPermi.formDef.entityId}" class="btnList" title="编辑表单权限"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formPermi/delete?permiId='+row.permiId+'" class="btnList" title="删除该表单权限" data-confirm="确认要删除该表单权限吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>