<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="编码规则管理 - ${codeRule.isNewRecord ? '新增' : '编辑'}编码规则" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${codeRule.isNewRecord ? '新增' : '编辑'}编码规则</div>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="codeRule" action="${ctx}/ass/codeRule/save" method="post"
                   class="form-horizontal">
            <form:hidden path="codeId"/>
            <form:hidden path="codeNow"/>
            <div class="row">
                <div class="col-xs-3">
                    <div class="form-group" >
                        <label class="control-label col-sm-4" title="">
                            <span class="required" >*</span>编码对象：<i class="fa icon-question hide"></i></label>
                        <div class="col-sm-6">
                            <form:select path="codeObjectId" htmlEscape="false" maxlength="20" disabled="true"
                                         class="form-control width-160 selectHeight" onclick="codeObject()">
                                <form:options items="${fns:getUserDictList('eflow_bill_type')}"
                                              itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                            </form:select>
                            <form:hidden path="codeObject"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-4">
                    <div class="form-group">
                        <label class="control-label col-sm-4" title="">
                            <span class="required">*</span> 流水号长度：<i class="fa icon-question hide"></i></label>
                        <div class="col-sm-6">
                            <form:input path="maxCode" id='codeLen' htmlEscape="false" maxlength="100"
                                        onblur="calcSumMoney()" class="form-control digits"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-left: 2%">
                <div class="col-sm-6">
                    <div class="form-group">
                        <a href="#" id="assetCodeRulesDataGridAddRowBtn"  class="btn btn-primary"><i
                                class="fa fa-plus"></i> 增行编码规则</a>
                        <table id="assetCodeRulesDataGrid"></table>
                        <div id="dataGridPage"></div>
                    </div>
                </div>
            </div>
            <!--        <div class="row" style="margin-left: 25%">
            <div class="col-sm-6">
            <table id="assetCodeRulesDataGrid"></table>
            <div id="dataGridPage"></div>
            </div>
            </div> -->
            <!--  <div class="row" style="margin-top: 50px;margin-left: 25%">

            </div> -->
            <div class="row">
                <div class="col-sm-12">
                    <p style="margin-left:2%;" id="bianmavaluett"></p>
                </div>
            </div>
            <div class="form-actions fluid" style="margin-top: 20px" style="margin-left: 20px">
                <div class="row">
                    <div class="col-sm-4">
                    </div>
                    <div class="col-sm-4">
                        <shiro:hasPermission name="ass:codeRule:edit">
                            <button id="btnSubmit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存
                            </button>
                            &nbsp;
                        </shiro:hasPermission>
                        <button id="btnCancel" type="button" class="btn default"
                                onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i
                                class="fa fa-reply-all"></i> 关 闭
                        </button>
                    </div>
                    <div class="col-sm-4">
                    </div>
                </div>
            </div>
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    $("#inputForm").validate({
        submitHandler: function (form) {
            $("#codeObject").val($("#codeObjectId").select2("data").text);
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
    var dataArr =${fns:toJson(codeRuleslist)};
    if (dataArr == null || dataArr == '') {
        dataArr = [];

    };
    //初始化编码规则表DataGrid对象
    $("#assetCodeRulesDataGrid").dataGrid({
        data: dataArr,
        datatype: "local", // 设置本地数据
        /* autoGridHeight: function () {
            return 'auto'
        }, */ // 设置自动高度
        // 设置数据表格列
        columnModel: [
            {
                header: '规则项编码', name: 'rulesItemCode', index: 'a.rules_item_code', width: 150,
                formatter: function (val, obj, row, act) {
                    return getDictLabel(${fns:getUserDictListJson('asset_rules')}, val, '未知', true);
                },
                editable: true, edittype: "select", editoptions: {
                    'class': 'text-center required',
                    items: $.merge([{label: '&nbsp;', value: ''}], ${fns:getUserDictListJson('asset_rules')}),
                    itemLabel: 'label', itemValue: 'value', dataInit: function (element) {
                        $(element).select2().on("change", function () {
                            try {
                                var csTd = $(this).closest('td').next();
                                var csInput = csTd.find('input:eq(0)');
                                csInput.addClass('required');
                                csInput.attr('type', 'text');
                                var vals = csInput.val().split(',');
                                var lab = $(this).select2('data').text;
                                vals[0] = lab;
                                csInput.val(vals[0]);
                                csTd.html(csInput);
                                $(this).valid();
                            } catch (e) {
                            }
                        });
                    }, dataEvents: [
                        {
                            type: 'change',     //blur,focus,change........焦点失去事件
                            fn: calcSumMoney
                        }
                    ]
                }
            },
            {
                header: '规则编码名称',
                name: 'rulesItemName',
                index: 'a.rules_item_name',
                width: 150,
                hidden: true,
                editable: true,
                edittype: 'text',
                editoptions: {'maxlength': '64', 'class': 'form-control required'}
            }, {
                header: '行数据', name: 'rowData', hidden: true, formatter: function (val, obj, row, act) {
                    return JSON.stringify(row);
                }
            },
            {
                header: '操作',
                name: 'actions',
                width: 120,
                sortable: false,
                fixed: true,align:"center",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    console.log("操作");
                    console.log(obj.rowId);
                    actions.push('<a href="#"  onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#assetCodeRulesDataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\',null,{display:\'none\'});$(\'#' + obj.rowId + '_status\').val(\'' + Global.STATUS_DELETE + '\');calcSumMoney()});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    return actions.join('');
                },
                editoptions: {defaultValue: 'new'}
            }
        ],
        // 编辑表格参数
        editGrid: true,				// 是否是编辑表格
        editGridInitRowNum: 1,		// 编辑表格的初始化新增行数
        editGridAddRowBtn: $('#assetCodeRulesDataGridAddRowBtn'),	// 子表增行按钮
        editGridAddRowInitData: {id: '', status: Global.STATUS_NORMAL},	// 新增行的时候初始化的数据
        // 编辑表格的提交数据参数
        editGridInputFormListName: 'assetCodeRulesList', // 提交的数据列表名
        editGridInputFormListAttrs: 'id,status,codeId,codeRulesItem,codeRulesItemName,codeRulesFormat,codeRulesFormatContent,codeRulesLen,codeRulesRemarks,codeRulesSort,category1,category2,lastMax,flowComplement,flowComplementMode,remarks', // 提交数据列表的属性字段
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $("#assetCodeRulesDataGrid")
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusFiled: false});
            }
            var bianmavalue = "";
            var codeLensum = "";
            codeLensum = document.getElementById("codeLen").value + '流水号';
            $("#assetCodeRulesDataGrid").find("[name$='rulesItemCode']").each(function () {
                if ($(this).val() == '01') {
                    bianmavalue = bianmavalue + '日期（六位）+';

                } else if ($(this).val() == '02') {
                    bianmavalue = bianmavalue + '资产分类编码+';

                } else if ($(this).val() == '03') {
                    bianmavalue = bianmavalue + '部门编码+';

                } else if ($(this).val() == '04') {
                    bianmavalue = bianmavalue + '单位编码+';

                } else if ($(this).val() == '05') {
                    bianmavalue = bianmavalue + '日期（八位）+';
                }
            });
            bianmavalue = bianmavalue + codeLensum;
            console.log(bianmavalue);
            document.getElementById('bianmavaluett').innerHTML = "编码规则为：" + bianmavalue;
            $("#codeNow").val(bianmavalue);
        },
        onSelectRow: function (id, isSelect, event) {
        }
    });
    //重写执行发送的方法.
    $("#btnSubmit").click(function () {
        var dg = $('#assetCodeRulesDataGrid');
        console.log("重写执行发送的方法");
        updateListFieldName(dg, 'codeRulesList', 'rulesItemCode');
        updateListFieldName(dg, 'codeRulesList', 'rulesItemName');
        updateListFieldName(dg, 'codeRulesList', 'codeFormat');
        updateListFieldName(dg, 'codeRulesList', 'codeFormatContent');
        updateListFieldName(dg, 'codeRulesList', 'codeLen');
        updateListFieldName(dg, 'codeRulesList', 'flowComplement');
        updateListFieldName(dg, 'codeRulesList', 'codeSort');
        updateListFieldName(dg, 'codeRulesList', 'flowComplementMode');
        updateListFieldName(dg, 'codeRulesList', 'rulesRemarks');
        $("#inputForm").submit();
    });

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(function (key, val) {
            $(this).attr('name', listName + '[' + key + '].' + fieldName);
        });
    }
    function calcSumMoney() {
        var bianmavalue = "";
        var codeLensum = "";
        var sign1 = 0;
        var sign2 = 0;
        var sign3 = 0;
        var sign4 = 0;
        var sign5 = 0;
        codeLensum = document.getElementById("codeLen").value + '流水号';
        $("#assetCodeRulesDataGrid").find("[name$='rulesItemCode']").each(function () {
            if ($(this).val() == '01') {
                bianmavalue = bianmavalue + '日期（六位）+';
                sign1++;
            } else if ($(this).val() == '02') {
                bianmavalue = bianmavalue + '资产分类编码+';
                sign2++;
            } else if ($(this).val() == '03') {
                bianmavalue = bianmavalue + '部门编码+';
                sign3++;
            } else if ($(this).val() == '04') {
                bianmavalue = bianmavalue + '单位编码+';
                sign4++;
            } else if ($(this).val() == '05') {
                bianmavalue = bianmavalue + '日期（八位）+';
                sign5++;
            }
        });
        if (sign1 > 1 || sign2 > 1 || sign3 > 1 || sign4 > 1 || sign5 > 1) {
            showMessage('提示：规则项最好不要重复');
            var bianmavalue = "";
            var codeLensum = "";
            codeLensum = document.getElementById("codeLen").value + '流水号';
            $("#assetCodeRulesDataGrid").find("[name$='rulesItemCode']").each(function () {
                if ($(this).val() == '01') {
                    bianmavalue = bianmavalue + '日期（六位）+';
                } else if ($(this).val() == '02') {
                    bianmavalue = bianmavalue + '资产分类编码+';
                } else if ($(this).val() == '03') {
                    bianmavalue = bianmavalue + '部门编码+';
                } else if ($(this).val() == '04') {
                    bianmavalue = bianmavalue + '单位编码+';
                } else if ($(this).val() == '05') {
                    bianmavalue = bianmavalue + '日期（八位）+';
                }
            });
        }
        bianmavalue = bianmavalue + codeLensum;
        document.getElementById('bianmavaluett').innerHTML = "编码规则为：" + bianmavalue;
        $("#codeNow").val(bianmavalue);

    }
    //用户字典
    function codeObject() {
        $("#codeObject").val($("#codeObjectId").select2("data").text);
    }
</script>
