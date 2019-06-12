<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="计提折旧管理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>计提折旧管理</div>
        <div class="actions">
            <a href="#" class="btn btn-default btn-sm" id="btnJTAll" title="全部计提"><i class="fa fa-external-link"></i>全部计提</a>
        </div>
    </div>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetDepre" action="${ctx}/assetdepre/assetDepre/listData"
                   method="post" class="breadcrumb form-inline"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">当前年：</label>
                <div class="input-inline">
                    <input id="currYear" name="currYear" type="text" readonly="readonly" maxlength="20"
                           class="form-control Wdate width-120"
                           value="<fmt:formatDate value="${assetDepre.currYear}" pattern="yyyy"/>"
                           onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label">当前月：</label>
                <div class="input-inline">
                    <input id="currMonth" name="currMonth" type="text" readonly="readonly" maxlength="20"
                           class="form-control Wdate width-120"
                           value="<fmt:formatDate value="${assetDepre.currMonth}" pattern="MM"/>"
                           onclick="WdatePicker({dateFmt:'MM',isShowClear:false});"/>
                </div>
            </div>
            <div class="form-group" style="margin-left:10px;">
                <input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
                <input class="btn default btn-sm" type="reset" value="重置"/>
            </div>
        </form:form>
    </div>
    <div class="portlet-body list">
        <table id="dataGrid"></table>
        <div id="dataGridPage"></div>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/js/pubnew.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var year = new Date().format("yyyy");
        var month = new Date().format("MM");
        $("#currYear").val(year);
        $("#currMonth").val(month);
    });
    // 初始化DataGrid对象
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        autoGridHeight: function(){return '100%'},
        showFooter: true,	// 是否显示底部合计行
        shrinkToFit: false,
        // 设置数据表格列
        columnModel: [
            {
                header: '资产大类编码',
                name: 'topSortCode',
                index: 'a.top_sort_code',
                width: 200,
                align: "left",
                frozen: true,
                formatter: function (val, obj, row, act) {
                    return '<a href="${ctx}/assetdepre/assetDepre/form?sysId=' + row.sysId + '" class="btnList" data-title="编辑计提折旧">' + (val ? val : row.sysId) + '</a>';
                }
            },
            {header: '资产大类', name: 'topSortName', index: 'a.top_sort_name', width: 200, align: "left"},
            {header: '当前年', name: 'currYear', index: 'a.curr_year', width: 80, align: "center"},
            {header: '当前月', name: 'currMonth', index: 'a.curr_month', width: 80, align: "center"},
            {
                header: '本月折旧', name: 'mdepreValue', index: 'a.mdepre_value', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="mdepreValue" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }, align: "right"
            },
            {
                header: '计提状态',
                name: 'assetType',
                width: 100,
                align: "center",
                formatter: function (val, obj, row, act) {
                    var assetStatus = ["未计提", "已计提"]
                    return assetStatus[row.assetType]
                }
            },
            {
                header: '原值总和', name: 'originalValue', index: 'a.original_value', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="originalValue" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }, align: "right"
            },
            {
                header: '累计折旧总和',
                name: 'depreTotal',
                index: 'a.depre_total',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="depreTotal" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },
                align: "right"
            },
            {
                header: '净值总和',
                name: 'netsalvageValue',
                index: 'a.netsalvage_value',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="netsalvageValue" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },
                align: "right"
            },
            {
                header: '操作',
                name: 'actions',
                width: 50,
                fixed: true,
                align: "center",
                sortable: false,
                formatter: function (val, obj, row, act) {
                    var actions = [];//<shiro:hasPermission name="assetdepre:assetDepre:edit">
                    if (row.status == Global.STATUS_NORMAL) {
                        actions.push('<a href="${ctx}/assetdepre/assetDepre/form?sysId=' + row.sysId + '" class="btnList" title="编辑计提折旧"><i class="fa fa-pencil"></i></a>&nbsp;');
                        // actions.push('<a href="${ctx}/assetdepre/assetDepre/delete?sysId=' + row.sysId + '" class="btnList" title="删除该计提折旧" data-confirm="确认要删除该计提折旧吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    }//</shiro:hasPermission>
                    return actions.join('');
                }
            }
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $('#dataGrid');
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
            }
            var mdepreValueall = 0;
            $("#dataGrid").find("input[name$='mdepreValue']").each(function () {
                mdepreValueall = mdepreValueall.add(Number($(this).val()));
            });
            var originalValueall = 0;
            $("#dataGrid").find("input[name$='originalValue']").each(function () {
                originalValueall = originalValueall.add(Number($(this).val()));
            });
            var depreTotalall = 0;
            $("#dataGrid").find("input[name$='depreTotal']").each(function () {
                depreTotalall = depreTotalall.add(Number($(this).val()));
            });
            var netsalvageValueall = 0;
            $("#dataGrid").find("input[name$='netsalvageValue']").each(function () {
                netsalvageValueall = netsalvageValueall.add(Number($(this).val()));
            });
            $('#dataGrid').dataGrid("footerData", "set", {
                'topSortCode': '<em class="pull-left">合计：&nbsp;</em>',
                'mdepreValue': '<em class="pull-right">' + parseMoney(mdepreValueall) + '</em>',
                'originalValue': '<em class="pull-right">' + parseMoney(originalValueall) + '</em>',
                'depreTotal': '<em class="pull-right">' + parseMoney(depreTotalall) + '</em>',
                'netsalvageValue': '<em class="pull-right">' + parseMoney(netsalvageValueall) + '</em>'
            }, false);
        }
    });

    //全部计提
    $("#btnJTAll").click(function () {
        top.$.jBox.confirm("确定要全部计提吗", "提交结果提示", function (v, h, f) {
            if (v == "ok") {
                $.jBox.tip("正在计提数据请稍后...", 'loading');
                var url = "${ctx}/assetdepre/assetDepre/btnJTAll?currYear=" + $("#currYear").val() + "&currMonth=" + $("#currMonth").val();
                $.post(url,
                    function (data) {
                        if (data.message == "success") {
                            showMessage("计提成功");
                            $.jBox.closeTip();
                            $('#searchForm').submit();
                        } else {
                            showMessage(data.false);
                        }
                    }
                );
            }

        }, {buttonsFocus: 1});
        top.$('.jbox-body .jbox-icon').css('top', '55px');
    })

</script>