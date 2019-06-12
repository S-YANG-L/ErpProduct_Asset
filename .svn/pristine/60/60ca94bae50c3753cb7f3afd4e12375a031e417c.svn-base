<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="共享任务" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 共享任务</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnLogoutAuth" title="退出代理人身份" style="display:none;"><i class="fa fa-sign-out"></i> 退出代理人身份</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefresh" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
			<!-- <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a> -->
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/jflow/sharing/listData?flag=${param.flag}" method="post" class="breadcrumb form-inline hide"
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
			{header:'标题', name:'title', sortable:false, width:330, align:"left", fixed:true,formatter: function(val, obj, row, act){
	   			return '<a name="doTask" class="btnList" href="${ctxPath}/WF/WFRpt.jsp?WorkID=' + row.workid + '&FK_Flow=' + row.fk_flow + '&FID=' +row.fid + '&FK_Node='+row.fk_node+'" title="流程日志"><img align="middle"  src="${ctxPath}/WF/Img/Mail_UnRead.png"/><b>'+val+'</b></a>';
	   		}},
	   		{header:'流程名称', name:'flowname', width:150, align:"center", sortable:false},
	   		{header:'发起人', name:'startername', sortable:false, width:80, align:"center", fixed:true},
			{header:'发起时间', name:'rdt', width:120, align:"center", fixed:true, sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'接受时间', name:'adt', width:120, align:"center", fixed:true, sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'期限', name:'sdt', width:120, align:"center", fixed:true, sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'状态', name:'gq_zt', width:80, align:"center", fixed:true, sortable:false},
			{header:'操作', name:'actions', width:80, align:"center", fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if(row.tasksta==1){
					actions.push('&nbsp;<a name="applyTask" class="btnList" href="${ctx}/jflow/sharing/applyTask?workId='+row.workid+'" title="申请任务" data-confirm="您确定要申请下来该任务吗？"><i class="fa fa-level-down")></i></a>&nbsp;');
				}else if(row.tasksta==2){
					actions.push('&nbsp;<a name="backTask" class="btnList" href="${ctx}/jflow/sharing/backTask?workId='+row.workid+'" title="放回共享池" data-confirm="您确定要把该任务放回共享池吗？"><i class="fa fa-level-up")></i></a>&nbsp;');
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.fk_flow+'&FK_Node='+row.fk_node+'&FID='+row.fid+'&WorkID='+row.workid+'&IsRead=0&Paras='+row.atpara+'" title="办理任务"><i class="fa fa-caret-square-o-right font-purple")></i></a>&nbsp;');
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