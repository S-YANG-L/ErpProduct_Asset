<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="模块管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-puzzle-piece"></i> ${fns:text('模块管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="sys:module:edit">
				<a href="${ctx}/sys/module/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增模块')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
				<a href="#" class="btn btn-default btn-sm" id="btnUpdateCache" title="${fns:text('清理平台及项目缓存，不包含参数配置')}"><i class="fa fa-refresh"></i> ${fns:text('清理缓存')}</a>
			</shiro:hasPermission>
			<div class="btn-group">
				<!-- <a class="btn btn-default btn-sm" href="#" data-toggle="dropdown"><i class="fa fa-cogs"></i> 工具 <i class="fa fa-angle-down"></i></a>
				<ul class="dropdown-menu pull-right" style="width:100px;">
					<li><a href="#"> <i class="fa fa-pencil"></i> 导出</a></li>
					<li><a href="#"> <i class="fa fa-trash-o"></i> 导入</a></li>
				</ul> -->
			</div>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="module" action="${ctx}/sys/module/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('模块编码')}：</label>
				<div class="input-inline width-160">
					<form:input path="moduleCode" htmlEscape="false" maxlength="500" class="form-control input-sm width-160"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('模块名称')}：</label>
					<form:input path="moduleName" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('状态')}：</label>
				<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
				    <form:option  value="">${fns:text('全部')}</form:option>
					<form:options items="${fns:getDictList('search_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>	
			<div class="form-group" > &nbsp; &nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
			</div>	
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	//初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'${fns:text("模块名称")}', name:'moduleName', index:'module_name', width:50, align:"center", frozen:true , formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/module/form?moduleCode='+row.id+'" class="btnList" data-title="${fns:text("编辑模块")}">'+val+'</a>';
			}},
			{header:'${fns:text("模块编码")}', name:'moduleCode', index:'module_code', width:50, align:"center"},
			{header:'${fns:text("描述")}', name:'description', sortable:false, width:190},
			{header:'${fns:text("版本")}', name:'currentVersion', index:'a.currentVersion', width:50, align:"center"},
			{header:'${fns:text("状态")}', name:'status', index:'status', width:60, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return row.isLoader ? getDictLabel(${fns:getDictListJson('status')}, val, '<font color=red>未知</font>', true) : '<font color=red>${fns:text("未安装")}</font>';
			}},
			{header:'${fns:text("操作")}', name:'actions', width:50, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:module:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/module/form?moduleCode='+row.id+'" class="btnList" title="${fns:text("编辑模块")}"><i class="fa fa-pencil"></i></a>&nbsp;');
					actions.push('<a href="${ctx}/sys/module/disable?moduleCode='+row.id+'" class="btnList" title="${fns:text("停用模块")}" data-confirm="${fns:text("确认要停用该模块吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/module/enable?moduleCode='+row.id+'" class="btnList" title="${fns:text("启用模块")}" data-confirm="${fns:text("确认要启用该模块吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	// 更新平台及项目的系统缓存
	$("#btnUpdateCache").click(function(){ 
		ajaxSubmit("${ctx}/sys/cache/clear", function(data){
			showMessage(data.message);
		});
	});
</script>