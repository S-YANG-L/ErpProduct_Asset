<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="盘盈入库" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>盘盈入库</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="inoutBill" action="${ctx}/scm/inout/inoutBill/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <form:hidden path="memo"/>
			<div class="form-group">
				<label class="control-label">入库日期：</label>
				<div class="input-inline">
					<input name="orderDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						value="<fmt:formatDate value="${inoutBill.orderDate}" pattern="yyyy-MM-dd"/>"
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
        shrinkToFit: false,
		// 设置数据表格列
		columnModel: [
			{header:'入库单号', name:'billCode', index:'a.bill_code', width:200, align:"left", frozen:true},
			{header:'经办人', name:'psnName', index:'a.psn_name', width:150, align:"center"},
			{header:'经办日期', name:'orderDate', index:'a.order_date', width:200, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true,align:"center", sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/scm/inout/inoutBill/materialStorageCheckForm?sysCode='+row.sysCode+'" class="btnList" title="编辑盘盈入库"><i class="fa fa-pencil"></i></a>&nbsp;');
					/* actions.push('<a href="${ctx}/scm/inout/inoutBill/delete?sysCode='+row.sysCode+'" class="btnList" title="删除该采购订单" data-confirm="确认要删除该采购订单吗？"><i class="fa fa-trash-o"></i></a>&nbsp;'); */
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>