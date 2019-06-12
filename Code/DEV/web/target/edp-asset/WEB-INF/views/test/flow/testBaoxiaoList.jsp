<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="报销单管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 报销单管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="test:testBaoxiao:edit">
				<a href="${ctx}/test/testBaoxiao/form" class="btn btn-default btn-sm btnTool" title="新增报销单"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="testBaoxiao" action="${ctx}/test/testBaoxiao/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">报销理由：</label>
				<div class="input-inline">
					<form:input path="title" htmlEscape="false" maxlength="200" class="form-control input-sm width-60"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">报销金额：</label>
				<div class="input-inline">
					<form:input path="money" htmlEscape="false" maxlength="18" class="form-control input-sm width-60"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">报销人：</label>
				<div class="input-inline width-120" >
					<sys:treeselect id="createBy" name="createBy.userCode" value="${testBaoxiao.createBy.userCode}" labelName="createBy.userName" labelValue="${testBaoxiao.createBy.userName}"
						title="用户" url="/sys/office/treeData?type=3" controlSize="sm" allowClear="true" notAllowSelectParent="true" notAllowSelectRoot="true"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">报销时间：</label>
				<div class="input-inline">
					<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-90"
						value="<fmt:formatDate value="${testBaoxiao.beginCreateDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
					<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-90"
						value="<fmt:formatDate value="${testBaoxiao.endCreateDate}" pattern="yyyy-MM-dd"/>"
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
			{header:'报销理由', name:'title', index:'a.title', width:200, frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/test/testBaoxiao/form?id='+row.id+'" class="btnList" data-title="编辑报销单">'+(val ? val : row.id)+'</a>';
			}},
			{header:'报销金额', name:'money', index:'a.money', width:200},
			{header:'报销人', name:'createByName', index:'a.create_by', width:200},
			{header:'报销时间', name:'createDate', index:'a.create_date', width:200},
			{header:'备注', name:'remarks', index:'a.remarks', width:200},
			{header:'更新时间', name:'updateDate', index:'a.update_date', width:200},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="test:testBaoxiao:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/test/testBaoxiao/form?id='+row.id+'" class="btnList" title="编辑报销单"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/test/testBaoxiao/delete?id='+row.id+'" class="btnList" title="删除该报销单" data-confirm="确认要删除该报销单吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>