<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="用户管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> ${not empty param.title ? param.title : fns:text('用户管理')}</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="${fns:text('查询')}"><i class="fa fa-search"></i> ${fns:text("查询")}</a>
			<shiro:hasPermission name="sys:user:edit">
				<a href="${ctx}/sys/empUser/formV2?op=add&managerDataScope=true" class="btn btn-default btn-sm btnTool" title="${fns:text('新增用户')}"><i class="fa fa-plus"></i> ${fns:text("新增")}</a>
			</shiro:hasPermission>
			<div class="btn-group">
				 <a class="btn btn-default btn-sm" href="#" data-toggle="dropdown"><i class="fa fa-cogs"></i> ${fns:text("工具")} <i class="fa fa-angle-down"></i></a>
				<ul class="dropdown-menu pull-right" style="width:100px;">
					<!-- <li><a href="#"> <i class="fa fa-pencil"></i> 导出</a></li> -->
					<li><a href="#" id="btnImport"> <i class="fa fa-pencil-square-o"></i> ${fns:text("导入")}</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="importBox" class="hide">
        <form:form id="importDataForm" action="${ctx}/sys/empUser/import" method="post" enctype="multipart/form-data"
                class="form-search" style="padding-left:20px;text-align:center;" onsubmit="" ><br/>
           <input id="uploadFile" name="file" type="file" style="width:330px;margin-left:100px;" /><br/><br/>
           <input id="btmImportSubmit" class="btn btn-primary" onclick="upload();" type="submit" value="${fns:text('导入数据')}" style="margin-left:43px;" />&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="${ctxStatic}/modules/sys/user/用户导入模板.xlsx" style="margin-right:0px;" >${fns:text("下载模板")}</a>
        </form:form>
   </div>
	<sys:message content="${message}"></sys:message>
	<div class="portlet-body list">
		<!-- <div class="row" style="margin:0 -5px 0 0">
			<div class="col-xs-2" id="left" style="padding:0 5px;overflow:auto;">
				<div id="ztree" class="ztree"></div>
			</div>
			<div class="col-xs-10" id="right" style="padding:0 5px"> -->
		<form:form id="searchForm" modelAttribute="employee" action="${ctx}/sys/empUser/listData?managerDataScope=true&isAll=${param.isAll}" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<form:hidden path="loginInfo.roleCode"/>
			<c:choose>
				<c:when test="${fns:getModule('core_extend').isEnable}">
					<div class="form-group">
						<label class="control-label">${fns:text('用户名称')}：</label>
							<form:input path="loginInfo.userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('所属公司')}：</label>
						<div class="input-inline width-160">
							<sys:treeselect id="company" name="company.companyCode" value="${employee.company.companyCode}" labelName="company.companyName" labelValue="${employee.company.companyName}"
								title="${fns:text('公司')}" url="/sys/company/treeData" controlSize="sm" allowClear="true" notAllowSelectParent="false"/>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('岗位')}：</label>
						<form:select path="postCode" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
						    <form:option  value="">${fns:text('全部')}</form:option>
							<form:options items="${allPosts}" itemLabel="postName" itemValue="postCode" htmlEscape="false"/>
						</form:select>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<label class="control-label">${fns:text('登录账号')}：</label>
							<form:input path="loginInfo.loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('所属机构')}：</label>
						<div class="input-inline width-160">
							<sys:treeselect id="office" name="office.officeCode" value="${employee.office.officeCode}" labelName="office.officeName" labelValue="${employee.office.officeName}" 
								title="${fns:text('机构')}" url="/sys/office/treeData" isAll="${param.isAll}" controlSize="sm" allowClear="true"/>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('状态')}：</label>
						<form:select path="status" class="form-control width-90 input-sm" onchange="$(this).parents('form').submit()">
						    <form:option  value="">${fns:text('全部')}</form:option>
							<form:options items="${fns:getDictList('user_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-group">
						<label class="control-label">${fns:text('用户名称')}：</label>
							<form:input path="loginInfo.userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('登录账号')}：</label>
							<form:input path="loginInfo.loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">${fns:text('所属机构')}：</label>
						<div class="input-inline width-120">
							<sys:treeselect id="office" name="office.officeCode" value="${employee.office.officeCode}" labelName="office.officeName" labelValue="${employee.office.officeName}" 
								title="${fns:text('机构')}" url="/sys/office/treeData" isAll="${param.isAll}" controlSize="sm" allowClear="true"/>
						</div>
					</div>
					<div class="form-group"> &nbsp;
