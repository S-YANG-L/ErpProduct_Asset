<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="资产还原" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 资产还原</div>
		<div class="actions">
		</div>
	</div>
	<div class="nav_right nav2">
    <ul id="myTab" class="nav nav-tabs nav-top">
					<li ><a href="${ctx}/assetsclean/assetClean/list" data-toggle="a">清理</a></li>
					<li class="active" ><a href="${ctx}/assetsclean/assetClean/list2" data-toggle="e">还原</a></li>	
				</ul>
    </div>
	<div class="portlet-body list">
			<form:form id="searchForm" modelAttribute="assetInfo" action="${ctx}/assetsclean/assetClean/listDataCode?assetCode=${assetInfo.assetCode}&assetStatus=4"
					   method="post" class="breadcrumb form-inline hide"
					   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
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
            {header:'状态', name:'assetStatus', index:'a.asset_status', width:150, align:"left",formatter: function(val, obj, row, act){
                    var Status = ["闲置","领用","借用","维修","报废"]
                    return Status[row.assetStatus]
                }},
            {header:'资产编码', name:'assetCode', index:'a.asset_code', width:200, align:"left"},
            {header:'资产名称', name:'assetName', index:'a.asset_name', width:200, align:"left"},
            {header:'资产分类编码', name:'sortCode',hidden:true, index:'a.sort_code', width:200, align:"left"},
            {header:'资产小类', name:'sortName', index:'a.sort_name', width:200, align:"left"},
            {header:'型号', name:'version', index:'a.version', width:200, align:"left"},
            {header:'公司名称', name:'companyName', hidden:true, index:'a.company_name', width:200, align:"left"},
            {header:'使用部门', name:'officeName', index:'a.office_name', width:200, align:"left"},
            // {header:'区域名称', name:'regionName', index:'a.region_name', width:200, align:"left"},
            {header:'责任人名称', name:'dutyName', hidden:true, index:'a.duty_name', width:200, align:"left"},
            {header:'存放地点', name:'storagePlace', index:'a.storage_place', width:200, align:"left"},
            {header:'行数据', name:'rowData', hidden:true, formatter: function(val, obj, row, act){
                    return JSON.stringify(row);
                }},
            {header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
                    var actions = [];
                    if (row.status == Global.STATUS_NORMAL){
                        actions.push('<a href="${ctx}/assetsclean/assetClean/update1?assetCode='+row.assetCode+'" class="btnList" title="资产还原" data-confirm="确认要还原该资产吗？"><i class="fa fa-external-link"></i></a>&nbsp;');
                    }
                    return actions.join('');
                }}
        ],
		ajaxSuccess: function(data){ // 加载成功后执行方法

		}
	});
</script>