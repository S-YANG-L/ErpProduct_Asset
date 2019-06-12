<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('参数管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption" title="${fns:text('读取顺序：JVM系统参数')} -> app.properties -> global.properties -> ${fns:text('本窗口中的参数，读取参数方法')}：Global.getConfig('${fns:text('参数键名')}')">
			<i class="fa fa-qrcode"></i>${fns:text('参数管理')} <i class="fa icon-question" style="float:none;font-size:14px;"></i></div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="sys:config:edit">
				<a href="${ctx}/sys/config/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增参数')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
				<a href="#" class="btn btn-default btn-sm" id="btnUpdateCache" title="${fns:text('清理全部缓存，包括属性文件的配置')}"><i class="fa fa-refresh"></i> ${fns:text('清理缓存')}</a>
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
		<form:form id="searchForm" modelAttribute="config" action="${ctx}/sys/config/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('参数名称')}：</label>
					<form:input path="name" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('参数键名')}：</label>
				<div class="input-inline width-160" >
					<form:input path="keys" htmlEscape="false" maxlength="100" class="form-control input-sm width-160"/>
				</div>
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
			{header:'${fns:text("参数名称")}', name:'name', index:'name', width:100, frozen:true , formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/config/form?id='+row.id+'" class="btnList" data-title="${fns:text("编辑参数")}">'+val+'</a>';
			}},
			{header:'${fns:text("参数键名")}', name:'keys', index:'keys', width:100},
			{header:'${fns:text("参数键值")}', name:'value', sortable:false, width:160, classes:"nowrap"},
			{header:'${fns:text("操作")}', name:'actions', width:50, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:config:edit">
				actions.push('<a href="${ctx}/sys/config/form?id='+row.id+'" class="btnList" title="${fns:text("编辑参数")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				actions.push('<a href="${ctx}/sys/config/delete?id='+row.id+'" class="btnList" title="${fns:text("删除参数")}" data-confirm="${fns:text("确认要删除该参数吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	// 更新平台中的全部缓存，包含属性配置文件。
	$("#btnUpdateCache").click(function(){ 
		ajaxSubmit("${ctx}/sys/cache/clearAll", function(data){
			showMessage(data.message);
		});
	});
</script>