<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="测试工作流" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 测试工作流</div>
		<div class="actions">
		    <a href="${ctx}/test/testFlow/form" class="btn btn-default btn-sm btnTool" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		 <form:form id="searchForm" modelAttribute="testFlow" action="${ctx}/test/testFlow/listData" method="post" class="breadcrumb form-inline hide" > 
			<div class="form-group">
					<label class="control-label" title="">申请人：</label>
					<div class="input-inline">
						<form:input path="applicantName" />
					</div>
				</div>
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置" />
			</div>
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">	
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		columnModel: [
			{header:'单号', name:'id', index:'a.id', width:140, align:"center",formatter: function(val, obj, row, act){
				return '<a href="${ctx}/test/testFlow/form?id='+row.id+'" class="btnList" title="编辑测试工作流">'+row.id+'</a>';
			}},
			{header:'单据日期', name:'billDate', index:'a.bill_date', width:80, align:"center"},
			{header:'单据类型', name:'billtypeCode', index:'a.billtype_code', width:80, align:"center",formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('eflow_bill_type')},val,'', true);}},
			{header:'申请人', name:'applicantName', index:'a.applicant_name', width:80, align:"left"},
			{header:'部门', name:'officeName', index:'a.office_name', width:100, align:"left"},
		    {header:'公司', name:'companyName', index:'a.company_name',align:"left", width:100},
		    {header:'金额', name:'billAmt', index:'a.bill_amt',align:"right", width:80}, 
		    {header:'业务描述', name:'remarks', index:'a.remarks',align:"left", width:140},
		    {header:'操作', name:'actions', width:80, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){	
					actions.push('<a href="${ctx}/test/testFlow/form?id='+row.id+'" class="btnList" title="编辑测试工作流"><i class="fa fa-pencil"></i></a>&nbsp;');				
					actions.push('<a href="${ctx}/test/testFlow/delete?id='+row.id+'" class="btnList" title="删除" data-confirm="确认要删除该数据吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		], 
		ajaxSuccess: function(data){ // 加载成功后执行方法
		}        
	});


	
</script>