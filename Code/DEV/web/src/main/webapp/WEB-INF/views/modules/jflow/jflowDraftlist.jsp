<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="我的草稿" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i> 我的草稿</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnLogoutAuth" title="退出代理人身份" style="display:none;"><i class="fa fa-sign-out"></i> 退出代理人身份</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefresh" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
			<!-- <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a> -->
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/jflow/draft/listData?flag=${param.flag}" method="post" class="breadcrumb form-inline hide"
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
	   			return '<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.fk_flow+'&FID=0&WorkID='+row.workid+'&IsRead=0" title="发起流程"><img align="middle"  src="${ctxPath}/WF/Img/Mail_UnRead.png"/><b>'+val+'</b></a>';
	   		}},
	   		{header:'流程名称', name:'flowname', width:150, align:"center", sortable:false},
	   		{header:'日期', name:'rdt', sortable:false, width:80, align:"center", fixed:true},
			{header:'备注', name:'flownote', width:120, align:"center", fixed:true, sortable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d H:i', newformat:'Y-m-d H:i'}},
			{header:'操作', name:'actions', width:80, align:"center", fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/MyFlow.jsp?FK_Flow='+row.fk_flow+'&FID=0&WorkID='+row.workid+'&IsRead=0" title="发起流程"><i class="fa fa-play")></i></a>&nbsp;');
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