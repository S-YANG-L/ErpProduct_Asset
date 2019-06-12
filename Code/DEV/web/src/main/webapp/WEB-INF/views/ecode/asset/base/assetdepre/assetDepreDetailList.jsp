<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="计提折旧管理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>计提明细</div>
    </div>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetDepreDtl" action="${ctx}/assetdepre/assetDepre/listDataDetail"
                   method="post" class="breadcrumb form-inline"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">当前年：</label>
                <div class="input-inline">
                    <input id="currYear" name="currYear" type="text" readonly="readonly" maxlength="20"
                           class="form-control Wdate width-120"
                           value="<fmt:formatDate value="${assetDepreDtl.currYear}" pattern="yyyy"/>"
                           onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label">当前月：</label>
                <div class="input-inline">
                    <input id="currMonth" name="currMonth" type="text" readonly="readonly" maxlength="20"
                           class="form-control Wdate width-120"
                           value="<fmt:formatDate value="${assetDepreDtl.currMonth}" pattern="MM"/>"
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
        shrinkToFit: false,
        showFooter: true,	// 是否显示底部合计行
        // 设置数据表格列
        columnModel: [
            {header:'资产大类编码', name:'topSortCode', hidden: true,width:150,  editoptions:{'maxlength':'64', 'class':'form-control'}},
            {header:'资产大类', name:'topSortName', width:150,hidden: true,   editoptions:{'maxlength':'100', 'class':'form-control'}},
            {header:'资产小类编码', name:'sortCode',hidden: true, width:150,  editoptions:{'maxlength':'64', 'class':'form-control'}},
            {header:'资产小类', name:'sortName', width:150,  editoptions:{'maxlength':'100', 'class':'form-control'}},
            {header:'资产编码', name:'assetCode',hidden: true, width:150, editoptions:{'maxlength':'64', 'class':'form-control'}},
            {header:'资产名称', name:'assetName', width:150, editoptions:{'maxlength':'100', 'class':'form-control'}},
            {header:'品牌', name:'brand', width:100,  editoptions:{'maxlength':'100', 'class':'form-control'}},
            {header:'型号', name:'version', width:150,  editoptions:{'maxlength':'64', 'class':'form-control'}},
            {header:'折旧方法', name:'accountComStatus', width:100,editoptions:{'class':'form-control digits'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    if (val == 0) {
                        val = "折旧中";
                    }
                    else if(val == 1) {
                        val = "折旧完成";
                    }
                    actions.push(val);
                    return actions.join('');
                }},
            {header:'开始使用时间', name:'buyDate', width:150,
                formatter:'date', formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},
                editoptions:{'class':'form-control Wdate', 'readonly':'true',
                    dataInit: function(element){ $(element).on('focus', function(){
                        WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});
                    });
                    }}
            },
            {header:'使用期限', name:'ageLimit', width:100, align: "center", editoptions:{'class':'form-control digits'}},
            {header:'已计提月份', name:'accountQuantity', width:100, align: "center", editoptions:{'class':'form-control number'}},
            {
                header: '原值',
                name: 'unitPrice',
                width: 130,
                align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unitPrice" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },
                editoptions: {'class': 'form-control number'}
            },
            {
                header: '本月折旧',
                name: 'accountThisMonth',
                width: 130,
                align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="accountThisMonth" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },
                editoptions: {'class': 'form-control number'}
            },
            {header: '净残率(%)', name: 'residualValue', width: 100,align: "center", editoptions: {'class': 'form-control number'}},
            {
                header: '净残值',
                name: 'netSalvage',
                width: 130,
                align: "right",
                editoptions: {'class': 'form-control number'}
            },
            {
                header: '累计折旧',
                name: 'addAccount',
                width: 130,
                align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="addAccount" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },
                editoptions: {'class': 'form-control number'}
            },
            {header: '净值', name: 'netPrice', width: 130, align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="netPrice" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },editoptions: {'class': 'form-control number'}},
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $('#dataGrid');
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
            }
            var unitPriceall= 0;
            $("#dataGrid").find("input[name$='unitPrice']").each(function () {
                unitPriceall = unitPriceall.add(Number($(this).val()));
            });
            var accountThisMonthall = 0;
            $("#dataGrid").find("input[name$='accountThisMonth']").each(function () {
                accountThisMonthall = accountThisMonthall.add(Number($(this).val()));
            });
            var addAccountall= 0;
            $("#dataGrid").find("input[name$='addAccount']").each(function () {
                addAccountall = addAccountall.add(Number($(this).val()));
            });
            var  netPriceall=0;
            $("#dataGrid").find("input[name$='netPrice']").each(function () {
                netPriceall = netPriceall.add(Number($(this).val()));
            });
            $('#dataGrid').dataGrid("footerData", "set", {
                'topSortCode': '<em class="pull-left">合计：&nbsp;</em>',
                'unitPrice': '<em class="pull-right">' +parseMoney(unitPriceall) + '</em>',
                'accountThisMonth': '<em class="pull-right">' +parseMoney(accountThisMonthall) + '</em>',
                'addAccount': '<em class="pull-right">' +parseMoney(addAccountall)+ '</em>',
                'netPrice': '<em class="pull-right">' + parseMoney(netPriceall)+ '</em>'
            }, false);
        }
    });
</script>