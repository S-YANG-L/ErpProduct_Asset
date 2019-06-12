<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="办公用品采购 - ${orderBill.isNewRecord ? '新增' : '编辑'}办公用品采购 " extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${orderBill.isNewRecord ? '新增' : '编辑'}办公用品采购</div>
        <div class="actions">
            <c:choose>
                <c:when test="${orderBill.isNewRecord == true}">
                    <button id="btnSubmit" type="button" class="btn btn-primary">
                        <i class="fa fa-reply-all"></i> 提 交
                    </button>
                </c:when>
                <c:when test="${orderBill.pageFlag==0&&orderBill.approvalStatus!=2}">
                    <!-- 我的申请 -->
                    <c:choose>
                        <c:when test="${orderBill.approvalStatus !=1}">
                            <button id="btnSubmit" type="button" class="btn btn-primary">
                                <i class="fa fa-check"></i> 提 交
                            </button>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${orderBill.approvalStatus !=0}">
                            <c:choose>
                                <c:when test="${orderBill.approvalStatus !=3}">
                                    <button id="btnUnSubmit" type="button"
                                            class="btn btn-primary">
                                        <i class="fa fa-reply-all"></i> 撤回申请
                                    </button>
                                </c:when>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </c:when>
                <c:when test="${orderBill.pageFlag == 1}">
                    <!-- 我的待办 -->
                    <c:choose>
                        <c:when test="${orderBill.step<2}">
                            <button id="btnAuditPass" type="button"
                                    class="btn btn-primary">
                                <i class="fa fa-check"></i></i> 审批通过
                            </button>
                            <button id="btnReject" type="button" class="btn btn-primary">
                                <i class="fa fa-times"></i> 驳回
                            </button>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${orderBill.step>=2}">
                            <button id="btnAuditPass" type="button"
                                    class="btn btn-primary">
                                <i class="fa fa-check"></i></i>确认
                            </button>
                        </c:when>
                    </c:choose>
                </c:when>
                <c:when test="${orderBill.pageFlag == 2}">
                    <!-- 我的已办 -->
                    <button id="btnUndo" type="button" class="btn btn-primary">
                        <i class="fa fa-reply-all"></i> 撤回审批
                    </button>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${orderBill.approvalStatus==0}">
                    <button id="btnDelete" type="button" class="btn btn-primary">
                        <i class="fa fa-reply-all"></i> 删除申请
                    </button>
                </c:when>
            </c:choose>
            <button id="btnCancel" type="button" class="btn btn-danger"
                    onclick="closeCurrentTabPage('${param.parentTabPageId}')">
                <i class="fa fa-reply-all"></i> 关 闭
            </button>
        </div>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="orderBill" action="${ctx}/orderbill/orderBill/save" method="post"
                   class="form-horizontal">
            <div class="form-body ">
                <form:hidden path="sysCode"/>
                <form:hidden path="step"/>
                <form:hidden path="companyCode"/>
                <table class="table table-bordered">
                    <tr>
                        <td class=" judp-table-lable" align="right" style="width:150px"><span
                                class="required red">*</span>采购人：
                        </td>
                        <td class=" judp-table-content" style="width:150px">
                            <form:input path="buyerCode" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required hide"/>
                            <form:input path="buyerName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
                                <%-- <sys:treeselect id="buyerCode" name="buyerCode"
                                                       value="${orderBill.buyerCode}" labelName="buyerName"
                                                       labelValue="${orderBill.buyerName}"
                                                       title="使用人" url="/sys/office/treeData?type=3" cssClass=""
                                                       allowClear="true" notAllowSelectParent="true" isAll="true"/> --%>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px">部门名称：</td>
                        <td class=" judp-table-content" style="width:150px">
                            <form:input path="office" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required hide"/>
                            <form:input path="officeName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
                                <%-- <sys:treeselect id="office" name="office"
                                                        value="${orderBill.office}" labelName="officeName"
                                                        labelValue="${orderBill.officeName}"
                                                        title="部门" url="/sys/office/treeData?type=2" cssClass=""
                                                        allowClear="true" notAllowSelectParent="true"/> --%>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px">采购日期：</td>
                        <td class=" judp-table-content" style="width:150px">
                            <input name="orderDate" type="text" readonly="readonly" maxlength="20"
                                   class="form-control Wdate "
                                   value="<fmt:formatDate value="${orderBill.orderDate}" pattern="yyyy-MM-dd "/>"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="1" class=" judp-table-lable" style="" align="right">采购说明：</td>
                        <td colspan="5" rowspan="1" class=" judp-table-content">
                            <form:input path="remarks" htmlEscape="false" maxlength="50"
                                        class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" class="judp-table-tab-content">
                            <c:choose>
                                <c:when test="${orderBill.isNewRecord}">
                                    <div class="row">
                                        <div class="col-sm-4" hidden="hidden">
                                            <a href="#" id="btnAddRow" class="btn btn-default"><i
                                                    class="fa fa-plus"></i></a>
                                        </div>
                                        <div class="col-sm-4">
                                            <a href="#" id="btnIntroduce" onclick="selectInvWindow()"
                                               class="btn btn-primary"><i
                                                    class="fa fa-plus"></i>选择办公物品</a>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                            <table id="orderBillsDataGrid"></table>
                            <div id="dataGridPage"></div>
                            <div class="hide">
                                <input type="hidden" id="flowId" name="flowId"/>
                                <sys:listselect id="approval" name="approval" value="" labelName="approvalName"
                                                labelValue=""
                                                returnCodeAttr="userCode" returnNameAttr="userName" title="审批人" url=""
                                                multiple="false" cssClass="form-control"/>
                            </div>
                            <div class="hide">
                                <sys:listselect id="nextApproval" name="nextApprovalCode" value=""
                                                labelName="nextApprovalName"
                                                labelValue=""
                                                boxHeight="500" boxWidth="450" returnCodeAttr="userCode"
                                                returnNameAttr="userName"
                                                title="审批人" url="" multiple="false" cssClass="form-control"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form:form>
        <form:form id="searchForm"
                   action="${ctx}/orderbill/orderBill/getDtlData?sysCode=${orderBill.sysCode}&isNewRecord=${orderBill.isNewRecord}"> </form:form>
    </div>
