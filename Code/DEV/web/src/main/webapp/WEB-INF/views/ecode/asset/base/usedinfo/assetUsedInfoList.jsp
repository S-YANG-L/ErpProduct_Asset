<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="资产领用管理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> 资产领用</div>
        <div class="actions">
            <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
            <shiro:hasPermission name="usedinfo:assetUsedInfo:edit">
                <a href="${ctx}/usedinfo/assetUsedInfo/form" class="btn btn-default btn-sm btnTool" title="新增资产领用"><i
                        class="fa fa-plus"></i> 新增</a>
            </shiro:hasPermission>
        </div>
    </div>
    <div class="nav_right nav2">
        <ul id="myTab" class="nav nav-tabs nav-top">
            <li class="active"><a href="${ctx}/usedinfo/assetUsedInfo/list" data-toggle="a">领用</a></li>
            <li><a href="${ctx}/cancelstocks/assetReturnInfo/list" data-toggle="e">退库</a></li>
        </ul>
    </div>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetUsedInfo" action="${ctx}/usedinfo/assetUsedInfo/listData"
                   method="post" class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">审批状态：</label>
                <div class="input-inline">
                    <form:select path="approvalStatus" class="form-control input-sm width-160">
                        <form:option value="" label="全部"/>
                        <form:option value="2" label="已审批"/>
                        <form:option value="1" label="未审批"/>
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
                header: '状态',
                name: 'approvalStatus',
                index: 'a.approval_status',
                width: 100,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var approvalStatus = ["撤回", "审批中", "审批完成", "拒绝"]
                    return approvalStatus[row.approvalStatus]
                }
            },
            {header: '领用人', name: 'receiverName', index: 'a.receiver_name', width: 150, align: "left"},
            {header: '领用日期', name: 'receiverDate', index: 'a.receiver_date', width: 200, align: "left"},
            {header: '部门名称', name: 'usedOfficeName', index: 'a.used_office_name', width: 150, align: "left"},
            {
                header: '操作',
                name: 'actions',
                width: 100,
                fixed: true,
                sortable: false,
                align: "center",
                formatter: function (val, obj, row, act) {
                    var actions = [];//<shiro:hasPermission name="usedinfo:assetUsedInfo:edit">
                    if (row.status == Global.STATUS_NORMAL) {
                        actions.push('<a href="${ctx}/usedinfo/assetUsedInfo/form?id=' + row.id + '" class="btnList" title="查看资产领用"><i class="fa fa-pencil"></i></a>&nbsp;');
                        //actions.push('<a href="${ctx}/usedinfo/assetUsedInfo/delete?id='+row.id+'" class="btnList" title="删除该资产领用" data-confirm="确认要删除该资产领用吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    }//</shiro:hasPermission>
                    return actions.join('');
                }
            }
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法
        }
    });
</script>