<!-- 						<label class="control-label">用户状态：</label> -->
						<form:select path="status" class="form-control width-90 input-sm"  >
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
			{header:'${fns:text("用户名称")}', name:'loginInfo.userName', index:'u.user_name', width:100, align:"center", frozen:true , formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sys/empUser/formV2?userCode='+row.loginInfo.userCode+'&managerDataScope=true" class="btnList" data-title="<shiro:hasPermission name="sys:user:edit">编辑</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission>用户">'+val+'</a>';
			}},
			{header:'${fns:text("登录账号")}', name:'loginInfo.loginCode', index:'u.login_code', width:100, align:"center"},
			//<c:if test="${fns:getModule('core_extend').isEnable}">
			{header:'${fns:text("所属公司")}', name:'company.companyNameSimple', index:'c.company_name_simple', width:160, align:"center"},//</c:if>
			{header:'${fns:text("组织机构")}', name:'office.officeName', index:'o.office_name', width:160, align:"center"},
			{header:'${fns:text("手机号码")}', name:'loginInfo.mobile', index:'u.mobile', width:100, align:"center", sortable:false/* ,
				cellattr: function(rowId, tv, rawObject, cm, rdata) {
			         return ' colspan=2' 
			    } */},
			{header:'${fns:text("电话号码")}', name:'loginInfo.phone', index:'u.phone', width:100, align:"center", sortable:false/* ,
		    	cellattr: function(rowId, tv, rawObject, cm, rdata) {
		            return ' style="display:none;"'
		        } */},
			{header:'${fns:text("电子邮箱")}', name:'email', index:'a.email', width:100, sortable:false},
			{header:'${fns:text("状态")}', name:'status', index:'a.status', width:50, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('user_status')}, val, '${fns:text("未知")}', true);
			}},
			{header:'${fns:text("操作")}', name:'actions', width:180, fixed:true, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="sys:user:edit">
				actions.push('<a href="${ctx}/sys/empUser/formV2?userCode='+row.loginInfo.userCode+'&managerDataScope=true" class="btnList" title="${fns:text("编辑用户")}"><i class="fa fa-pencil"></i></a>&nbsp;');
				//</shiro:hasPermission><shiro:hasPermission name="sys:user:delete">
				actions.push('<a href="${ctx}/sys/empUser/delete?userCode='+row.loginInfo.userCode+'" class="btnList" title="${fns:text("删除员工")}" data-confirm="${fns:text("确认要删除该员工吗")}？"><i class="fa fa-trash-o"></i></a>&nbsp;');
				//</shiro:hasPermission><shiro:hasPermission name="sys:user:disable">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/empUser/disable?userCode='+row.loginInfo.userCode+'" class="btnList" title="${fns:text("停用用户")}" data-confirm="${fns:text("确认要停用该用户吗")}？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:activate">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/sys/empUser/activate?userCode='+row.loginInfo.userCode+'" class="btnList" title="${fns:text("启用用户")}" data-confirm="${fns:text("确认要启用该用户吗")}？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:unfreeze">
				if (row.status == Global.STATUS_FREEZE){
					actions.push('<a href="${ctx}/sys/user/unfreeze?userCode='+row.loginInfo.userCode+'" class="btnList" title="${fns:text("解冻用户")}" data-confirm="${fns:text("确认要解冻该用户吗")}？"><i class="fa fa-unlock"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:resetpwd">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/user/resetpwd?userCode='+row.loginInfo.userCode+'" class="btnList" title="${fns:text("密码重置")}" data-confirm="${fns:text("确认要将该用户密码重置吗")}？"><i class="fa fa-retweet"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:authorize">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/empUser/formV2?userCode='+row.loginInfo.userCode+'&op=authorize&managerDataScope=true" class="btnList" title="${fns:text("用户授权")}"><i class="fa fa-check-square-o"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="sys:user:authorize">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/sys/empUser/formUserMenu?userCode='+row.loginInfo.userCode+'" class="btnList" title="${fns:text("用户菜单授权")}"><i class="fa fa-bars"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
// 			// 合并单元格（参数：需要合并的列名，多个用逗号分隔，如：'company.companyNameSimple,office.officeName'）
// 			$('#dataGrid').dataGrid('mergeCell', 'company.companyNameSimple,office.officeName');
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
<!-- 导入按钮js -->
<script type="text/javascript">

    $("#btnImport").click(function(){
         $.jBox($("#importBox").html(),{title:"导入数据",buttons:{"关闭":true},bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
    });
    
  //导入loading
	function upload(){
		$.jBox.tip("正在检查数据合法性并导入数据到数据库，请稍后...", 'loading');
	}
</script>