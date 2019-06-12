<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产盘点管理 - ${assetCheck.isNewRecord ? '新增' : '编辑'}资产盘点" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee" style="float: left"></i>
            <p id="topCheck" style="float: left">${assetCheck.isNewRecord ? '新增' : '编辑'}资产盘点</p></div>
        <div class="actions">
            <c:choose>
                <c:when test="${assetCheck.submitStatus==0}">
                    <a href="#" class="btn btn-default btn-sm" id="btnExportSM" title="私密盘点导出"><i
                            class="fa fa-external-link"></i>私密盘点导出</a>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${assetCheck.submitStatus==0}">
                    <a href="#" class="btn btn-default btn-sm" id="btnExportSMR" title="私密盘点导入"><i
                            class="fa fa-external-link"></i>私密盘点导入</a>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${assetCheck.submitStatus==0}">
                    <a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i
                            class="fa fa-external-link"></i> 导出</a>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${assetCheck.submitStatus==0}">
                    <a href="" id="btnRefresh" class="btn btn-default btn-sm" title="刷新"><i class="fa fa-coffee"></i>刷新</a>
                </c:when>
            </c:choose>

        </div>
    </div>
    <div id="importBox" class="hide">
        <form:form id="importDataForm" action="${ctx}/assetcheck/assetCheck/importFile" method="post"
                   enctype="multipart/form-data"
                   class="form-search" style="padding-left:20px;text-align:center;" onsubmit=""><br/>
            <input id="uploadFile" name="file" type="file" style="width:330px;margin-left:100px;"/><br/><br/>
            <input id="chackCodeid" name="chackCode" type="text" hidden="hidden" style="width:330px;margin-left:100px;"/>
            <input id="btmImportSubmit" class="btn btn-primary" onclick="upload();" type="submit"
                   value="${fns:text('导入数据')}" style="margin-left:43px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
        </form:form>
    </div>
    <div>
        <sys:message content="${message}"></sys:message>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="assetCheck" action="${ctx}/assetcheck/assetCheck/save" method="post"
                   class="form-horizontal">
            <form:hidden path="id"/>
            <div class="form-body" id="formBody">
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 盘点单名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="chackName" htmlEscape="false" maxlength="255"
                                            class="form-control required"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 发起人：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect id="handleCode" name="handleCode" value="${assetCheck.handleCode}"
                                                labelName="handleName" labelValue="${assetCheck.handleName}"
                                                title="责任人" url="/sys/office/treeData?type=3" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                发起时间：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <input name="handleTime" type="text" readonly="readonly" maxlength="20"
                                       class="form-control Wdate "
                                       value="<fmt:formatDate value="${assetCheck.handleTime}" pattern="yyyy-MM-dd HH:mm"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                使用部门：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect id="office" name="office"
                                                value="${assetCheck.office}" labelName="officeName"
                                                labelValue="${assetCheck.officeName}"
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
                                资产分类名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect url="${ctx}/ass/assetSort/treeData" id="sortCode"
                                                value="${assetCheck.sortCode}" labelName="sortName"
                                                labelValue="${assetCheck.sortName}" title="资产分类名称" name="sortCode"
                                                cssClass="rightBorder" allowClear="true"
                                                notAllowSelectParent="true" isAll="true">
                                </sys:treeselect>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                区域名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:select path="regionCode" htmlEscape="false" maxlength="20"
                                             class="form-control" onclick="getregionCode()">
                                    <form:option value=" ">&nbsp;</form:option>
                                    <form:options items="${fns:getUserDictList('ass_area')}"
                                                  itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                                </form:select>
                            </div>
                            <form:input path="regionName" type="hidden"/>
                        </div>
                    </div>
                </div>
            </div>
            <div id="dataGridStatus">
                <div class="row">
                    <div class="col-xs-1">
                        <div style="float: left;margin-left: 10%;color:rgba(39, 117, 190, 1);font-weight:bold"><p
                                id="all">全部0</p></div>
                    </div>
                    <div class="col-xs-1">
                        <div style="float: left;margin-left: 10%;color:rgba(39, 117, 190, 1);font-weight:bold"><p
                                id="check">已盘0</p></div>
                    </div>
                    <div class="col-xs-1">
                        <div style="float: left;margin-left: 10%;color:rgba(39, 117, 190, 1);font-weight:bold"><p
                                id="unCheck">未盘0</p></div>
                    </div>
                    <div class="col-xs-1">
                        <div style="float: left;margin-left: 10%;color:rgba(39, 117, 190, 1);font-weight:bold"><p
                                id="unyesCheck">盘亏0</p></div>
                    </div>
                </div>
                <div class="ml10 mr10">
                    <table id="assetCheckDtlDataGrid"></table>
                    <div id="dataGridPage"></div>
                </div>
            </div>
            <div class="form-actions fluid">
                <div class="row">
                    <div class="col-sm-offset-2 col-sm-10">
                        <shiro:hasPermission name="assetcheck:assetCheck:edit">
                            <button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i>创建盘点单
                            </button>
                            <c:choose>
                                <c:when test="${assetCheck.submitStatus==0||assetCheck.isNewRecord}">
                                    <a id="btnSubmitCheck" class="btn btn-primary" title="提交盘点结果"><i
                                            class="fa fa-check"></i>提交盘点结果</a>
                                </c:when>
                            </c:choose>
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
        <form:form id="searchForm2" method="post"
                   action="${ctx}/assetcheck/assetCheck/findCheckCode?chackCode=${chackCode}">
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    //判断提交状态
    var submitStatus = "1"
    $(window).load(function () {
        if (${assetCheck.isNewRecord}) {
            $("#dataGridStatus").attr("style", "display:none;");
            $("#btnSubmitCheck").attr("style", "display:none;");
        } else {
            $("#formBody").attr("style", "display:none;");
            $("#btnSubmit").attr("style", "display:none;");
            $("#dataGridStatus").removeAttr("style");
            $("#btnSubmitCheck").removeAttr("style");
            $("#topCheck").html("盘点结果");
            submitStatus = "2";
        }
    });

    function getregionCode() {
        $("#regionName").val($("#regionCode").select2("data").text);
    }

    //初始化资产盘点子表DataGrid对象
    $("#assetCheckDtlDataGrid").dataGrid({
        searchForm: $("#searchForm2"), // 数据来源表单
        shrinkToFit: false,
        // 设置数据表格列
        columnModel: [
            {
                header: '状态',
                name: 'assetStatus',
                width: 50,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="assetStatus" value="' + val + '" />');
                    if (val == 0) {
                        val = "未盘";
                    }
                    else if (val == 1) {
                        val = "已盘";
                    } else {
                        val = "盘亏";
                    }
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '资产编码',
                name: 'assetCode',
                width: 150,
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
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unit" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '使用部门编码', name: 'officeCode',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="officeCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '使用部门',
                name: 'officeName',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="officeName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '购入日期', name: 'buyDate',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="buyDate" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '使用人编码', name: 'userCode',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="userCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '使用人名称',
                name: 'userName',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="userName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '区域编码',
                name: 'regionCode',
                width: 150,
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
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="regionName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },

            {
                header: '存放地点',
                name: 'storagePlace',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="storagePlace" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '供货商',
                name: 'supplier',
                width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="supplier" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            }, {
                header: '行数据', name: 'rowData', hidden: true, formatter: function (val, obj, row, act) {

                    return JSON.stringify(row);
                }
            },
        ],
        // 编辑表格参数
        editGrid: true,				// 是否是编辑表格
        editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $('#assetCheckDtlDataGrid');
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
            }
            var all = 0;
            var check = 0;
            var unCheck = 0;
            var unyesCheck = 0;
            console.log("dssd", "sfsfd");
            $("#assetCheckDtlDataGrid").find("[name$='assetStatus']").each(function () {
                all++;
                if ($(this).val() == 0) {
                    unCheck++;
                } else if ($(this).val() == 1) {
                    check++;
                } else {
                    unyesCheck++;
                }
            });
            $("#all").html("全部(" + all + ")");
            $("#check").html("已盘(" + check + ")");
            $("#unCheck").html("未盘(" + unCheck + ")");
            $("#unyesCheck").html("盘亏(" + unyesCheck + ")");

        }
    });
    $('#btnSubmit').click(function () {
        var dg = $('#assetCheckDtlDataGrid');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'assetStatus');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'assetCode');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'assetName');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'sortCode');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'sortName');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'brand');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'version');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'unitPrice');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'unit');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'snCode');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'officeCode');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'officeName');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'userCode');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'userName');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'buyDate');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'regionCode');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'regionName');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'storagePlace');
        updateListFieldNameCheck(dg, 'assetCheckDtlList', 'supplier');
        // $("#formBody").attr("style", "display:none;");
        // $("#btnSubmit").attr("style", "display:none;");
        // $("#dataGridStatus").removeAttr("style");
        // $("#btnSubmitCheck").removeAttr("style");
        // $("#topCheck").html("盘点结果");
        $("#inputForm").submit();

    })
    $('#btnRefresh').click(function () {
        var url = "${ctx}/assetcheck/assetCheck/findCheckCode?chackCode=" + $("#id").val();
        $('#searchForm2').attr('action', url);
        $('#searchForm2').submit();
    })
    //提交盘点结果
    $('#btnSubmitCheck').click(function () {
        var dg = $('#assetCheckDtlDataGrid');
        var ids = dg.dataGrid('getDataIDs');
        for (var i = 0; i < ids.length; i++) {
            dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
        }
        var unCheck = 0;
        $("#assetCheckDtlDataGrid").find("[name$='assetStatus']").each(function () {
            if ($(this).val() == 0) {
                unCheck++;
            }
        });
        if (unCheck > 0) {
            var paly = "现在未盘数量为" + unCheck + ",确定要提交盘点结果吗，如果提交未盘的资产将被清理"
            top.$.jBox.confirm(paly, "提交结果提示", function (v, h, f) {
                if (v == "ok") {
                    var dg = $('#assetCheckDtlDataGrid');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'assetStatus');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'assetCode');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'assetName');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'sortCode');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'sortName');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'brand');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'version');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'unitPrice');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'unit');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'snCode');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'officeCode');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'officeName');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'userCode');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'userName');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'buyDate');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'regionCode');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'regionName');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'storagePlace');
                    updateListFieldNameCheck(dg, 'assetCheckDtlList', 'supplier');
                    $("#inputForm").submit();
                }
            }, {buttonsFocus: 1});
            top.$('.jbox-body .jbox-icon').css('top', '55px');
        }else{
            $("#inputForm").submit();
        }
    })

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldNameCheck(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
        });
    }

    $("#btnExportSMR").click(function () {
        $("#chackCodeid").attr("value",$("#id").val());//推荐这种写法,可正常赋值
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

    $("#inputForm").validate({
        submitHandler: function (form) {
            ajaxSubmitForm($(form), function (data) {
                $("#id").val(data.id);
                console.log("submitStatus", submitStatus);
                if (submitStatus == "1") {
                    showMessage(data.message1);
                    if (data.code == "200") {
                        closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                            contentWindow.page();
                        });
                    }
                } else {
                    showMessage(data.message1);
                    if (data.code == "200") {
                        closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                            contentWindow.page();
                        });
                    }
                }
                submitStatus = "2";
            }, "json");
        }
    });
    //数据导出
    $("#btnExportSM").click(function () {
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                ajaxDownload('${ctx}/assetcheck/assetCheck/exportSM?chackCode=${assetCheck.id}', $("#searchForm2").serialize());
            }
        }, {buttonsFocus: 1});
        top.$('.jbox-body .jbox-icon').css('top', '55px');
    });
    //数据导出
    $("#btnExport").click(function () {
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                ajaxDownload('${ctx}/assetcheck/assetCheck/export?chackCode=${assetCheck.id}', $("#searchForm2").serialize());
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
</script>
