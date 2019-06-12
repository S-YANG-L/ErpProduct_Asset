<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="按钮详细配置" extLibs="${extLibs}" />
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
		<div class="caption"><i class="fa fa-coffee"></i> 按钮详细配置</div>
	</div>
	<div class="portlet-tabs">
		<ul class="nav nav-tabs">
			<li><a id="btn_portlet_tab6" href="${ctx}/form/formQueryDataScope/form?queryId=${formQueryButton.queryId}">数据权限配置</a></li>
			<li><a id="btn_portlet_tab5" href="${ctx}/form/formQueryPermi/list?queryId=${formQueryButton.queryId}">按钮权限配置</a></li>
			<li><a id="btn_portlet_tab4" href="${ctx}/form/formQuery/formDataGridOptions?queryId=${formQueryButton.queryId}">表格选项配置</a></li>
			<li class="active"><a id="btn_portlet_tab3" href="javascript:void(0);">按钮详细配置</a></li>
			<li><a id="btn_portlet_tab2" href="${ctx}/form/formQueryColumn/list?queryId=${formQueryButton.queryId}">列表字段配置</a></li>
			<li><a id="btn_portlet_tab1" href="${ctx}/form/formQuery/form?queryId=${formQueryButton.queryId}">&lt;&lt;基本信息</a></li>
		</ul>
		<div class="tab-content1">
			<div class="tab-pane active" id="portlet_tab3">
				 <div id="content" class="row-fluid">
					<div id="left">
						<div class="portlet box white autoHeight">
							<form:form id="searchForm" modelAttribute="formQueryButton" action="${ctx}/form/formQueryButton/listData" method="post" class="breadcrumb form-inline hide"
								data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
								<form:hidden path="queryId" />
							</form:form>
							<table id="dataGrid"></table>
						</div>
					</div>
					<div id="right">
						<iframe id="mainFrame" name="mainFrame" src="${ctx}/form/formQueryButton/form?queryId=${formQueryButton.queryId}"
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
			{header:'按钮表id', name:'id', index:'a.id', width:200 ,hidden:true},
			{header:'查询列表编号', name:'queryId', index:'a.query_id', width:200 ,hidden:true},
			{header:'按钮类型', name:'btnType',sortable:false, width:200 ,hidden:true,formatter: function(val, obj, row, act){
				if(val=='0'){
					return "顶部按钮";
				}else return "操作按钮";
			}},
			{header:'按钮id', name:'btnId', sortable:false, width:200, align:"left"},
			{header:'按钮名称', name:'btnName', sortable:false, width:200, align:"center"},
		],
		//分组设置
		grouping: true,
	    groupingView: {
	        groupField: ["btnType"],
	        groupColumnShow: [false],
	        groupText: ["<b>{0}</b>"],
	        groupOrder: ["asc"],
	        groupSummary: [false],
	        groupCollapse: false
	    }, 
	    onSelectRow: function(id, isSelect, event){
			var rowData = $('#dataGrid').jqGrid('getRowData',id);
			$('#mainFrame').attr("src", '${ctx}/form/formQueryButton/form?id='+id);
			$(window).resize();
		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			setTimeout(function(){
				$(window).resize().resize();
			},100);
		}
	});
	
	// 框架布局调整
	var leftWidth = "30%"; // 左侧窗口大小
	var wSize = function(){
		var heightWidth = getWindowSize().toString().split(",");
		$("#right").width(heightWidth[1] - $("#left").width() - 25);
		$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
	}	
	$(window).resize(function(){
		$('#mainFrame').height($('#searchForm').parent().height());
	});
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>