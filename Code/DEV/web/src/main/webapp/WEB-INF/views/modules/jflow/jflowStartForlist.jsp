<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="待办任务" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 流程发起</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnLogoutAuth" title="退出代理人身份" style="display:none;"><i class="fa fa-sign-out"></i> 退出代理人身份</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefresh" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/jflow/start/listData" method="post"   class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input type="hidden" name="orderBy" id="orderBy"/>
			<div style="display: none;"><input id="btnCx" class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;</div>
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
	   			return '<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.no+'&FK_Node='+row.no+'01" title="'+val+'"><img src="${ctxPath}/WF/Img/WFState/Runing.png" class="Icon" align="middle" width="16px"/> <b>'+val+'</b></a>';
			}},
	   		{header:'流程分类', name:'fk_flowsorttext', sortable:false, width:120, align:"center", fixed:true},
			/* {header:'发起人', name:'startername', sortable:false, width:140, align:"center", fixed:true},
			{header:'发起时间', name:'rdt', width:95, align:"center", fixed:true, sortable:false,width:150},
			{header:'${param.flag eq "1" ? "当前步骤" : "办理信息"}', name:'nodename', width:150, sortable:false, align:"center", fixed:true},
			{header:'到达时间', name:'adt', width:95, align:"center", fixed:true,width:150}, */
			{header:'操作', name:'actions', width:120, fixed:true, sortable:false,align:"center", formatter: function(val, obj, row, act){
				var actions = [];
				if(row.isbatchstart==0){
					//发起
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.no+'&FK_Node='+row.no+'01" title="发起流程"><i class="fa fa-play")></i></a>&nbsp;');
					//查询
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/Rpt/Search.jsp?RptNo=ND'+Number(row.no)+'MyRpt&FK_Flow=' + row.no + '" title="查询"><i class="fa fa-search")></i></a>&nbsp;');
					//流程图
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/Admin/CCFlowDesigner/Truck.html?FK_Flow=' + row.no+ '&DoType=Chart" title="流程图"><i class="fa fa-picture-o")></i></a>&nbsp;');
				}else{
					//批量发起
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/BatchStart.jsp?FK_Flow='+row.no+'" title="批量发起"><i class="fa fa-list")></i></a>&nbsp;');
					//查询
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/Rpt/Search.jsp?RptNo=ND'+Number(row.no)+'MyRpt&FK_Flow=' + row.no + '" title="查询"><i class="fa fa-search")></i></a>&nbsp;');
					//流程图
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/Admin/CCFlowDesigner/Truck.html?FK_Flow=' + row.no+ '&DoType=Chart" title="流程图"><i class="fa fa-picture-o")></i></a>&nbsp;');
				}
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
	// 刷新列表
	$("#btnRefresh").click(function(){
		$("#btnCx").click();
		$("#btnLogoutAuth").trigger('btnLogoutAuthRefresh');
	});
	// 退出代理人身份、绑定按钮显示或隐藏
	$("#btnLogoutAuth").click(function(){
		ajaxSubmit("${ctx}/jflow/authorized/logout", function(data){
			showMessage(data.message);
			$("#btnRefresh").click();
		});
	})
	.on('btnLogoutAuthRefresh', function(){
		ajaxSubmit("${ctx}/jflow/authorized/isAuth", function(data){
			if (data == 'true'){
				$("#btnLogoutAuth").show();
			}else{
				$("#btnLogoutAuth").hide();
			}
		}, "text");
	})
	.trigger('btnLogoutAuthRefresh');
</script>