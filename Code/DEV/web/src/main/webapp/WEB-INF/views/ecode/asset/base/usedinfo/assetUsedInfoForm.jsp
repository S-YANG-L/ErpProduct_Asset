<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产领用 - ${assetUsedInfo.isNewRecord ? '新增' : '编辑'}资产领用" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${assetUsedInfo.isNewRecord ? '新增' : '编辑'}资产领用</div>
        <div class="actions">
            <c:choose>
                <c:when test="${assetUsedInfo.isNewRecord == true}">
                    <button id="btnSubmit" type="button" class="btn btn-primary">
                        <i class="fa fa-check"></i> 提 交
                    </button>
                </c:when>
                <c:when test="${assetUsedInfo.pageFlag==0&&assetUsedInfo.approvalStatus!=2}">
                    <!-- 我的申请 -->
                    <c:choose>
                        <c:when test="${assetUsedInfo.approvalStatus !=1}">
                            <button id="btnSubmit" type="button" class="btn btn-primary">
                                <i class="fa fa-check"></i> 提 交
                            </button>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${assetUsedInfo.approvalStatus !=0}">
                            <c:choose>
                                <c:when test="${assetUsedInfo.approvalStatus !=3}">
                                    <button id="btnUnSubmit" type="button"
                                            class="btn btn-primary">
                                        <i class="fa fa-reply-all"></i> 撤回申请
                                    </button>
                                </c:when>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </c:when>
                <c:when test="${assetUsedInfo.pageFlag == 1}">
                    <!-- 我的待办 -->
                    <c:choose>
                        <c:when test="${assetUsedInfo.step<=2}">
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
                        <c:when test="${assetUsedInfo.step>=3}">
                            <button id="btnAuditPass" type="button"
                                    class="btn btn-primary">
                                <i class="fa fa-check"></i></i>确认
                            </button>
                        </c:when>
                    </c:choose>
                </c:when>
                <c:when test="${assetUsedInfo.pageFlag == 2}">
                    <!-- 我的已办 -->
                    <button id="btnUndo" type="button" class="btn btn-primary">
                        <i class="fa fa-reply-all"></i> 撤回审批
                    </button>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${assetUsedInfo.approvalStatus==0}">
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
        <form:form id="inputForm" modelAttribute="assetUsedInfo" action="${ctx}/usedinfo/assetUsedInfo/save"
                   method="post" class="form-horizontal">
            <div class="form-body">
                <form:hidden path="id"/>
                <form:hidden path="step"/>
                <form:hidden path="approvalStatus"/>
                <table class="table table-bordered">
                    <tr>
                        <td class=" judp-table-lable" align="right" style="width:150px"><span
                                class="required red">*</span> 领用人：<i class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                            <form:input path="receiverName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
                            <form:input path="receiverCode" type="hidden"/>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px"><span
                                class="required red">*</span> 领用日期：<i class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                             <input name="receiverDate" type="text" readonly="readonly" maxlength="20"
                                                  class="form-control Wdate required "
                                                  value="<fmt:formatDate value="${assetUsedInfo.receiverDate}" pattern="yyyy-MM-dd "/>"
                                                  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px">部门名称：<i
                                class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                            <form:input path="usedOfficeName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
                            <form:input path="usedOfficeCode" type="hidden"/>
                        </td>
                    </tr>
                    <tr>
                        <td class=" judp-table-lable" align="right" style="width:150px"><span
                                class="required red">*</span> 资产分类名称：<i class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                            <sys:treeselect url="${ctx}/ass/assetSort/treeData" id="assetClassCode"
                                            value="${assetUsedInfo.assetClassCode}" labelName="assetClass"
                                            labelValue="${assetUsedInfo.assetClass}" title="资产分类名称"
                                            name="assetClassCode"
                                            cssClass="rightBorder required" allowClear="true"
                                            notAllowSelectParent="true" isAll="true">
                            </sys:treeselect>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px"><span
                                class="required red">*</span>领用数量：<i
                                class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                            <form:input path="numberRecipients" htmlEscape="false" value="1"  maxlength="100"
                                        class="form-control required  digits"/>
                        </td>
                        <td class=" judp-table-lable" align="right" style="width:150px"><i
                                class="fa icon-question hide"></i></td>
                        <td class=" judp-table-content" style="width:150px">
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="1" class=" judp-table-lable" style="" align="right">备注信息：<i
                                class="fa icon-question hide"></i></td>
                        <td colspan="5" rowspan="1" class=" judp-table-content">
                            <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000"
                                           class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" class="judp-table-tab-content">

                            <c:choose>
                                <c:when test="${assetUsedInfo.step==2}">
                                    <div class="row">
                                        <div class="col-sm-6" hidden="hidden">
                                            <a href="#" id="btnAddRow" class="btn btn-primary"><i
                                                    class="fa fa-plus"></i></a>
                                        </div>
                                        <div class="col-sm-6">
                                            <a href="#" id="btnAddRowinfo" onclick="selectInvWindow()"
                                               class="btn btn-primary"><i
                                                    class="fa fa-plus"></i>选择资产</a>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${assetUsedInfo.step>=2||assetUsedInfo.approvalStatus==2}">
                                    <!-- <div class="row"> -->
                                    <!-- <div class="col-sm-12"> -->
                                    <table id="dataGrid"></table>
                                    <div id="dataGridPage"></div>
                                    <!-- </div> -->
                                    <!-- </div> -->
                                </c:when>
                            </c:choose>
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
                            <c:if test="${assetUsedInfo.pageFlag == 1||assetUsedInfo.pageFlag == 2}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" hidden="hidden">
                                            <label class="control-label col-sm-2">处理意见：</label>
                                            <div class="col-sm-8">
                                                <form:textarea path="approvalMemo" htmlEscape="false" rows="4"
                                                               maxlength="255" value=""
                                                               class="form-control"/>
                                                <span class="help-block">&nbsp;</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </div>
        </form:form>
        <form:form id="searchForm2" method="post"
                   action="${ctx}/usedinfo/assetUsedInfo/getDtlData?usedCode=${usedCode}">
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
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
    //全局变量存选中的资产表的assetCode
    var assetcodes = [];
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm2"), // 数据来源表单
        columnModel: [
            {
                header: '资产编码', name: 'assetCode', width: 150, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '资产名称', name: 'assetName', edittype: 'text', width: 150, align: "left",
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
                width: 150,
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
                width: 150,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '品牌', name: 'brand', width: 150, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '型号', name: 'version', width: 150, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '存放地址',
                name: 'storagePlace',
                width: 150,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="storagePlace" value="' + val + '" />');
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
                header: '操作', name: 'actions', width: 100, fixed: true, sortable: false,
                hidden: ${assetUsedInfo.step==2 ? 'false' : 'true'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    return actions.join('');
                }
            }
        ],
        // 编辑表格参数
        editGrid: true,				// 是否是编辑表格
        editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
        editGridAddRowBtn: $('#btnAddRow'),	// 子表增行按钮
        ajaxSuccess: function (data) { // 加载成功后执行方法
            $('#dataGrid').dataGrid('getParam', 'onSelectRow')('new');
        }, onSelectRow: function (id, isSelect, event) {
            var dg = $('#dataGrid');
            codes = dg.dataGrid('getDataIDs');

        }
    });

    //选择资产
    function selectInvWindow() {
        var assetcodes = getexisting();
        var selectData = "";
        console.log("assetClassCodeCode", $("#assetClassCodeCode").val());
        console.log("assetClassCodeName", $("#assetClassCodeName").val());
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/usedinfo/assetUsedInfo/getusedDtllist?assetCodes=" + assetcodes + "&sortCode=" + $("#assetClassCodeCode").val() + "&sortName=" + $("#assetClassCodeName").val(), "选择资产", $(window).width() - 100, $(window).height() - 100,
            {
                ajaxData: {selectData: selectData},
                buttons: {
                    "<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定": "ok",
                    /* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
                    '<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
                },
                submit: function (v, h, f) { // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                    console.log("vvvv", v);
                    if (v == "ok") {
                        var w = h.find("iframe")[0].contentWindow;
                        var dataMap = w.getDataMap();
                        $.each(dataMap, function (key, value) {
                            $('#btnAddRow').click();
                            var selRow = $("#dataGrid").dataGrid("getSelectRow");
                            $("#dataGrid").dataGrid("setRowData", selRow, {assetCode: value.assetCode});
                            $("#dataGrid").dataGrid("setRowData", selRow, {assetName: value.assetName});
                            $("#dataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                            $("#dataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                            $("#dataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                            $("#dataGrid").dataGrid("setRowData", selRow, {version: value.version});
                            $("#dataGrid").dataGrid("setRowData", selRow, {companyCode: value.companyCode});
                            $("#dataGrid").dataGrid("setRowData", selRow, {companyName: value.companyName});
                            $("#dataGrid").dataGrid("setRowData", selRow, {storagePlace: value.storagePlace});

                        });
                    }
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
        });
    }

    //用户字典
    function getusedRegionCode() {
        $("#usedRegionName").val($("#usedRegionCode").select2("data").text);
    }

    function getexisting() {
        assetcodes = [];
        $("#dataGrid").find("[name$='assetCode']").each(function () {
            assetcodes.push($(this).val());
        });
        return assetcodes;
    }

    //工作流对应模板
    $('#btnSubmit').click(function () {
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "ZCLY", // 对应工作流模板的单据类型
                "companyCode": $("#usedCompanyCode").val(),// 申请人公司编码
                "officeCode": $("#usedOfficeCode").val() // 申请人部门编码
            },
            function (data) {
                console.log("查找工作流对应模板", data);
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    $("#flowId").val(data.message);
                    var url = "${ctx}/usedinfo/assetUsedInfo/approvalSelect?applicantCode=" + $("#applicantCode").val() + "&flowId=" + data.message;
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
                "billType": "ZCLY", // 对应工作流模板的单据类型
                "companyCode": $("#usedCompanyCode").val(),// 申请人公司编码
                "officeCode": $("#usedOfficeCode").val() // 申请人部门编码
            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    console.log("asdasd","asdasdasd");
                    $("#flowId").val(data.message);
                    var flowId = data.message;
                    var url = "${ctx}/usedinfo/assetUsedInfo/getNextFlowBusiness?bizKey=" + $("#id").val() + "&step=${assetUsedInfo.step}";
                    $.post(url, function (data) {
                        if (data == 0) {//审批最后一步
                            console.log("审批最后一步", data);
                            var stepId = "${param.stepId}";
                            var urls = "${ctx}/usedinfo/assetUsedInfo/agreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=0" + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val();
                            $.post(urls, function (data) {
                                showMessage("确认成功");
                                if (data.result == Global.TRUE) {
                                    closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                                        contentWindow.page();
                                    });
                                }
                            }, "json");
                        }
                        else if (data == 1) {
                            if (${assetUsedInfo.step==1}) {
                                var url = "${ctx}/eflow/flowBusiness/nextApprovalSelect?bizKey=${assetUsedInfo.id}&flowId=" + flowId + "&step=${assetUsedInfo.step}";
                                $("#nextApprovalDiv").attr("data-url", url);
                                $("#nextApprovalName").click();
                            } else if (${assetUsedInfo.step==2}) {
                                var url = "${ctx}/approval/flowHelp/getFlowren?flowId=" + $("#id").val() + "&step=2&";
                                $.ajax({
                                    async: false, type: "POST", url: url, dataType: 'json',
                                    success: function (data) {
                                        console.log("date", data.applicantCode);
                                        chengenextApprovalCallbackForMap(data);
                                    }
                                });
                            } else if (${assetUsedInfo.step==3}) {
                                var url = "${ctx}/approval/flowHelp/getFlowren?flowId=" + $("#id").val() + "&step=1&";
                                $.ajax({
                                    async: false, type: "POST", url: url, dataType: 'json',
                                    success: function (data) {
                                        console.log("date", data.applicantCode);
                                        chengenextApprovalCallbackForMap(data);
                                    }
                                });
                            } else {
                                console.log("审批不是最后一步", data);
                                var url = "${ctx}/usedinfo/assetUsedInfo/nextApprovalSelect?bizKey=${assetUsedInfo.id}&flowId=" + flowId + "&step=${assetUsedInfo.step}&";
                                $("#nextApprovalDiv").attr("data-url", url);
                                $("#nextApprovalName").click();
                            }

                        }
                    });

                }
            }, "json"
        )


    })

    //驳回
    $("#btnReject").click(function () {
        var stepId = "${param.stepId}";
        var url = "${ctx}/usedinfo/assetUsedInfo/disagreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val();
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
        var url = "${ctx}/usedinfo/assetUsedInfo/unDo?bizKey=" + $("#id").val();
        $.post(url, function (data) {
            showMessage(data.messagePc);
            if (data.code == "200") {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");

    })

    function chengenextApprovalCallbackForMap(data) {
        $("#nextApprovalCode").val(data.applicantCode);
        $("#nextApprovalName").val(data.applicantName);
        console.log("date", data.applicantCode);
        console.log("date", data.applicantName);
        var dg = $('#dataGrid');
        updateListFieldName(dg, 'assetUsedDtls', 'assetCode');
        updateListFieldName(dg, 'assetUsedDtls', 'assetName');
        updateListFieldName(dg, 'assetUsedDtls', 'sortCode');
        updateListFieldName(dg, 'assetUsedDtls', 'sortName');
        updateListFieldName(dg, 'assetUsedDtls', 'brand');
        updateListFieldName(dg, 'assetUsedDtls', 'version');
        updateListFieldName(dg, 'assetUsedDtls', 'companyCode');
        updateListFieldName(dg, 'assetUsedDtls', 'companyName');
        updateListFieldName(dg, 'assetUsedDtls', 'storagePlace');

        $("#inputForm").submit();    //提交ID为inputForm的表单
        var nextApprovalCode = $("#nextApprovalCode").val();
        var nextApprovalName = $("#nextApprovalName").val();
        var stepId = "${param.stepId}";
        var url = "${ctx}/usedinfo/assetUsedInfo/agreePC?flowBusinessId=" + stepId + "&nextApprovalCode=" + nextApprovalCode + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=1" + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val() + "&nextApprovalName=" + nextApprovalName;
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

    //选择下一步审批人的回调函数
    function nextApprovalCallbackForMap(dataMap, v, h, f) {
        $.each(dataMap, function (key, value) {
            $("#nextApprovalCode").val(value.userCode);
            $("#nextApprovalName").val(value.userName);
        })
        var dg = $('#dataGrid');
        updateListFieldName(dg, 'assetUsedDtls', 'assetCode');
        updateListFieldName(dg, 'assetUsedDtls', 'assetName');
        updateListFieldName(dg, 'assetUsedDtls', 'sortCode');
        updateListFieldName(dg, 'assetUsedDtls', 'sortName');
        updateListFieldName(dg, 'assetUsedDtls', 'brand');
        updateListFieldName(dg, 'assetUsedDtls', 'version');
        updateListFieldName(dg, 'assetUsedDtls', 'companyCode');
        updateListFieldName(dg, 'assetUsedDtls', 'companyName');
        updateListFieldName(dg, 'assetUsedDtls', 'storagePlace');
        $("#inputForm").submit();    //提交ID为inputForm的表单
        var nextApprovalCode = $("#nextApprovalCode").val();
        var nextApprovalName = $("#nextApprovalName").val();
        var stepId = "${param.stepId}";
        var url = "${ctx}/usedinfo/assetUsedInfo/agreePC?flowBusinessId=" + stepId + "&nextApprovalCode=" + nextApprovalCode + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=1" + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val() + "&nextApprovalName=" + nextApprovalName;
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
        var dg = $('#dataGrid');
        updateListFieldName(dg, 'assetUsedDtls', 'assetCode');
        updateListFieldName(dg, 'assetUsedDtls', 'assetName');
        updateListFieldName(dg, 'assetUsedDtls', 'sortCode');
        updateListFieldName(dg, 'assetUsedDtls', 'sortName');
        updateListFieldName(dg, 'assetUsedDtls', 'brand');
        updateListFieldName(dg, 'assetUsedDtls', 'version');
        updateListFieldName(dg, 'assetUsedDtls', 'companyCode');
        updateListFieldName(dg, 'assetUsedDtls', 'companyName');
        updateListFieldName(dg, 'assetUsedDtls', 'storagePlace');
        $("#inputForm").submit();
    }


    //撤回申请
    $("#btnUnSubmit").click(function () {
        var url = "${ctx}/usedinfo/assetUsedInfo/unSubmit?bizKey=" + $("#id").val();
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
        var url = "${ctx}/usedinfo/assetUsedInfo/delete?id=" + $("#id").val();
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