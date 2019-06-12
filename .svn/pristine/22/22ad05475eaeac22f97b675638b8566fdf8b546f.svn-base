<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产查询" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> 资产查询</div>
        <div class="actions">
            <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
            <a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
        </div>
    </div>
    <sys:message content="${message}"></sys:message>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetListing"
                   action="${ctx}/ass/assetInfo/assetPersonalData?user=${assetListing.user}&assetStatus=1" method="post"
                   class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">

            <div class="row">
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4 col-sm-4">资产编码：</label>
                        <div class="col-sm-8">
                            <form:input path="assetCode" htmlEscape="false" maxlength="255"
                                        class="form-control input-sm width-160"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">资产名称：</label>
                        <div class="col-sm-8">
                            <form:input path="assetName" htmlEscape="false" maxlength="255"
                                        class="form-control input-sm width-160"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4"><span style="color: white">两字</span>品牌：</label>
                        <div class="col-sm-8">
                            <form:input path="brand" htmlEscape="false" maxlength="255"
                                        class="form-control input-sm width-160"/>
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
                        <label class="control-label col-sm-4"><span style="color: white">两字</span>型号：</label>
                        <div class="col-sm-8">
                            <form:input path="version" htmlEscape="false" maxlength="255"
                                        class="form-control input-sm width-160"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4 ">区域名称：</label>
                        <div class="col-sm-8">
                            <form:select path="regionCode" htmlEscape="false" maxlength="20"
                                         class="form-control required width-160" onclick="getregionCode()">
                                <form:option value=" ">&nbsp;</form:option>
                                <form:options items="${fns:getUserDictList('ass_area')}"
                                              itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                            </form:select>
                        </div>
                        <form:input path="regionName" type="hidden"/>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <label class="control-label col-sm-4">存放地点：</label>
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
<script type="text/javascript">
    // 初始化DataGrid对象
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        // 设置数据表格列
        columnModel: [
            {
                header: '状态',
                name: 'assetStatus',
                index: 'a.asset_status',
                width: 80,
                align: "left",
                formatter: function (val, obj, row, act) {
                    var assetStatus = ["闲置", "领用", "借用", "维修", "报废"]
                    return assetStatus[row.assetStatus]
                }
            },
            {header: '资产编码', name: 'assetCode', index: 'a.asset_code', width: 200, align: "left"},
            {header: '资产名称', name: 'assetName', index: 'a.asset_name', width: 200, align: "left"},
            {header: '资产小类', name: 'sortName', index: 'a.sort_name', width: 200, align: "left"},
            {header: '品牌', name: 'brand', index: 'a.brand', width: 100, align: "left"},
            {header: '型号', name: 'version', index: 'a.version', width: 150, align: "left"},
            {header: '公司名称', name: 'companyName', hidden: true, index: 'a.company_name', width: 200, align: "left"},
            {header: '使用部门', name: 'officeName', index: 'a.office_name', width: 200, align: "left"},
            {header: '区域名称', name: 'regionName', index: 'a.region_name', width: 200, align: "left"},
            {header: '责任人名称', name: 'dutyName', hidden: true, index: 'a.duty_name', width: 200, align: "left"},
            {header: '存放地点', name: 'storagePlace', index: 'a.storage_place', width: 200, align: "left"},
            {header: '备注信息', name: 'remarks', index: 'a.remarks', width: 100, align: "left"},
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法

        }
    });
    //数据导出
    $("#btnExport").click(function () {
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                ajaxDownload('${ctx}/ass/assetInfo/exportAssetPersonal?user=${assetListing.user}&assetStatus=1', $("#searchForm").serialize());
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
