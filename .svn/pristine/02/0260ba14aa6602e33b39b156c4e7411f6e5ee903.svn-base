<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="计提折旧" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>计提折旧</div>
        <div class="actions">
            <shiro:hasPermission name="assetdepre:assetDepre:edit">
                <c:choose>
                    <c:when test="${assetDepre.assetType==0}">
                        <button class="btn btn-default" id="mentionSubmit"><i
                                class="fa fa-plus"></i>计提</button>
                    </c:when>
                </c:choose>
            </shiro:hasPermission>
        </div>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="assetDepre" action="${ctx}/assetdepre/assetDepre/save" method="post"
                   class="form-horizontal">
            <div class="form-body">
                <form:hidden path="sysId"/>
                <form:hidden path="topSortCode"/>
                <form:hidden path="currYear"/>
                <form:hidden path="currMonth"/>
                <div class="ml10 mr10">
                    <table id="assetDepreDtlDataGrid"></table>

                </div>
            </div>
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/js/pubnew.js" type="text/javascript"></script>
<script type="text/javascript">
    //初始化资产折旧子表DataGrid对象
    var voucherList=${fns:toJson(assetDepreDtlList)};
    $("#assetDepreDtlDataGrid").dataGrid({
        data: ${fns:toJson(assetDepreDtlList)},
        datatype: "local", // 设置本地数据
        showFooter: true,	// 是否显示底部合计行
        shrinkToFit: false,
        // 设置数据表格列
        columnModel: [
            {
                header: '资产大类',
                name: 'topSortName',
                width: 150,fixed:true,
                editoptions: {'maxlength': '100', 'class': 'form-control'}
            },
            {
                header: '资产小类编码',
                name: 'sortCode',
                hidden: true,
                width: 150,fixed:true,
                editoptions: {'maxlength': '64', 'class': 'form-control'}
            },
            {header: '资产小类', name: 'sortName', width: 150, editoptions: {'maxlength': '100', 'class': 'form-control'}},
            {
                header: '资产编码',
                name: 'assetCode',
                hidden: true,
                width: 150,fixed:true,
                editoptions: {'maxlength': '64', 'class': 'form-control'}
            },
            {header: '资产名称', name: 'assetName', width: 150, editoptions: {'maxlength': '100', 'class': 'form-control'}},
            {
                header: '资产大类编码',
                name: 'topSortCode',
                hidden: true,
                width: 150,fixed:true,
                editoptions: {'maxlength': '64', 'class': 'form-control'}
            },
            {header: '品牌', name: 'brand', width: 100,fixed:true, editoptions: {'maxlength': '100', 'class': 'form-control'}},
            {header: '型号', name: 'version', width: 150,fixed:true, editoptions: {'maxlength': '64', 'class': 'form-control'}},
            {
                header: '折旧方法', name: 'accountComStatus', width: 100,fixed:true, editoptions: {'class': 'form-control digits'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    if (val == 0) {
                        val = "折旧中";
                    }
                    else if (val == 1) {
                        val = "折旧完成";
                    }
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '开始使用时间', name: 'buyDate', width: 150,fixed:true,
                formatter: 'date', formatoptions: {srcformat: 'Y-m-d', newformat: 'Y-m-d'},
                editoptions: {
                    'class': 'form-control Wdate', 'readonly': 'true',
                    dataInit: function (element) {
                        $(element).on('focus', function () {
                            WdatePicker({dateFmt: 'yyyy-MM-dd', isShowClear: false});
                        });
                    }
                }
            },
            {header: '使用期限', name: 'ageLimit', width: 100,align: "center",fixed:true, editoptions: {'class': 'form-control digits'}},
            {header: '已计提月份', name: 'accountQuantity', width: 100,align: "center",fixed:true, editoptions: {'class': 'form-control number'}},
            {
                header: '原值',
                name: 'unitPrice',
                width: 150,
                align: "right",fixed:true,
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
                width: 150,
                align: "right",fixed:true,
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
                width: 150,
                align: "right",fixed:true,
                editoptions: {'class': 'form-control number'}
            },
            {
                header: '累计折旧',
                name: 'addAccount',
                width: 150,
                align: "right",fixed:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="addAccount" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },
                editoptions: {'class': 'form-control number'}
            },
            {header: '净值', name: 'netPrice', width: 150, align: "right",fixed:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="netPrice" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },editoptions: {'class': 'form-control number'}},
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $('#assetDepreDtlDataGrid');
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
            }
            var unitPriceall= 0;
            $("#assetDepreDtlDataGrid").find("input[name$='unitPrice']").each(function () {
                unitPriceall = unitPriceall.add(Number($(this).val()));
            });
            var accountThisMonthall = 0;
            $("#assetDepreDtlDataGrid").find("input[name$='accountThisMonth']").each(function () {
                accountThisMonthall = accountThisMonthall.add(Number($(this).val()));
            });
            var addAccountall= 0;
            $("#assetDepreDtlDataGrid").find("input[name$='addAccount']").each(function () {
                addAccountall = addAccountall.add(Number($(this).val()));
            });
            var  netPriceall=0;
            $("#assetDepreDtlDataGrid").find("input[name$='netPrice']").each(function () {
                netPriceall = netPriceall.add(Number($(this).val()));
            });
            $('#assetDepreDtlDataGrid').dataGrid("footerData", "set", {
                'topSortName': '<em class="pull-left">合计：&nbsp;</em>',
                'unitPrice': '<em class="pull-right">' +parseMoney(unitPriceall) + '</em>',
                'accountThisMonth': '<em class="pull-right">' +parseMoney(accountThisMonthall) + '</em>',
                'addAccount': '<em class="pull-right">' +parseMoney(addAccountall)+ '</em>',
                'netPrice': '<em class="pull-right">' + parseMoney(netPriceall)+ '</em>'
            }, false);
        }
    });
    $("#inputForm").validate({
        submitHandler: function (form) {
            ajaxSubmitForm($(form), function (data) {
                showMessage(data.message);
                if (data.result == Global.TRUE) {
                    closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                        contentWindow.page();
                    });
                }
            }, "json");
        }
    });

    <%--&lt;%&ndash;//提交前更新列表字段名字，以方便后台接受&ndash;%&gt;--%>
    <%--&lt;%&ndash;function mentionSubmit() {&ndash;%&gt;--%>
        <%--&lt;%&ndash;var isurl = "${ctx}/assetdepre/assetDepre/isJudge?currYear=" + $("#currYear").val() + "&currMonth=" + $("#currMonth").val();&ndash;%&gt;--%>
        <%--&lt;%&ndash;$.ajax({&ndash;%&gt;--%>
            <%--&lt;%&ndash;async: false, type: "POST", url: isurl, dataType: 'json', success: function (data) {&ndash;%&gt;--%>
                <%--&lt;%&ndash;if (data.message == "success") {&ndash;%&gt;--%>
                <%--&lt;%&ndash;} else {&ndash;%&gt;--%>
                    <%--&lt;%&ndash;showMessage("上个月没有提计");&ndash;%&gt;--%>
                <%--&lt;%&ndash;}&ndash;%&gt;--%>
            <%--&lt;%&ndash;}&ndash;%&gt;--%>
        <%--&lt;%&ndash;});&ndash;%&gt;--%>

        <%--var isurl = "${ctx}/assetdepre/assetDepre/isJudge?currYear=" + $("#currYear").val() + "&currMonth=" + $("#currMonth").val();--%>
        <%--$.post(isurl, function (data) {--%>
            <%--if (data.message == "success") {--%>

            <%--} else {--%>
                <%--showMessage("上个月没有提计");--%>
            <%--}--%>
        <%--}, "json");--%>

    <%--&lt;%&ndash;}&ndash;%&gt;--%>
    //提交提计
    $("#mentionSubmit").click(function () {
        console.log("asdad",voucherList);
        if(voucherList==null||voucherList==''){
            showMessage("没有资产不能提计");
        }else{
            var isurl = "${ctx}/assetdepre/assetDepre/isJudge?currYear=" + $("#currYear").val() + "&currMonth=" + $("#currMonth").val()+"&topSortCode="+$("#topSortCode").val();
            $.post(isurl, function (data) {
             //   if (data.message == "success") {
                    var url = "${ctx}/assetdepre/assetDepre/mentionSubmit?sysId=" + $("#sysId").val();
                    $.post(url, function (data) {
                        if (data.message == "success") {
                            showMessage("计提成功");
                            closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                                contentWindow.page();
                            });
                        } else {
                            showMessage(data.false);
                        }
                    }, "json");
                // } else {
                //     showMessage("上个月没有提计");
                // }
            }, "json");
        }




    })

</script>