<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产清理管理 - ${assetClean.isNewRecord ? '新增' : '编辑'}资产清理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${assetClean.isNewRecord ? '新增' : '查看'}资产清理</div>
        <div class="actions">
            <c:choose>
                <c:when test="${assetClean.isNewRecord == true}">
                    <button id="btnSave" type="submit" class="btn btn-primary">
                        <i class="fa fa-check"></i> 提 交
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
        <form:form id="inputForm" modelAttribute="assetClean" action="${ctx}/assetsclean/assetClean/save" method="post"
                   class="form-horizontal">
            <div class="form-body">
                <form:hidden path="id"/>
                <form:hidden path="companyCode"/>
                <table class="table table-bordered">
                    <tr>
                        <td class="judp-table-lable" align="right"><span class="required red">*</span> 清理人：<i
                                class="fa icon-question hide"></i></td>
                        <td class="judp-table-content">
                            <form:input path="cleanerName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
                                <%-- <sys:treeselect id="cleanerCode" name="cleanerCode"
                                                    value="${assetClean.cleanerCode}" labelName="cleanerName"
                                                    labelValue="${assetClean.cleanerName}"
                                                    title="借用人" url="/sys/office/treeData?type=3" cssClass=""
                                                    allowClear="true" notAllowSelectParent="true" isAll="true"/> --%>
                        </td>
                        <td class="judp-table-lable" align="right"><span class="required red">*</span> 清理日期：<i
                                class="fa icon-question hide"></i></td>
                        <td class="judp-table-content">
                            <input name="cleanDate" id="cleanDate" type="text" readonly="true" maxlength="20"
                                   class="form-control Wdate required"
                                   value="<fmt:formatDate value="${assetClean.cleanDate}" pattern="yyyy-MM-dd "/>"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',isShowClear:false,maxDate:'#F{$dp.$D(\'expectedReturnDate\')}'});"/>
                        </td>

                    </tr>
                    <tr>
                        <td rowspan="1" class=" judp-table-lable" style="" align="right">说明：<i
                                class="fa icon-question hide"></i></td>
                        <td colspan="5" rowspan="1" class=" judp-table-content">
                            <form:textarea path="notes" htmlEscpace="false" rows="2" maxlength="255"
                                           class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" class="judp-table-tab-content">
                            <table id="assetReturnDtlDataGrid"></table>
                        </td>
                    </tr>
                </table>
            </div>
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    //全局变量存选中的资产表的assetCode
    var assetcodes = [];
    $("#assetReturnDtlDataGrid").dataGrid({
        data: ${fns:toJson(assetCleanDtlList)},
        datatype: "local", // 设置本地数据
        columnModel: [
            {
                header: '资产编码', name: 'assetCode', width: 240, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '资产名称', name: 'assetName', edittype: 'text', width: 200, align: "left",
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
                width: 200,
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
                header: '资产小类',
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
            {
                header: '品牌', name: 'brand', width: 200, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '型号', name: 'version', width: 200, align: "left", formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '公司编码',
                name: 'companyCode',
                width: 200,
                align: "left",
                hidden: true,
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
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="companyName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '存放地点',
                name: 'storagePlace',
                width: 150,
                align: "left",
                hidden: true,
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
                header: '操作',
                name: 'actions',
                width: 80,
                sortable: false,
                fixed: true,
                hidden: ${assetClean.isNewRecord? 'false' : 'true'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetReturnDtlDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
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
    function selectInvWindow() {
        geretuentexisting();//下一步选择资产时 过滤已经选中的
        var assetcode = assetcodes.join(',')
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/assetsclean/assetClean/getusedDtllist?assetCode=" + assetcode + "&sortCode=" + $("#assetClassCodeCode").val(), "选择资产", $(window).width() - 100, $(window).height() - 100,
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
                    $.each(dataMap, function (key, value) {
                        $('#btnAddRow').click();
                        var selRow = $("#assetReturnDtlDataGrid").dataGrid("getSelectRow");
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {assetCode: value.assetCode});
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {assetName: value.assetName});
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {version: value.version});
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {companyCode: value.companyCode});
                        $("#assetReturnDtlDataGrid").dataGrid("setRowData", selRow, {companyName: value.companyName});
                    });

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

    //保存
    $("#btnSave").click(function () {
        var dg = $('#assetReturnDtlDataGrid');
        updateListFieldName(dg, 'assetCleanDtlList', 'assetCode');
        updateListFieldName(dg, 'assetCleanDtlList', 'assetName');
        updateListFieldName(dg, 'assetCleanDtlList', 'sortCode');
        updateListFieldName(dg, 'assetCleanDtlList', 'sortName');
        updateListFieldName(dg, 'assetCleanDtlList', 'brand');
        updateListFieldName(dg, 'assetCleanDtlList', 'version');
        updateListFieldName(dg, 'assetCleanDtlList', 'companyCode');
        updateListFieldName(dg, 'assetCleanDtlList', 'companyName');
        $("#inputForm").submit();
    });
</script>
