<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="出入库主表管理 - 入库单" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
  <div class="portlet-title">
   <div class="caption"><i class="fa fa-coffee"></i>${inoutBill.isNewRecord ? '新增' : '查看'}办公用品入库</div>
      <div class="actions">
      <c:choose>
            			<c:when test="${inoutBill.isNewRecord == true}">
                   			<button id="btnSubmit" type="submit" style="margin-left: 10px;"
                            	class="btn btn-primary">
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
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="inoutBill" action="${ctx}/scm/inout/inoutBill/materialStorageSave"
                   method="post" class="form-horizontal">
            <div class="form-body">
                <form:hidden path="sysCode"/>
                <form:hidden path="isNewRecord"/>
                <form:hidden path="inoutFlag" value="1"/>
                  <table class="table table-bordered">
                  
             	<tr>
					<td class="judp-table-lable"align="right"><span class="required red">* </span>入库日期：</td>
					<td class="judp-table-content">
					     <input name="orderDate" type="text" readonly="readonly"
                                       maxlength="20" class="form-control Wdate required"
                                       value="<fmt:formatDate value="${inoutBill.orderDate}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
					<td class="judp-table-lable"align="right"><span class="required red">* </span>仓库名称：</td>
					<td class="judp-table-content">
						 <form:select path="whCode" class="form-control required selectHeight"
                                             onChange="selProjectName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${warehouses}" itemLabel="warehouseName"
                                                  itemValue="warehouseCode" htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="whName"/>
					</td>
					
				</tr>
                  
                  	<tr>
					<td class="judp-table-lable"align="right">经办人：</td>
					<td class="judp-table-content">
					    <sys:listselect id="psn" name="psnCode"
                                                value="${inoutBill.psnCode}"
                                                labelName="psnName"
                                                labelValue="${inoutBill.psnName}" title="经办人"
                                                url="${ctx}/sys/employee/employeeSelect" multiple="false"
                                                cssClass="form-control rightBorder" returnCodeAttr="empCode"
                                                returnNameAttr="empName"/>
					</td>
					<td class="judp-table-lable"align="right">描述：</td>
					<td class="judp-table-content">
						<form:input path="memo" htmlEscape="false" maxlength="50" class="form-control"/>
					</td>
					
				</tr>
				<tr>
                     <td colspan="6" class="judp-table-tab">
                    <ul id="myTab" class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab">采购订单</a></li>
                    <li><a href="#ios" data-toggle="tab">办公用品</a></li>
                     </ul>
                    </td>
                </tr>
                <tr>
					<td colspan="6" class="judp-table-tab-content">
                 <div id="myTabContent" class="judp-width-100 tab-content">
                <div class="tab-pane fade in active" id="home">
                    <div class="judp-table-button" hidden="hidden">
                        <a href="#" class="btn judp-btn-gray btn-sm" id="btnAddRow"></a>
                    </div>
                    <a href="#" id="btnIntroduce" onclick="selectWindowbtnIntroduce()" class="btn btn-primary"><i
                            class="fa fa-plus"></i>选择采购订单</a>

                    <table id="dataGrid"></table>
                </div>
                <div class="tab-pane fade" id="ios">
                    <div class="judp-table-button" hidden="hidden">
                        <a href="#" class="btn judp-btn-gray btn-sm" id="btnAddRowTwo"></a>
                    </div>
                    <a href="#" id="btnAddOffice" onclick="selectInvWindowbtnAddOffice()" class="btn btn-primary">
                        <i class="fa fa-plus"></i>选择办公用品</a>

                    <table id="paDataGrid"></table>
                </div>
                <div id="dataGridPage"></div>
            </div>
            </td>
            </tr>
              </table>
             
               
            </div>
           
           
        </form:form>
        <form:form id="searchForm"
                   action="${ctx}/scm/inout/inoutBill/InoutBillsDtl?sysCode=${sysCode}&grantNo=1"> </form:form>
        <form:form id="paymentAgreement"
                   action="${ctx}/scm/inout/inoutBill/InoutBillsDtl?sysCode=${sysCode}&grantNo=2">
        </form:form>

        <div id="nav" class="form-actions fluid">
            <div class="row">
                <div class="col-sm-offset-2 col-sm-10">
                    
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

    //var articleCodes = [];
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


  	//全局变量存选中的采购表的sysCodes
    var sysCodes = [];
    $('#dataGrid').dataGrid({
        // 当前页签编号
        searchForm: $("#searchForm"), // 数据来源表单
        columnModel: [
            {
                header: '关联键', name: 'sysCode', index: 'sys_code', width: 100,hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sysCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公用品编码', name: 'articleCode', index: 'articles_code', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articleCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公用品名称', name: 'articlesName', index: 'articles_name', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articlesName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类编码', name: 'sortCode', width: 100,hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类名称', name: 'sortName', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }

            },

            {
                header: '品牌名称', name: 'brand', index: 'brand', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },
            {
                header: '单位', name: 'unit', index: 'unit', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unit" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },

            {
                header: '规格型号', name: 'version', index: 'version', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }

            },
            {
                header: '数量', name: 'qty', index: 'qty', width: 100, align: 'right',
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="qty" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '单价', name: 'price', width: 100, align: 'right',
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="price" value="' + val + '" />');
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
    
  	//全局变量存选中的办公用品档案表的articlesCode
    var articleCodes = [];
    $('#paDataGrid').dataGrid({
        // 当前页签编号
        searchForm: $("#paymentAgreement"), // 数据来源表单
        columnModel: [
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
                header: '办公用品名称', name: 'articlesName', index: 'articles_name', width: 150,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="articlesName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类编码', name: 'sortCode', width: 150,hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '办公分类名称', name: 'sortName', width: 150,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }

            },

            {
                header: '品牌名称', name: 'brand', index: 'brand', width: 150,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },
            {
                header: '单位', name: 'unit', index: 'unit', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="unit" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }


            },

            {
                header: '规格型号', name: 'version', index: 'version', width: 100,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }

            },
            {
                header: '数量', name: 'qty', width:100, editable: true, align: 'right',
                editoptions: {
                    'maxlength': '100', 'class': 'form-control number'
                }
            },
            {
                header: '单价', name: 'price', width: 100, editable: true, align: 'right',
                editoptions: {
                    'maxlength': '100', 'class': 'form-control number'
                }
            },
            {
                header: '操作',
                name: 'actions',
                width: 60,
                align: 'center',
                fixed: true,
                sortable: false,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#paDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    if (row.status == Global.STATUS_NORMAL) {
                    }
                    return actions.join('');
                }
            }
        ],        // 编辑表格参数
        editGrid: true,				// 是否是编辑表格
        editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
        editGridAddRowBtn: $('#btnAddRowTwo'),	// 子表增行按钮
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
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'unit');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'version');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'qty');
        updateListFieldName(dgo, 'inoutBillsListOrderbill', 'price');
        var dga = $('#paDataGrid');
        var rowsa = dga.dataGrid('getRowData');
        updateListFieldName(dga, 'inoutBillsListArticles', 'sortCode');
        updateListFieldName(dga, 'inoutBillsListArticles', 'sortName');
        updateListFieldName(dga, 'inoutBillsListArticles', 'articleCode');
        updateListFieldName(dga, 'inoutBillsListArticles', 'articlesName');
        updateListFieldName(dga, 'inoutBillsListArticles', 'brand');
        updateListFieldName(dga, 'inoutBillsListArticles', 'unit');
        updateListFieldName(dga, 'inoutBillsListArticles', 'version');
        updateListFieldName(dga, 'inoutBillsListArticles', 'qty');
        updateListFieldName(dga, 'inoutBillsListArticles', 'price');
        $("#inputForm").submit();
    });
    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div):not(a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
            console.log(fieldName, val);
        });
    }
    
    //判断是否选中
    function getexisting() {
    	sysCodes = [];
        $("#dataGrid").find("[name$='sysCode']").each(function () {
        	sysCodes.push($(this).val());
        });
        return sysCodes;
    }
    //选择采购物资
    function selectWindowbtnIntroduce() {
    	var sysCodes = getexisting();
        //var articleCode = articleCodes.join(',');
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/orderbill/orderBill/assetOrderBillsList?approvalStatus=2&inoutStatus=0&sysCodes="+sysCodes, "选择资产", $(window).width() - 100, $(window).height() - 100,
            {
                ajaxData: {selectData: selectData},
                buttons: {
                	"<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定":"ok",
                    /* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
                    '<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
                },
                submit: function (v, h, f) { // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                	if(v== "ok"){
                    var w = h.find("iframe")[0].contentWindow;
                    var dataMap = w.getDataMap();
                    $.each(dataMap, function (key, value) {
                        var syscode = value.sysCode;
                        var url = "${ctx}/orderbill/orderBill/getDtlData?sysCode=" + syscode;
                        $.ajax({
                            async: false, type: "POST", url: url, dataType: 'json',
                            success: function (data) {
                                $.each(data, function (key, value) {
                                    $('#btnAddRow').click();
                                    var selRow = $("#dataGrid").dataGrid("getSelectRow");
                                    $("#dataGrid").dataGrid("setRowData", selRow, {sysCode: value.sysCode});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {articleCode: value.articlesCode});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {articlesName: value.articlesName});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {unit: value.unit});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {version: value.version});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {qty: value.qty});
                                    $("#dataGrid").dataGrid("setRowData", selRow, {price: value.price});
                                });
                            }
                        });
                    });
                }
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }
    
    //判断是否选中
    function getOfficeExisting() {
        articleCodes = [];
        $("#paDataGrid").find("[name$='articleCode']").each(function () {
            articleCodes.push($(this).val());
        });
        return articleCodes;
    }
    //选择添加办公物品
    function selectInvWindowbtnAddOffice() {
    	var articleCodes =  getOfficeExisting();
        //var articleCode = articleCodes.join(',');
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/articlesfile/articlesFile/articlesList?articleCodes="+articleCodes, "选择办公物品", $(window).width() - 100, $(window).height() - 100,
            {
                ajaxData: {selectData: selectData},
                buttons: {
                	"<i class=\"glyphicon glyphicon-ok\"></i>&nbsp;确定":"ok",
                    /* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
                    '<i class=\'glyphicon glyphicon-remove\'></i>&nbsp;关闭': "close"
                },
                submit: function (v, h, f) { // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                	if(v== "ok"){
                    var w = h.find("iframe")[0].contentWindow;
                    var dataMap = w.getDataMap();
                    $.each(dataMap, function (key, value) {
                        $('#btnAddRowTwo').click();
                        var selRow = $("#paDataGrid").dataGrid("getSelectRow");
                        $("#paDataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                        $("#paDataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                        $("#paDataGrid").dataGrid("setRowData", selRow, {articleCode: value.articlesCode});
                        $("#paDataGrid").dataGrid("setRowData", selRow, {articlesName: value.articlesName});
                        $("#paDataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                        $("#paDataGrid").dataGrid("setRowData", selRow, {unit: value.unit});
                        $("#paDataGrid").dataGrid("setRowData", selRow, {version: value.version});
                    });
                }
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }


</script>