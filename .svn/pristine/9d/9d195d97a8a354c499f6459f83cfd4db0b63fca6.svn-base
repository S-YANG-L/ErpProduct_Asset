<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="存放地点管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 存放地点</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="location:assLocation:edit">
				<a href="${ctx}/location/assLocation/form" class="btn btn-default btn-sm btnTool" title="新增存放地点"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="assLocation" action="${ctx}/location/assLocation/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">存放地点名称：</label>
				<div class="input-inline">
					<form:input path="localeName" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
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
			{header:'存放地点编码', name:'localeCode', index:'a.locale_code', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/location/assLocation/form?id='+row.id+'" class="btnList" data-title="编辑存放地点">'+(val ? val : row.id)+'</a>';
			}},
			{header:'存放地点名称', name:'localeName', index:'a.locale_name', width:200, align:"left"},
			{header:'创建时间', name:'createDate', index:'a.create_date', width:100, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false,align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="location:assLocation:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/location/assLocation/form?id='+row.id+'" class="btnList" title="编辑存放地点"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/location/assLocation/delete?id='+row.id+'" class="btnList" title="删除该存放地点" data-confirm="确认要删除该存放地点吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>