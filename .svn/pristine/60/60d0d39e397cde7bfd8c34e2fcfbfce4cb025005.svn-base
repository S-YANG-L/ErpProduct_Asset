<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="办公用品领用" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>办公用品领用表</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="recipients" action="${ctx}/recipients/recipients/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="form-group">
				<label class="control-label">起止日期：</label>
				<div class="input-inline">
					<input name="beginDate" id="beginDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
                           value="<fmt:formatDate value="${recipients.beginDate}" pattern="yyyy-MM-dd"/>"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>-
                    <input name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
                           value="<fmt:formatDate value="${recipients.endDate}" pattern="yyyy-MM-dd"/>"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,minDate:'#F{$dp.$D(\'beginDate\')}'});"/>
				</div>
			</div>
            
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<form:form></form:form>
		<table id="dataGrid"></table>
		<div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'部门', name:'officeName', index:'a.office_name', width:150, align:"left",hidden:true},
			{header:'领用单号', name:'sysId', index:'a.sys_id', width:150, align:"left"},
			{header:'办公用品分类', name:'sortName', index:'a.sort_name', width:150, align:"left"},
			{header:'办公用品名称', name:'articlesName', index:'a.articles_name', width:230, align:"left"},
			{header:'领用日期', name:'createDate', index:'a.create_date', width:150, align:"left"},
			{header:'领用人', name:'outbounderName', index:'b.outbounder_name', width:150, align:"left"},
			{header:'领用数量', name:'sumNumber', index:'sum(a.outbound_number)', width:150, align:"left"},
			/* {header:'领用单价', name:'price', index:'a.price', width:150, align:"left"}, */
			{header:'金额', name:'sumMoney', index:'ROUND(sum(a.sum_money),2)', width:150, align:"left"},
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
    
/*     var whList = ${fns:toJson(warehouses)};
    function selWhName() {
        var whCode = $("#whCode").val();
        $.each(whList, function (key, value) {
            if (whCode == value.warehouseCode) {
                $("#whName").val(value.warehouseName);
            }
        });
        console.log("得到", $("#whName").val());
    }
    
    var productList = ${fns:toJson(articlesFiles)};
    function selProjectName() {
        var articlesCode = $("#articlesCode").val();
        $.each(productList, function (key, value) {
            if (articlesCode == value.articlesCode) {
                $("#articlesName").val(value.articlesName);
            }
        });
        console.log("得到", $("#articlesName").val());
    } */
    
	 //数据导出
    $("#btnExport").click(function(){
        top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
            if(v=="ok"){
                ajaxDownload('${ctx}/recipients/recipients/export',$("#searchForm").serialize());
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