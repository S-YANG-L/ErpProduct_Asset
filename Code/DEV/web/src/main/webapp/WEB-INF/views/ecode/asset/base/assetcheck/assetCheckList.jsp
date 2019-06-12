<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="资产盘点管理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> 资产盘点管理</div>
        <div class="actions">
            <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
            <shiro:hasPermission name="assetcheck:assetCheck:edit">
                <a href="${ctx}/assetcheck/assetCheck/form" class="btn btn-default btn-sm btnTool" title="新增资产盘点"><i
                        class="fa fa-plus"></i> 新增</a>
            </shiro:hasPermission>
        </div>
    </div>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetCheck" action="${ctx}/assetcheck/assetCheck/listData"
                   method="post" class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">盘点单名称：</label>
                <div class="input-inline">
                    <form:input path="chackName" htmlEscape="false" maxlength="255"
                                class="form-control input-sm width-160"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label">起止日期：</label>
                <div class="input-inline">
                    <input name="beginDate" id="beginDate" type="text" readonly="readonly" maxlength="20"
                           class="form-control input-sm Wdate width-150"
                           value="<fmt:formatDate value="${recipients.beginDate}" pattern="yyyy-MM-dd"/>"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>-
                    <input name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
                           class="form-control input-sm Wdate width-150"
                           value="<fmt:formatDate value="${recipients.endDate}" pattern="yyyy-MM-dd"/>"
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
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    // 初始化DataGrid对象
    $("#dataGrid").dataGrid({

        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        shrinkToFit: false,
        // 设置数据表格列
        columnModel: [
            {
                header: '盘点单编码',
                name: 'chackCode',
                index: 'a.chack_code',
                width: 200,
                align: "left",
                frozen: true,
                formatter: function (val, obj, row, act) {
                    return '<a href="${ctx}/assetcheck/assetCheck/form?id=' + row.id + '" class="btnList" data-title="编辑资产盘点">' + (val ? val : row.id) + '</a>';
                }
            },
            {header: '盘点单名称', name: 'chackName', index: 'a.chack_name', width: 200, align: "left", frozen: true},
            {header: '发起人', name: 'handleName', index: 'a.handle_name', width: 150, align: "center"},
            {header: '发起时间', name: 'handleTime', index: 'a.handle_time', width: 200, align: "center"},
            {
                header: '操作',
                name: 'actions',
                width: 100,
                fixed: true,
                sortable: false,
                align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];//<shiro:hasPermission name="assetcheck:assetCheck:edit">
                    if (row.status == Global.STATUS_NORMAL) {
                        actions.push('<a href="${ctx}/assetcheck/assetCheck/form?id=' + row.id + '" class="btnList" title="盘点结果"><i class="fa fa-pencil"></i></a>&nbsp;');
                       // actions.push('<a href="${ctx}/assetcheck/assetCheck/delete?id=' + row.id + '" class="btnList" title="删除该资产盘点" data-confirm="确认要删除该资产盘点吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    }//</shiro:hasPermission>
                    return actions.join('');
                }
            }
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法

        }
    });
</script>