<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产入库管理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> <!-- 资产入库 -->资产查询</div>
        <div class="actions">
            <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
            <shiro:hasPermission name="ass:assetInfo:edit">
                <%-- <a href="${ctx}/ass/assetInfo/form" class="btn btn-default btn-sm btnTool" title="新增资产入库"><i
                        class="fa fa-plus"></i> 新增</a> --%>
                <a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i>
                    导出</a>
                <a href="#" class="btn btn-default btn-sm" id="btnExportGou" title="导出"><i
                        class="fa fa-external-link"></i>
                    勾选导出</a>
                <a href="#" class="btn btn-default btn-sm" id="btnQl" title="批量清理"><i class="fa fa-external-link"></i>
                    批量清理</a>
                <a href="#" class="btn btn-default btn-sm" id="btnBg" title="批量变更"><i class="fa fa-external-link"></i>
                    批量变更</a>
                <a href="#" class="btn btn-default btn-sm" id="btnImport"><i
                        class="fa fa-pencil-square-o"></i> ${fns:text('导入')}</a>
            </shiro:hasPermission>
            <a href="#" class="btn btn-default btn-sm" onclick="assetPrint()" title="打印"><i class="fa fa-coffee"></i>打印</a>
        </div>
    </div>
    <div id="importBox" class="hide">
        <form:form id="importDataForm" action="${ctx}/ass/assetInfo/importFile" method="post"
                   enctype="multipart/form-data"
                   class="form-search" style="padding-left:20px;text-align:center;" onsubmit=""><br/>
            <input id="uploadFile" name="file" type="file" style="width:330px;margin-left:100px;"/><br/><br/>
            <input id="btmImportSubmit" class="btn btn-primary" onclick="upload();" type="submit"
                   value="${fns:text('导入数据')}" style="margin-left:43px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="${ctxStatic}/modules/sys/office/资产入库模板.xlsx" style="margin-right:0px;">${fns:text('下载模板')}</a>
        </form:form>
    </div>
    <sys:message content="${message}"></sys:message>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetInfo" action="${ctx}/ass/assetInfo/listData" method="post"
                   class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="row">
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label  col-sm-4"><span style="color: white">占位</span>状态:</label>
                        <div class="col-sm-8">
                            <form:select path="assetStatus" maxlength="20"
                                         class="form-control input-sm width-160">
                                <form:options items="${fns:getUserDictList('asset_status')}"
                                              itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                                <form:option value=" ">全部</form:option>
                            </form:select>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">资产编码:</label>
                        <div class="col-sm-8">
                            <form:input path="assetCode" htmlEscape="false" maxlength="255"
                                        class="form-control  width-160"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">资产名称:</label>
                        <div class="col-sm-8">
                            <form:input path="assetName" htmlEscape="false" maxlength="255"
                                        class="form-control width-160"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">资产小类:</label>
                        <div class="col-sm-8">
                            <sys:treeselect url="${ctx}/ass/assetSort/treeData" id="sortCode"
                                            value="${assetInfo.sortCode}" labelName="sortName"
                                            labelValue="${assetInfo.sortName}" title="资产小类"
                                            name="sortCode"
                                            cssClass="rightBorder" allowClear="true"
                                            notAllowSelectParent="true" isAll="true">
                            </sys:treeselect>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">财务编码:</label>
                        <div class="col-sm-8">
                            <form:input path="financeCode" htmlEscape="false" maxlength="255"
                                        class="form-control width-160"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">存放地点:</label>
                        <div class="col-sm-8">
                            <form:select path="storagePlaceCode" class="form-control width-160 selectHeight"
                                         onchange="selProjectName()">
                                <form:option value="" label=""/>
                                <form:options items="${locations}" itemLabel="localeName" itemValue="localeCode"
                                              htmlEscape="false"/>
                            </form:select>
                            <form:hidden path="storagePlace"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4"><span style="color: white">占位</span>品牌:</label>
                        <div class="col-sm-8">
                            <form:input path="brand" htmlEscape="false" maxlength="255"
                                        class="form-control width-160 "/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">使用部门:</label>
                        <div class="col-sm-8">
                            <sys:treeselect id="office" name="office"
                                            value="${assetInfo.office}"
                                            labelName="officeName" labelValue="${assetInfo.officeName}"
                                            title="部门" url="/sys/office/treeData?type=2" cssClass=""
                                            allowClear="true" notAllowSelectParent="true" isAll="true"/>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4"><span style="color: white">占位</span>型号:</label>
                        <div class="col-sm-8">
                            <form:input path="version" htmlEscape="false" maxlength="255"
                                        class="form-control width-160 "/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">区域名称:</label>
                        <div class="col-sm-8">
                            <form:select path="regionCode" htmlEscape="false" maxlength="20"
                                         class="form-control  width-160">
                                <form:option value="">&nbsp;</form:option>
                                <form:options items="${fns:getUserDictList('ass_area')}"
                                              itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                            </form:select>
                        </div>
                        <form:input path="regionName" type="hidden"/>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4"><span style="color: white">占</span>供货商:</label>
                        <div class="col-sm-8">
                            <form:select path="supplierCode" class="form-control width-160  selectHeight"
                                         onchange="supplierInfo1()">
                                <form:option value="" label=""/>
                                <form:options items="${supplierInfos}" itemLabel="supplierName"
                                              itemValue="id"
                                              htmlEscape="false"/>
                            </form:select>
                            <form:hidden path="supplier"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4"><span style="color: white">字</span>使用人:</label>
                        <div class="col-sm-8">
                            <sys:treeselect id="user" name="user" value="${assetInfo.user}"
                                            labelName="userName" labelValue="${assetInfo.userName}"
                                            title="使用人" url="" cssClass=""
                                            allowClear="true" notAllowSelectParent="true" isAll="true"/>
                        </div>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4"><span style="color: white">占位</span>原值:</label>
                        <div class="col-sm-8">
                            <form:input path="unitPrice" htmlEscape="false" maxlength="255"
                                        class="form-control number width-160"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4" style="margin-left:-3px">净残值率(%):</label>
                        <div class="col-sm-8">
                            <form:input path="residualValue" htmlEscape="false" maxlength="255"
                                        class="form-control digits width-160"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4" style="margin-left:-3px">使用期限(月):</label>
                        <div class="col-sm-8">
                            <form:input path="ageLimit" htmlEscape="false" maxlength="255"
                                        class="form-control digits width-160"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label class="control-label"><span style="color: white">占位占</span>起止日期：</label>
                    <div class="input-inline">
                        <input name="beginDate" id="beginDate" type="text" readonly="readonly" maxlength="20"
                               class="form-control input-sm Wdate width-150"
                               value="<fmt:formatDate value="${recipients.beginDate}" pattern="yyyy-MM-dd"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>-
                        <input name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20"
                               class="form-control input-sm Wdate width-150"
                               value="<fmt:formatDate value="${recipients.endDate}" pattern="yyyy-MM-dd"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,minDate:'#F{$dp.$D(\'beginDate\')}'});"/>
                    </div>
                </div>
                <div class="form-group" style="margin-left:10px;">
                    <input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
                    <input class="btn default btn-sm" type="reset" value="重置"/>
                </div>
            </div>
        </form:form>
        <table id="dataGrid"></table>
        <div id="dataGridPage"></div>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/layer/layer.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/js/pubnew.js" type="text/javascript"></script>
