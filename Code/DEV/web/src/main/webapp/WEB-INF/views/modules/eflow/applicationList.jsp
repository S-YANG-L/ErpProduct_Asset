<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="我的申请" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 我的申请</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="eflow:flowLog:edit">
				<a href="${ctx}/eflow/flowLog/form" class="btn btn-default btn-sm btnTool" title="新增申请"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="FlowLog" action="${ctx}/eflow/flowLog/findapplicationList" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label"> 业务：</label>
				<form:select path="billtypeCode" class="form-control width-120 input-sm"  >
					<form:option  value="">全部</form:option>
					<form:options items="${fns:getDictList('eflow_bill_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="form-group">
				<label>发起时间：&nbsp;</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate2"
				value="<fmt:formatDate value="${flowLog.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				<label>&nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;</label><input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate2"
				value="<fmt:formatDate value="${flowLog.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
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
		    {header:'申请人', name:'applicantCode', index:'a.applicant_code', width:100, align:"left",hidden:true},
			{header:'业务', name:'billtypeName', index:'a.billtype_name', width:90, align:"center"},
			{header:'单号', name:'bizKey', index:'a.biz_key', width:150, align:"left", formatter: function(val, obj, row, act){
				return '<a href="${ctx}'+row.linkUrlPc+"&pageFlag=0"+'" class="btnList" data-title="单据详情">'+ val +'</a>';
			}},
			{header:'业务描述', name:'content', index:'a.content', width:250, align:"left"},
			{header:'发起时间', name:'billDate', index:'a.bill_date', width:150, align:"center"},
			{header:'当前步骤', name:'stepName', index:'stepName', width:130, align:"left"},
			{header:'到达时间', name:'arriveDate', index:'c.arrive_date', width:150, align:"center"},
			{header:'操作', name:'actions', width:80,align:"center",fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
				//	actions.push('<a href="${ctx}/eflow/flowBusiness/unSubmit?bizKey='+row.bizKey+'" class="btnList" title="撤回" data-confirm="确认要撤回申请吗？"><i class="fa fa-mail-reply"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/eflow/flowLog/list?bizKey='+row.bizKey+'" class="btnList" title="流程跟踪" ><i class="fa  fa-bullseye" ></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>