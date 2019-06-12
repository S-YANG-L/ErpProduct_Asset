<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="分类使用情况详情" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>分类使用情况详情</div>
    </div>
    <sys:message content="${message}"></sys:message>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetInfo" action="${ctx}/ass/assetInfo/listData" method="post"
                   class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <form:hidden path="topSortCode"/>
            <form:hidden path="assetStatus"/>
            <form:hidden path="office.officeCode"/>
        </form:form>
        <table id="dataGrid"></table>
        <div id="dataGridPage"></div>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/layer/layer.js" type="text/javascript"></script>
<script type="text/javascript">
    // 初始化DataGrid对象
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        // 设置数据表格列
        columnModel: [
            {header: '资产大类', name: 'topSortName', index: 'a.top_sort_name', width: 200, align: "left"},
            {header: '资产小类', name: 'sortName', index: 'a.sort_name', width: 200, align: "left"},
            {header: '资产编码', name: 'assetCode', index: 'a.asset_code', width: 200, align: "left"},
            {header: '资产名称', name: 'assetName', index: 'a.asset_name', width: 200, align: "left"},
            {header: '型号', name: 'version', index: 'a.version', width: 200, align: "left"},
            {header: '品牌', name: 'brand', index: 'a.brand', width: 200, align: "left"},
            {header: '原值', name: 'unitPrice', index: 'a.unit_price', width: 200, align: "right"},
            {header: '区域名称', name: 'regionName', index: 'a.region_name', width: 200, align: "center"},
            {header: '存放地点', name: 'storagePlace', index: 'a.storage_place', width: 200, align: "left"},
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法
        }
    });
</script>