</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/js/pubnew.js" type="text/javascript"></script>
<script type="text/javascript">
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

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
            console.log(fieldName, val);
        });
    }


    //全局变量存选中的办公用品档案表的articlesCode
    var articlesCodes = [];
    $('#orderBillsDataGrid').dataGrid({
        // 当前页签编号
        tabPageId: '${param.tabPageId}',
        searchForm: $("#searchForm"), // 数据来源表单
        showFooter: true,	// 是否显示底部合计行
        columnModel: [
            {
                header: '办公用品编码', name: 'articlesCode', index: 'articles_code', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articlesCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },
            {
                header: '办公用品名称', name: 'articlesName', index: 'articles_name', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articlesName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },
            {
                header: '办公类别编码', name: 'sortCode', width: 100, hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公用品类别', name: 'sortName', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '品牌名称', name: 'brand', index: 'brand', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },
            {
                header: '规格型号', name: 'version', index: 'version', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }

            },
            {
                header: '单位', name: 'unit', index: 'unit', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unit" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },
            {
                header: '数量',
                name: 'qty',
                width: 100,
                editable: ${orderBill.isNewRecord||orderBill.step==2||orderBill.pageFlag==0? 'true' : 'false'},
                align: 'right',
                editoptions: {
                    'maxlength': '100', 'class': 'form-control number',
                    dataEvents: [
                        {
                            type: 'blur',     //blur,focus,change.............焦点失去事件
                            fn: calcSumMoney
                        }
                    ]
                }
            },
            {
                header: '单价',
                name: 'price',
                width: 100,
                editable:${orderBill.isNewRecord||orderBill.step==2||orderBill.pageFlag==0? 'true' : 'false'},
                align: 'right',
                editoptions: {
                    'maxlength': '100', 'class': 'form-control number',
                    dataEvents: [
                        {
                            type: 'blur',     //blur,focus,change.............焦点失去事件
                            fn: calcSumMoney
                        },
                        {
                            type: 'keydown',
                            fn: function (e) {
                                if (e.keyCode == 13) {
                                    calcSumMoney();
                                }
                            }
                        }

                    ]

                }
            },
            {
                header: '合计金额',
                name: 'sumMoney',
                width: 100,
                align: 'right',
                formatter: 'currency',
                formatoptions: {decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 2, prefix: ""},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sumMoney" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '操作',
                name: 'actions',
                width: 100,
                align: 'center',
                hidden: ${orderBill.isNewRecord ? 'false' : 'true'},
                sortable: false,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<a href="#" onclick="confirmx(\'你提交要删除这条数据吗？\', function(){$(\'#orderBillsDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    return actions.join('');
                }
            }
        ],
        // 编辑表格参数
        editGrid: true,				// 是否是编辑表格
        editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
        editGridAddRowBtn: $('#btnAddRow'),	// 子表增行按钮
        onSelectRow: function (id) {
        },
        ajaxSuccess: function (data) { // 加载成功后执行方法
            if (data && data.length > 0) {//判断是否有数据（判断的方法可以跟踪console.log(data)来决定）
                // 初始化后编辑所有行
                var dg = $("#orderBillsDataGrid");
                var ids = dg.dataGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
                }
            } else {//没有数据默认新增一行
                /*   $('#orderBillsDataGrid').dataGrid('getParam', 'onSelectRow')('new'); */
                var date = new Date().format("yyyy-MM-dd");
                $("#orderDate").val(date);
            }
            var totalQty = 0;
            var totalSumMoney = 0;
            for (var i = 0; i < data.length; i++) {
                console.log("123", data[i].qty);
                totalQty = totalQty.add(data[i].qty);
                console.log("", data[i].sumMoney);
                totalSumMoney = totalSumMoney.add(data[i].sumMoney);
            }
            // 设置底部合计行数据
            $('#orderBillsDataGrid').dataGrid("footerData", "set", {
                'invCode': '<em class="pull-right">合计：&nbsp;</em>',
                'invUnit': '<em class="pull-right"></em>',
                'qty': '<em class="pull-right">' + parseMoney(totalQty) + '</em>',
                'sumMoney': '<em class="pull-right">' + parseMoney(totalSumMoney) + '</em>'
            }, false);
        }
    });

    //计算合计金额
    function calcSumMoney(e) {
        var selRow = $("#orderBillsDataGrid").dataGrid("getSelectRow");
        var qty = $("#" + selRow + "_qty").val();
        var price = $("#" + selRow + "_price").val();
        var taxRate = $("#taxRate").val();
        var sumMoney = Number(qty).mul(Number(price));
        $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {sumMoney: sumMoney});

        //重新计算底部合计
        var totalQty = 0;
        var totalSumMoney = 0;
        $("#orderBillsDataGrid").find("input[name$='qty']").each(function () {
            totalQty = totalQty.add(Number($(this).val()));
        });
        $("#orderBillsDataGrid").find("input[name$='sumMoney']").each(function () {
            totalSumMoney = totalSumMoney.add(Number($(this).val()));
        });
        $('#orderBillsDataGrid').dataGrid("footerData", "set", {
            'invCode': '<em class="pull-right">合计：&nbsp;</em>',
            'invUnit': '<em class="pull-right"></em>',
            'qty': '<em class="pull-right">' + totalQty + '</em>',
            'sumMoney': '<em class="pull-right">' + formatMoney(totalSumMoney) + '</em>'
        }, false);
        // 移除 添加合计金额后的冲突数据
        $("td[aria-describedby='dataGrid_invUnit']").empty();
    }

    //工作流对应模板
    $('#btnSubmit').click(function () {
        //计算比例合计
        tatalApplyMoney = 0;
        $("#orderBillsDataGrid").find("input[name$='applyMoney']").each(function () {
            tatalApplyMoney = tatalApplyMoney.add(Number($(this).val()));
        });
        var applicantCode = '${fns:getUser().userCode}';
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "CG", // 对应工作流模板的单据类型
                "companyCode": $("#companyCode").val(),
                "officeCode": $("#officeCode").val() // 申请人部门编码
            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    $("#flowId").val(data.message);
                    var url = "${ctx}/eflow/flowBusiness/approvalSelect?applicantCode=" + applicantCode + "&flowId=" + data.message;
                    $("#approvalDiv").attr("data-url", url);
                    $("#approvalName").click();
                }
            }, "json"
        )
    });

    function approvalCallbackForMap(dataMap, v, h, f) {
        $.each(dataMap, function (key, value) {
            $("#approvalCode").val(value.userCode);
            $("#approvalName").val(value.userName);
        })
        var approvalCode = $("#approvalCode").val();
        if (approvalCode == null || approvalCode == "") {
            showTip("请选择下一步审批人");
            return false;
        }
        var dg = $('#orderBillsDataGrid');
        updateListFieldName(dg, 'orderBillsList', 'sortCode');
        updateListFieldName(dg, 'orderBillsList', 'sortName');
        updateListFieldName(dg, 'orderBillsList', 'articlesCode');
        updateListFieldName(dg, 'orderBillsList', 'articlesName');
        updateListFieldName(dg, 'orderBillsList', 'brand');
        updateListFieldName(dg, 'orderBillsList', 'version');
        updateListFieldName(dg, 'orderBillsList', 'unit');
        updateListFieldName(dg, 'orderBillsList', 'qty');
        updateListFieldName(dg, 'orderBillsList', 'price');
        updateListFieldName(dg, 'orderBillsList', 'sumMoney');
        updateListFieldName(dg, 'orderBillsList', 'companyCode');
        updateListFieldName(dg, 'orderBillsList', 'companyName');
        $("#inputForm").submit();

    }

    //审批通过
    $("#btnAuditPass").click(function () {
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "CG", // 对应工作流模板的单据类型
                "companyCode": $("#companyCode").val(),
                "officeCode": $("#deptCodeCode").val() // 申请人部门编码

            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    $("#flowId").val(data.message);
                    var flowId = data.message;
                    var url = "${ctx}/orderbill/orderBill/getNextFlowBusiness?bizKey=" + $("#sysCode").val() + "&step=${orderBill.step }";
                    $.post(url, function (data) {
                        if (data == 0) {//审批最后一步
                            var dg = $('#orderBillsDataGrid');
                            updateListFieldName(dg, 'orderBillsList', 'sortCode');
                            updateListFieldName(dg, 'orderBillsList', 'sortName');
                            updateListFieldName(dg, 'orderBillsList', 'articlesCode');
                            updateListFieldName(dg, 'orderBillsList', 'articlesName');
                            updateListFieldName(dg, 'orderBillsList', 'brand');
                            updateListFieldName(dg, 'orderBillsList', 'version');
                            updateListFieldName(dg, 'orderBillsList', 'unit');
                            updateListFieldName(dg, 'orderBillsList', 'qty');
                            updateListFieldName(dg, 'orderBillsList', 'price');
                            updateListFieldName(dg, 'orderBillsList', 'sumMoney');
                            updateListFieldName(dg, 'orderBillsList', 'companyCode');
                            updateListFieldName(dg, 'orderBillsList', 'companyName');
                            $("#inputForm").submit();
                            var stepId = "${param.stepId}";
                            var urls = "${ctx}/orderbill/orderBill/agreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=0" + "&sysCode=" + $("#sysCode").val();
                            $.post(urls, function (data) {
                                showMessage(data.message);
                                if (data.result == Global.TRUE) {
                                    closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                                        contentWindow.page();
                                    });

                                }
                            }, "json");
                        }
                        else if (data == 1) {
                            var url = "${ctx}/eflow/flowBusiness/nextApprovalSelect?bizKey=${orderBill.sysCode }&flowId=" + flowId + "&step=${orderBill.step}";
                            $("#nextApprovalDiv").attr("data-url", url);
                            $("#nextApprovalName").click();
                        }
                    });

                }
            }, "json"
        )


    })

    function nextApprovalCallbackForMap(dataMap, v, h, f) {
        $.each(dataMap, function (key, value) {
            $("#nextApprovalCode").val(value.userCode);
            $("#nextApprovalName").val(value.userName);
        })
        var dg = $('#orderBillsDataGrid');
        updateListFieldName(dg, 'orderBillsList', 'sortCode');
        updateListFieldName(dg, 'orderBillsList', 'sortName');
        updateListFieldName(dg, 'orderBillsList', 'articlesName');
        updateListFieldName(dg, 'orderBillsList', 'brand');
        updateListFieldName(dg, 'orderBillsList', 'version');
        updateListFieldName(dg, 'orderBillsList', 'unit');
        updateListFieldName(dg, 'orderBillsList', 'qty');
        updateListFieldName(dg, 'orderBillsList', 'price');
        updateListFieldName(dg, 'orderBillsList', 'sumMoney');
        updateListFieldName(dg, 'orderBillsList', 'companyCode');
        updateListFieldName(dg, 'orderBillsList', 'companyName');
        $("#inputForm").submit();
        var nextApprovalCode = $("#nextApprovalCode").val();
        var nextApprovalName = $("#nextApprovalName").val();
        var stepId = "${param.stepId}";
        var url = "${ctx}/orderbill/orderBill/agreePC?flowBusinessId=" + stepId + "&nextApprovalCode=" + nextApprovalCode + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=1" + "&sysCode=" + $("#sysCode").val() + "&nextApprovalName=" + nextApprovalName;
        $.post(url, function (data) {
            console.log(data);
            showMessage(data.message);
            if (data.result == Global.TRUE) {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");
    }

    //驳回
    $("#btnReject").click(function () {
        var stepId = "${param.stepId}";
        var url = "${ctx}/orderbill/orderBill/disagreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&sysCode=" + $("#sysCode").val();
        $.post(url, function (data) {
            showMessage(data.message);
            if (data.result == Global.TRUE) {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");

    })

    //撤回审批
    $("#btnUndo").click(function () {
        var stepId = "${param.stepId}";
        var url = "${ctx}/orderbill/orderBill/unDo?bizKey=" + $("#id").val();
        $.post(url, function (data) {
            showMessage(data.messagePc);
            if (data.code == "200") {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");

    })
    //删除申请
    $("#btnDelete").click(function () {
        var stepId = "${param.stepId}";
        var url = "${ctx}/orderbill/orderBill/delete?sysCode=" + $("#sysCode").val();
        $.post(url, function (data) {
            showMessage(data.message);
            if (data.result == Global.TRUE) {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");

    })
    //撤回申请
    $("#btnUnSubmit").click(function () {
        var url = "${ctx}/orderbill/orderBill/unSubmit?bizKey=" + $("#sysCode").val();
        $.post(url, function (data) {
            if (data.message == "success") {
                showMessage(data.true);
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            } else {
                showMessage(data.false);
            }
        }, "json");

    })
    //撤回审批
    $("#btnUndo").click(function () {
        var stepId = "${param.stepId}";
        var url = "${ctx}/orderbill/orderBill/unDo?bizKey=" + $("#sysCode").val();
        $.post(url, function (data) {
            showMessage(data.message);
            if (data.code == "200") {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");

    })

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

    function getexisting() {
        articlesCodes = [];
        $("#orderBillsDataGrid").find("[name$='articlesCode']").each(function () {
            articlesCodes.push($(this).val());
        });
        return articlesCodes;
    }


    //选择办公物品
    function selectInvWindow() {
        var articlesCodes = getexisting();
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/articlesfile/articlesFile/articlesList?articlesCodes=" + articlesCodes, "选择办公物品", $(window).width() - 100, $(window).height() - 100,
            {
                ajaxData: {selectData: selectData},
                buttons: {
                    "<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定": "ok",
                    /* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
                    '<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
                },
                submit: function (v, h, f) {
                    if (v == "ok") {
                        // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                        var w = h.find("iframe")[0].contentWindow;
                        var dataMap = w.getDataMap();
                        $.each(dataMap, function (key, value) {
                            $('#btnAddRow').click();
                            var selRow = $("#orderBillsDataGrid").dataGrid("getSelectRow");
                            $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                            $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                            $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {articlesCode: value.articlesCode});
                            $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {articlesName: value.articlesName});
                            $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                            $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {version: value.version});
                            $("#orderBillsDataGrid").dataGrid("setRowData", selRow, {unit: value.unit});
                        });
                    }
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }
</script>
