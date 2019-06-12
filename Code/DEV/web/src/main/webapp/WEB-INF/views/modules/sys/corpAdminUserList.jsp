<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="集团管理员设置" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user-md"></i> 集团管理员设置</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:corpAdminUser:edit">
				<a href="${ctx}/sys/corpAdminUser/form?op=add" class="btn btn-default btn-sm btnTool" title="新增集团管理员"><i class="fa fa-plus"></i> 新增</a>
				<a href="javascript:" id="btnAdd" class="btn btn-default btn-sm" title="添加集团管理员"><i class="fa fa-plus"></i> ${fns:text('添加')}</a>
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
		<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/corpAdminUser/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">用户昵称：</label>
					<form:input path="userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
			</div>
			<div class="form-group">
				<label class="control-label">登录账号：</label>
					<form:input path="loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
			</div>
			<div class="form-group"> &nbsp;&nbsp;
<!-- 				<label class="control-label">状态：</label> -->
				<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
				    <form:option  value="">全部</form:option>
					<form:options items="${fns:getDictList('user_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="form-group" > &nbsp;&nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
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
 			//<c:if test="${fns:getConfig('user.useCorpModel') eq 'true'}">
   		{header:'集团名称', name:'corpName_', index:'a.corp_name', width:100, align:"center"},
 			{header:'集团代码', name:'corpCode_', index:'a.corp_code', width:80, align:"center"},
 			//</c:if>
		{header:'用户名称', name:'userName', index:'user_name', width:80, align:"center", frozen:true , formatter: function(val, obj, row, act){
			return '<a href="${ctx}/sys/corpAdminUser/form?userCode='+row.id+'&op=edit" class="btnList" data-title="编辑用户">'+val+'</a>';
		}},
		{header:'登录账号', name:'loginCode', index:'login_code', width:80, align:"center"},
		{header:'手机号码', name:'mobile', index:'a.mobile', width:100, align:"center", sortable:false},
		{header:'电话号码', name:'phone', index:'a.phone', width:100, align:"center", sortable:false},
		/* {header:'用户类型', name:'userType', width:50, align:'center', formatter: function(val, obj, row, act){
			return getDictLabel(${fns:getDictListJson('user_type')}, val, '员工', true);
		}}, */
		{header:'状态', name:'status', index:'a.status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
			return getDictLabel(${fns:getDictListJson('user_status')}, val, '未知', true);
		}},
		{header:'操作', name:'actions', width:120, fixed:true, fixed:true, sortable:false, formatter: function(val, obj, row, act){
			var actions = [];//<shiro:hasPermission name="sys:corpAdminUser:edit">
			actions.push('<a href="${ctx}/sys/corpAdminUser/form?userCode='+row.id+'&op=edit" class="btnList" title="编辑集团管理员"><i class="fa fa-pencil"></i></a>&nbsp;');
			if (row.refCode == ''){
				actions.push('<a href="${ctx}/sys/corpAdminUser/delete?userCode='+row.id+'" class="btnList" title="删除集团管理员" data-confirm="确认要删除集团管理员吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}else{
				actions.push('<a href="${ctx}/sys/corpAdminUser/delete?userCode='+row.id+'" class="btnList" title="取消集团管理员身份" data-confirm="确认要取消集团管理员身份吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
			}
			//</shiro:hasPermission><shiro:hasPermission name="sys:user:disable">
			if (row.status == Global.STATUS_NORMAL){
				actions.push('<a href="${ctx}/sys/user/disable?userCode='+row.id+'" class="btnList" title="停用用户" data-confirm="确认要停用该用户吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
			}//</shiro:hasPermission><shiro:hasPermission name="sys:user:activate">
			if (row.status == Global.STATUS_DISABLE){
				actions.push('<a href="${ctx}/sys/user/activate?userCode='+row.id+'" class="btnList" title="启用用户" data-confirm="确认要启用该用户吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
			}//</shiro:hasPermission><shiro:hasPermission name="sys:user:unfreeze">
			if (row.status == Global.STATUS_FREEZE){
				actions.push('<a href="${ctx}/sys/user/unfreeze?userCode='+row.id+'" class="btnList" title="解冻用户" data-confirm="确认要解冻该用户吗？"><i class="fa fa-unlock"></i></a>&nbsp;');
			}//</shiro:hasPermission><shiro:hasPermission name="sys:user:resetpwd">
			if (row.status == Global.STATUS_NORMAL){
				actions.push('<a href="${ctx}/sys/user/resetpwd?userCode='+row.id+'" class="btnList" title="密码重置" data-confirm="确认要将该用户密码重置吗？"><i class="fa fa-retweet"></i></a>&nbsp;');
			}//</shiro:hasPermission>
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
		addTabPage(null, '添加系统管理员', '${ctx}/sys/corpAdminUser/form?userCode='
				+$('#selectUserCode').val()+'&op=edit');
	}
}
</script>