<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产处理记录" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>资产处理记录</div>
    </div>
    <form:form id="inputForm" modelAttribute="assetInfo" action="${ctx}/ass/assetInfo/save" method="post"
               class="form-horizontal">
        <form:hidden path="id"/>
        <div id="myTabContent" class="tab-content">
            <div class="form-body">
                    <%--<h4 class="form-section">基本信息</h4>--%>
                    <%--项目名称--%>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title=""> 资产名称：<i
                                    class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="assetName" htmlEscape="false" maxlength="100" readonly="true"
                                            class="form-control required"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">资产大类：<i
                                    class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="topSortName" htmlEscape="false" maxlength="100" readonly="true"
                                            class="form-control required"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">资产小类：<i
                                    class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="sortName" htmlEscape="false" maxlength="100" readonly="true"
                                            class="form-control required"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                品牌：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="brand" htmlEscape="false" maxlength="100" readonly="true"
                                            class="form-control "/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                型号：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="version" htmlEscape="false" maxlength="64" readonly="true"
                                            class="form-control "/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">购入日期：<i
                                    class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <input name="buyDate" type="text" readonly="readonly" maxlength="20"
                                       class="form-control Wdate required" disabled="true"
                                       value="<fmt:formatDate value="${assetInfo.buyDate}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                供应商：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="supplier" htmlEscape="false" maxlength="64" readonly="true"
                                            class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                计量单位：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="unit" htmlEscape="false" maxlength="64" readonly="true"
                                            class="form-control "/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <%--标签选项卡--%>
        <ul id="myTab" class="nav nav-tabs nav-top">
            <li class="active" onclick="changaction('1')"><a data-toggle="tab">领用</a></li>
            <li class="" onclick="changaction('2')"><a data-toggle="tab">退库</a></li>
            <li class="" onclick="changaction('3')"><a data-toggle="tab">变更</a></li>
            <li class="" onclick="changaction('4')"><a data-toggle="tab">调拨</a></li>
        </ul>
        <div class="tab-pane fade in active" >
            <div class="form-body">
                <table id="dataGrid"></table>
                <div id="dataGridPage"></div>
            </div>
        </div>
    </form:form>
    <form:form id="searchForm2" method="post"
               action="${ctx}/ass/assetInfo/getAllData1?assetCode=${assetInfo.assetCode}&aaa=1">
    </form:form>
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
    // 初始化DataGrid对象
    var codes = "";
    var assetcodes = [];
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm2"), // 数据来源表单
        showRownum: false, // 是否显示行号
        // 设置数据表格列
        columnModel: [
            {
                header: '处理时间', name: 'dealDate', width: 110, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="dealDate" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '处理人', name: 'dealName', width: 100, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="dealName" value="' + val + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '处理内容', name: 'dealAll', width: 300, align: "left",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    actions.push('<input type="hidden" name="dealAll" value="' + val + '" />');
                    actions.push(val);
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

    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(
            function (key, val) {
                $(this).attr('name', listName + '[' + key + '].' + fieldName);
            });
    }

    //提交前更新列表字段名字，以方便后台接受
    function changaction(e) {
        url = "${ctx}/ass/assetInfo/getAllData1?assetCode=${assetInfo.assetCode}&aaa=" + e;
        $('#searchForm2').attr('action', url);
        $('#searchForm2').submit();
    }
</script>