<script type="text/javascript">
    var dataMap = {};
    var dataSize = 0; // 获取数据MAP
    // 初始化DataGrid对象
    $("#dataGrid").dataGrid({
        shrinkToFit: false,
        showCheckbox: true,
        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        showFooter: true,	// 是否显示底部合计行
        // 设置数据表格列
        columnModel: [
            {
                header: '状态',
                name: 'assetStatus',
                index: 'a.asset_status',
                width: 70,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var assetStatus = ["闲置", "领用", "借用", "维修", "报废", "调拨中", "已捐献", "到新单位"]
                    return assetStatus[row.assetStatus]
                }
            },
            {header: '资产编码', name: 'assetCode', index: 'a.asset_code', width: 150, align: "left"},
            {header: '资产名称', name: 'assetName', index: 'a.asset_name', width: 100, align: "left"},
            {header: '财务编码', name: 'financeCode', index: 'a.finance_code', width: 150, align: "left"},
            {header: '购入日期', name: 'buyDate', index: 'a.buy_date', width: 150, align: "center"},
            {header: '资产大类', name: 'topSortName', index: 'a.top_sort_name', width: 100, align: "left"},
            {header: '资产小类', name: 'sortName', index: 'a.sort_name', width: 150, align: "left"},
            {header: '存放地点', name: 'storagePlace', index: 'a.storage_place', width: 100, align: "left"},
            {header: '计量单位', name: 'unit', index: 'a.unit', width: 100, align: "left"},
            {header: '品牌', name: 'brand', index: 'a.brand', width: 100, align: "left"},
            {header: '型号', name: 'version', index: 'a.version', width: 70, align: "left"},
            {header: '使用部门', name: 'officeName', index: 'a.office_name', width: 100, align: "left"},
            {header: '使用人', name: 'userName', index: 'a.user_name', width: 100, align: "left"},
            {header: '区域名称', name: 'regionName', index: 'a.region_name', width: 100, align: "left"},

            {header: '供货商', name: 'supplier', index: 'a.supplier', width: 100, align: "left"},
            {
                header: '净残值率(%)', name: 'residualValue', index: 'a.residual_value', width: 100, align: "center",
            },
            {
                header: ' 原值',
                name: 'netPrice',
                index: 'a.net_price',
                width: 100,
                align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="netPrice" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                },
            },
            {header: '使用期限(月)', name: 'ageLimit', index: 'a.age_limit', width: 100, align: "center",},
            {header: '备注信息', name: 'remarks', index: 'a.remarks', width: 100, align: "left",},
            {
                header: '行数据', name: 'rowData', hidden: true, formatter: function (val, obj, row, act) {
                    return JSON.stringify(row);
                }
            },
            {
                header: '操作',
                name: 'actions',
                width: 100,
                fixed: true,
                align: "center",
                sortable: false,
                formatter: function (val, obj, row, act) {
                    var actions = [];//<shiro:hasPermission name="ass:assetInfo:edit">
                    if (row.status == Global.STATUS_NORMAL) {
                        actions.push('<a href="${ctx}/ass/assetInfo/form?id=' + row.id + '" class="btnList" title="查看资产"><i class="fa fa-eye"></i></a>&nbsp;');
                        //actions.push('<a href="${ctx}/ass/assetInfo/assetForm?id=' + row.id + '" class="btnList" title="资产卡片"><i class="fa fa-book"></i></a>&nbsp;');

                        actions.push('<a href="${ctx}/ass/assetInfo/Listing?assetCode=' + row.assetCode + '" class="btnList" title="资产处理记录" ><i class="fa fa-book"></i></a>&nbsp;');

                        //           actions.push('<a href="${ctx}/ass/assetInfo/delete?id='+row.id+'" class="btnList" title="删除该资产入库" data-confirm="确认要删除该资产入库吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
                        actions.push('<a href="javascript:void(0);" id="" onclick="openLable(&apos;' + row.id + '&apos;);" class="" title="打印预览"><i class="fa fa-object-group"></i></a>&nbsp;');
                        //actions.push('<a href="javascript:void(0);" id="" onclick="openLableCode(&apos;'+row.assetCode+'&apos;);" class="" title="资产卡片"><i class="fa fa-eye"></i></a>&nbsp;');
                    }//</shiro:hasPermission>
                    return actions.join('');
                }
            }
        ],
        multiboxonly: false,
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $('#dataGrid');
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
            }
            var netPriceall = 0;
            $("#dataGrid").find("input[name$='netPrice']").each(function () {
                netPriceall = netPriceall.add(Number($(this).val()));
            });
            var ageLimitall = 0;
            $("#dataGrid").find("input[name$='ageLimit']").each(function () {
                ageLimitall = ageLimitall.add(Number($(this).val()));
            });
            var residualValueall = 0;
            $("#dataGrid").find("input[name$='residualValue']").each(function () {
                residualValueall = residualValueall.add(Number($(this).val()));
            });
            var quantityall = 0;
            $("#dataGrid").find("input[name$='quantity']").each(function () {
                quantityall = quantityall.add(Number($(this).val()));
            });
            $('#dataGrid').dataGrid("footerData", "set", {
                'assetStatus': '<em class="pull-left">合计:&nbsp;</em>',
                'netPrice': '<em class="pull-right">' + parseMoney(netPriceall) + '</em>',
                'quantity': '<em class="pull-right">' + quantityall + '</em>'
            }, false);

        },
        onSelectRow: function (id, isSelect, event) {//单选
            if (isSelect) {
                dataMap[id] = JSON.parse($('#dataGrid').dataGrid('getRowData', id).rowData);
            } else {
                delete dataMap[id];
            }
        },
        onSelectAll: function (ids, isSelect) {//全选
            for (var i = 0; i < ids.length; i++) {
                if (isSelect) {
                    dataMap[ids[i]] = JSON.parse($('#dataGrid').dataGrid('getRowData', ids[i]).rowData);
                } else {
                    delete dataMap[ids[i]];
                }
            }
        }

    });

    //资产打印assetPrint
    function assetPrint() {
        var ids = [];
        $.each(dataMap, function (key, value) {
            ids.push(value.id);
        });
        if (ids.length != 0) {
            layer.open({
                type: 2,
                skin: 'layui-layer-rim',
                closeBtn: 2,
                time: 3000000,
                scrollbar: false,
                title:"打印预览",
                shadeClose: true,
                area: ['850px', '350px'],
                content: ['${ctx}' + '/ass/assetInfo/assetLablelist?ids=' + ids, 'no']
            });
        } else {
            showMessage("没有选中");
        }
        <%--console.log("asdad");--%>
        <%--if (assetCodes.length != 0) {--%>
        <%--var url = "${ctx}/ass/assetInfo/assetPrint?assetCodes=" + assetCodes;--%>
        <%--$.post(url, function (data) {--%>
        <%--if (data.message == "success") {--%>
        <%--showMessage("打印中");--%>
        <%--} else {--%>
        <%--showMessage("失败");--%>
        <%--}--%>
        <%--}, "json");--%>
        <%--} else {--%>
        <%--showMessage("没有选中");--%>
        <%--}--%>
    }

    //数据导出
    $("#btnExport").click(function () {
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                ajaxDownload('${ctx}/ass/assetInfo/export', $("#searchForm").serialize());
            }
        }, {buttonsFocus: 1});
        top.$('.jbox-body .jbox-icon').css('top', '55px');
    });
    //数据勾选导出
    $("#btnExportGou").click(function () {
        var assetCodes = [];
        $.each(dataMap, function (key, value) {
            assetCodes.push(value.assetCode);
        });
        if (assetCodes.length != 0) {
            top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
                if (v == "ok") {
                    ajaxDownload('${ctx}/ass/assetInfo/exportGou?assetCodes=' + assetCodes, $("#searchForm").serialize());
                }
            }, {buttonsFocus: 1});
            top.$('.jbox-body .jbox-icon').css('top', '55px');
        } else {
            showMessage("没有选中");
        }

    });
    //
    $("#btnQl").click(function () {
        ajaxDownload('${ctx}/assetsclean/assetClean/listDataQl', $("#searchForm").serialize());
    });
    //
    $("#btnBg").click(function () {
        ajaxDownload('${ctx}/changeinfo/assetChangeInfo/listDataBg', $("#searchForm").serialize());
    });
    $("#btnImport").click(function () {
        $.jBox($("#importBox").html(), {
            title: "${fns:text('导入数据')}",
            buttons: {"${fns:text('关闭')}": true},
            bottomText: "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件"
        });
    });

    //导入loading
    function upload() {
        $.jBox.tip("正在检查数据合法性并导入数据到数据库，请稍后...", 'loading');
    }

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

    function openLable(assetCode) {
        layer.open({
            type: 2,
            skin: 'layui-layer-rim',
            closeBtn: 1,
            time: 300000,
            title:"打印预览",
            scrollbar: false,
            shadeClose: true,
            area: ['850px', '350px'],
            content: ['${ctx}' + '/ass/assetInfo/assetLable?assetCode=' + assetCode, 'no']
        });
    }

    function openLableCode(assetCode) {
        <%--var assetCode= '${fns:getUser().userCode}';--%>
        layer.open({
            type: 2,
            skin: 'layui-layer-rim',
            closeBtn: 1,
            time: 30000,
            scrollbar: false,
            shadeClose: true,
            area: ['850px', '500px'],
            content: ['${ctx}' + '/ass/assetInfo/Listingcar?assetCode=' + assetCode, 'no']
        });
    }

    var supplierInfoList =${fns:toJson(supplierInfos)};

    function supplierInfo1() {
        var supplierCode = $("#supplierCode").val();
        $.each(supplierInfoList, function (key, value) {
            if (supplierCode == value.id) {
                $("#supplier").val(value.supplierName);
            }
        });
    }

    function officeTreeselectCallBack(v, h, f) {

        var url = "${ctx}/ass/assetInfo/treeData?type=3&extCode=" + $("#officeCode").val();
        $("#userDiv").attr("data-url", url);
        $("#userCode").val("");
        $("#userName").val("");
    }

    $("#searchForm").validate({
        submitHandler: function (form) {
            ajaxSubmitForm($(form), function (data) {
            }, "json");
        }
    });
</script>
