<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="授权待办" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i>授权待办</div>
		<div class="actions">
			<a href="${ctx}/jflow/authorized/setting" class="btn btn-default btn-sm btnTool" title="代理人设置"><i class="fa fa-cogs"></i> 代理人设置</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefresh" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/jflow/authorized/listData?flag=${param.flag}" method="post" class="breadcrumb form-inline hide"
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
  	     	{header:'任务主题', name:'title', width:260, align:"left", sortable:false, formatter: function(val, obj, row, act){
  	     		if (row.flowname != '全部流程'){
  	     			return '<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.fk_flow+'&FK_Node='+row.fk_node+'&FID='+row.fid+'&WorkID='+row.workid+'&IsRead=0&Paras='+row.atpara+'&fk_emp='+row.fk_emp+'" title="办理任务"><img align="middle"  src="${ctxPath}/WF/Img/Mail_UnRead.png"/> <b>'+val+'</b></a>';
  	     		}
  	     		return val;
			}},
	   		{header:'流程名称', name:'flowname', sortable:false, width:160, align:"center", fixed:true},
			{header:'发起时间', name:'rdt', width:95, align:"center", fixed:true, sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'${param.flag eq "1" ? "当前步骤" : "办理信息"}', name:'nodename', width:150, sortable:false, align:"center", fixed:true},
			{header:'到达时间', name:'adt', width:95, align:"center", fixed:true,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'授权人', name:'sqr_name', width:95, align:"center", fixed:true},
			{header:'操作', name:'actions', width:80, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.flowname != '全部流程'){
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.fk_flow+'&FK_Node='+row.fk_node+'&FID='+row.fid+'&WorkID='+row.workid+'&IsRead=0&Paras='+row.atpara+'&fk_emp='+row.fk_emp+'" title="办理任务"><i class="fa fa-caret-square-o-right font-purple")></i></a>&nbsp;');
					actions.push('&nbsp;<a name="flowGraph" class="btnList" href="${ctxPath}/WF/WorkOpt/OneWork/Track.jsp?FID='+row.fid+'&FK_Flow='+row.fk_flow+'&WorkID='+row.workid+'" title="跟踪"><i class="fa fa-bullseye"></i></a>&nbsp;');
				}
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
	//刷新
	jQuery("#btnRefresh").click(function(){
		$("#btnCx").click();
	});
</script>