<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<sys:header title="分类使用情况" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i> 分类使用情况</div>
        <div class="actions">
            <a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
            <a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>

        </div>
    </div>
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="assetClean" action="${ctx}/assetsclean/assetClean/summaryData"
                   method="post" class="breadcrumb form-inline hide"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">资产大类：</label>
                <div class="input-inline width-160">
                    <sys:treeselect url="${ctx}/ass/assetSort/treeDataTop" id="topSortCode"
                                    value="${assetInfo.topSortCode}" labelName="topSortName"
                                    labelValue="${assetInfo.topSortName}" title="资产大类"
                                    name="topSortCode"
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
        <table id="dataGrid"></table>
        <div id="dataGridPage"></div>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script src="${ctxStatic}/common/js/pubnew.js" type="text/javascript"></script>
<script type="text/javascript">
    // 初始化DataGrid对象
    var countxzAll = 0;
    var countlyAll = 0;
    var countdbAll = 0;
    var countdwAll = 0;
    var countjxAll = 0;
    var countbfAll = 0;
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        showFooter: true,	// 是否显示底部合计行
        // 设置数据表格列
        columnModel: [
            {header: '资产大类编码', name: 'topSortCode', index: 'z.top_sort_code',hidden:true, width: 300, align: "left", frozen: true},
            {header: '资产大类名称', name: 'topSortName', index: 'z.top_sort_name', width: 300, align: "left", frozen: true},
            {
                header: '闲置', name: 'countxz', index: 'xz.countxz', width: 200, align: "right", frozen: true,
                formatter: function (val, obj, row, act) {
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    countxzAll = countxzAll + Number(lingAll)
                    return '<a href="${ctx}/assetsclean/assetClean/assetSummaryInfoList?topSortCode=' + row.topSortCode + '&assetStatus=0' + '" id="" class="btnList" data-title="分类使用情况详情">' + (lingAll ? lingAll : row.id) + '</a>';
                }
            },
            {
                header: '领用',
                name: 'countly',
                index: 'ly.countly',
                width: 200,
                align: "right",
                formatter: function (val, obj, row, act) {
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    countlyAll = countlyAll + Number(lingAll);
                    return '<a href="${ctx}/assetsclean/assetClean/assetSummaryInfoList?topSortCode=' + row.topSortCode + '&assetStatus=1' + '" class="btnList" data-title="分类使用情况详情">' + (lingAll ? lingAll : row.id) + '</a>';
                }
            },
            {
                header: '借用', name: 'countjy', index: 'jy.countjy', hidden: true, width: 200, align: "right",
                formatter: function (value, row, index) {
                    if (value == null) {
                        return 0;
                    } else {
                        return value;
                    }
                }
            },
            {
                header: '调拨中', name: 'countdb', index: 'db.countdb', width: 200, align: "right",
                formatter: function (val, obj, row, act) {
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    countdbAll = countdbAll + Number(lingAll);
                    return '<a href="${ctx}/assetsclean/assetClean/assetSummaryInfoList?topSortCode=' + row.topSortCode + '&assetStatus=5' + '" class="btnList" data-title="分类使用情况详情">' + (lingAll ? lingAll : row.id) + '</a>';
                }
            },
            {
                header: '捐献', name: 'countjx', index: 'jx.countjx', width: 200, align: "right",
                formatter: function (val, obj, row, act) {
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    countjxAll = countjxAll + Number(lingAll);
                    return '<a href="${ctx}/assetsclean/assetClean/assetSummaryInfoList?topSortCode=' + row.topSortCode + '&assetStatus=6' + '" class="btnList" data-title="分类使用情况详情">' + (lingAll ? lingAll : row.id) + '</a>';
                }
            },
            {
                header: '到新单位', name: 'countdw', index: 'dw.countdw', width: 200, align: "right",
                formatter: function (val, obj, row, act) {
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    countdwAll = countdwAll + Number(lingAll);
                    return '<a href="${ctx}/assetsclean/assetClean/assetSummaryInfoList?topSortCode=' + row.topSortCode + '&assetStatus=7' + '"  class="aaa' + row.lingAll + '" data-title="分类使用情况详情">' + (lingAll ? lingAll : row.id) + '</a>';
                }
            },
            {
                header: '报废', name: 'countbf', index: 'bf.countbf', width: 200, align: "right",
                formatter: function (val, obj, row, act) {
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    countbfAll = countbfAll + Number(lingAll);
                    return '<a href="${ctx}/assetsclean/assetClean/assetSummaryInfoList?topSortCode=' + row.topSortCode + '&assetStatus=4' + '" class="btnList" data-title="分类使用情况详情">' + (lingAll ? lingAll : row.id) + '</a>';
                }
            },
            {
                header: '合计', name: 'hj', index: 'z.hj', width: 200, align: "right",
                formatter: function (val, obj, row, act) {
                    var actions = [];
                    var lingAll = "0";
                    if (val == null) {
                        lingAll = "0";
                    } else {
                        lingAll = val;
                    }
                    actions.push('<input type="hidden" name="hj" value="' + lingAll + '" />');
                    actions.push(val);
                    return actions.join('');
                }
            },
            {
                header: '金额', name: 'je', index: 'z.je', width: 200, align: "right",
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
                }
            }

        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法
            var dg = $('#dataGrid');
            var ids = dg.dataGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                dg.dataGrid('editRow', ids[i], {keys: true, focusField: false});
            }
            var  hjs=0;
            $("#dataGrid").find("input[name$='hj']").each(function () {
                hjs = hjs.add(Number($(this).val()));
            });
            var  jes=0;
            $("#dataGrid").find("input[name$='je']").each(function () {
                jes = jes.add(Number($(this).val()));
            });
            $('#dataGrid').dataGrid("footerData", "set", {
                'topSortName': '<em class="pull-left">合计：&nbsp;</em>',
                'countxz': '<em class="pull-right">' + countxzAll + '</em>',
                'countly': '<em class="pull-right">' + countlyAll + '</em>',
                'countdb': '<em class="pull-right">' + countdbAll + '</em>',
                'countdw': '<em class="pull-right">' + countdwAll + '</em>',
                'countjx': '<em class="pull-right">' + countjxAll + '</em>',
                'countbf': '<em class="pull-right">' + countbfAll + '</em>',
                'hj': '<em class="pull-right">' + hjs + '</em>',
                'je': '<em class="pull-right">' + parseMoney(jes)+ '</em>'
            }, false);
        }
    });
    //数据导出
    $("#btnExport").click(function () {
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
            if (v == "ok") {
                ajaxDownload('${ctx}/assetsclean/assetClean/exportSort', $("#searchForm").serialize());
            }
        }, {buttonsFocus: 1});
        top.$('.jbox-body .jbox-icon').css('top', '55px');
    });

    /**
     * Ajax 文件下载
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

    function openLable(cleanCode) {
        <%--var assetCode= '${fns:getUser().userCode}';--%>
        layer.open({
            type: 2,
            skin: 'layui-layer-rim',
            closeBtn: 1,
            time: 30000,
            scrollbar: false,
            shadeClose: true,
            area: ['850px', '350px'],
            content: ['${ctx}' + '/assetsclean/assetClean/assetCleanJiluDtl?cleanCode=' + cleanCode, 'no']
        });
    }
</script>