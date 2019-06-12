<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="待办任务" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> ${param.flag eq '1' ? '待办' : '已办'}任务</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnLogoutAuth" title="退出代理人身份" style="display:none;"><i class="fa fa-sign-out"></i> 退出代理人身份</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefresh" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
			<!-- <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a> -->
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/jflow/todolist/listData?flag=${param.flag}" modelAttribute="jflow" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<input type="hidden" name="orderBy" id="orderBy"/>
			<form:hidden path="FK_FLOWSORT" id="FK_FLOWSORT"/>
			<form:hidden path="FK_Flow" id="FK_Flow"/>
			<form:hidden path="FK_Node" id="FK_Node"/>
			<form:hidden path="FLOWNAME" id="FLOWNAME"/>
			<form:hidden path="NODENAME" id="NODENAME"/>
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
  	     	{header:'任务主题', name:'title', width:260, align:"left", sortable:false, formatter: function(val, obj, row, act){
	   			return '<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.fk_flow+'&FK_Node='+row.fk_node+'&FID='+row.fid+'&WorkID='+row.workid+'&IsRead=0&Paras='+row.atpara+'" title="任务办理"><img align="middle"  src="${ctxPath}/WF/Img/Mail_UnRead.png"/> <b>'+val+'</b></a>';
			}},
	   		{header:'流程名称', name:'flowname', sortable:false, width:160, align:"center", fixed:true},
			{header:'发起人', name:'startername', sortable:false, width:100, align:"center", fixed:true},
			{header:'发起时间', name:'rdt', width:95, align:"center", fixed:true, sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'${param.flag eq "1" ? "当前步骤" : "办理信息"}', name:'nodename', width:150, sortable:false, align:"center", fixed:true},
			{header:'到达时间', name:'adt', width:95, align:"center", fixed:true,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'操作', name:'actions', width:80, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.fk_flow+'&FK_Node='+row.fk_node+'&FID='+row.fid+'&WorkID='+row.workid+'&IsRead=0&Paras='+row.atpara+'" title="任务办理"><i class="fa fa-caret-square-o-right font-purple")></i></a>&nbsp;');
				actions.push('&nbsp;<a name="flowGraph" class="btnList" href="${ctxPath}/WF/WorkOpt/OneWork/Track.jsp?FID='+row.fid+'&FK_Flow='+row.fk_flow+'&WorkID='+row.workid+'" title="跟踪"><i class="fa fa-bullseye"></i></a>&nbsp;');
				return actions.join('');
			}}
		],
		//分组设置
		grouping: true,
        groupingView: {
            groupField: ["flowname"],
            groupColumnShow: [true],
            groupText: ["<b>{0}</b>"],
            groupOrder: ["asc"],
            groupSummary: [false],
            groupCollapse: false
        },
		ajaxSuccess: function(data){ // 加载成功后执行方法
		}
	});
	//按流程名称分组
	jQuery("#jqgh_dataGrid_flowname").click(function(){
		$('#orderBy').val('flowname');
		jQuery("#dataGrid").jqGrid('groupingGroupBy',"flowname");
	});
	//按发起人分组
	jQuery("#jqgh_dataGrid_startername").click(function(){
		$('#orderBy').val('startername');
		jQuery("#dataGrid").jqGrid('groupingGroupBy',"startername");
	});
	//按当前处理步骤分组
	jQuery("#jqgh_dataGrid_nodename").click(function(){
		$('#orderBy').val('nodename');
		jQuery("#dataGrid").jqGrid('groupingGroupBy',"nodename");
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