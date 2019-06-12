<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产调拨 - ${assetAllotInfo.isNewRecord ? '新增' : '编辑'}资产调拨" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${assetAllotInfo.isNewRecord ? '新增' : '编辑'}资产调拨</div>
        <div class="actions">
            <div class="actions">
                <c:choose>
                    <c:when test="${assetAllotInfo.isNewRecord == true}">
                        <button id="btnSubmit" type="button" class="btn btn-primary">
                            <i class="fa fa-check"></i> 提交
                        </button>
                        <button id="btnAllot" type="button" class="btn btn-primary">
                            <i class="fa fa-check"></i> 调拨
                        </button>
                        <button id="btnAllotjuan" type="button" class="btn btn-primary">
                            <i class="fa fa-check"></i> 捐献
                        </button>
                    </c:when>
                    <c:when test="${assetAllotInfo.pageFlag == 0}">
                        <c:choose>
                            <c:when test="${assetAllotInfo.approvalStatus !=1}">
                                <button id="btnSubmit" type="button" class="btn btn-primary">
                                    <i class="fa  fa-check"></i> 提 交
                                </button>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${assetAllotInfo.approvalStatus !=0}">
                                <c:choose>
                                    <c:when test="${assetAllotInfo.approvalStatus !=3}">
                                        <button id="btnUnSubmit" type="button"
                                                class="btn btn-primary">
                                            <i class="fa fa-reply-all"></i> 撤回申请
                                        </button>
                                    </c:when>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </c:when>
                    <c:when test="${assetAllotInfo.pageFlag == 1}">
                        <!-- 我的待办 -->
                        <c:choose>
                            <c:when test="${assetAllotInfo.step<=1}">
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
                            <c:when test="${assetAllotInfo.step>=2}">
                                <button id="btnAuditPass" type="button"
                                        class="btn btn-primary">
                                    <i class="fa fa-check"></i></i>确认
                                </button>
                            </c:when>
                        </c:choose>
                    </c:when>
                    <c:when test="${assetAllotInfo.pageFlag == 2}">
                        <!-- 我的已办 -->
                        <button id="btnUndo" type="button" class="btn btn-primary">
                            <i class="fa fa-reply-all"></i> 撤回审批
                        </button>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${assetAllotInfo.approvalStatus==0}">
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
    </div>
