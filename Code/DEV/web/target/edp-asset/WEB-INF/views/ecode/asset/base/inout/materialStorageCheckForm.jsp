<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="盘盈入库- ${inoutBill.isNewRecord ? '新增' : '编辑'}盘盈入库" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${inoutBill.isNewRecord ? '新增' : '编辑'}盘盈入库</div>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="inoutBill" action="${ctx}/scm/inout/inoutBill/materialStorageSave"
                   method="post" class="form-horizontal">
        <div class="form-body">
            <form:hidden path="sysCode"/>
            <form:hidden path="isNewRecord"/>
            <form:hidden path="inoutFlag" value="1"/>
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="control-label col-sm-4" title="">
                            <span class="required">*</span> 入库日期：<i class="fa icon-question hide"></i></label>
                        <div class="col-sm-8">
                            <input name="orderDate" type="text" readonly="readonly"
                                   maxlength="20" class="form-control Wdate required"
                                   value="<fmt:formatDate value="${inoutBill.orderDate}" pattern="yyyy-MM-dd"/>"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="control-label col-sm-4" title=""><span class="required">*</span>仓库名称：<i
                                class="fa icon-question hide"></i></label>
                        <div class="col-sm-8">
                            <form:select path="whCode" class="form-control required selectHeight"
                                         onChange="selProjectName()">
                                <form:option value="" label=""/>
                                <form:options items="${warehouses}" itemLabel="warehouseName"
                                              itemValue="warehouseCode" htmlEscape="false"/>
                            </form:select>
                            <form:hidden path="whName"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="control-label col-sm-4" title="">经办人：<i
                                class="fa icon-question hide"></i></label>
                        <div class="col-sm-8">
                            <sys:listselect id="psn" name="psnCode"
                                            value="${inoutBill.psnCode}"
                                            labelName="psnName"
                                            labelValue="${inoutBill.psnName}" title="经办人"
                                            url="${ctx}/sys/employee/employeeSelect" multiple="false"
                                            cssClass="form-control rightBorder" returnCodeAttr="empCode"
                                            returnNameAttr="empName"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="control-label col-sm-4" title="">描述：<i
                                class="fa icon-question hide"></i></label>
                        <div class="col-sm-8">
                            <form:input path="memo" htmlEscape="false" maxlength="50" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="judp-table-button" hidden="hidden">
            <a href="#" class="btn judp-btn-gray btn-sm" id="btnAddRow"></a>
        </div>
        <table id="dataGrid"></table>
    </div>
    </form:form>
    <form:form id="searchForm" method="post"
    	 action="${ctx}/scm/inout/inoutBill/InoutBillsDtl?sysCode=${billCode}">
    </form:form>
    <div id="nav" class="form-actions fluid">
        <div class="row">
            <div class="col-sm-offset-2 col-sm-10">
            <c:choose>
            	<c:when test="${inoutBill.isNewRecord==true}">
                	<button id="btnSubmit" type="submit" style="margin-left: 10px;"
                       		class="btn btn-default color: blue">
                    	<i class="fa fa-save" class="#"></i>保存
                	</button>
                </c:when>
           	</c:choose>
                <button id="btnCancel" type="button" class="btn default"
                        onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i
                        class="fa fa-reply-all"></i>关闭
                </button>
            </div>
        </div>
    </div>
</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/js/pubnew.js" type="text/javascript"></script>
<script type="text/javascript">
    $("#inputForm").validate({
        submitHandler: function (form) {
            ajaxSubmitForm($(form), function (data) {
                if (data.result == Global.TRUE) {
                    showMessage(data.message);
                    if (data.result == Global.TRUE) {
                        closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                            contentWindow.page();
                        });
                    }
                }
                showTip(data.message);
            }, "json");
        }
    });

    var articleCodes = [];
    var whList = ${fns:toJson(warehouses)};

    function selProjectName() {
        var whCode = $("#whCode").val();
        $.each(whList, function (key, value) {
            if (whCode == value.warehouseCode) {
                $("#whName").val(value.warehouseName);
            }
        });
        console.log("得到", $("#whName").val());
    }

    //判断是否选中
    function getexisting() {
        articleCodes = [];
        $("#dataGrid").find("[name$='articleCode']").each(function () {
            articleCodes.push($(this).val());
        });
    }

    $('#dataGrid').dataGrid({
        // 当前页签编号
        searchForm: $("#searchForm"), // 数据来源表单
        columnModel: [
            {
                header: '关联键', name: 'sysCode', index: 'sys_code', width: 150,hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sysCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公用品编码', name: 'articleCode', index: 'articles_code', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articleCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公用品名称', name: 'articlesName', index: 'articles_name', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articlesName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类编码', name: 'sortCode', width: 180,hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类名称', name: 'sortName', width: 180,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }

            },

            {
                header: '品牌名称', name: 'brand', index: 'brand', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },

            {
                header: '规格型号', name: 'version', index: 'version', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }

            },
            {
                header: '数量', name: 'qty', index: 'qty', width: 150, align: 'right',hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="qty" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '单价', name: 'price', width: 100, align: 'right',hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="price" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '库存数量', name: 'inInitialQty', index: 'a.inInitialQty', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="inInitialQty" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '入库数量', name: 'qty', index: 'a.qty', width: 150,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="qty" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '操作',
                name: 'actions',
                width: 60,
                align: 'center',
                fixed: true,
                sortable: false,
                hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    if (row.status == Global.STATUS_NORMAL) {
                    }
                    return actions.join('');
                }
            }
        ],        // 编辑表格参数
        editGrid: true,				// 是否是编辑表格
        editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
        editGridAddRowBtn: $('#btnAddRow'),	// 子表增行按钮
        onSelectRow: function (id) {
        },
        ajaxSuccess: function (data) { // 加载成功后执行方法
        }
    });
    //提交
    $("#btnSubmit").click(function () {
        var dgo = $('#dataGrid');
        var rowso = dgo.dataGrid('getRowData');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'sysCode');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'sortCode');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'sortName');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'articleCode');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'articlesName');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'brand');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'version');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'qty');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'price');
        $("#inputForm").submit();
    });
    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div):not(a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
            console.log(fieldName, val);
        });
    }
</script>