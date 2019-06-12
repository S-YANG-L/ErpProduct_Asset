<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产退库 - ${assetReturnInfo.isNewRecord ? '新增' : '编辑'}资产退库" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${assetReturnInfo.isNewRecord ? '新增' : '编辑'}资产退库</div>
        <div class="actions">
            <c:choose>
                <c:when test="${assetReturnInfo.isNewRecord == true}">
                    <button id="btnSubmit" type="button" class="btn btn-primary">
                        <i class="fa fa-check"></i> 提 交
                    </button>
                </c:when>
                <c:when test="${assetReturnInfo.pageFlag == 0&&assetReturnInfo.approvalStatus!=2}">
                    <!-- 我的申请 -->
                    <c:choose>
                        <c:when test="${assetReturnInfo.approvalStatus !=1}">
                            <button id="btnSubmit" type="button" class="btn btn-primary">
                                <i class="fa fa-check"></i> 提 交
                            </button>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${assetReturnInfo.approvalStatus !=0}">
                            <c:choose>
                                <c:when test="${assetReturnInfo.approvalStatus !=3}">
                                    <button id="btnUnSubmit" type="button"
                                            class="btn btn-primary">
                                        <i class="fa fa-reply-all"></i> 撤回申请
                                    </button>
                                </c:when>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </c:when>
                <c:when test="${assetReturnInfo.pageFlag == 1}">
                    <!-- 我的待办 -->
                    <button id="btnAuditPass" type="button"
                            class="btn btn-primary">
                        <i class="fa fa-check"></i></i> 审批通过
                    </button>
                    <button id="btnReject" type="button" class="btn btn-primary">
                        <i class="fa fa-times"></i> 驳回
                    </button>
                </c:when>
                <c:when test="${assetReturnInfo.pageFlag == 2}">
                    <!-- 我的已办 -->
                    <button id="btnUndo" type="button" class="btn btn-primary">
                        <i class="fa fa-reply-all"></i> 撤回审批
                    </button>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${assetReturnInfo.approvalStatus==0}">
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
        <form:form id="inputForm" modelAttribute="assetReturnInfo" action="${ctx}/cancelstocks/assetReturnInfo/save"
                   method="post" class="form-horizontal">
            <div class="form-body">
                <form:hidden path="id"/>
                <form:hidden path="step"/>
                <form:hidden path="approvalStatus"/>
                <table class="table table-bordered">
                    <tr>
                        <td class=" judp-table-lable" align="right" style="width:150px"><span
                                class="required red">*</span> 退库人：<i class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                            <form:input path="retireName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
                            <form:input path="retireCode" type="hidden"/>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px"><span
                                class="required red">*</span> 退库日期：<i class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                            <input name="receiverDate" type="text" readonly="readonly" maxlength="20"
                                   class="form-control Wdate required "
                                   value="<fmt:formatDate value="${assetReturnInfo.receiverDate}" pattern="yyyy-MM-dd "/>"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px">部门名称：<i
                                class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                            <form:input path="returnOfficeName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
                            <form:input path="returnOfficeCode" type="hidden"/>
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="1" class=" judp-table-lable" style="" align="right">备注信息：<i
                                class="fa icon-question hide"></i></td>
                        <td colspan="5" rowspan="1" class=" judp-table-content">
                            <form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="1000"
                                           class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" class="judp-table-tab-content">
                            <c:choose>
                                <c:when test="${assetReturnInfo.isNewRecord}">
                                    <div class="row">
                                        <div class="col-sm-6" hidden="hidden">
                                            <a href="#" id="btnAddRow" class="btn btn-default"><i
                                                    class="fa fa-plus"></i></a>
                                        </div>
                                        <div class="col-sm-6">
                                            <a href="#" id="btnAddRowinfo" onclick="selectReturnInvWindow()"
                                               class="btn btn-primary"><i
                                                    class="fa fa-plus"></i>选择资产</a>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                            <table id="assetReturnDtlDataGrid"></table>
                            <div id="dataGridPage"></div>
                            <div class="hide">
                                <input type="hidden" id="flowId" name="flowId"/>
                                <sys:listselect id="approval" name="approvalCode" value=""
                                                labelName="approvalName" labelValue="" returnCodeAttr="userCode"
                                                returnNameAttr="userName" title="审批人" url="" multiple="false"
                                                cssClass="form-control"/>
                            </div>
                            <div class="hide">
                                <sys:listselect id="nextApproval" name="nextApprovalCode" value=""
                                                labelName="nextApprovalName" labelValue="" boxHeight="500"
                                                boxWidth="450" returnCodeAttr="userCode" returnNameAttr="userName"
                                                title="审批人" url="" multiple="false" cssClass="form-control"/>
                            </div>
                            <div class="row" hidden="hidden">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <label class="control-label col-sm-2">处理意见：</label>
                                        <div class="col-sm-8">
                                            <form:textarea path="approvalMemo" htmlEscape="false" rows="4"
                                                           maxlength="255" value=" "
                                                           class="form-control"/>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form:form>
        <form:form id="searchForm2" method="post"
                   action="${ctx}/cancelstocks/assetReturnInfo/getDtlData?returnCode=${usedCode}">
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    //全局变量存选中的资产表的assetCode
    var assetcodes = [];
    //初始化资产退库子表DataGrid对象
    $("#assetReturnDtlDataGrid").dataGrid({
        searchForm: $("#searchForm2"), // 数据来源表单
        columnModel: [
            {
                header: '资产编码', name: 'assetCode', width: 80, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '资产名称', name: 'assetName', edittype: 'text', width: 80, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '资产分类编码',
                name: 'sortCode',
                width: 80,
                align: "left",
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '资产分类名称',
                name: 'sortName',
                width: 80,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '品牌', name: 'brand', width: 80, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '型号', name: 'version', width: 80, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '行数据', name: 'rowData', hidden: true,
                formatter: function (val, obj, row, act) {
                    return JSON.stringify(row);
                }
            },
            {
                header: '存放地点',
                name: 'storagePlace',
                width: 80,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="storagePlace" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '操作',
                name: 'actions',
                width: 50,
                sortable: false,
                fixed: true,
                hidden: ${assetReturnInfo.step==1||assetReturnInfo.step==2? 'true' : 'false'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    if (val == 'new') {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetReturnDtlDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    } else {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetReturnDtlDataGrid\').dataGrid(\'setRowData\',\'' + obj.rowId + '\',null,{display:\'none\'});$(\'#' + obj.rowId + '_status\').val(\'' + Global.STATUS_DELETE + '\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    }
                    return actions.join('');
                },
                editoptions: {defaultValue: 'new'}
            }
        ],
        // 编辑表格参数
        editGrid: true,				// 是否是编辑表格
        editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
        editGridAddRowBtn: $('#btnAddRow'),	// 子表增行按钮
        ajaxSuccess: function (data) { // 加载成功后执行方法
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

    //选择资产
    function selectReturnInvWindow() {
        geretuentexisting();//下一步选择资产时 过滤已经选中的
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/cancelstocks/assetReturnInfo/getusedDtllist?assetCodes=" + assetcodes + "&user=" + $("#retireCode").val(), "选择资产", $(window).width() - 100, $(window).height() - 100,
            {
                ajaxData: {selectData: selectData},
                buttons: {
                    "<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定": "ok",
                    /* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
                    '<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
                },
                submit: function (v, h, f) { // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                    if (v == "ok") {
                        var w = h.find("iframe")[0].contentWindow;
                        var dataMap = w.getDataMap();
                        $.each(dataMap, function (key, value) {
                            $('#btnAddRow').click();
                            var selRow = $("#assetReturnDtlDataGrid").dataGrid("getSelectRow");
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {assetCode: value.assetCode});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {assetName: value.assetName});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {version: value.version});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {storagePlace: value.storagePlace});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {companyCode: value.companyCode});
                            $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {companyName: value.companyName});
                        });
                    }
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }

    //用户字典
    function getreturnRegionCode() {
        $("#returnRegionName").val($("#returnRegionCode").select2("data").text);
    }

    function geretuentexisting() {
        assetcodes = [];
        $("#assetReturnDtlDataGrid").find("[name$='assetCode']").each(function () {
            assetcodes.push($(this).val());
        });
    }

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
        });
    }

    //工作流对应模板
    $('#btnSubmit').click(function () {
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "ZCTK", // 对应工作流模板的单据类型
                "companyCode": $("#returnCompanyName").val(),// 申请人公司编码
                "officeCode": $("#returnOfficeCode").val() // 申请人部门编码
            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    $("#flowId").val(data.message);
                    var url = "${ctx}/cancelstocks/assetReturnInfo/approvalSelect?applicantCode=" + $("#applicantCode").val() + "&flowId=" + data.message;
                    $("#approvalDiv").attr("data-url", url);
                    $("#approvalName").click();
                }
            }, "json"
        )
    });
    //审批通过
    $("#btnAuditPass").click(function () {
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "ZCTK", // 对应工作流模板的单据类型
                "companyCode": $("#returnCompanyName").val(),// 申请人公司编码
                "officeCode": $("#returnOfficeCode").val() // 申请人部门编码
            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    $("#flowId").val(data.message);
                    var flowId = data.message;
                    var url = "${ctx}/cancelstocks/assetReturnInfo/getNextFlowBusiness?bizKey=" + $("#id").val() + "&step=${assetReturnInfo.step}";
                    $.post(url, function (data) {
                        if (data == 0) {//审批最后一步
                            console.log("审批最后一步", data);
                            var stepId = "${param.stepId}";
                            var urls = "${ctx}/cancelstocks/assetReturnInfo/agreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=0" + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val();
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
                            console.log("审批不是最后一步", data);
                            var url = "${ctx}/eflow/flowBusiness/nextApprovalSelect?bizKey=${assetReturnInfo.id}&flowId=" + flowId + "&step=${assetReturnInfo.step}";
                            $("#nextApprovalDiv").attr("data-url", url);
                            $("#nextApprovalName").click();
                        }
                    });

                }
            }, "json"
        )
    })

    //驳回
    $("#btnReject").click(function () {
        var stepId = "${param.stepId}";
        var url = "${ctx}/cancelstocks/assetReturnInfo/disagreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val();
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
        var url = "${ctx}/cancelstocks/assetReturnInfo/unDo?bizKey=" + $("#id").val();
        $.post(url, function (data) {
            showMessage(data.messagePc);
            if (data.code == "200") {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");

    })

    //选择下一步审批人的回调函数
    function nextApprovalCallbackForMap(dataMap, v, h, f) {
        $.each(dataMap, function (key, value) {
            $("#nextApprovalCode").val(value.userCode);
            $("#nextApprovalName").val(value.userName);
        })
        var nextApprovalCode = $("#nextApprovalCode").val();
        var nextApprovalName = $("#nextApprovalName").val();
        var stepId = "${param.stepId}";
        var url = "${ctx}/cancelstocks/assetReturnInfo/agreePC?flowBusinessId=" + stepId + "&nextApprovalCode=" + nextApprovalCode + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=1" + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val() + "&nextApprovalName=" + nextApprovalName;
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

    function approvalCallbackForMap(dataMap, v, h, f) {
        $.each(dataMap, function (key, value) {
            $("#approvalCode").val(value.userCode);
        })
        var dg = $('#assetReturnDtlDataGrid');
        updateListFieldName(dg, 'assetReturnDtlList', 'assetCode');
        updateListFieldName(dg, 'assetReturnDtlList', 'assetName');
        updateListFieldName(dg, 'assetReturnDtlList', 'sortCode');
        updateListFieldName(dg, 'assetReturnDtlList', 'sortName');
        updateListFieldName(dg, 'assetReturnDtlList', 'brand');
        updateListFieldName(dg, 'assetReturnDtlList', 'version');
        updateListFieldName(dg, 'assetReturnDtlList', 'companyCode');
        updateListFieldName(dg, 'assetReturnDtlList', 'companyName');
        $("#inputForm").submit();
    }

    //撤回申请
    $("#btnUnSubmit").click(function () {
        var url = "${ctx}/cancelstocks/assetReturnInfo/unSubmit?bizKey=" + $("#id").val();
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

    //删除申请
    $("#btnDelete").click(function () {
        var stepId = "${param.stepId}";
        var url = "${ctx}/cancelstocks/assetReturnInfo/delete?id=" + $("#id").val();
        $.post(url, function (data) {
            showMessage(data.message);
            if (data.result == Global.TRUE) {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");

    })
</script>

