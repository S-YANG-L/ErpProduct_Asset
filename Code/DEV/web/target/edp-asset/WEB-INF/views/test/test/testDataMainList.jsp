<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="主表管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 主表管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="test:testDataMain:edit">
				<a href="${ctx}/test/testDataMain/form" class="btn btn-default btn-sm btnTool" title="新增主表"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="testDataMain" action="${ctx}/test/testDataMain/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">归属部门：</label>
				<div class="input-inline width-160" >
					<sys:treeselect id="office" name="office.officeCode" value="${testDataMain.office.officeCode}" labelName="office.officeName" labelValue="${testDataMain.office.officeName}"
						title="部门" url="/sys/office/treeData?type=2" controlSize="sm" allowClear="true" notAllowSelectParent="false"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">名称：</label>
				<div class="input-inline">
					<form:input path="name" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">性别：</label>
				<div class="input-inline">
					<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">加入日期：</label>
				<div class="input-inline">
					<input name="inDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-90"
						value="<fmt:formatDate value="${testDataMain.inDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
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
			{header:'名称', name:'name', index:'a.name', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/test/testDataMain/form?id='+row.id+'" class="btnList" data-title="编辑主表">'+(val ? val : row.id)+'</a>';
			}},
			{header:'备注信息', name:'remarks', index:'a.remarks', width:200, align:"left"},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="test:testDataMain:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/test/testDataMain/form?id='+row.id+'" class="btnList" title="编辑主表"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/test/testDataMain/delete?id='+row.id+'" class="btnList" title="删除该主表" data-confirm="确认要删除该主表吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>