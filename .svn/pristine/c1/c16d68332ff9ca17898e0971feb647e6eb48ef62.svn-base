<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="月增加对账表" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 月增加对账表</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
                <a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
		</div>
	</div>
    <sys:message content="${message}"></sys:message>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="assetSum" action="${ctx}/ass/assetInfo/sumlistData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
                <label class="control-label">购入年月：</label>
                <div class="input-inline">
                    <input name="beginDate" id="beginDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
                           value="<fmt:formatDate value="${assetSum.beginDate}" pattern="yyyy-MM"/>"
                           onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});"/>-
                    <input name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
                           value="<fmt:formatDate value="${assetSum.endDate}" pattern="yyyy-MM"/>"
                           onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false,minDate:'#F{$dp.$D(\'beginDate\')}'});"/>
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
<sys:footer extLibs="${extLibs}" />
<script src="${ctxStatic}/common/layer/layer.js" type="text/javascript"></script>
<script type="text/javascript">
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({

		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		// 设置数据表格列
		columnModel: [
            {header:'资产编码', name:'assetCode', index:'a.asset_code', width:200, align:"left"},
            {header:'资产名称', name:'assetName', index:'a.asset_name', width:200, align:"left"},
            {header:'购入日期', name:'buyDate', index:'a.buy_date', width:200, align:"left"},
			{header:'资产小类', name:'sortName', index:'a.sort_name', width:200, align:"left"},
			{header:'型号', name:'version', index:'a.version', width:200, align:"left"},
			{header:'公司名称', name:'companyName', index:'a.company_name', hidden:true, width:200, align:"left"},
			{header:'使用部门', name:'officeName', index:'a.office_name', width:200, align:"left"},
			{header:'区域名称', name:'regionName', index:'a.region_name', width:200, align:"left"},
			{header:'责任人名称', name:'dutyName', hidden:true,index:'a.duty_name', width:200, align:"left"},
			{header:'存放地点', name:'storagePlace', index:'a.storage_place', width:200, align:"left"}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
    //数据导出
    $("#btnExport").click(function(){
        top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
            if(v=="ok"){
                ajaxDownload('${ctx}/ass/assetInfo/exportSum',$("#searchForm").serialize());
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
