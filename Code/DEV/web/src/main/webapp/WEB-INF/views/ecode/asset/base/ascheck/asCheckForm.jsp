<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="办公用品盘点管理 - ${asCheck.isNewRecord ? '新增' : '查看'}办公用品盘点" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${asCheck.isNewRecord ? '新增' : '查看'}办公用品盘点</div>
        <div class="actions">
            <c:choose>
                <c:when test="${asCheck.isNewRecord}">
                    <shiro:hasPermission name="ascheck:asCheck:edit">
                        <button id="btnSubmit" type="submit" class="btn btn-primary"><i
                                class="fa fa-check"></i> 提交
                        </button>
                        <button id="btnSubmitTong" type="submit" class="btn btn-primary"><i
                                class="fa fa-coffee"></i> 同步
                        </button>
                        <button id="btnExport" type="submit" class="btn btn-primary"><i
                                class="fa fa-external-link"></i> 导出
                        </button>
                        <%--<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i--%>
                                <%--class="fa fa-external-link"></i> 导出</a>--%>
                    </shiro:hasPermission>
                </c:when>
            </c:choose>
            <button id="btnCancel" type="button" class="btn default"
                    onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i
                    class="fa fa-reply-all"></i> 关 闭
            </button>
        </div>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="asCheck" action="${ctx}/ascheck/asCheck/save" method="post"
                   class="form-horizontal">
            <div class="form-body">
                <form:hidden path="id"/>
                <table class="table table-bordered">
                    <tr>
                        <td class="judp-table-lable" align="right"><span class="required red">*</span>
                            盘点名称：<i class="fa icon-question hide"></i></td>
                        <td class="judp-table-content">
                            <form:input path="checkName" htmlEscape="false" maxlength="100"
                                        class="form-control required"/>
                        </td>
                        <td class="judp-table-lable" align="right"><span class="required red">*</span> 盘点人：</td>
                        <td class="judp-table-content">
                            <form:input path="operatorCode" htmlEscape="false" maxlength="100"
                                        class="form-control required hide"/>
                            <form:input path="operatorName" readonly="true" htmlEscape="false" maxlength="100"
                                        class="form-control required"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="judp-table-lable" align="right"><span class="required red">*</span>仓库名称：</td>
                        <td class="judp-table-content">
                            <form:select path="whCode" class="form-control required selectHeight"
                                         onChange="selProjectName()">
                                <form:option value="" label=""/>
                                <form:options items="${warehouses}" itemLabel="warehouseName"
                                              itemValue="warehouseCode" htmlEscape="false"/>
                            </form:select>
                            <form:hidden path="whName"/>
                        </td>
                        <td class="judp-table-lable" align="right"> 盘点时间：</td>
                        <td class="judp-table-content">
                            <input name="checkDate" type="text" readonly="readonly" maxlength="20"
                                   class="form-control Wdate "
                                   value="<fmt:formatDate value="${asCheck.checkDate}" pattern="yyyy-MM-dd "/>"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="1" class=" judp-table-lable" style="" align="right">备注：<i
                                class="fa icon-question hide"></i></td>
                        <td colspan="5" rowspan="1" class=" judp-table-content">
                            <form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="1000"
                                           class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" class="judp-table-tab-content">
                            <table id="asCheckDtlDataGrid"></table>
                        </td>
                    </tr>
                </table>
            </div>
        </form:form>
        <form:form id="searchForm" method="post"
                   action="${ctx}/ascheck/asCheck/findCheckCode?checkCode=${checkCode}">
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

    //全局变量存选中的仓库表的articlesCodes
    var articlesCodes = [];
    $("#asCheckDtlDataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        // 设置数据表格列
        columnModel: [
            {
                header: '办公用品编码', name: 'articlesCode', index: 'a.articles_code', width: 100,
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articlesCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公用品名称', name: 'articlesName', index: 'a.articles_name', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articlesName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类编码', name: 'sortCode', index: 'a.sort_code', width: 100,
                hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类名称', name: 'sortName', index: 'a.sort_name', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '品牌名称', name: 'brand', index: 'a.brand', width: 80,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '规格型号', name: 'version', index: 'a.version', width: 80,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '仓库编码', name: 'whCode', index: 'a.wh_code', width: 80, hidden: true,
                // hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="whCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '仓库名称', name: 'whName', index: 'a.wh_name', width: 80,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="whName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '初始数量', name: 'initialQty', index: 'a.initial_qty', width: 80, hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="initialQty" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '初始单价', name: 'initialPrice', index: 'a.initial_price', width: 80, hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="initialPrice" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '初始金额', name: 'initialMoney', index: 'a.initial_money', width: 80, hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="initialMoney" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '应盘数量', name: 'qty', index: 'a.qty', width: 80,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="qty" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '单价', name: 'price', index: 'a.price', width: 80, hidden: true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="price" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '实盘数量',
                name: 'checkQty',
                index: 'a.check_qty',
                width: 80,
                editable: ${asCheck.isNewRecord? 'true' : 'false'},
                edittype: 'text',
                editoptions: {
                    'maxlength': '100', 'class': 'form-control number'
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
                width: 50, fixed: true, sortable: false,
                hidden: ${asCheck.isNewRecord ? 'false' : 'true'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    if (val == 'new') {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#asCheckDtlDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    } else {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#asCheckDtlDataGrid\').dataGrid(\'setRowData\',\'' + obj.rowId + '\',null,{display:\'none\'});$(\'#' + obj.rowId + '_status\').val(\'' + Global.STATUS_DELETE + '\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
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
        },
        onSelectRow: function (id) {//id
        }
    });

    //数据导出
    $("#btnExport").click(function () {
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                ajaxDownload('${ctx}/wareitems/warehouseItems/warehouseItemsExport?whCode='+ $("#whCode").val(), $("#searchForm").serialize());
            }
        }, {buttonsFocus: 1});
        top.$('.jbox-body .jbox-icon').css('top', '55px');
    });

    /**
     * Ajax 文件下载   ajaxDownload('ExcelDownload.do','find=commoncode','post' );
     * @param url
     * @param data
     * @param method
     */
    function ajaxDownload(url, data, method) {
        // 获取url和data
        if (url && data) {
            // data 是 string 或者 array/object
            data = typeof data == 'string' ? data : jQuery.param(data);
            // 把参数组装成 form的 input
            var inputs = '';
            $.each(data.split('&'), function () {
                var pair = this.split('=');
                inputs += '<input type="hidden" name="' + pair[0] + '" value="'
                    + pair[1] + '" />';
            });
            // request发送请求
            $('<form action="' + url + '" method="' + (method || 'post')
                + '" >' + inputs + '</form>').appendTo('body').submit().remove();
        }
    }
    function getexisting() {
        articlesCodes = [];
        $("#asCheckDtlDataGrid").find("[name$='articlesCode']").each(function () {
            articlesCodes.push($(this).val());
        });
        return articlesCodes;
    }

    //选择资产
    function selectInvWindow() {
        if ($('#whCode').val() != "") {
            var articlesCodes = getexisting();
            var selectData = "";
            var $jBox = getJBox();
            $jBox.open("iframe:${ctx}/wareitems/warehouseItems/getWarehouseinfoCode?whCode=" + $('#whCode').val() + "&articlesCodes=" + articlesCodes, "选择仓库物品", $(window).width() - 100, $(window).height() - 100,
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
                            var selRow = $("#asCheckDtlDataGrid").dataGrid("getSelectRow");
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {articlesCode: value.articlesCode});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {articlesName: value.articlesName});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {version: value.version});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {whCode: value.whCode});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {whName: value.whName});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {initialQty: value.qty});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {initialPrice: value.price});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {initialMoney: value.sumMoney});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {qty: value.qty});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {whName: value.whName});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {price: value.price});
                            $("#asCheckDtlDataGrid").dataGrid("setRowData", selRow, {checkQty: value.checkQty});

                        });

                    },
                    loaded: function (h) {
                        $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                    }
                });
        } else {
            showMessage("请选择仓库");
        }

    }

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
        });
    }

    var whCode = "";
    var whList = ${fns:toJson(warehouses)};

    function selProjectName() {
        whCode = $("#whCode").val();
        $.each(whList, function (key, value) {
            if (whCode == value.warehouseCode) {
                $("#whName").val(value.warehouseName);
            }
        });
        var url = "${ctx}/wareitems/warehouseItems/listDataYuan?whCode=" + $("#whCode").val();
        $('#searchForm').attr('action', url);
        $('#searchForm').submit();
    }

    $("#btnSubmit").click(function () {
        var dg = $('#asCheckDtlDataGrid');
        updateListFieldName(dg, 'asCheckDtlList', 'articlesName');
        updateListFieldName(dg, 'asCheckDtlList', 'articlesCode');
        updateListFieldName(dg, 'asCheckDtlList', 'sortCode');
        updateListFieldName(dg, 'asCheckDtlList', 'sortName');
        updateListFieldName(dg, 'asCheckDtlList', 'whCode');
        updateListFieldName(dg, 'asCheckDtlList', 'whName');
        updateListFieldName(dg, 'asCheckDtlList', 'brand');
        updateListFieldName(dg, 'asCheckDtlList', 'version');
        updateListFieldName(dg, 'asCheckDtlList', 'initialQty');
        updateListFieldName(dg, 'asCheckDtlList', 'initialPrice');
        updateListFieldName(dg, 'asCheckDtlList', 'initialMoney');
        updateListFieldName(dg, 'asCheckDtlList', 'qty');
        updateListFieldName(dg, 'asCheckDtlList', 'price');
        updateListFieldName(dg, 'asCheckDtlList', 'checkQty');
        $("#inputForm").submit();
    })

    $("#btnSubmitTong").click(function () {
        if (whCode == "") {
            showMessage("请选择仓库");
        } else {
            var url = "${ctx}/wareitems/warehouseItems/listDataTong?whCode=" + $("#whCode").val();
            $('#searchForm').attr('action', url);
            $('#searchForm').submit();
        }
    })
</script>
