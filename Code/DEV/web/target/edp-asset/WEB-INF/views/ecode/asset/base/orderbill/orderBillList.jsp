<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="办公用品采购" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>办公用品采购</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="orderbill:orderBill:edit">
				<a href="${ctx}/orderbill/orderBill/form" class="btn btn-default btn-sm btnTool" title="新增办公用品采购"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="orderBill" action="${ctx}/orderbill/orderBill/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
				<div class="form-group">
                    <label class="control-label">状态：</label>
                    <div class="input-inline">
                        <form:select path="approvalStatus" class="form-control input-sm width-160">
                        	<%-- <form:option value="" label="全部"/>
                            <form:option value="0" label="撤回"/> --%>
                            <form:option value="1" label="审批"/>
                            <form:option value="2" label="已审批"/>
                            <form:option value="3" label="驳回"/>
                        </form:select>
                    </div>
                </div>
			<div class="form-group">
				<label class="control-label">采购人姓名：</label>
				<div class="input-inline">
					<form:input path="buyerName" htmlEscape="false" maxlength="61" class="form-control input-sm width-160"/>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="control-label">公司名称：</label>
				<div class="input-inline">
					<form:input path="companyName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
				</div>
			</div> --%>
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
			{header:'状态', name:'approvalStatus', index:'a.approval_status', width:100, align:"left",formatter: function(val, obj, row, act){
                var approvalStatus = ["撤回","审批中","审批完成","已驳回"]
                return approvalStatus[row.approvalStatus]
            }},
            {header:'采购单号', name:'cgCode', index:'a.cg_code', width:200, align:"left",frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/orderbill/orderBill/form?sysCode='+row.sysCode+'" class="btnList" data-title="查看办公用品采购">'+(val ? val : row.sysCode)+'</a>';}},
			{header:'采购人姓名', name:'buyerName', index:'a.buyer_name', width:200, align:"left"},
			/* {header:'公司名称', name:'companyName', index:'a.company_name', width:200, align:"left"}, */
			{header:'部门名称', name:'officeName', index:'a.office_name', width:150, align:"left"},
			{header:'采购日期', name:'orderDate', index:'a.order_date', width:200, align:"left"},
			/* {header:'往来单位名称', name:'btypeName', index:'a.btype_name', width:200, align:"left"},
			{header:'送货信息', name:'addr', index:'a.addr', width:200, align:"left"},
			{header:'电话', name:'tel', index:'a.tel', width:200, align:"left"},
			{header:'联系人', name:'linkMan', index:'a.link_man', width:200, align:"left"}, */
			{header:'采购说明', name:'remarks', index:'a.remarks', width:250, align:"left"},
			{header:'操作', name:'actions', width:80, fixed:true,align:"center", sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="orderbill:orderBill:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/orderbill/orderBill/form?sysCode='+row.sysCode+'" class="btnList" title="查看办公用品采购"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/orderbill/orderBill/delete?sysCode='+row.sysCode+'" class="btnList" title="删除该物资采购" data-confirm="确认要删除该物资采购吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>