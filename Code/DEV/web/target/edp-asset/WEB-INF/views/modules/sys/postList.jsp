<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('岗位管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> ${fns:text('岗位管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="sys:post:edit">
				<a href="${ctx}/sys/post/form" class="btn btn-default btn-sm btnTool" title="${fns:text('新增岗位')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
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
		<form:form id="searchForm" modelAttribute="post" action="${ctx}/sys/post/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">${fns:text('岗位名称')}：</label>
				<div class="input-inline width-160" >
					<form:input path="postName" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">${fns:text('状态')}：</label>
				<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
				    <form:option  value="">${fns:text('全部')}</form:option>
					<form:options items="${fns:getDictList('search_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>	
			<div class="form-group" style="margin-left:10px;"> 
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
	
	// 初始化DataGrid对象
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'${fns:text("岗位名称")}', name:'postName', index:'post_name', width:100, align:"center", formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/post/form?postCode='+row.id+'" class="btnList" data-title="${fns:text("编辑岗位")}">'+val+'</a>';
			}},
			//<c:if test="${post.currentUser.admin}">
			{header:'${fns:text("岗位编码")}', name:'postCode', index:'post_code', width:100, align:"center"},//</c:if>
			{header:'${fns:text("备注")}', name:'remarks', index:'remarks', width:260},
			{header:'${fns:text("状态")}', name:'status', index:'status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('status')}, val, '${fns:text("未知")}', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:post:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/post/form?postCode='+row.id+'" class="btnList" title="${fns:text("编辑岗位")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:post:disable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/post/disable?postCode='+row.id+'" class="btnList" title="${fns:text("停用岗位")}" data-confirm="${fns:text("确认要停用该岗位吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:post:enable">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/post/enable?postCode='+row.id+'" class="btnList" title="${fns:text("启用岗位")}" data-confirm="${fns:text("确认要启用该岗位吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:employee:view">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/employee/list?postCode='+row.id+'" class="btnList" title="查找'+row.postName+'岗位的员工"><i class="fa fa-user"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
	
</script>