<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产折旧" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 资产折旧</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="assetZheJiu" action="${ctx}/ass/assetInfo/save" method="post"
				   class="form-horizontal">
			<div class="form-body">
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-3" title=""> 资产总额：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
									${assetZheJiu.zczE}
							</div>
						</div>
					</div>

					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-3" title="">资产总累计折旧：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
									${assetZheJiu.zclJ}
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
<sys:message content="${message}"></sys:message>
<div class="portlet-body list">
	<form:form id="searchForm" modelAttribute="assetZheJiu" action="${ctx}/ass/assetInfo/zheJiuData" method="post" class="breadcrumb form-inline hide"
			   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
		<div class="form-group">
			<label class="control-label">资产大类：</label>
			<div class="input-inline width-160">
				<sys:treeselect id="topSortCode" name="topSortCode" value="${assetZheJiu.topSortCode}" labelName="sortName" labelValue="${assetZheJiu.topSortName}"
								title="资产大类" url="${ctx}/ass/assetSort/treeDataTop" cssClass="" allowClear="true" notAllowSelectParent="true" />
			</div>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
			<input class="btn default btn-sm" type="reset" value="重置" onclick="cz();"/>
		</div>
	</form:form>
	<table id="dataGrid"></table>
	<div id="dataGridPage"></div>
</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
    $("#inputForm").validate({
        submitHandler: function(form){
            ajaxSubmitForm($(form), function(data){
                showMessage(data.message);
                if(data.result == Global.TRUE){
                    closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
                        contentWindow.page();
                    });
                }
            }, "json");
        }
    });
    // 初始化DataGrid对象
    $("#dataGrid").dataGrid({
        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号
        // 设置数据表格列
        columnModel: [
            {header:'资产编码', name:'assetCode', index:'a.assetCode', width:200, align:"left"},
            {header:'资产名称', name:'assetName', index:'a.assetName', width:200, align:"left"},
            {header:'原值', name:'unitPrice', index:'a.unitPrice', width:200, align:"right"},
            {header:'本期折旧', name:'bqzJ', index:'a.BQZJ', width:200, align:"right"},
            {header:'累计折旧', name:'ljzJ', index:'a.LJZJ', width:200, align:"right"},
            {header:'净值', name:'qZ', index:'a.QZ', width:200, align:"right"},
            {header:'净残值', name:'qcZ', index:'a.QCZ', width:200, align:"right"},
            {header:'使用期限', name:'ageLimit', index:'a.ageLimit', width:200, align:"right"},
            {header:'已使用月份', name:'syyF', index:'a.SYYF', width:200, align:"right"},
            {header:'剩余期限', name:'syqX', index:'a.SYQX', width:200, align:"right"}
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
            console.log("UU",codes);
        }
    });
    //提交前更新列表字段名字，以方便后台接受
    function updateListFieldName(dg, listName, fieldName) {
        dg.find('[name$="' + fieldName + '"]:not(div,a)').each(
            function(key, val) {
                $(this).attr('name',listName + '[' + key + '].' + fieldName);
            });
    }
    //数据导出
    $("#btnExport").click(function(){
        top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
            if(v=="ok"){
                ajaxDownload('${ctx}/ass/assetInfo/exportZhejiu',$("#searchForm").serialize());
            }
        },{buttonsFocus:1});
        top.$('.jbox-body .jbox-icon').css('top','55px');
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
            $.each(data.split('&'), function() {
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
