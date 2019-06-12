<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="即时库存" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>即时库存</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="warehouseItems" action="${ctx}/wareitems/warehouseItems/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<%--  <div class="form-group">
				<label class="control-label">仓库：</label>
				<div class="input-inline">
					<form:input path="whName" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
				</div>
			</div> --%>
			<div class="form-group">
                  <label class="control-label">仓库：</label>
                    <div class="input-inline">
                                <form:select path="whCode" class="form-control selectHeight width-120"
                                             onChange="selWhName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${warehouses}" itemLabel="warehouseName"
                                                  itemValue="warehouseCode" htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="whName"/>
                            </div>
            </div>
			
			<%-- <div class="form-group">
                  <label class="control-label">物品：</label>
                    <div class="input-inline">
                                <form:select path="articlesCode" class="form-control selectHeight width-120"
                                             onChange="selProjectName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${articlesFiles}" itemLabel="articlesName"
                                                  itemValue="articlesCode" htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="articlesName"/>
                            </div>
            </div> --%>
            <div class="form-group">
				<label class="control-label">物品名称：</label>
				<div class="input-inline">
					<form:input path="articlesName" htmlEscape="false" maxlength="61" class="form-control input-sm width-160"/>
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
<script type="text/javascript">
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
			{header:'类别编码', name:'sortCode', index:'a.sort_code', width:200, align:"left",hidden:true},
			{header:'类别名称', name:'sortName', index:'a.sort_name', width:200, align:"center"},
			{header:'物品编码', name:'articlesCode', index:'a.articles_code', width:250, align:"left"},
			{header:'物品名称', name:'articlesName', index:'a.articles_Name', width:200, align:"center"},
			{header:'品牌名称', name:'brand', index:'a.brand', width:200, align:"center"},
			{header:'规格型号', name:'version', index:'a.version', width:200, align:"center"},
			{header:'仓库', name:'whName', index:'a.wh_name', width:200, align:"center"},
			{header:'单价', name:'price', index:'a.price', width:200, align:"center"},
			{header:'数量', name:'qty', index:'a.qty', width:200, align:"center"},
			{header:'合计金额', name:'sumMoney', index:'a.sum_money', width:200, align:"center"},
			/* {header:'安全库存下限', name:'lowerLimit', index:'a.lower_limit', width:220, align:"left",hidden:true},
			{header:'安全库存上限', name:'upperLimit', index:'a.upper_limit', width:220, align:"left",hidden:true}, */
			/* {header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="wareitems:warehouseItems:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/wareitems/warehouseItems/form?id='+row.id+'" class="btnList" title="编辑仓库物品信息"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/wareitems/warehouseItems/delete?id='+row.id+'" class="btnList" title="删除该仓库物品信息" data-confirm="确认要删除该仓库物品信息吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}} */
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
    
    var whList = ${fns:toJson(warehouses)};
    function selWhName() {
        var whCode = $("#whCode").val();
        $.each(whList, function (key, value) {
            if (whCode == value.warehouseCode) {
                $("#whName").val(value.warehouseName);
            }
        });
        console.log("得到", $("#whName").val());
    }
    
/*     var productList = ${fns:toJson(articlesFiles)};
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
                ajaxDownload('${ctx}/wareitems/warehouseItems/export',$("#searchForm").serialize());
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