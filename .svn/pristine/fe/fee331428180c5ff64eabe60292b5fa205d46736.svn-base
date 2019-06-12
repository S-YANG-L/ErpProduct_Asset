<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="流程委托管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 流程委托管理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="eflow:flowAgent:edit">
				<a href="${ctx}/eflow/flowAgent/form" class="btn btn-default btn-sm btnTool" title="新增流程委托"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="flowAgent" action="${ctx}/eflow/flowAgent/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">委托开始时间：</label>
				<div class="input-inline">
					<input name="agentStartDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-120"
						value="<fmt:formatDate value="${flowAgent.agentStartDate}" pattern="yyyy-MM-dd HH:mm"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">委托结束时间：</label>
				<div class="input-inline">
					<input name="agentEndDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-120"
						value="<fmt:formatDate value="${flowAgent.agentEndDate}" pattern="yyyy-MM-dd HH:mm"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">委托关系：</label>
				<div class="input-inline">
					<form:select path="agentRelation" cssClass="form-control width-120">
						<form:options items="${fns:getDictList('flow_agent_relation')}" itemLabel="label" itemValue="value"/>
					</form:select>
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
			{header:'委托人', name:'createByName', index:'a.create_by', width:200, align:"center", frozen:true},
			{header:'受委托人', name:'agentUserName', index:'a.agent_user_name', width:200, align:"center", frozen:true},
			{header:'委托开始时间', name:'agentStartDate', index:'a.agent_start_date', width:200, align:"center"},
			{header:'委托结束时间', name:'agentEndDate', index:'a.agent_end_date', width:200, align:"center"},
			{header:'状态', name:'statusName', index:'a.status', width:200, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false, align:"center", formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="eflow:flowAgent:edit">
				// 创建者和当前用户是一个，则允许编辑
				if (row.createByCode == '${fns:getUser().userCode}'){
					actions.push('<a href="${ctx}/eflow/flowAgent/form?id='+row.id+'" class="btnList" title="编辑流程委托"><i class="fa fa-pencil"></i></a>&nbsp;');
					if(row.status == "0"){
						actions.push('<a href="${ctx}/eflow/flowAgent/cancelAgent?id='+row.id+'" class="btnList" title="取消授权" data-confirm="确认要取消授权吗？"><i class="fa fa-close"></i></a>&nbsp;');
					}else{
						actions.push('<a href="${ctx}/eflow/flowAgent/renewAgent?id='+row.id+'" class="btnList" title="重新授权" data-confirm="确认要重新授权吗？"><i class="fa fa-check"></i></a>&nbsp;');
					}
					actions.push('<a href="${ctx}/eflow/flowAgent/delete?id='+row.id+'" class="btnList" title="删除该流程委托" data-confirm="确认要删除该流程委托吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>