</div>
<div class="portlet-body form">
    <form:form id="inputForm" modelAttribute="assetAllotInfo" action="${ctx}/allotinfo/assetAllotInfo/save"
               method="post" class="form-horizontal">
    <div class="form-body">
        <form:hidden path="id"/>
        <form:hidden path="companyCode"/>
        <form:hidden path="step"/>
        <div class="row">
        </div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        <span class="required">*</span> 调拨人：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <sys:treeselect id="operatorName" name="operatorCode"
                                        value="${assetAllotInfo.operatorCode}" labelName="operatorName"
                                        labelValue="${assetAllotInfo.operatorName}"
                                        title="调拨人" url="/sys/office/treeData?type=3" cssClass=""
                                        allowClear="true" notAllowSelectParent="true" isAll="true"/>
                    </div>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        <span class="required">*</span> 调拨日期：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <input name="allotDate" type="text" readonly="readonly" maxlength="20"
                               class="form-control Wdate required"
                               value="<fmt:formatDate value="${assetAllotInfo.allotDate}" pattern="yyyy-MM-dd HH:mm"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>

                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        <span class="required">*</span> 部门：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <sys:treeselect id="office" name="office"
                                        value="${assetAllotInfo.office}"
                                        labelName="officeName" labelValue="${assetAllotInfo.officeName}"
                                        title="使用部门" url="/sys/office/treeData?type=2" cssClass=""
                                        allowClear="true" notAllowSelectParent="true" isAll="true"/>
                    </div>
                </div>
            </div>

            <div class="col-xs-6">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        <span class="required">*</span> 调拨类型：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:select path="allotTypeCode" htmlEscape="false" maxlength="20"
                                     disabled="${assetAllotInfo.step>=1 ? 'true' : 'false'}"
                                     class="form-control required" onclick="getallotTypeCode()">
                            <form:options items="${fns:getUserDictList('ass_allot_type')}"
                                          itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                        </form:select>
                    </div>
                    <form:input path="allotTypeName" type="hidden"/>
                </div>
            </div>
        </div>
        <div class="row" style="margin-bottom: 30px">
            <div class="col-xs-6" id="allotOfficeDiv">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        <span class="required">*</span> 调拨后部门：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <sys:treeselect id="allotOfficeCode" name="allotOfficeCode"
                                        value="${assetAllotInfo.allotOfficeCode}"
                                        labelName="allotOfficeName" labelValue="${assetAllotInfo.allotOfficeName}"
                                        title="调拨后使用部门" url="/sys/office/treeData?type=2" cssClass=""
                                        allowClear="true" notAllowSelectParent="true" isAll="true"/>
                    </div>
                </div>
            </div>
            <div class="col-xs-6" id="allotCompanyNameDiv">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        新单位：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:input path="allotCompanyName" htmlEscape="false" maxlength="64"
                                    class="form-control"/>
                    </div>
                </div>
            </div>
            <c:choose>
                <c:when test="${assetAllotInfo.step==2}">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 使用人：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect id="allotUserCode" name="allotUserCode"
                                                value="${assetAllotInfo.allotUserCode}" labelName="allotUserName"
                                                labelValue="${assetAllotInfo.allotUserName}"
                                                title="使用人" url="/sys/office/treeData?type=3" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </div>
        <c:choose>
            <c:when test="${assetAllotInfo.isNewRecord == true||assetAllotInfo.pageFlag == 0}">
                <div class="row">
                    <div class="col-sm-6" hidden="hidden">
                        <a href="#" id="btnAddRow" class="btn btn-default"><i
                                class="fa fa-plus"></i></a>
                    </div>
                    <div class="col-sm-6" style="margin-left: 2%">
                        <a href="#" id="btnAddRowinfo" onclick="selectInvWindow()" class="btn btn-default"><i
                                class="fa fa-plus"></i>选择资产</a>
                    </div>
                </div>
            </c:when>
        </c:choose>
        <div class="row">
            <div class="col-sm-12"style="margin-left: 2%">
                <table id="assetAllotDtlDataGrid"></table>
                <div id="dataGridPage"></div>
            </div>
        </div>
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
        <c:if test="${assetAllotInfo.pageFlag == 1||assetAllotInfo.pageFlag == 2}">
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group" hidden="hidden">
                        <label class="control-label col-sm-2">处理意见：</label>
                        <div class="col-sm-8">
                            <form:textarea path="approvalMemo" htmlEscape="false" rows="4" maxlength="255" value=""
                                           class="form-control"/>
                            <span class="help-block">&nbsp;</span>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        </form:form>
        <form:form id="searchForm2" method="post"
                   action="${ctx}/allotinfo/assetAllotInfo/getDtlData?allotCode=${allotCode}">
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    //初始化资产调拨信息子表DataGrid对象
    $("#assetAllotDtlDataGrid").dataGrid({
        searchForm: $("#searchForm2"), // 数据来源表单
        autoGridHeight: function () {
            return 'auto'
        }, // 设置自动高度
        // 设置数据表格列
        columnModel: [
            {
                header: '资产编码',
                name: 'assetCode',
                width: 150,
                editoptions: {'maxlength': '64', 'class': 'form-control'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '资产名称',
                name: 'assetName',
                width: 150,
                editoptions: {'maxlength': '100', 'class': 'form-control'},
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
                editoptions: {'maxlength': '64', 'class': 'form-control'},
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
                editoptions: {'maxlength': '100', 'class': 'form-control'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '品牌',
                name: 'brand',
                width: 150,
                editoptions: {'maxlength': '100', 'class': 'form-control'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '型号',
                name: 'version',
                width: 150,
                editoptions: {'maxlength': '64', 'class': 'form-control'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '单价',
                name: 'unitPrice',
                width: 150,
                editoptions: {'class': 'form-control number'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unitPrice" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '计量单位',
                name: 'unit',
                width: 150,
                editoptions: {'class': 'form-control number'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unit" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '使用部门',
                name: 'officeName',
                width: 150,
                editoptions: {'maxlength': '100', 'class': 'form-control'},
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="officeName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '区域编码',
                name: 'regionCode',
                width: 150,
                editoptions: {'maxlength': '64', 'class': 'form-control'},
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="regionCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '区域名称',
                name: 'regionName',
                width: 150,
                editoptions: {'maxlength': '100', 'class': 'form-control'},
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="regionName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '责任人编码',
                name: 'dutyCode',
                width: 150,
                editoptions: {'maxlength': '64', 'class': 'form-control'},
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="dutyCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '责任人名称',
                name: 'dutyName',
                width: 150,
                editoptions: {'maxlength': '64', 'class': 'form-control'},
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="dutyName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '存放地点',
                name: 'storagePlace',
                width: 150,
                editoptions: {'maxlength': '64', 'class': 'form-control'},
                hidden: true,
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
                width: 80,
                sortable: false,
                hidden: ${assetAllotInfo.pageFlag == 0||assetAllotInfo.isNewRecord ? 'false' : 'true'},
                fixed: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    if (val == 'new') {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetAllotDtlDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    } else {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetAllotDtlDataGrid\').dataGrid(\'setRowData\',\'' + obj.rowId + '\',null,{display:\'none\'});$(\'#' + obj.rowId + '_status\').val(\'' + Global.STATUS_DELETE + '\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
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
    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldNameAllot(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
        });
    }
    function getexisting() {
        var assetcodes = [];
        $("#assetAllotDtlDataGrid").find("[name$='assetCode']").each(function () {
            assetcodes.push($(this).val());
        });
        return assetcodes;
    }
    //选择资产
    function selectInvWindow() {
        var assetcodes = getexisting();
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/allotinfo/assetAllotInfo/getusedDtllist?assetCodes=" + assetcodes + "&office=" + $("#officeCode").val() + "&assetStatus=1", "选择资产", $(window).width() - 100, $(window).height() - 100,
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
                            var selRow = $("#assetAllotDtlDataGrid").dataGrid("getSelectRow");

                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {assetCode: value.assetCode});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {assetName: value.assetName});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {version: value.version});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {unitPrice: value.unitPrice});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {unit: value.unit});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {snCode: value.snCode});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {companyCode: value.companyCode});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {companyName: value.companyName});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {officeName: value.officeName});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {regionCode: value.regionCode});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {regionName: value.regionName});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {dutyCode: value.dutyCode});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {dutyName: value.dutyName});
                            $("#assetAllotDtlDataGrid").dataGrid("setRowData", selRow, {storagePlace: value.storagePlace});
                        });
                    }
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }

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
    var voucherList =${fns:toJson(locations)};

    function selProjectName() {
        var storagePlaceCode = $("#storagePlaceCode").val();
        $.each(voucherList, function (key, value) {
            if (storagePlaceCode == value.localeCode) {
                $("#storagePlace").val(value.localeName);
            }
        });
        console.log("得到", $("#storagePlace").val());
    }

    $("#allotOfficeDiv").removeAttr("style");
    $("#storagePlaceDiv").removeAttr("style");
    $("#allotCompanyNameDiv").attr("style", "display:none;");
    $("#btnAllot").attr("style", "display:none;");
    $("#btnAllotjuan").attr("style", "display:none;");
    $("#allotTypeName").val("调拨到部门");

    function getallotTypeCode() {
        var selectallotType = $("#allotTypeCode").val();
        $("#allotTypeName").val($("#allotTypeCode").select2("data").text);
        console.log("sss", selectallotType);
        if (selectallotType == 01) {
            $("#allotOfficeDiv").removeAttr("style");
            $("#storagePlaceDiv").removeAttr("style");
            $("#allotCompanyNameDiv").attr("style", "display:none;");
            $("#btnSubmit").removeAttr("style");
            $("#btnAllot").attr("style", "display:none;");
            $("#btnAllotjuan").attr("style", "display:none;");
        } else if (selectallotType == 02) {
            $("#allotOfficeDiv").attr("style", "display:none;");
            $("#storagePlaceDiv").attr("style", "display:none;");
            $("#allotCompanyNameDiv").removeAttr("style");
            $("#btnSubmit").attr("style", "display:none;");
            $("#btnAllot").removeAttr("style");
            $("#btnAllotjuan").attr("style", "display:none;");
        } else if (selectallotType == 03) {
            $("#allotOfficeDiv").attr("style", "display:none;");
            $("#storagePlaceDiv").attr("style", "display:none;");
            $("#allotCompanyNameDiv").attr("style", "display:none;");
            $("#btnSubmit").attr("style", "display:none;");
            $("#btnAllotjuan").removeAttr("style");
            $("#btnAllot").attr("style", "display:none;");
        }
    }

    $('#btnAllot').click(function () {
        var dg = $('#assetAllotDtlDataGrid');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'brand');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'version');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unitPrice');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unit');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'snCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'officeName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlaceCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlace');
        $("#inputForm").submit();
    })
    $('#btnAllotjuan').click(function () {
        var dg = $('#assetAllotDtlDataGrid');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'brand');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'version');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unitPrice');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unit');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'snCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'officeName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlaceCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlace');
        $("#inputForm").submit();
    })
    //工作流对应模板
    $('#btnSubmit').click(function () {
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "ZCDB", // 对应工作流模板的单据类型
                "companyCode": $("#companyName").val(),// 申请人公司编码
                "officeCode": $("#officeCode").val() // 申请人部门编码
            },
            function (data) {
                console.log("查找工作流对应模板", data);
                if ($("#allotOfficeCodeName").val()=='') {
                    showMessage("请选择调拨后部门");
                } else {
                    if (data.result == Global.FALSE) {
                        showMessage(data.message);
                    } else {
                        $("#flowId").val(data.message);
                        var url = "${ctx}/eflow/flowBusiness/approvalSelect?applicantCode=" + $("#applicantCode").val() + "&flowId=" + data.message;
                        $("#approvalDiv").attr("data-url", url);
                        $("#approvalName").click();
                    }

                }
            }, "json"
        )
    });
    //审批通过
    $("#btnAuditPass").click(function () {
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "ZCDB", // 对应工作流模板的单据类型
                "companyCode": $("#companyName").val(),// 申请人公司编码
                "officeCode": $("#officeCode").val() // 申请人部门编码
            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    $("#flowId").val(data.message);
                    var flowId = data.message;
                    var url = "${ctx}/allotinfo/assetAllotInfo/getNextFlowBusiness?bizKey=" + $("#id").val() + "&step=${assetAllotInfo.step}";
                    $.post(url, function (data) {
                        if (data == 0) {//审批最后一步
                            console.log("审批最后一步", data);
                            var dg = $('#assetAllotDtlDataGrid');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetCode');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetName');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortCode');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortName');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'brand');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'version');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unitPrice');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unit');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'snCode');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyCode');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyName');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'officeName');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionCode');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionName');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyCode');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyName');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlaceCode');
                            updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlace');
                            $("#inputForm").submit();
                            var stepId = "${param.stepId}";
                            var urls = "${ctx}/allotinfo/assetAllotInfo/agreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=0" + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val();
                            $.post(urls, function (data) {
                                showMessage("确认成功");
                                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                                    contentWindow.page();
                                });
                            }, "json");
                        }
                        else if (data == 1) {
                            var url = "${ctx}/allotinfo/assetAllotInfo/nextApprovalSelect?bizKey=${assetAllotInfo.id}&flowId=" + flowId + "&step=${assetAllotInfo.step}&allotOfficeCode=" + $("#allotOfficeCodeCode").val();
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
        var assetcodes = getexisting();
        var stepId = "${param.stepId}";
        var url = "${ctx}/allotinfo/assetAllotInfo/disagreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val() + "&assetCodes=" + assetcodes;
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
        var url = "${ctx}/allotinfo/assetAllotInfo/unDo?bizKey=" + $("#id").val();
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
        console.log("___________AA__________");
        $.each(dataMap, function (key, value) {
            $("#nextApprovalCode").val(value.userCode);
            $("#nextApprovalName").val(value.userName);
        })
        var dg = $('#assetAllotDtlDataGrid');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'brand');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'version');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unitPrice');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unit');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'snCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'officeName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlaceCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlace');
        var nextApprovalCode = $("#nextApprovalCode").val();
        var nextApprovalName = $("#nextApprovalName").val();
        var stepId = "${param.stepId}";
        var url = "${ctx}/allotinfo/assetAllotInfo/agreePC?flowBusinessId=" + stepId + "&nextApprovalCode=" + nextApprovalCode + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=1" + "&sysCode=" + $("#id").val() + "&id=" + $("#id").val() + "&nextApprovalName=" + nextApprovalName;
        $.post(url, function (data) {
            $("#inputForm").submit();
            console.log("___________bb__________");
            closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                contentWindow.page();
            });
        }, "json");
    }

    function approvalCallbackForMap(dataMap, v, h, f) {
        $.each(dataMap, function (key, value) {
            $("#approvalCode").val(value.userCode);

        });
        var dg = $('#assetAllotDtlDataGrid');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'assetName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'sortName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'brand');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'version');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unitPrice');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'unit');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'snCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'companyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'officeName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'regionName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'dutyName');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlaceCode');
        updateListFieldNameAllot(dg, 'assetAllotDtlList', 'storagePlace');
        $("#inputForm").submit();
    }

    //撤回申请
    $("#btnUnSubmit").click(function () {
        var assetcodes = getexisting();
        var url = "${ctx}/allotinfo/assetAllotInfo/unSubmit?bizKey=" + $("#id").val() + "&assetCodes=" + assetcodes;
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
        var assetcodes = getexisting();
        var stepId = "${param.stepId}";
        var url = "${ctx}/allotinfo/assetAllotInfo/delete?id=" + $("#id").val() + "&assetCodes=" + assetcodes;
        $.post(url, function (data) {
            showMessage(data.message);
            if (data.result == Global.TRUE) {
                closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                    contentWindow.page();
                });

            }
        }, "json");
    })

    function allotOfficeCodeTreeselectCallBack(v, h, f) {
        if ($("#officeCode").val() == $("#allotOfficeCodeCode").val()) {
            $("#allotOfficeCodeCode").val("");
            $("#allotOfficeCodeName").val("");
            showMessage("调拨后部门不能与原部门相同");
        } else {
        }
    }
</script>
