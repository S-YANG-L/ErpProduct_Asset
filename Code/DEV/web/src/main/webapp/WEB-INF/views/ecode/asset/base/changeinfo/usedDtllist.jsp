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
        <form:form id="searchForm" modelAttribute="assetInfo" action="${ctx}/ass/assetInfo/listDataChange" method="post"
                   class="breadcrumb form-inline "
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <form:hidden path="assetCodes"/>
            <div class="form-group">
                <label class="control-label">资产名称：</label>
                <div class="input-inline">
                    <form:input path="assetName" htmlEscape="false" maxlength="64"
                                class="form-control input-sm width-160"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label" title=""> 资产小类：</label>
                <div class="input-inline width-160">
                    <sys:treeselect url="${ctx}/ass/assetSort/treeData" id="sortCode"
                                    value="${assetInfo.sortCode}" labelName="sortName"
                                    labelValue="${assetInfo.sortName}" title="资产小类" name="sortCode"
                                    cssClass="rightBorder" allowClear="true"
                                    notAllowSelectParent="true" isAll="true">
                    </sys:treeselect>
                </div>
            </div>
            <div class="form-group"> &nbsp;&nbsp;
                <input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
                <input class="btn default btn-sm" type="reset" value="重置"/>
            </div>
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
                {header: '资产编码', name: 'assetCode', index: 'a.asset_code', width: 200, align: "left"},
                {header: '资产名称', name: 'assetName', index: 'a.asset_name', width: 200, align: "left"},
                {header: '资产分类名称', name: 'sortName', index: 'a.sort_name', width: 200, align: "left"},
                {header: '品牌', name: 'brand', index: 'a.brand', width: 200, align: "left"},
                {header: '型号', name: 'version', index: 'a.version', width: 200, align: "left"},
                {header: '使用部门', name: 'officeName', index: 'a.office_name', width: 200, align: "left"},
                {header: '区域名称', name: 'regionName', index: 'a.region_name', width: 200, align: "left"},
                {header: '责任人名称', name: 'dutyName', hidden: true, index: 'a.duty_name', width: 200, align: "left"},
                {header: '存放地点', name: 'storagePlace', index: 'a.storage_place', width: 200, align: "left"},
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
            selectHtml += '<span class="tag" id="' + key + '_tagsinput"><span>' + value.assetCode + '&nbsp;&nbsp;</span><a href="#" onclick="removingTag(\'' + key + '\');" title="Removing tag">x</a></span>';
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
</script>