<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="清理清单" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> 清理清单</div>
    </div>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetCleanDtl"
                   action="${ctx}/assetsclean/assetClean/assetCleanJilu?cleanCode=${assetCleanDtl.cleanCode}"
                   method="post" class="breadcrumb form-inline hide">
        </form:form>
        <table id="dataGrid"></table>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    $(document).ready(function () {
        // 初始化DataGrid对象
        $("#dataGrid").dataGrid({
            searchForm: $("#searchForm"), // 数据来源表单
            // 设置数据表格列
            columnModel: [
                {header: '清理人', name: 'cleanerName', index: 'a.cleaner_name', width: 200, align: "center"},
                {header: '清理人编码', name: 'cleanerCode', index: 'a.cleaner_code', width: 200, align: "center"},
                {header: '清理日期', name: 'cleanDate', index: 'a.clean_date', width: 200, align: "center"}
            ],
            ajaxSuccess: function (data) { // 加载成功后执行方法
            },
        });
    });
</script>