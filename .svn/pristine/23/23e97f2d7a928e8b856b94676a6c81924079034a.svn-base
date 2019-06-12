<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="办公用品领用" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>办公用品领用</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
				<a href="${ctx}/outbound/outboundBill/form" class="btn btn-default btn-sm btnTool" title="新增办公用品领用"><i class="fa fa-plus"></i> 新增</a>
			
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="outboundBill" action="${ctx}/outbound/outboundBill/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <form:hidden path="memo"/>
            <div class="form-group">
				<label class="control-label">状态：</label>
				<div class="input-inline">
					<form:select path="approvalStatus" class="form-control input-sm width-160">
									<form:option value="" label="全部"/>
									<form:option value="0">撤回</form:option>
									<form:option value="1">审批中</form:option>
									<form:option value="2">审批完成</form:option>
									<form:option value="3">已驳回</form:option>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">申请日期：</label>
				<div class="input-inline">
					<input name="applyDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						value="<fmt:formatDate value="${outboundBill.applyDate}" pattern="yyyy-MM-dd"/>"
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
			{header:'状态', name:'approvalStatus', index:'a.approval_status', width:150, align:"center",formatter: function(val, obj, row, act){
                var approvalStatus = ["撤回","审批中","审批完成","拒绝"]
                return approvalStatus[row.approvalStatus]
            }},
			{header:'单号', name:'outboundCode', index:'a.outbound_code', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/outbound/outboundBill/form?sysCode='+row.sysCode+'" class="btnList" data-title="编辑物资出库">'+(val ? val : row.sysCode)+'</a>';
			}},
			{header:'申请人', name:'outbounderName', index:'a.outbounder_name', width:150, align:"center"},
			{header:'部门名称', name:'officeName', index:'a.office_name', width:200, align:"center"},
			{header:'领用日期', name:'outboundDate', index:'a.outbound_date', width:200, align:"center"},
			{header:'操作', name:'actions', width:50, fixed:true,align:"center", sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/outbound/outboundBill/form?sysCode='+row.sysCode+'" class="btnList" title="编辑办公用品领用"><i class="fa fa-pencil"></i></a>&nbsp;');
					/* actions.push('<a href="${ctx}/outbound/outboundBill/delete?sysCode='+row.sysCode+'" class="btnList" title="删除该物资出库" data-confirm="确认要删除该物资出库吗？"><i class="fa fa-trash-o"></i></a>&nbsp;'); */
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>