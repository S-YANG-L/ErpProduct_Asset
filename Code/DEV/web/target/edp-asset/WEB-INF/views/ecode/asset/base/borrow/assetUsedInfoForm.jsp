<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产领用管理 - ${assetUsedInfo.isNewRecord ? '新增' : '编辑'}资产领用" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${assetUsedInfo.isNewRecord ? '新增' : '编辑'}资产领用</div>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="assetUsedInfo" action="${ctx}/usedinfo/assetUsedInfo/save"
                   method="post" class="form-horizontal">
            <div class="form-body">
                <form:hidden path="id"/>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 领用人：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect id="receiverCode" name="receiverCode"
                                                value="${assetUsedInfo.receiverName}" labelName="receiverName"
                                                labelValue="${assetUsedInfo.receiverName}"
                                                title="使用人" url="/sys/office/treeData?type=3" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 领用日期：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <input name="receiverDate" type="text" readonly="readonly" maxlength="20"
                                       class="form-control Wdate required"
                                       value="<fmt:formatDate value="${assetUsedInfo.receiverDate}" pattern="yyyy-MM-dd HH:mm"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 领用后公司名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="usedCompanyName" htmlEscape="false" maxlength="100"
                                            class="form-control required"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                领用后部门名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect id="usedOfficeCode" name="usedOfficeCode"
                                                value="${assetUsedInfo.usedOfficeName}"
                                                labelName="usedOfficeName" labelValue="${assetUsedInfo.usedOfficeName}"
                                                title="部门" url="/sys/office/treeData?type=2" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 区域名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:select path="usedRegionCode" htmlEscape="false" maxlength="20"
                                             class="form-control required" onclick="getusedRegionCode()">
                                    <form:options items="${fns:getUserDictList('ass_area')}"
                                                  itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                                </form:select>
                            </div>
                            <form:input path="usedRegionName" type="hidden"/>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                领用后存放地点：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="usedStoragePlace" htmlEscape="false" maxlength="100"
                                            class="form-control"/>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                说明：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="notes" htmlEscape="false" maxlength="100" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                审核状态：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="approveStatus" htmlEscape="false" maxlength="1" class="form-control"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="control-label col-sm-2" title="">
                                备注信息：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-10">
                                <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000"
                                               class="form-control"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <a href="#" id="btnAddRow" onclick="selectInvWindow()" class="btn btn-default"><i
                            class="fa fa-plus"></i>选择资产</a>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <table id="dataGrid"></table>
                    <div id="dataGridPage"></div>
                </div>
            </div>
            <div class="form-actions fluid">
                <div class="row">
                    <div class="col-sm-offset-2 col-sm-10">
                        <shiro:hasPermission name="usedinfo:assetUsedInfo:edit">
                            <button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存
                            </button>
                            &nbsp;
                        </shiro:hasPermission>
                        <button id="btnCancel" type="button" class="btn default"
                                onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i
                                class="fa fa-reply-all"></i> 关 闭
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
        <from:form id="searchForm2" method="post" action="${ctx}/usedinfo/assetUsedInfo/getDtlData?usedCode=${usedCode}">
        </from:form>
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
    //全局变量存选中的资产表的id
    var codes="";
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm2"), // 数据来源表单
        columnModel: [
            {header: '资产编码', name: 'assetCode', width: 200, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {header: '资产名称', name: 'assetName', edittype: 'text', width: 200, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {header: '资产分类编码',
                name: 'sortCode',
                width: 200,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {header: '资产分类名称',
                name: 'sortName',
                width: 200,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {header: '品牌', name: 'brand', width: 200, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {header: '型号', name: 'version', width: 200, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {header: '公司编码',
                name: 'companyCode',
                width: 200,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="companyCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '公司名称',
                name: 'companyName',
                width: 200,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="companyName" value="' + val + '" />');
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
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\');updateid()});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
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
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/usedinfo/assetUsedInfo/getusedDtllist", "选择资产", $(window).width() - 100, $(window).height() - 100,
            {
                ajaxData: {selectData: selectData},
                buttons: {
                    "<i class=glyphicon glyphicon-ok></i>&nbsp;确定": "ok",
                    /* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
                    '<i class=glyphicon glyphicon-remove></i>&nbsp;关闭': "close"
                },
                submit: function (v, h, f) { // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                    var w = h.find("iframe")[0].contentWindow;
                    var dataMap = w.getDataMap();
                    var ids = [];
                    var assetCodes = [];
                    var assetNames = [];
                    var sortCodes = [];
                    var sortNames = [];
                    var brands = [];
                    var versions = [];
                    var companyCodes = [];
                    var companyNames = [];
                    $.each(dataMap, function (key, value) {
                        ids.push(value.id);
                        assetCodes.push(value.assetCode);
                        assetNames.push(value.assetName);
                        sortCodes.push(value.sortCode);
                        sortNames.push(value.sortName);
                        brands.push(value.brand);
                        versions.push(value.version);
                        companyCodes.push(value.companyCode);
                        companyNames.push(value.companyName);
                    });
                    var selRow = $("#dataGrid").dataGrid("getSelectRow");
                    $("#dataGrid").dataGrid("setRowData", selRow, {assetCode: assetCodes});
                    $("#dataGrid").dataGrid("setRowData", selRow, {assetName: assetNames});
                    $("#dataGrid").dataGrid("setRowData", selRow, {sortCode: sortCodes});
                    $("#dataGrid").dataGrid("setRowData", selRow, {sortName: sortNames});
                    $("#dataGrid").dataGrid("setRowData", selRow, {brand: brands});
                    $("#dataGrid").dataGrid("setRowData", selRow, {version: versions});
                    $("#dataGrid").dataGrid("setRowData", selRow, {companyCode: companyCodes});
                    $("#dataGrid").dataGrid("setRowData", selRow, {companyName: companyNames});
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });

    }

    //重写执行发送的方法.
    $("#btnSubmit").click(function () {
        var dg = $('#dataGrid');
        updateListFieldName(dg, 'assetUsedDtls', 'assetCode');
        updateListFieldName(dg, 'assetUsedDtls', 'assetName');
        updateListFieldName(dg, 'assetUsedDtls', 'sortCode');
        updateListFieldName(dg, 'assetUsedDtls', 'sortName');
        updateListFieldName(dg, 'assetUsedDtls', 'brand');
        updateListFieldName(dg, 'assetUsedDtls', 'version');
        updateListFieldName(dg, 'assetUsedDtls', 'companyCode');
        updateListFieldName(dg, 'assetUsedDtls', 'companyName');
        $("#inputForm").submit();
    });

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
</script>