<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="资产清理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 资产清理</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
				<a href="${ctx}/assetsclean/assetClean/form" class="btn btn-default btn-sm btnTool" title="新增资产清理"><i class="fa fa-plus"></i> 新增</a>

			<%--<a href="${ctx}/assetsclean/assetClean/list2" class="btn btn-default btn-sm btnTool" title="资产还原"><i class="fa fa-external-link"></i> 还原</a>--%>

		</div>
	</div>
	<div class="nav_right nav2">
    <ul id="myTab" class="nav nav-tabs nav-top">
					<li  class="active"><a href="${ctx}/assetsclean/assetClean/list" data-toggle="a">清理</a></li>
					<li ><a href="${ctx}/assetsclean/assetClean/list2" data-toggle="e">还原</a></li>	
				</ul>
    </div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="assetClean" action="${ctx}/assetsclean/assetClean/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">清理年月：</label>
				<div class="input-inline">
					<input name="beginDate" id="beginDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						   value="<fmt:formatDate value="${assetClean.beginDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>-
					<input name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						   value="<fmt:formatDate value="${assetClean.endDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,minDate:'#F{$dp.$D(\'beginDate\')}'});"/>
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
        shrinkToFit: false,
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		// 设置数据表格列
		columnModel: [
			{header:'清理编码', name:'cleanCode', index:'a.clean_code', width:200, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/assetsclean/assetClean/form?id='+row.id+'" class="btnList" data-title="编辑资产清理">'+(val ? val : row.id)+'</a>';
			}},
			{header:'清理人', name:'cleanerName', index:'a.cleaner_name', width:150, align:"center"},
			{header:'清理日期', name:'cleanDate', index:'a.clean_date', width:200, align:"center"},
			{header:'操作', name:'actions', width:100, fixed:true, sortable:false,align:"center",formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/assetsclean/assetClean/form?id='+row.id+'" class="btnList" title="查看资产清理"><i class="fa fa-pencil"></i></a>&nbsp;');
			//		actions.push('<a href="${ctx}/assetsclean/assetClean/delete?id='+row.id+'" class="btnList" title="删除该资产清理" data-confirm="确认要删除该资产清理吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
</script>