<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="表单查询列管理" extLibs="${extLibs}" />
<style>
<!--
.ui-jqgrid-bdiv{height: 100%;}
-->

.portlet.box.default .portlet-tabs>.tab-content1 {
    padding: 0 0 10px 0!important;
}
.portlet-tabs>.tab-content1 {
    margin: 0;
    margin-top: -52px!important;
}
</style>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 查询列表字段配置</div>
	</div>
	<div class="portlet-tabs">
		<ul class="nav nav-tabs">
			<li><a id="btn_portlet_tab6" href="${ctx}/form/formQueryDataScope/form?queryId=${formQueryColumn.queryId}">数据权限配置</a></li>
			<li><a id="btn_portlet_tab5" href="${ctx}/form/formQueryPermi/list?queryId=${formQueryColumn.queryId}">按钮权限配置</a></li>
			<li><a id="btn_portlet_tab4" href="${ctx}/form/formQuery/formDataGridOptions?queryId=${formQueryColumn.queryId}">表格选项配置</a></li>
			<li><a id="btn_portlet_tab3" href="${ctx}/form/formQueryButton/list?queryId=${formQueryColumn.queryId}">按钮详细配置</a></li>
			<li class="active"><a id="btn_portlet_tab2" href="javascript:void(0);">列表字段配置</a></li>
			<li><a id="btn_portlet_tab1" href="${ctx}/form/formQuery/form?queryId=${formQueryColumn.queryId}">&lt;&lt;基本信息</a></li>
		</ul>
		<div class="tab-content1">
			<div class="tab-pane active" id="portlet_tab2">
				<div id="content" class="row-fluid">
					<div id="left">
						<div class="portlet box white autoHeight">
							<form:form id="searchForm" modelAttribute="formQueryColumn" action="${ctx}/form/formQueryColumn/listData" method="post" class="breadcrumb form-inline"
								data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
								<form:hidden path="queryId" />
								<form:hidden path="isShow" value="0"/>
								<div class="form-group">
									<label class="control-label">列名：</label>
									<div class="input-inline">
										<form:input path="columnName" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
									</div>
								</div>
								<div class="form-group" style="margin-left:10px;"> 
									<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
								</div>
							</form:form>
							<table id="dataGrid"></table>
						</div>
					</div>
					<div id="right">
						<iframe id="mainFrame" name="mainFrame" src="${ctx}/form/formQueryColumn/form"
									style="overflow:visible;" scrolling="yes" frameborder="no" width="100%"></iframe>
					</div>
				</div>
			</div>
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
			{header:'查询列表编号', name:'id', index:'a.id', width:200 ,hidden:true},
			{header:'查询列表编号', name:'queryId', index:'a.query_id', width:200 ,hidden:true},
			{header:'表名', name:'tableName', index:'a.table_name', width:200, align:"left"},
			{header:'列描述', name:'columnComment', index:'a.column_comment', width:200, align:"center"},
			{header:'列名', name:'columnName', index:'a.column_name', width:200, align:"center"}
		],
		//分组设置
		grouping: true,
	    groupingView: {
	        groupField: ["tableName"],
	        groupColumnShow: [false],
	        groupText: ["<b>{0}</b>"],
	        groupOrder: ["desc"],
	        groupSummary: [false],
	        groupCollapse: false
	    }, 
	    onSelectRow: function(id, isSelect, event){
			var rowData = $('#dataGrid').jqGrid('getRowData',id);
			$('#mainFrame').attr("src", '${ctx}/form/formQueryColumn/form?id='+id+'&tableName='+rowData.tableName);
			$(window).resize();
		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			setTimeout(function(){
				$(window).resize().resize();
			},100);
		}
	});// 框架布局调整
	var leftWidth = "30%"; // 左侧窗口大小
	var wSize = function(){
		var heightWidth = getWindowSize().toString().split(",");
		$("#right").width(heightWidth[1] - $("#left").width() - 25);
		$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
	}
	 
	
	$(window).resize(function(){
		$('#mainFrame').height($('#searchForm').parent().height());
		//$('#mainFrame').height("440px");
	});
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>