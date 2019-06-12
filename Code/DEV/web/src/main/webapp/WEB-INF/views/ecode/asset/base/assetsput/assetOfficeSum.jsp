<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="部门汇总" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> 部门汇总</div>
        <div class="actions">
            <c:choose>
                <c:when test="${statusOffice=='0'}">
                    <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
                </c:when>
            </c:choose>
            <a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
        </div>
    </div>
    <sys:message content="${message}"></sys:message>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetOffice" action="${ctx}/ass/assetInfo/getOfficeData"
                   method="post" class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">部门：</label>
                <div class="input-inline">
                    <form:input path="officeName" htmlEscape="false" maxlength="100"
                                class="form-control input-sm width-160"/>
                </div>
            </div>
            <div class="form-group" style="margin-left:10px;">
                <input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
                <input class="btn default btn-sm" type="reset" value="重置"/>
            </div>
        </form:form>
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <table id="dataGrid"></table>
                    <div id="dataGridPage"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/layer/layer.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/js/pubnew.js" type="text/javascript"></script>
<script type="text/javascript">
    // 初始化DataGrid对象
    var sumAssetNameAll=0;
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        showFooter: true,	// 是否显示底部合计行
        // 设置数据表格列
        columnModel: [
            {header: '部门', name: 'officeCode',hidden:true, index: 'a.office_code', width: 200, align: "left"},
            {header: '部门', name: 'officeName', index: 'a.office_name', width: 200, align: "left"},
            {header: '资产数量', name: 'sumAssetName', index: 'a.sumAssetName', width: 200, align: "right",
                formatter: function (val, obj, row, act) {
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    sumAssetNameAll = sumAssetNameAll + Number(lingAll)
                    return '<a href="${ctx}/assetsclean/assetClean/assetSummaryInfoList?office.officeCode=' + row.officeCode + '&assetStatus=1' + '" id="" class="btnList" data-title="分类使用情况详情">' + (lingAll ? lingAll : row.id) + '</a>';
                }
            },
            {header: '资产金额', name: 'je', index: 'a.je', width: 200, align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    actions.push('<input type="hidden" name="je" value="' + lingAll + '" />');
                    actions.push(val);
                    return actions.join('');
                }}
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $('#dataGrid');
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
            }
            var  jes=0;
            $("#dataGrid").find("input[name$='je']").each(function () {
                jes = jes.add(Number($(this).val()));
            });

            $('#dataGrid').dataGrid("footerData", "set", {
                'officeName': '<em class="pull-left">合计：&nbsp;</em>',
                'sumAssetName': '<em class="pull-right">' + sumAssetNameAll + '</em>',
                'je': '<em class="pull-right">' + parseMoney(jes)+ '</em>'
            }, false);
        }
    });
    //数据导出
    $("#btnExport").click(function () {
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                ajaxDownload('${ctx}/ass/assetInfo/exportoffice', $("#searchForm").serialize());
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
