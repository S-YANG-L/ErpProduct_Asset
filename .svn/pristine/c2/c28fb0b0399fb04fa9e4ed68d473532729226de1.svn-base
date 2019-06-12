<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid"/>
<c:set var="extHead">
<style type="text/css">
<!--
div.tagsinput { border:1px solid #ccc; background:#fff; margin-top:9px; padding:5px; padding-bottom:0; overflow-y: auto;width:auto;min-height:42px; height:42px;}
div.tagsinput span.tag { border: 1px solid #a5d24a; -moz-border-radius:2px; -webkit-border-radius:2px; display: block; float: left; padding: 5px; text-decoration:none; background: #cde69c; color: #638421; margin-right: 5px; margin-bottom:5px;}
div.tagsinput span.tag a { font-weight: bold; color: #82ad2b; text-decoration:none; font-size: 11px;  } 
div.tagsinput input { width:80px; margin:0px; font-family: helvetica; font-size: 13px; border:1px solid transparent; padding:5px; background: transparent; color: #000; outline:0px;  margin-right:5px; margin-bottom:5px; }
div.tagsinput div { display:block; float: left; } 
.tags_clear { clear: both; width: 100%; height: 0px; }
.not_valid {background: #fbd8db !important; color: #90111a !important;}
.breadcrumb{padding-top:4px;}
-->
</style>
</c:set>
<sys:header title="采购引入" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-body list">
        <form:form id="searchForm" modelAttribute="orderBill" action="${ctx}/orderbill/orderBill/listData" method="post"
                   class="breadcrumb form-inline"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <form:hidden path="approvalStatus"/>
            <form:hidden path="inoutStatus"/>
            <form:hidden path="sysCodes"/>
            <div class="form-group">
                <label class="control-label">采购单号：</label>
                <div class="input-inline">
                    <form:input path="cgCode" htmlEscape="false" maxlength="100"
                                class="form-control input-sm width-160"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label">采购人：</label>
                <div class="input-inline">
                    <form:input path="buyerName" htmlEscape="false" maxlength="100"
                                class="form-control input-sm width-160"/>
                </div>
            </div>
            <div class="form-group" style="margin-left:10px;">
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
        $("#dataGrid").dataGrid({
            searchForm: $("#searchForm"), // 数据来源表单
            tabPageId: '${param.tabPageId}',// 当前页签编号
            showCheckbox: true, // 是否显示复选框

            // 设置数据表格列
            columnModel: [
                {header: '采购人', name: 'buyerName', index: 'a.buyer_name', width: 200, align: "center"},
                {header: '采购单号', name: 'cgCode', index: 'a.cg_code', width: 200, align: "center"},
                {header: '采购日期', name: 'orderDate', index: 'a.order_date', width: 200, align: "center"},
                {
                    header: '行数据', name: 'rowData', hidden: true, formatter: function (val, obj, row, act) {
                        return JSON.stringify(row);
                    }
                }
            ],
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
                console.log(ids);
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
            selectHtml += '<span class="tag" id="'+key+'_tagsinput"><span>'+value.cgCode+'&nbsp;&nbsp;</span><a href="#" onclick="removingTag(\''+key+'\');" title="Removing tag">x</a></span>';
        });
        selectHtml = '<span class="tag" style="border-color:#fff;background:#fff;"><span>&nbsp;当前已选择<span id="dataSize">'+dataSize+'</span>项：</span></span>' + selectHtml + '<div class="tags_clear"></div>';
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