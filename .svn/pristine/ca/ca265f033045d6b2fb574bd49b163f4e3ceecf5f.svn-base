<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('二级管理员设置')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user-md"></i> ${fns:text('二级管理员设置')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="sys:secAdminUser:edit">
<%-- 				<a href="${ctx}/sys/secAdminUser/form?op=add&managerDataScope=true" class="btn btn-default btn-sm btnTool" title="${fns:text('新增二级管理员')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a> --%>
				<a href="javascript:" id="btnAdd" class="btn btn-default btn-sm" title="${fns:text('新增二级管理员')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
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
		<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/secAdminUser/listData?managerDataScope=true" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="refCode"/>
			<form:hidden path="all"/>
			<c:choose>
				<c:when test="${fns:getModule('core_extend').isEnable}">
					<div class="form-group">
						<label class="control-label">${fns:text('用户名称')}：</label>
							<form:input path="userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('登录账号')}：</label>
							<form:input path="loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('所属公司')}：</label>
						<div class="input-inline width-160">
							<sys:treeselect id="employeeCompany" name="employee.companyCode" value="" labelName="employee.company.companyName" labelValue="" 
								title="${fns:text('公司')}" url="/sys/company/treeData" controlSize="sm" allowClear="true"/>
						</div>
					</div>
					<div class="form-group"> &nbsp;&nbsp;
		<!-- 				<label class="control-label">状态：</label> -->
						<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
						    <form:option  value="">${fns:text('全部')}</form:option>
							<form:options items="${fns:getDictList('user_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<label class="control-label">${fns:text('员工姓名')}：</label>
							<form:input path="employee.empName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('员工编码')}：</label>
							<form:input path="employee.empNo" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('所属机构')}：</label>
						<div class="input-inline width-160">
							<sys:treeselect id="employeeOffice" name="employee.officeCode" value="" labelName="employee.office.officeName" labelValue="" 
								title="${fns:text('机构')}" url="/sys/office/treeData" controlSize="sm" allowClear="true"/>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-group">
						<label class="control-label">${fns:text('用户名称')}：</label>
							<form:input path="userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('登录账号')}：</label>
							<form:input path="loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('所属机构')}：</label>
						<div class="input-inline width-120">
							<sys:treeselect id="employeeOffice" name="employee.officeCode" value="" labelName="employee.office.officeName" labelValue="" 
								title="${fns:text('机构')}" url="/sys/office/treeData" controlSize="sm" allowClear="true"/>
						</div>
					</div>
					<div class="form-group"> &nbsp;&nbsp;
		<!-- 				<label class="control-label">状态：</label> -->
						<form:select path="status" class="form-control width-90 input-sm"  >
						    <form:option value="">${fns:text('全部')}</form:option>
							<form:options items="${fns:getDictList('user_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="form-group" > &nbsp;&nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="${fns:text('查询')}"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="${fns:text('重置')}"/>
			</div>	
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
	</div>
</div>
<div style="display:none;">
	<sys:listselect id="selectUser" name="" value=""  labelName="" labelValue=""
		title="用户" url="${ctx}/sys/user/userSelect" isAll="true" multiple="false"
		returnCodeAttr="userCode" returnNameAttr="userName" cssClass="form-control"/>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
