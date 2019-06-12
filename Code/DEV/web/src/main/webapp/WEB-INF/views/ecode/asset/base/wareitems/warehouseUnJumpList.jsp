<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<c:set var="extHead">
    <style type="text/css">
        <!--
        div.tagsinput {
            border: 1px solid #ccc;
            background: #fff;
            margin-top: 9px;
            padding: 5px;
            padding-bottom: 0;
            overflow-y: auto;
            width: auto;
            min-height: 42px;
            height: 42px;
        }

        div.tagsinput span.tag {
            border: 1px solid #a5d24a;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            display: block;
            float: left;
            padding: 5px;
            text-decoration: none;
            background: #cde69c;
            color: #638421;
            margin-right: 5px;
            margin-bottom: 5px;
        }

        div.tagsinput span.tag a {
            font-weight: bold;
            color: #82ad2b;
            text-decoration: none;
            font-size: 11px;
        }

        div.tagsinput input {
            width: 80px;
            margin: 0px;
            font-family: helvetica;
            font-size: 13px;
            border: 1px solid transparent;
            padding: 5px;
            background: transparent;
            color: #000;
            outline: 0px;
            margin-right: 5px;
            margin-bottom: 5px;
        }

        div.tagsinput div {
            display: block;
            float: left;
        }

        .tags_clear {
            clear: both;
            width: 100%;
            height: 0px;
        }

        .not_valid {
            background: #fbd8db !important;
            color: #90111a !important;
        }

        .breadcrumb {
            padding-top: 4px;
        }

        -->
    </style>
</c:set>
<sys:header title="项目查询" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="portlet box">
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="warehouseItems" action="${ctx}/wareitems/warehouseItems/listData"
                   method="post" class="breadcrumb form-inline "
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <form:hidden path="whCode"/>
            <form:hidden path="articlesCodes"/>
        </form:form>
        <table id="dataGrid"></table>
        <div id="dataGridPage"></div>
        <div id="selectProjects" class="tagsinput"></div>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    var dataMap = {};
    var dataSize = 0; // 获取数据MAP
    $(document).ready(function () {
        // 初始化DataGrid对象
        $('#dataGrid').dataGrid({
            // 当前页签编号
            showCheckbox: true,
            tabPageId: '${param.tabPageId}',
            // 设置数据表格列
            columnModel: [
                {
                    header: '办公用品编码',
                    name: 'articlesCode',
                    index: 'a.articles_code',
                    width: 200,
                    align: "left",
                    hidden: true,
                    frozen: true
                },
                {
                    header: '办公用品名称',
                    name: 'articlesName',
                    index: 'a.articles_name',
                    width: 200,
                    align: "left",
                    frozen: true
                },
                {header: '类别编码', name: 'sortCode', index: 'a.sort_code', width: 200, hidden: true, align: "left"},
                {header: '类别名称', name: 'sortName', index: 'a.sort_name', width: 200, align: "left"},
                {header: '仓库编码', name: 'whCode', index: 'a.wh_code', width: 200, hidden: true, align: "left"},
                {header: '仓库名称', name: 'whName', index: 'a.wh_name', width: 200, align: "left"},
                {header: '品牌名称', name: 'brand', index: 'a.brand', width: 200, align: "left"},
                {header: '规格型号', name: 'version', index: 'a.version', width: 200, align: "left"},
                {header: '单价', name: 'price', index: 'a.price', width: 200, align: "left"},
                {header: '数量', name: 'qty', index: 'a.qty', width: 200, align: "left"},
                {header: '合计金额', name: 'sumMoney', index: 'a.sum_money', width: 200, align: "left"},
                {header: '备注', name: 'remarks', index: 'a.remarks', width: 200, align: "left"},
                {
                    header: '行数据', name: 'rowData', hidden: true, formatter: function (val, obj, row, act) {
                        return JSON.stringify(row);
                    }
                }
            ],
            multiboxonly: false,
            ajaxSuccess: function (data) { // 加载成功后执行方法

            },
            onSelectRow: function (id, isSelect, event) {//单选
                if (isSelect) {
                    dataMap[id] = JSON.parse($('#dataGrid').dataGrid('getRowData', id).rowData);
                } else {
                    delete dataMap[id];
                }
                selectProjects();
            },
            onSelectAll: function (ids, isSelect) {//全选
                console.log("sdsf", ids);
                for (var i = 0; i < ids.length; i++) {
                    if (isSelect) {
                        dataMap[ids[i]] = JSON.parse($('#dataGrid').dataGrid('getRowData', ids[i]).rowData);
                    } else {
                        delete dataMap[ids[i]];
                    }
                }
                selectProjects();
            }
        });

    });

    function selectProjects() {
        dataSize = 0;
        var selectHtml = "";
        $.each(dataMap, function (key, value) {

            dataSize++;
            selectHtml += '<span class="tag" id="' + key + '_tagsinput"><span>' + value.articlesName + '&nbsp;&nbsp;</span><a href="#" onclick="removingTag(\'' + key + '\');" title="Removing tag">x</a></span>';
        });
        selectHtml = '<span class="tag" style="border-color:#fff;background:#fff;"><span>&nbsp;当前已选择<span id="dataSize">' + dataSize + '</span>项：</span></span>' + selectHtml + '<div class="tags_clear"></div>';
        $('#selectProjects').empty().append(selectHtml);
    }

    function removingTag(key) {
        $('#dataGrid').dataGrid('resetSelection', key);
        delete dataMap[key];
        $('#dataSize').html(--dataSize);
        $('#' + key + '_tagsinput').remove();
    }

    function getDataMap() {
        return dataMap;
    }

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

</script>