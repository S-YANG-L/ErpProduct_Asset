<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="抄送列表" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-tasks"></i>抄送列表</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnLogoutAuth" title="退出代理人身份" style="display:none;"><i class="fa fa-sign-out"></i> 退出代理人身份</a>
			<a href="#" class="btn btn-default btn-sm" id="btnRefresh" title="刷新"><i class="fa fa-refresh"></i> 刷新</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" action="${ctx}/jflow/cc/listData" method="post" class="breadcrumb form-inline"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
				<input type="hidden" name="orderBy" id="orderBy"/>
			<div class="form-group">
				抄送信息状态：
				<c:forEach items="${statusList }" var="a">
					<input type="radio"  name="stauts" value="${a.key}" ${a.checked } onclick="radioClick(this.value);">${a.name }
				</c:forEach>
			</div>
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
  	     	{header:'流程标题', name:'title', width:240, align:"left", sortable:false, formatter: function(val, obj, row, act){
	   			if(row.sta==0){
	   				return '<a name="doTask" class="btnList" href="${ctxPath}/WF/Do.jsp?DoType=DoOpenCC&FK_Flow=' + row.fk_flow + '&FK_Node=' + row.fk_node + '&WorkID=' + row.workid + '&FID=' + row.fid + '&Sta=' + row.sta + '&MyPK=' + row.mypk+'" title="查看"><img src="${ctxPath}/WF/Img/CCSta/0.png"  class=Icon > <b>'+val+'</b></a>';
				}else{
					return '<a name="doTask" class="btnList" href="${ctxPath}/WF/WorkOpt/OneWork/Track.jsp?FK_Flow=' + row.fk_flow + '&FK_Node=' + row.fk_node + '&WorkID=' + row.workid + '&FID=' + row.fid + '&Sta=' +row.sta + '&MyPK=' + row.mypk+'" title="查看"><img src="${ctxPath}/WF/Img/CCSta/'+row.sta+'.png"  class=Icon > <b>'+val+'</b></a>';
				}
  	     	}},
	   		{header:'流程名称', name:'flowname', width:120, align:"center", sortable:false},
	   		{header:'内容', name:'doc', width:300, align:"left", sortable:false},
	   		{header:'抄送时间', name:'rdt', width:95, align:"center", fixed:true, sortable:false},
	   		{header:'抄送人', name:'rec', width:100, align:"center", sortable:false},
	   		{header:'状态', name:'sta', width:80, align:"center", sortable:false, formatter: function(val, obj, row, act){
	   			if(val==0) 	return '未读';
	   			if(val==1) 	return '已读';
	   			if(val==3) 	return '删除';
	   		}},
			{header:'操作', name:'actions', width:80, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				//查看 
				if(row.sta==0){
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/Do.jsp?DoType=DoOpenCC&FK_Flow=' + row.fk_flow + '&FK_Node=' + row.fk_node + '&WorkID=' + row.workid + '&FID=' + row.fid + '&Sta=' + row.sta + '&MyPK=' + row.mypk+'" title="查看"><i class="fa fa-book")></i></a>&nbsp;');
				}else{
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctxPath}/WF/WorkOpt/OneWork/Track.jsp?FK_Flow=' + row.fk_flow + '&FK_Node=' + row.fk_node + '&WorkID=' + row.workid + '&FID=' + row.fid + '&Sta=' +row.sta + '&MyPK=' + row.mypk+'" title="查看"><i class="fa fa-book")></i></a>&nbsp;');
				}
				//查看后可以删除
				if(row.sta==1){
					actions.push('&nbsp;<a name="doTask" class="btnList" href="${ctx}/jflow/cc/del?MyPK='+row.mypk+'" title="删除" data-confirm="确认要删除该抄送信息吗？"><i class="fa fa-trash-o")></i></a>&nbsp;');
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
	//按流程名称分组  裴孝峰  BY  2016-6-15
	jQuery("#jqgh_dataGrid_flowname").click(function(){
		$('#orderBy').val('flowname');
		jQuery("#dataGrid").jqGrid('groupingGroupBy',"flowname");
	});
	//按发起人分组  裴孝峰  BY  2016-6-15
	jQuery("#jqgh_dataGrid_rec").click(function(){
		$('#orderBy').val('rec');
		jQuery("#dataGrid").jqGrid('groupingGroupBy',"rec");
	});
	//抄送状态切换方法   裴孝峰  BY  2016-6-15
	function radioClick(v){
		$("#searchForm").attr("action", "${ctx}/jflow/cc/listData?stauts="+v);
		$("#searchForm").submit();
	}
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