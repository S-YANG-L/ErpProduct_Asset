<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="工作流业务管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 待办业务</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="eflow:flowBusiness:edit">
				<a href="${ctx}/eflow/flowBusiness/form" class="btn btn-default btn-sm btnTool" title="新增工作流业务"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="flowBusiness" action="${ctx}/eflow/flowBusiness/flowTodoListData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
				<label class="control-label"> 业务：</label>
				<form:select path="billtypeCode" class="form-control width-120 input-sm"  >
					<form:option  value="">全部</form:option>
					<form:options items="${fns:getDictList('eflow_bill_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="form-group">
				<label class="control-label">发起人姓名：</label>
				<div class="input-inline">
					<form:input path="applicantName" htmlEscape="false" maxlength="50" class="form-control input-small"/>
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
		  	{header:'业务', name:'billtypeName', index:'a.billtype_code', width:90, align:"center"},
			{header:'单号', name:'bizKey', index:'a.biz_key', width:150, align:"left", formatter: function(val, obj, row, act){
				return '<a href="${ctx}'+ row.linkUrlPc +"&pageFlag=1"+"&stepId="+row.id+'&step='+row.step+'" class="btnList" data-title="单据详情">'+ val +'</a>';
			}},
			{header:'业务描述', name:'content', index:'a.content', width:250, align:"left"},
			{header:'发起人', name:'applicantName', index:'a.applicant_name', width:100, align:"center"},
			{header:'发起时间', name:'billDate', index:'a.bill_date', width:150, align:"center"},
			{header:'当前步骤', name:'stepName', index:'a.step_name', width:130, align:"left"},
			{header:'到达时间', name:'arriveDate', index:'a.arrive_date', width:150, align:"center"},
			{header:'操作', name:'actions', width:80, align:"center", fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					if(row.actionType == "3" ){
						actions.push('<a href="javascript:void(0);" onclick="markAsRead(\''+row.flowBusinessApprovalId+'\')"  title="标为已读"><i class="fa icon-envelope"></i></a>&nbsp;');
					}else{
						var fbApprovalId = row.flowBusinessApprovalId == null ? '' :row.flowBusinessApprovalId;
						var actionType = row.actionType == null ? '' :row.actionType;
						//【正式系统请注释掉下面一行代码】去掉自带审核按钮，必须在各自业务表单里进行审核，否则会造成业务数据不及时更新，数据混乱问题。
						//actions.push('<a href="javascript:void(0);" onclick="showAuditPage(\''+row.id+'\',\''+ fbApprovalId +'\',\''+ actionType +'\')"  title="办理"><i class="fa fa-caret-square-o-right font-purple"></i></a>&nbsp;');
					}
					actions.push('<a href="${ctx}/eflow/flowLog/list?bizKey='+row.bizKey+'" class="btnList" title="流程跟踪"><i class="fa fa-bullseye"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	// 显示审批页面
	function showAuditPage(id, fbApprovalId, actionType){
		var $jBox = getJBox();
		$jBox.open("iframe:${ctx}/eflow/flowBusiness/auditPageV2?id="+id+"&flowBusinessApprovalId="+fbApprovalId+"&actionType="+actionType, "流程审批", 800, 280, {
			buttons: {},
			loaded: function (h) {
				$(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
			},
			closed:function(){
			}
		});
	}
	// 知会记录 标为已读
	function markAsRead(flowBusinessApprovalId){
		$.post("${ctx}/eflow/flowBusiness/markAsRead",
			{"flowBusinessApprovalId":flowBusinessApprovalId},
			function(data){
				showMessage(data.message);
				page();
			},
			"json"
		)
	}
</script>