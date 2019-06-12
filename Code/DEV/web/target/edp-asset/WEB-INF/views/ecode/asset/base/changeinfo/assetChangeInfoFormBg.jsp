<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid,fileupload"/>
<sys:header title="实物信息变更 - ${assetChangeInfo.isNewRecord ? '新增' : '编辑'}实物信息变更" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${assetChangeInfo.isNewRecord ? '新增' : '查看'}实物信息变更</div>
        <%-- <div class="actions">
            <shiro:hasPermission name="changeinfo:assetChangeInfo:edit">
                <a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
            </shiro:hasPermission>
            <a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
        </div> --%>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="assetChangeInfo" action="${ctx}/changeinfo/assetChangeInfo/save"
                   method="post" class="form-horizontal">
        <div class="form-body">
            <form:hidden path="id"/>
            <table id="assetChangeDtlDataGrid"></table>
        </div>
        <h4 class="form-section">变更内容</h4>
        <div class="row" hidden="true">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        变更人：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <sys:treeselect id="operatorName" name="operatorCode"
                                        value="${assetChangeInfo.operatorCode}" labelName="operatorName"
                                        labelValue="${assetChangeInfo.operatorName}"
                                        title="使用人" url="/sys/office/treeData?type=3" cssClass=""
                                        allowClear="true" notAllowSelectParent="true" isAll="true"/>
                    </div>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        变更时间：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <input name="changeDate" type="text" readonly="readonly" maxlength="20"
                               class="form-control Wdate required"
                               value="<fmt:formatDate value="${assetChangeInfo.changeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        资产大类：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <sys:treeselect url="${ctx}/ass/assetSort/treeDataTop" id="topSortCode"
                                        value="${assetChangeInfo.topSortCode}" labelName="topSortName"
                                        labelValue="${assetChangeInfo.topSortName}" title="资产大类"
                                        name="topSortCode"
                                        cssClass="rightBorder" allowClear="true"
                                        notAllowSelectParent="true" isAll="true">
                        </sys:treeselect>
                    </div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        资产小类：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <sys:treeselect url="${ctx}/ass/assetSort/treeDataXiaoNULL" id="sortCode"
                                        value="${assetChangeInfo.sortCode}" labelName="sortName"
                                        labelValue="${assetChangeInfo.sortName}" title="资产小类" name="sortCode"
                                        cssClass="rightBorder" allowClear="true"
                                        notAllowSelectParent="true" isAll="true">
                        </sys:treeselect>
                    </div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        资产名称：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:input path="assetName" htmlEscape="false" maxlength="100" onclick=""
                                    class="form-control"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        存放地点：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:select path="storagePlaceCode" class="form-control selectHeight"
                                     onchange="selProjectName()">
                            <form:option value=" ">&nbsp;</form:option>
                            <form:options items="${locations}" itemLabel="localeName" itemValue="localeCode"
                                          htmlEscape="false"/>
                        </form:select>
                        <form:hidden path="storagePlace"/>
                    </div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        区域名称：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:select path="regionCode" htmlEscape="false" maxlength="20"
                                     class="form-control " onclick="getregionCode()">
                            <form:option value=" ">&nbsp;</form:option>
                            <form:options items="${fns:getUserDictList('ass_area')}"
                                          itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                        </form:select>
                    </div>
                    <form:input path="regionName" type="hidden"/>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        供货商:<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:select path="supplierCode" class="form-control  selectHeight"
                                     onchange="supplierInfoName()">
                            <form:option value=" ">&nbsp;</form:option>
                            <form:options items="${supplierInfos}" itemLabel="supplierName"
                                          itemValue="id"
                                          htmlEscape="false"/>
                        </form:select>
                        <form:hidden path="supplier"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                         计量单位：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:input path="unit" htmlEscape="false" maxlength="64"
                                    class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        品牌：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:input path="brand" htmlEscape="false" maxlength="100"
                                    class="form-control "/>
                    </div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        型号：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:input path="version" htmlEscape="false" maxlength="64"
                                    class="form-control "/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4" title="">
                        备注信息：<i class="fa icon-question hide"></i></label>
                    <div class="col-sm-8">
                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000"
                                       class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="form-group">
                    <label class="control-label col-sm-4">图片： </label>
                    <div class="col-sm-7">
                        <sys:fileupload maxUploadNum="1" id="picturePath" bizCategory="picturePath"
                                        bizKey="${assetChangeInfo.picturePath}" uploadType="image" returnPath="true"/>
                    </div>

                </div>
            </div>
        </div>

    </div>
    <div class="form-actions fluid">
        <div class="row">
            <div class="col-sm-offset-2 col-sm-10">
                <shiro:hasPermission name="changeinfo:assetChangeInfo:edit">
                    <c:choose>
                        <c:when test="${assetChangeInfo.isNewRecord == true}">
                            <a id="btnSubmit" class="btn btn-primary"><i class="fa fa-check"></i> 变 更
                            </a>
                            &nbsp;
                        </c:when>
                    </c:choose>
                </shiro:hasPermission>
                <button id="btnCancel" type="button" class="btn default"
                        onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i
                        class="fa fa-reply-all"></i> 关 闭
                </button>
            </div>
        </div>
    </div>
    </form:form>
    <form:form id="searchForm2" method="post"
               action="${ctx}/changeinfo/assetChangeInfo/getDtlData?changeCode=${changeCode}">
    </form:form>
</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    //全局变量存选中的资产表的assetCode
    var assetcodes = [];
    var sum = 0;
    //初始化实物信息变更子表DataGrid对象
    $("#assetChangeDtlDataGrid").dataGrid({
        data: ${fns:toJson(assetChangeDtlList)},
        datatype: "local", // 设置本地数据
        autoGridHeight: function () {
            return 'auto'
        },
        columnModel: [
            {
                header: '资产编码',
                name: 'assetCode',
                width: 200,
                align: "left",
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
                width: 200,
                align: "left",
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
                header: '资产分类名称',
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
                header: '使用部门',
                name: 'officeName',
                width: 200,
                align: "left",
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
                width: 200,
                align: "left",
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
                width: 200,
                align: "left",
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
                width: 200,
                align: "left",
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
                width: 200,
                align: "left",
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
                width: 200,
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
                header: '品牌',
                name: 'brand',
                width: 200,
                align: "right",
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
                width: 200,
                align: "right",
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
                width: 200,
                align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unitPrice" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '操作',
                name: 'actions',
                width: 80,
                sortable: false,
                fixed: true,
                hidden: ${assetChangeInfo.isNewRecord? 'false' : 'true'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    if (val == 'new') {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetChangeDtlDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    } else {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetChangeDtlDataGrid\').dataGrid(\'setRowData\',\'' + obj.rowId + '\',null,{display:\'none\'});$(\'#' + obj.rowId + '_status\').val(\'' + Global.STATUS_DELETE + '\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
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
    $("#btnSubmit").click(function () {
        var dg = $('#assetChangeDtlDataGrid');
        updateListFieldName(dg, 'assetChangeDtlList', 'assetCode');
        updateListFieldName(dg, 'assetChangeDtlList', 'assetName');
        updateListFieldName(dg, 'assetChangeDtlList', 'sortCode');
        updateListFieldName(dg, 'assetChangeDtlList', 'sortName');
        updateListFieldName(dg, 'assetChangeDtlList', 'companyCode');
        updateListFieldName(dg, 'assetChangeDtlList', 'companyName');
        updateListFieldName(dg, 'assetChangeDtlList', 'officeName');
        updateListFieldName(dg, 'assetChangeDtlList', 'regionCode');
        updateListFieldName(dg, 'assetChangeDtlList', 'regionName');
        updateListFieldName(dg, 'assetChangeDtlList', 'dutyCode');
        updateListFieldName(dg, 'assetChangeDtlList', 'dutyName');
        updateListFieldName(dg, 'assetChangeDtlList', 'storagePlaceCode');
        updateListFieldName(dg, 'assetChangeDtlList', 'storagePlace');
        updateListFieldName(dg, 'assetChangeDtlList', 'brand');
        updateListFieldName(dg, 'assetChangeDtlList', 'version');
        updateListFieldName(dg, 'assetChangeDtlList', 'unitPrice');
        updateListFieldName(dg, 'assetChangeDtlList', 'snCode');
        if (sum > 0) {
            $("#inputForm").submit();
        } else {
            showMessage("请选择资产");
        }
    })

    //customerCode为id
    $("#sortCodeName").click(function(){
        var topSortCode = $("#topSortCodeCode").val();
        if(topSortCode == null || topSortCode == ""){
            showMessage("请先选择资产大类！");
        }
    })
    function getexisting() {
        assetcodes = [];
        $("#assetChangeDtlDataGrid").find("[name$='assetCode']").each(function () {
            assetcodes.push($(this).val());
        });
    }

    //选择资产
    function selectInvWindow() {
        getexisting();
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/changeinfo/assetChangeInfo/getusedDtllist?assetCodes=" + assetcodes, "选择资产", $(window).width() - 100, $(window).height() - 100,
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
                            var selRow = $("#assetChangeDtlDataGrid").dataGrid("getSelectRow");
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {assetCode: value.assetCode});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {assetName: value.assetName});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {companyCode: value.companyCode});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {companyName: value.companyName});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {officeName: value.officeName});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {regionCode: value.regionCode});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {regionName: value.regionName});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {dutyCode: value.dutyCode});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {dutyName: value.dutyName});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {storagePlaceCode: value.storagePlaceCode});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {storagePlace: value.storagePlace});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {version: value.version});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {unitPrice: value.unitPrice});
                            $("#assetChangeDtlDataGrid").dataGrid("setRowData", selRow, {snCode: value.snCode});
                        });
                    }
                    webuploaderRefresh();
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            sum++;
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
        });
    }

    //用户字典
    function getregionCode() {
        $("#regionName").val($("#regionCode").select2("data").text);
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
    // extCode
    function topSortCodeTreeselectCallBack(v, h, f) {
        console.log("asasas")
        var url = "${ctx}/ass/assetSort/treeDataXiao?id=" + $("#topSortCodeCode").val();
        $("#sortCodeDiv").attr("data-url", url);
        $("#sortCodeCode").val("");
        $("#sortCodeName").val("");
    }

    var voucherList =${fns:toJson(locations)};

    function selProjectName() {
        var storagePlaceCode = $("#storagePlaceCode").val();
        var storagePlaceName = "";
        $.each(voucherList, function (key, value) {
            if (storagePlaceCode == value.localeCode) {
                storagePlaceName = value.localeName;
            }
        });
        $("#storagePlace").val(storagePlaceName);
    }
</script>
