<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="${fns:text('用户管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> ${fns:text('用户管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text('查询')}</a>
			<shiro:hasPermission name="sys:user:edit">
				<a href="${ctx}/sys/user/form?op=add" class="btn btn-default btn-sm btnTool" title="${fns:text('新增用户')}"><i class="fa fa-plus"></i> ${fns:text('新增')}</a>
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
		<!-- <div class="row" style="margin:0 -5px 0 0">
			<div class="col-xs-2" id="left" style="padding:0 5px;overflow:auto;">
				<div id="ztree" class="ztree"></div>
			</div>
			<div class="col-xs-10" id="right" style="padding:0 5px"> -->
		<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="refCode"/>
			<form:hidden path="roleCode"/>
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
								title="机构" url="/sys/office/treeData" controlSize="sm" allowClear="true"/>
						</div>
					</div>
					<div class="form-group"> &nbsp;&nbsp;
		<!-- 				<label class="control-label">状态：</label> -->
						<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
						    <form:option  value="">${fns:text('全部')}</form:option>
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
			<!-- </div>
		</div> -->
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
			{header:'${fns:text("用户名称")}', name:'userName', index:'user_name', width:100, align:"center", frozen:true, formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/user/form?userCode='+row.id+'&op=edit" class="btnList" data-title="编辑用户">'+val+'</a>';
			}},
			{header:'${fns:text("登录账号")}', name:'loginCode', index:'login_code', width:100, align:"center"},
			//<c:if test="${fns:getModule('core_extend').isEnable}">
			{header:'${fns:text("所属公司")}', name:'refObj.companyNameSimple', index:'c.company_name_simple', width:160, align:"center"},//</c:if>
			{header:'${fns:text("组织机构")}', name:'refObj.officeName', index:'d.office_name', width:160, align:"center"},
			//<c:if test="${fns:getModule('core_extend').isEnable}">
			{header:'${fns:text("员工姓名")}', name:'refObj.empName', index:'emp_name', width:100},
			{header:'${fns:text("员工编码")}', name:'refObj.empNo', index:'emp_no', width:100},//</c:if>
			{header:'${fns:text("手机号码")}', name:'mobile', index:'a.mobile', width:100, align:"center", sortable:false},
			{header:'${fns:text("电话号码")}', name:'phone', index:'a.phone', width:100, align:"center", sortable:false},
			{header:'${fns:text("状态")}', name:'status', index:'a.status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('user_status')}, val, '未知', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:130, fixed:true, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:user:edit">
				actions.push('<a href="${ctx}/sys/user/form?userCode='+row.id+'&op=edit" class="btnList" title="${fns:text("编辑用户")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				//</shiro:hasPermission><shiro:hasPermission name="sys:user:disable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/disable?userCode='+row.id+'" class="btnList" title="${fns:text("停用用户")}" data-confirm="${fns:text("确认要停用该用户吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:activate">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/user/activate?userCode='+row.id+'" class="btnList" title="${fns:text("启用用户")}" data-confirm="${fns:text("确认要启用该用户吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:unfreeze">
				if (row.status == Global.STATUS_FREEZE){
					actions.push('<a href="${ctx}/sys/user/unfreeze?userCode='+row.id+'" class="btnList" title="${fns:text("解冻用户")}" data-confirm="${fns:text("确认要解冻该用户吗")}？"><i class="fa fa-unlock"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:resetpwd">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/resetpwd?userCode='+row.id+'" class="btnList" title="${fns:text("密码重置")}" data-confirm="${fns:text("确认要将该用户密码重置吗")}？"><i class="fa fa-retweet"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:authorize">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/form?userCode='+row.id+'&op=authorize" class="btnList" title="${fns:text("用户授权")}"><i class="fa fa-check-square-o"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});

	/* // 加载机构树结构
	$.getJSON("${ctx}/sys/office/treeData",function(data){
		$.fn.zTree.init($("#ztree"), {data:{simpleData:{
			enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
				$('#employeeOfficeCode').val(treeNode.id);
				$('#employeeOfficeName').val(treeNode.name);
				$('#searchForm').submit();
			}}
		}, data).expandAll(true);
	});
	$(window).resize(function(){
		$("#left").height($('.portlet-body').height());
	}).resize(); */
	
</script>