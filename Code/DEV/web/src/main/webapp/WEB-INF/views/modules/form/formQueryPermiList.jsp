<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="列表权限管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 列表权限管理</div>
		<div class="actions hide">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-tabs">
		<ul class="nav nav-tabs">
			<li><a id="btn_portlet_tab6" href="${ctx}/form/formQueryDataScope/form?queryId=${formQueryPermi.queryId}">数据权限配置</a></li>
			<li class="active"><a id="btn_portlet_tab5" href="javascript:void(0);">按钮权限配置</a></li>
			<li><a id="btn_portlet_tab4" href="${ctx}/form/formQuery/formDataGridOptions?queryId=${formQueryPermi.queryId}">表格选项配置</a></li>
			<li><a id="btn_portlet_tab3" href="${ctx}/form/formQueryButton/list?queryId=${formQueryPermi.queryId}">按钮详细配置</a></li>
			<li><a id="btn_portlet_tab2" href="${ctx}/form/formQueryColumn/list?queryId=${formQueryPermi.queryId}">列表字段配置</a></li>
			<li><a id="btn_portlet_tab1" href="${ctx}/form/formQuery/form?queryId=${formQueryPermi.queryId}">&lt;&lt;基本信息</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="portlet_tab5">
				<div class="portlet-body list">
					<form:form id="searchForm" modelAttribute="formQueryPermi" action="${ctx}/form/formQueryPermi/listData" method="post" class="breadcrumb form-inline hide"
							data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
							<form:hidden path="queryId" />
						<div class="form-group">
							<label class="control-label">权限Key：</label>
							<div class="input-inline">
								<form:input path="permiKey" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
							</div>
						</div>
						<div class="form-group" style="margin-left:10px;"> 
							<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
							<input class="btn default btn-sm" type="reset" value="重置"/>
						</div>
					</form:form>
					<table id="dataGrid"></table>
				</div>
				<a id="btnAddPermi" href="${ctx}/form/formQueryPermi/form?queryId=${formQueryPermi.queryId}&queryKey=${formQuery.queryKey}" class="btn btn-default btn-sm btnTool hide" title="新增表单权限"></a>
				<button type="button" class="btn btn-primary" style="margin-top: 7px;" onclick="javascript:$('#btnAddPermi').click();"> <i class="fa fa-plus"></i> 新增</button>
				&nbsp;
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
		
		// 设置数据表格列
		columnModel: [
			{header:'权限Key', name:'permiKey', index:'a.permi_key', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/form/formQueryPermi/form?permiId='+row.permiId+'" class="btnList" data-title="编辑列表权限">'+(val ? val : row.permiId)+'</a>';
			}},
			{header:'权限名称', name:'permiName', index:'a.permi_name', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/form/formQueryPermi/form?permiId='+row.permiId+'" class="btnList" title="编辑列表权限"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/form/formQueryPermi/delete?permiId='+row.permiId+'" class="btnList" title="删除该列表权限" data-confirm="确认要删除该列表权限吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>