// 初始化DataGrid对象
$('#dataGrid').dataGrid({
	
	// 当前页签编号
	tabPageId: '${param.tabPageId}',
	
	// 设置数据表格列
	columnModel: [
		{header:'${fns:text("用户名称")}', name:'userName', index:'user_name', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
			return '<a href="${ctx}/sys/secAdminUser/form?userCode='+row.id+'&op=authorize&managerDataScope=true" class="btnList" data-title="${fns:text("编辑二级管理员")}">'+val+'</a>';
		}},
 			{header:'${fns:text("登录账号")}', name:'loginCode', index:'login_code', width:100, align:"center"},
		//<c:if test="${fns:getModule('core_extend').isEnable}">
		{header:'${fns:text("所属公司")}', name:'refObj.companyNameSimple', index:'c.company_name_simple', width:160, align:"center"},//</c:if>
		{header:'${fns:text("组织机构")}', name:'refObj.officeName', index:'d.office_name', width:160, align:"center"},
		//<c:if test="${fns:getModule('core_extend').isEnable}">
		{header:'${fns:text("员工姓名")}', name:'refObj.empName', index:'emp_name', width:100},
		{header:'${fns:text("员工编码")}', name:'refObj.empNo', index:'emp_no', width:100},//</c:if>
		{header:'${fns:text("手机号码")}', name:'mobile', index:'mobile', width:100, align:"center", sortable:false},
		{header:'${fns:text("电话号码")}', name:'phone', index:'phone', width:100, align:"center", sortable:false},
		{header:'${fns:text("状态")}', name:'status', index:'a.status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
			return getDictLabel(${fns:getDictListJson('user_status')}, val, '未知', true);
		}},
		{header:'${fns:text("操作")}', name:'actions', width:150, fixed:true, fixed:true, sortable:false, formatter: function(val, obj, row, act){
			var actions = [];
			//<shiro:hasPermission name="sys:secAdminUser:authorize">
			if (row.status == Global.STATUS_NORMAL){
				actions.push('<a href="${ctx}/sys/secAdminUser/form?userCode='+row.id+'&op=authorize&managerDataScope=true" class="btnList" title="${fns:text("二级管理员授权")}"><i class="fa fa-pencil"></i></a>&nbsp;');
			}//</shiro:hasPermission><shiro:hasPermission name="sys:secAdminUser:edit">
// 			actions.push('<a href="${ctx}/sys/secAdminUser/form?userCode='+row.id+'&op=edit&managerDataScope=true" class="btnList" title="${fns:text("编辑二级管理员")}"><i class="fa fa-pencil"></i></a>&nbsp;');
			actions.push('<a href="${ctx}/sys/secAdminUser/delete?userCode='+row.id+'" class="btnList" title="${fns:text("取消二级管理员身份")}" data-confirm="${fns:text("确认要取消二级管理员身份吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
// 			//</shiro:hasPermission><shiro:hasPermission name="sys:secAdminUser:disable">
// 			if (row.status == Global.STATUS_NORMAL){
// 				actions.push('<a href="${ctx}/sys/secAdminUser/disable?userCode='+row.id+'" class="btnList" title="${fns:text("停用二级管理员")}" data-confirm="${fns:text("确认要停用该二级管理员吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
// 			}//</shiro:hasPermission><shiro:hasPermission name="sys:secAdminUser:activate">
// 			if (row.status == Global.STATUS_DISABLE){
// 				actions.push('<a href="${ctx}/sys/secAdminUser/activate?userCode='+row.id+'" class="btnList" title="${fns:text("启用二级管理员")}" data-confirm="${fns:text("确认要启用该二级管理员吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
// 			}//</shiro:hasPermission><shiro:hasPermission name="sys:secAdminUser:unfreeze">
// 			if (row.status == Global.STATUS_FREEZE){
// 				actions.push('<a href="${ctx}/sys/secAdminUser/unfreeze?userCode='+row.id+'" class="btnList" title="${fns:text("解冻二级管理员")}" data-confirm="${fns:text("确认要解冻该二级管理员吗")}？"><i class="fa fa-unlock"></i></a>&nbsp;');
// 			}//</shiro:hasPermission><shiro:hasPermission name="sys:secAdminUser:resetpwd">
// 			if (row.status == Global.STATUS_NORMAL){
// 				actions.push('<a href="${ctx}/sys/secAdminUser/resetpwd?userCode='+row.id+'" class="btnList" title="${fns:text("密码重置")}" data-confirm="${fns:text("确认要将该二级管理员密码重置吗")}？"><i class="fa fa-retweet"></i></a>&nbsp;');
// 			}
			//</shiro:hasPermission>
			return actions.join('');
		}}
	],
	ajaxSuccess: function(data){ // 加载成功后执行方法
		
	}
});

$('#btnAdd').click(function(){
	$('#selectUserButton').click();
});

function selectUserListselectCallBack(v, h, f){
	if ($('#selectUserCode').val() != ''){
		addTabPage(null, '二级管理员授权', '${ctx}/sys/secAdminUser/form?userCode='
				+$('#selectUserCode').val()+'&op=authorize&managerDataScope=true');
	}
}

</script>