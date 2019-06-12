<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="流程查询" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 流程查询</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/jflow/search/listData" method="post"   class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input type="hidden" name="orderBy" id="orderBy"/>
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 初始化DataGrid对象
	var dataGrid = new DataGrid({
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		// 设置数据表格列
		columnModel: [
  	     	{header:'流程名称', name:'name', width:260, align:"left", sortable:false, formatter: function(val, obj, row, act){
	   			return '<a name="doTask" class="btnList" href="${ctxPath}/WF/Rpt/Search.jsp?RptNo=ND'+Number(row.no)+'MyRpt&FK_Flow=' + row.no + '" title="'+val+'"><img src="${ctxPath}/WF/Img/WFState/Runing.png" class="Icon" align="middle" width="16px"/> <b>'+val+'</b></a>';
			}},
	   		{header:'流程分类', name:'fk_flowsorttext', sortable:false, width:120, align:"center", fixed:true},
			{header:'操作', name:'actions', width:120, fixed:true, sortable:false,align:"center", formatter: function(val, obj, row, act){
				var actions = [];
				//查询
				actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/Comm/Search.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews&RptNo=ND'+Number(row.no)+'MyRpt&FK_Flow=' + row.no + '" title="查询"><i class="fa fa-search")></i></a>&nbsp;');
				//流程图
				actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/Admin/CCFlowDesigner/Truck.html?FK_Flow=' + row.no+ '&DoType=Chart" title="流程图"><i class="fa fa-picture-o")></i></a>&nbsp;');
				return actions.join('');
			}}
		],
		//分组设置
		grouping: true,
        groupingView: {
            groupField: ["fk_flowsorttext"],
            groupColumnShow: [true],
            groupText: ["<b>{0}</b>"],
            groupOrder: ["asc"],
            groupSummary: [false],
            groupCollapse: false
        },
		ajaxSuccess: function(data){ // 加载成功后执行方法
		}
	});
	
</script>