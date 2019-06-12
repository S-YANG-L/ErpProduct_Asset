<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="到期资产" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> 到期资产</div>
        <div class="actions">
            <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
            <a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
            <a href="#" class="btn btn-default btn-sm" id="btnSave" type="submit" title="清理过期"><i
                    class="fa fa-external-link"></i> 清理过期</a>
        </div>
    </div>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetListing" action="${ctx}/ass/assetInfo/assetOverData"
                   method="post" class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">资产名称：</label>
                <div class="input-inline width-160">
                    <form:input path="assetName" htmlEscape="false" maxlength="100"
                                class="form-control"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label">资产小类：</label>
                <div class="input-inline width-160">
                    <sys:treeselect url="${ctx}/ass/assetSort/treeData" id="sortCode"
                                    value="${assetListing.sortCode}" labelName="sortName"
                                    labelValue="${assetListing.sortName}" title="资产小类"
                                    name="sortCode"
                                    cssClass="rightBorder" allowClear="true"
                                    notAllowSelectParent="true" isAll="true">
                    </sys:treeselect>
                </div>
            </div>
            <div class="form-group" style="margin-left:10px;">
                <input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
                <input class="btn default btn-sm" type="reset" value="重置"/>
            </div>
        </form:form>
    </div>

    <form:form id="inputForm" modelAttribute="assetClean" action="${ctx}/assetsclean/assetClean/save" method="post"
               class="form-horizontal">
    <div class="form-body">
        <div class="col-sm-8" hidden="true">
            <sys:treeselect id="cleanerCode" name="cleanerCode"
                            value="${assetListing.cleanerCode}" labelName="cleanerName"
                            labelValue="${assetListing.cleanerName}"
                            title="" url="/sys/office/treeData?type=3" cssClass=""
                            allowClear="true" notAllowSelectParent="true" isAll="true"/>
        </div>
        <div class="col-sm-8" hidden="true">
            <input name="cleanDate" id="cleanDate" type="text" readonly="true" maxlength="20"
                   class="form-control Wdate required"
                   value="<fmt:formatDate value="${assetListing.cleanDate}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:'#F{$dp.$D(\'expectedReturnDate\')}'});"/>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <table id="assetReturnDtlDataGrid"></table>
                <div id="dataGridPage"></div>
            </div>
        </div>
        </form:form>
        <sys:message content="${message}"></sys:message>

        <sys:footer extLibs="${extLibs}"/>
        <script type="text/javascript">
            //全局变量存选中的资产表的assetCode
            var assetcodes = [];
            //初始化资产退库子表DataGrid对象
            $("#assetReturnDtlDataGrid").dataGrid({
                showCheckbox: true,    // 是否显示复选框
                searchForm: $("#searchForm"), // 数据来源表单
                tabPageId: '${param.tabPageId}',// 当前页签编号
                // 设置数据表格列
                columnModel: [
                    {
                        header: '资产编码',
                        name: 'assetCode',
                        index: 'a.asset_code',
                        hidden: true,
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
                        header: '资产名称', name: 'assetName', index: 'a.asset_name', width: 200, align: "left",
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
                        index: 'a.sort_code',
                        width: 200,
                        hidden: true,
                        align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '资产大类', name: 'sortName', index: 'a.sort_name', width: 220, align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '品牌', name: 'brand', index: 'a.brand', width: 200, align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '型号', name: 'version', index: 'a.version', width: 200, align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="version" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '单价', name: 'unitPrice', index: 'a.unit_price', width: 200, align: "right",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="unitPrice" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '购入日期', name: 'buyDate', index: 'a.buy_date', width: 200, align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="buyDate" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '公司名称',
                        name: 'companyName',
                        index: 'a.company_name',
                        hidden: true,
                        width: 200,
                        align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="companyName" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '使用部门', name: 'officeName', index: 'a.office_name', width: 200, align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="officeName" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '区域名称', name: 'regionName', index: 'a.region_name', width: 200, align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="regionName" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '责任人名称',
                        name: 'dutyName',
                        hidden: true,
                        index: 'a.duty_name',
                        width: 200,
                        align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="dutyName" value="' + val + '" />');
                            actions.push(val);
                            return actions.join('');
                        }
                    },
                    {
                        header: '存放地点', name: 'storagePlace', index: 'a.storage_place', width: 200, align: "left",
                        formatter: function (val, obj, row, act) {
                            var actions = [];
                            actions.push('<input type="hidden" name="storagePlace" value="' + val + '" />');
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

            //用户字典
            function getreturnRegionCode() {
                $("#returnRegionName").val($("#returnRegionCode").select2("data").text);
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
                updateListFieldName(dg, 'assetCleanDtlList', 'companyName');
                $("#inputForm").submit();

            });
            //数据导出
            $("#btnExport").click(function () {
                top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
                    if (v == "ok") {
                        ajaxDownload('${ctx}/ass/assetInfo/exportOver', $("#searchForm").serialize());
                    }
                }, {buttonsFocus: 1});
                top.$('.jbox-body .jbox-icon').css('top', '55px');
            });

            function openLable(assetCode) {
                <%--var assetCode= '${fns:getUser().userCode}';--%>
                layer.open({
                    type: 2,
                    skin: 'layui-layer-rim',
                    closeBtn: 1,
                    time: 30000,
                    scrollbar: false,
                    shadeClose: true,
                    area: ['850px', '500px'],
                    content: ['${ctx}' + '/ass/assetInfo/Listing?assetCode=' + assetCode, 'no']
                });
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
        </script>
