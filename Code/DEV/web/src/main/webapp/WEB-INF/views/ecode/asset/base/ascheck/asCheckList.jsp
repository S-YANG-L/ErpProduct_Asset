<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="办公用品盘点" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 办公用品盘点</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="ascheck:asCheck:edit">
				<a href="${ctx}/ascheck/asCheck/form" class="btn btn-default btn-sm btnTool" title="新增办公用品盘点"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="asCheck" action="${ctx}/ascheck/asCheck/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">盘点名称：</label>
				<div class="input-inline">
					<form:input path="checkName" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="control-label">操作人：</label>
				<div class="input-inline">
					<form:input path="operatorCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>
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
        shrinkToFit: false,
		// 设置数据表格列
		columnModel: [
			{header:'盘点名称', name:'checkName', index:'a.check_name', width:150, align:"left", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/ascheck/asCheck/form?id='+row.id+'" class="btnList" data-title="查看办公用品盘点">'+(val ? val : row.id)+'</a>';
			}},
			{header:'经办人', name:'operatorName', index:'a.operator_name', width:100, align:"left"},
			{header:'仓库名称', name:'whName', index:'a.wh_name', width:150, align:"center"},
			{header:'盘点时间', name:'checkDate', index:'a.check_date', width:150, align:"center"},
			{header:'操作', name:'actions', width:150, fixed:true,align:"center", sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="ascheck:asCheck:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/ascheck/asCheck/form?id='+row.id+'" class="btnList" title="查看办公用品盘点"><i class="fa fa-eye"></i></a>&nbsp;');
					/* actions.push('<a href="${ctx}/ascheck/asCheck/delete?id='+row.id+'" class="btnList" title="删除该办公用品盘点" data-confirm="确认要删除该办公用品盘点吗？"><i class="fa fa-trash-o"></i></a>&nbsp;'); */
				}//</shiro:hasPermission>
				return actions.join('');
			}}
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
</script>