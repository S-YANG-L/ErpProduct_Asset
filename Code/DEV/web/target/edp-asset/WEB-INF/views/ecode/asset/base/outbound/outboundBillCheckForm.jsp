<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="盘亏出库- ${outboundBill.isNewRecord ? '新增' : '编辑'}盘亏出库" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${outboundBill.isNewRecord ? '新增' : '编辑'}盘亏出库</div>
         <div class="actions">
         	   <c:choose>
                            <c:when test="${outboundBill.isNewRecord == true}">
                                <button id="btnSubmit" type="button" class="btn btn-primary">
                                    <i class="fa fa-reply-all"></i> 提 交
                                </button>
                            </c:when>
                            <c:when test="${outboundBill.pageFlag == 0}">
                                <!-- 我的申请 -->
                                <button id="btnSubmit" type="button" class="btn btn-primary">
                                    <i class="fa fa-reply-all"></i> 提 交
                                </button>
                                <button id="btnUnSubmit" type="button"
                                        class="btn btn-primary">
                                    <i class="fa fa-reply-all"></i> 撤回申请
                                </button>
                            </c:when>
                            <c:when test="${outboundBill.pageFlag == 1}">
                                <!-- 我的待办 -->
                                <c:choose>
                                    <c:when test="${outboundBill.step<=2}">
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
                                    <c:when test="${outboundBill.step>=3}">
                                        <button id="btnAuditPass" type="button"
                                                class="btn btn-primary">
                                            <i class="fa fa-check"></i></i>确认
                                        </button>
                                    </c:when>
                                </c:choose>
                            </c:when>
                            <c:when test="${outboundBill.pageFlag == 2}">
                                <!-- 我的已办 -->
                                <button id="btnUndo" type="button" class="btn btn-primary">
                                    <i class="fa fa-reply-all"></i> 撤回审批
                                </button>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${outboundBill.approvalStatus==0&&outboundBill.approvalStatus != ''}">
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
        <form:form id="inputForm" modelAttribute="outboundBill" action="${ctx}/outbound/outboundBill/save" method="post"
                   class="form-horizontal">
            <div class="form-body">
                <form:hidden path="sysCode"/>
                <form:hidden path="companyCode"/>
                <form:hidden path="step"/>
                <table class="table table-bordered">
                    
             	<tr>
					<td class="judp-table-lable"align="right"><span class="required red">* </span> 出库日期：</td>
					<td class="judp-table-content">
					    <input name="outboundDate" type="text" readonly="readonly"
                                   maxlength="20" class="form-control Wdate required"
                                   value="<fmt:formatDate value="${outboundBill.outboundDate}" pattern="yyyy-MM-dd"/>"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
					<td class="judp-table-lable"align="right">部门：</td>
					<td class="judp-table-content">
					 <form:input path="office" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required hide"/>
					 <form:input path="officeName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
						<%--  <sys:treeselect id="officeCode" name="officeCode"
                                                value="${outboundBill.officeCode}"
                                                labelName="officeName" labelValue="${outboundBill.officeName}"
                                                title="部门" url="/sys/office/treeData?type=2" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/> --%>
					</td>
					
				</tr>
				<tr>
					<td class="judp-table-lable"align="right">经办人：</td>
					<td class="judp-table-content">
					 <form:input path="outbounderCode" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required hide"/>
					 <form:input path="outbounderName" htmlEscape="false" maxlength="100" readonly="true"
                                        class="form-control required"/>
					  <%-- <sys:treeselect id="outbounderCode" name="outbounderCode"
                                                value="${outboundBill.outbounderCode}" labelName="outbounderName"
                                                labelValue="${outboundBill.outbounderName}"
                                                title="使用人" url="/sys/office/treeData?type=3" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/> --%>
					</td>
					<td class="judp-table-lable"align="right">描述：</td>
					<td class="judp-table-content">
						   <form:input path="memo" htmlEscape="false" maxlength="50" class="form-control"/>
					</td>
					
				</tr>
          
               
              
              <tr>
                  <td colspan="6" class="judp-table-tab-content"> 
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
                <c:choose>
                    <c:when test="${outboundBill.step==2}">
                        <div class="row">
                            <div class="col-sm-6" hidden="hidden">
                                <a href="#" id="btnAddRow" class="btn btn-default"><i
                                        class="fa fa-plus"></i></a>
                            </div>
                            <div class="col-sm-6">
                                <a href="#" id="btnAddRowinfo" onclick="selectInvWindow()" class="btn btn-default"><i
                                        class="fa fa-plus"></i>选择仓库物品</a>
                            </div>
                        </div>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${outboundBill.step>=2||outboundBill.approvalStatus==2}">
                        
                                <table id="dataGrid"></table>
                                <div id="dataGridPage"></div>
                         
                    </c:when>
                </c:choose>
                </td>
         </tr>
              </table>
            </div>
           
        </form:form>
        <form:form id="searchForm" method="post"
                   action="${ctx}/outbound/outboundBill/findoutboundCode?sysCode=${outboundCode}">
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    //初始化物资出库子表DataGrid对象
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        autoGridHeight: function () {
            return 'auto'
        }, // 设置自动高度
        // 设置数据表格列
        columnModel: [
            {
                header: '办公用品编码', name: 'articlesCode', index: 'a.articles_code', width: 100,
                // hidden: true,
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
                header: '办公分类编码', name: 'sortCode', index: 'a.sort_code', width: 100,hidden:true,
                //   hidden: true,
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
                header: '品牌名称', name: 'brand', index: 'a.brand', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '规格型号', name: 'version', index: 'a.version', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="version" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '仓库编码', name: 'whCode', index: 'a.wh_code', width: 100,hidden:true,
                // hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="whCode" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '仓库名称', name: 'whName', index: 'a.wh_name', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="whName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '库存数量', name: 'qty', index: 'a.qty', width: 100,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="qty" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '单价', name: 'price', index: 'a.price', width: 100,hidden:true,
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="price" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '出库数量',
                name: 'outboundNumber',
                index: 'a.outbound_number',
                width: 150,
                editable: ${outboundBill.step==2? 'true' : 'false'},
                edittype: 'text',
                editoptions: {
                    'maxlength': '100', 'class': 'form-control number',
                    dataEvents: [
                        {
                            type: 'blur',     //blur,focus,change.............焦点失去事件
                            fn: prepareNumber
                        }
                    ]
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
                hidden: ${outboundBill.step==2 ? 'false' : 'true'},
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    if (val == 'new') {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    } else {
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'setRowData\',\'' + obj.rowId + '\',null,{display:\'none\'});$(\'#' + obj.rowId + '_status\').val(\'' + Global.STATUS_DELETE + '\');});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
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

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div):not(a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
            console.log(fieldName, val);
        });
    }

    function prepareNumber() {
        var selRow = $("#dataGrid").dataGrid("getSelectRow")
        var outboundNumber = $("#" + selRow).find("input[name='outboundNumber']").val();
        var qty = $("#" + selRow).find("input[name='qty']").val();
        if (outboundNumber >qty) {
        showMessage("超过最大库存");
        $("#" + selRow).find("input[name='outboundNumber']").val("0");
        }
    }

    function getexisting() {
        assetcodes = [];
        $("#dataGrid").find("[name$='assetCode']").each(function () {
            assetcodes.push($(this).val());
        });
    }

    //选择仓库物品
    function selectInvWindow() {
        var selectData = "";
        var $jBox = getJBox();
        $jBox.open("iframe:${ctx}/wareitems/warehouseItems/getWarehouseinfo", "选择仓库物品", $(window).width() - 100, $(window).height() - 100,
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
                        var selRow = $("#dataGrid").dataGrid("getSelectRow");
                        $("#dataGrid").dataGrid("setRowData", selRow, {sysId: value.sysId});
                        $("#dataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                        $("#dataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                        $("#dataGrid").dataGrid("setRowData", selRow, {articlesCode: value.articlesCode});
                        $("#dataGrid").dataGrid("setRowData", selRow, {articlesName: value.articlesName});
                        $("#dataGrid").dataGrid("setRowData", selRow, {whCode: value.whCode});
                        $("#dataGrid").dataGrid("setRowData", selRow, {whName: value.whName});
                        $("#dataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                        $("#dataGrid").dataGrid("setRowData", selRow, {version: value.version});
                        $("#dataGrid").dataGrid("setRowData", selRow, {qty: value.qty});
                        $("#dataGrid").dataGrid("setRowData", selRow, {price: value.price});
                    });
                },
                loaded: function (h) {
                    $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                }
            });
    }

    //工作流对应模板
    $('#btnSubmit').click(function () {
        $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
            {
                "billType": "WZCK", // 对应工作流模板的单据类型
                "companyCode": $("#companyCode").val(),// 申请人公司编码
                "officeCode": $("#officeCode").val() // 申请人部门编码
            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    .0
                    $("#flowId").val(data.message);
                    var url = "${ctx}/outbound/outboundBill/approvalSelect?applicantCode=" + $("#applicantCode").val() + "&flowId=" + data.message;
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
                "billType": "WZCK", // 对应工作流模板的单据类型
                "companyCode": $("#companyCode").val(),// 申请人公司编码
                "officeCode": $("#officeCode").val() // 申请人部门编码
            },
            function (data) {
                if (data.result == Global.FALSE) {
                    showMessage(data.message);
                } else {
                    $("#flowId").val(data.message);
                    var flowId = data.message;
                    var url = "${ctx}/outbound/outboundBill/getNextFlowBusiness?bizKey=" + $("#sysCode").val() + "&step=${outboundBill.step}";
                    $.post(url, function (data) {
                        if (data == 0) {//审批最后一步
                            console.log("审批最后一步", data);
                            $("#inputForm").submit();
                            var stepId = "${param.stepId}";
                            var urls = "${ctx}/outbound/outboundBill/agreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=0" + "&sysCode=" + $("#sysCode").val() + "&sysCode=" + $("#sysCode").val();
                            $.post(urls, function (data) {
                                showMessage(data.message);
                                if (data.result == Global.TRUE) {
                                    closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                                        contentWindow.page();
                                    });

                                }
                            }, "json");
                        }
                        else if (data == 1) {
                            console.log("审批不是最后一步", data);
                            var url = "${ctx}/outbound/outboundBill/nextApprovalSelect?bizKey=${outboundBill.sysCode}&flowId=" + flowId + "&step=${outboundBill.step}&";
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
        var stepId = "${param.stepId}";
        var url = "${ctx}/outbound/outboundBill/disagreePC?flowBusinessId=" + stepId + "&approvalMemo1=" + $("#approvalMemo").val() + "&sysCode=" + $("#sysCode").val();
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
        var url = "${ctx}/outbound/outboundBill/unDo?bizKey=" + $("#sysCode").val();
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
        $.each(dataMap, function (key, value) {
            $("#nextApprovalCode").val(value.userCode);
            $("#nextApprovalName").val(value.userName);
        })
        var dg = $('#dataGrid');
        updateListFieldName(dg, 'outboundBillDtlList', 'sortCode');
        updateListFieldName(dg, 'outboundBillDtlList', 'sortName');
        updateListFieldName(dg, 'outboundBillDtlList', 'articlesCode');
        updateListFieldName(dg, 'outboundBillDtlList', 'articlesName');
        updateListFieldName(dg, 'outboundBillDtlList', 'whCode');
        updateListFieldName(dg, 'outboundBillDtlList', 'whName');
        updateListFieldName(dg, 'outboundBillDtlList', 'brand');
        updateListFieldName(dg, 'outboundBillDtlList', 'version');
        updateListFieldName(dg, 'outboundBillDtlList', 'qty');
        updateListFieldName(dg, 'outboundBillDtlList', 'price');
        updateListFieldName(dg, 'outboundBillDtlList', 'outboundNumber');
        $("#inputForm").submit();    //提交ID为inputForm的表单
        var nextApprovalCode = $("#nextApprovalCode").val();
        var nextApprovalName = $("#nextApprovalName").val();
        var stepId = "${param.stepId}";
        var url = "${ctx}/outbound/outboundBill/agreePC?flowBusinessId=" + stepId + "&nextApprovalCode=" + nextApprovalCode + "&approvalMemo1=" + $("#approvalMemo").val() + "&isEnd=1" + "&sysCode=" + $("#sysCode").val() + "&nextApprovalName=" + nextApprovalName;
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
        updateListFieldName(dg, 'outboundBillDtlList', 'sortCode');
        updateListFieldName(dg, 'outboundBillDtlList', 'sortName');
        updateListFieldName(dg, 'outboundBillDtlList', 'articlesName');
        updateListFieldName(dg, 'outboundBillDtlList', 'articlesCode');
        updateListFieldName(dg, 'outboundBillDtlList', 'whCode');
        updateListFieldName(dg, 'outboundBillDtlList', 'whName');
        updateListFieldName(dg, 'outboundBillDtlList', 'brand');
        updateListFieldName(dg, 'outboundBillDtlList', 'version');
        updateListFieldName(dg, 'outboundBillDtlList', 'qty');
        updateListFieldName(dg, 'outboundBillDtlList', 'price');
        updateListFieldName(dg, 'outboundBillDtlList', 'outboundNumber');
        $("#inputForm").submit();
    }

    //撤回申请
    $("#btnUnSubmit").click(function () {
        var url = "${ctx}/outbound/outboundBill/unSubmit?bizKey=" + $("#sysCode").val();
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
        var url = "${ctx}/outbound/outboundBill/delete?sysCode=" + $("#sysCode").val();
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

