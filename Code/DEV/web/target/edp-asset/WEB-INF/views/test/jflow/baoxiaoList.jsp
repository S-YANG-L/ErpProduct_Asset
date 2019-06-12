<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="费用报销管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 费用报销管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="jflow:baoxiao:edit">
				<a href="${ctx}/jflow/baoxiao/form" class="btn btn-default btn-sm btnTool" title="新增费用报销"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="baoxiao" action="${ctx}/jflow/baoxiao/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">公司：</label>
				<div class="input-inline">
					<form:input path="company.companyCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">预算部门：</label>
				<div class="input-inline width-160" >
					<sys:treeselect id="office" name="office.officeCode" value="${baoxiao.office.officeCode}" labelName="office.officeName" labelValue="${baoxiao.office.officeName}"
						title="部门" url="/sys/office/treeData?type=2" controlSize="sm" allowClear="true" notAllowSelectParent="false"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">申请人：</label>
				<div class="input-inline width-160" >
					<sys:treeselect id="user" name="user.userCode" value="${baoxiao.user.userCode}" labelName="user.userName" labelValue="${baoxiao.user.userName}"
						title="用户" url="/sys/office/treeData?type=3" controlSize="sm" allowClear="true" notAllowSelectParent="false"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">申请日期：</label>
				<div class="input-inline">
					<input name="beginSqDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate width-95"
						value="${fns:formatDate(baoxiao.beginSqDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					&nbsp;--&nbsp;
					<input name="endSqDate" type="text" readonly="readonly" maxlength="20" class="input-sm Wdate width-95"
						value="${fns:formatDate(baoxiao.beginSqDate, 'yyyy-MM-dd')}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
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
			{header:'公司', name:'company.companyCode', index:'a.company_code', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/jflow/baoxiao/form?id='+row.id+'" class="btnList" data-title="编辑费用报销">'+(val ? val : row.id)+'</a>';
			}},
			{header:'预算部门', name:'office.officeName', index:'a.office_code', width:200, align:"center"},
			{header:'申请人', name:'user.userName', index:'a.user_code', width:200, align:"center"},
			{header:'申请日期', name:'sqDate', index:'a.sq_date', width:200, align:"left"},
			{header:'报销金额合计', name:'baoxiaoHj', index:'a.baoxiao_hj', width:200, align:"left"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="jflow:baoxiao:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/jflow/baoxiao/form?id='+row.id+'" class="btnList" title="编辑费用报销"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/jflow/baoxiao/delete?id='+row.id+'" class="btnList" title="删除该费用报销" data-confirm="确认要删除该费用报销吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>