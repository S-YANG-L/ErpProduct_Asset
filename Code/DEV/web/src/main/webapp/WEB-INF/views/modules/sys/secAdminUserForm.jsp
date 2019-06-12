<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="jbox,ztree,grid,validate"/>
<sys:header title="${fns:text('二级管理员设置')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} tabbable autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-user-md"></i>${fns:text('二级管理员设置')}
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/secAdminUser/save?op=${param.op}" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<c:if test="${param.op=='add' || param.op=='authorize'}">
						<li>
							<a href="#portlet_tab3" data-toggle="tab">
							${fns:text('管理的')}${fns:text('数据授权')} </a>
						</li>
						<li class="${param.op == 'authorize' ? 'active' : ''}">
							<a href="#portlet_tab2"  data-toggle="tab">
							${fns:text('管理的')}${fns:text('角色授权')} </a>
						</li>
					</c:if>
					<c:if test="${param.op != 'authorize'}">
						<li class="${param.op != 'authorize' ? 'active' : ''}">
							<a href="#portlet_tab1" data-toggle="tab">
							${fns:text('账号信息')} </a> 
						</li>
					</c:if>
				</ul>
				<div class="tab-content">
					<div class="tab-pane ${param.op != 'authorize' ? 'active' : ''}" id="portlet_tab1">
						<div class="form-body">
							<h4 class="form-section">${fns:text('员工信息')}</h4>
							<div class="row">
								<div class="col-xs-6 ">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('所属员工')}：</label>
										<div class="col-sm-8">
											<sys:listselect id="employee" name="employee.empCode" value="${user.employee.empCode}" labelName="employee.empName" labelValue="${user.employee.empName}"
												title="${fns:text('员工')}" url="${ctx}/sys/employee/employeeSelect" multiple="false" disabled="${user.isNewRecord ? '' : 'disabled'}" cssClass="form-control required"/>
											<form:hidden path="refCode"/><form:hidden path="refName"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('员工编号')}：</label>
										<div class="col-sm-8">
											<input type="text" id="employeeEmpNo" value="${user.employee.empNo}" maxlength="30" class="form-control " disabled="disabled"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<c:if test="${fns:getModule('core_extend').isEnable}">
									<div class="col-xs-6">
										<div class="form-group">
											<label class="control-label col-sm-4">${fns:text('所属公司')}：</label>
											<div class="col-sm-8">
												<input type="text" id="employeeCompanyNameSimple" value="${user.employee.companyNameSimple}" maxlength="100" class="form-control " disabled="disabled"/>
											</div>
										</div>
									</div>
								</c:if>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('所属机构')}：</label>
										<div class="col-sm-8 col-sm-9">
											<input type="text" id="employeeOfficeName" value="${user.employee.officeName}" maxlength="100" class="form-control " disabled="disabled"/>
										</div>
									</div>
								</div>
							</div>
							<h4 class="form-section" style="margin-top:15px;margin-bottom:20px;">${fns:text('登录信息')}</h4>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="col-sm-4  control-label"><span class="required">*</span> ${fns:text('登录账号')}：</label>
										<div class="col-sm-8">
											<form:hidden path="isNewRecord"/>
											<form:hidden path="userCode"/>
											<form:input path="loginCode" htmlEscape="false" placeholder="${fns:text('请输入账号')}" maxlength="30" readonly="${!user.isNewRecord}" class="form-control abc required"/>
										</div>
									</div>
								</div>
								<!--/span-->
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('用户名称')}：</label>
										<div class="col-sm-8">
											<form:input path="userName" htmlEscape="false" placeholder="${fns:text('请输入名称')}" maxlength="100" class="form-control required"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('手机号码')}：</label>
										<div class="col-sm-8">
											<div class="input-group">
												<span class="input-group-addon"> <i class="fa fa-mobile-phone"></i> </span>
												<form:input path="mobile" htmlEscape="false" placeholder="${fns:text('请输入手机')}" maxlength="100" class="form-control mobile"/>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('电话号码')}：</label>
										<div class="col-sm-8">
											<div class="input-group">
												<span class="input-group-addon"> <i class="fa fa-phone"></i> </span>
												<form:input path="phone" htmlEscape="false" placeholder="${fns:text('请输入电话')}" maxlength="100" class="form-control "/>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('电子邮箱')}：</label>
										<div class="col-sm-8">
											<div class="input-group">
												<span class="input-group-addon"> <i class="fa fa-envelope"></i> </span>
												<form:input path="email" htmlEscape="false" placeholder="${fns:text('请输入邮箱')}" maxlength="100" class="form-control email"/>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('手机串号')}：</label>
										<div class="col-sm-8">
											<div class="input-group">
												<span class="input-group-addon"> <i class="fa fa-ticket"></i> </span>
												<form:input path="imei" htmlEscape="false" placeholder="${fns:text('请输入手机串号')}" maxlength="100" class="form-control "/>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane ${param.op=='authorize'?'active':''}" id="portlet_tab2"  >
						<table id="roleGrid"></table>
					    <form:hidden path="roleCodes"/>
					</div>
					<div class="tab-pane " id="portlet_tab3">
						<div class="row">
							<c:if test="${fns:getModule('core_extend').isEnable}">
								<div class="col-sm-6">
									<div class="portlet">
										<div class="portlet-title">
											<div class="caption"><i class="fa"></i>${fns:text('公司列表')}</div>
											<div class="actions" style="float:left;margin:1px 10px;">
												<a href="javascript:" onclick="companyTree.expandAll(true);">${fns:text('展开')}</a>&nbsp;/
												<a href="javascript:" onclick="companyTree.expandAll(false);">${fns:text('折叠')}</a>
											</div>
										</div>
										<div class="portlet-body">
											<div id="companyTree" class="ztree" style="margin-top:3px;float:left;"></div>
											<form:hidden path="companyCodes"/>
										</div>
									</div>
								</div>
							</c:if>
							<div class="col-sm-6">
								<div class="portlet">
									<div class="portlet-title">
										<div class="caption"><i class="fa"></i>${fns:text('机构列表')}</div>
										<div class="actions" style="float:left;margin:1px 10px;">
											<a href="javascript:" onclick="officeTree.expandAll(true);">${fns:text('展开')}</a> /
											<a href="javascript:" onclick="officeTree.expandAll(false);">${fns:text('折叠')}</a>
										</div>
									</div>
									<div class="portlet-body">
										<div id="officeTree" class="ztree" style="margin-top:3px;float:left;"></div>
										<form:hidden path="officeCodes"/>
									</div>
								</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:user:edit">
							<c:if test="${user.status eq '0'}">
								<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
							</c:if>
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
					</div>
				</div>
			</div>	
		</form:form>
	</div>				
</div>
<sys:footer extLibs="${extLibs}" />
<script>	
	var companyTree, officeTree, setting = {check:{enable:true,nocheckInherit:true},
			view:{selectedMulti:false}, data:{simpleData:{enable:true}}};
	jQuery(document).ready(function() {  
		roleListInit();//加载角色列表
		companyTreeInit();//加载公司数据
		officeTreeInit();//加载组织机构
		$("#inputForm").validate({
// 			rules: {
// 				userCode: {remote: "${ctx}/sys/secAdminUser/checkUserCode?oldUserCode=" + encodeURIComponent("${user.userCode}")},
// 			},
// 			messages: {
// 				userCode: {remote: "用户账号已存在"},
// 			},
// 			ignore: "",
			submitHandler: function(form){
				//获取选中角色
				$("#roleCodes").val($("#roleGrid").dataGrid('getSelectRows').join(','));
				//获取控制公司的数据
				var companyCodes = [], companyNodes = companyTree.getCheckedNodes(true);
				for(var i=0; i<companyNodes.length; i++) {
					companyCodes.push(companyNodes[i].id);
				}
				$("#companyCodes").val(companyCodes);
				//获取控制组织机构的数据
				var officeCodes = [], officeNodes = officeTree.getCheckedNodes(true);
				for(var i=0; i<officeNodes.length; i++) {
					officeCodes.push(officeNodes[i].id);
				}
				$("#officeCodes").val(officeCodes);
				//提交表单
				ajaxSubmitForm($(form), function(data){
					showMessage(data.message);
					if(data.result == Global.TRUE){
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}
				}, "json");
		    }
		});
	});
	
	//初始化角色列表
	function roleListInit() {
		$("#roleGrid").dataGrid({
			data: ${fns:toJson(allRoles)},
			datatype: "local",
			columnModel: [
				{header:'${fns:text("角色名称")}', name:'roleName', sortable:false, width:100},
				{header:'${fns:text("角色编码")}', name:'roleCode', sortable:false, width:100} 
			],
			showCheckbox: true,
			autoGridHeight: function(){
				return 'auto';
			},
			autoGridWidth: function(){
				return $('#inputForm .tab-content').width();
			}
		});
		var ids = "${user.roleCodes}".split(",");
		for(var i=0; i<ids.length; i++) {
			$("#roleGrid").dataGrid('setSelectRow', ids[i]);
		}
	}
	
	//初始化公司树
	function companyTreeInit() {
		var zNodes=[
				<c:forEach items="${allCompanys}" var="company">
					{id:"${company.id}", pId:"${company.pid}", name:"${company.companyNameSimple}"},
				</c:forEach>
	            ];
		// 初始化树结构
		companyTree = $.fn.zTree.init($("#companyTree"), setting, zNodes);
		// 不选择父节点
		companyTree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
		// 单击链接选中和取消复选框
		companyTree.setting.callback.beforeClick = function (id, node){
			companyTree.checkNode(node, !node.checked, true, true);
		};
		// 默认选择节点
		var ids = "${user.companyCodes}".split(",");
		for(var i=0; i<ids.length; i++) {
			var node = companyTree.getNodeByParam("id", ids[i]);
			try{companyTree.checkNode(node, true, false);}catch(e){}
		}
// 		// 默认展开全部节点
// 		companyTree.expandAll(true);
		// 默认展开一级节点
		var nodes = companyTree.getNodesByParam("level", 0);
		for(var i=0; i<nodes.length; i++) {
			companyTree.expandNode(nodes[i], true, false, false);
		}
	}
	
	//初始化组织机构树
	function officeTreeInit() {
		var zNodes=[
				<c:forEach items="${allOffices}" var="office">
					{id:"${office.id}", pId:"${office.pid}", name:"${office.officeName}"},
				</c:forEach>
	            ];
		// 初始化树结构
		officeTree = $.fn.zTree.init($("#officeTree"), setting, zNodes);
		// 不选择父节点
		officeTree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
		// 单击链接选中和取消复选框
		officeTree.setting.callback.beforeClick = function (id, node){
			officeTree.checkNode(node, !node.checked, true, true);
		};
		// 默认选择节点
		var ids = "${user.officeCodes}".split(",");
		for(var i=0; i<ids.length; i++) {
			var node = officeTree.getNodeByParam("id", ids[i]);
			try{officeTree.checkNode(node, true, false);}catch(e){}
		}
// 		// 默认展开全部节点
// 		officeTree.expandAll(true);
		// 默认展开一级节点
		var nodes = officeTree.getNodesByParam("level", 0);
		for(var i=0; i<nodes.length; i++) {
			officeTree.expandNode(nodes[i], true, false, false);
		}
	}
	
	// 人员选择初始默认
	function employeeBeforeForMap(selectData){
		var codes = $('#employeeCode').val();
		var names = $('#employeeName').val();
   		var companyNames = $('#employeeCompanyNameSimple').val();
   		var officeNames = $('#employeeOfficeName').val();
		var codesArr = new Array();
		var namesArr = new Array();
		var companyNamesArr = new Array();
		var officeNamesArr = new Array();
		if(codes != null && codes !="" && names != null && names != ""){
			codesArr = codes.split(",");
			namesArr = names.split(",");
			companyNamesArr = companyNames.split(",");
			officeNamesArr = officeNames.split(",");
			var jsons = {}, str = "";
			for(var i=0; i<codesArr.length; i++) {
				str = '{"empCode":"'+codesArr[i]+'","empName":"'+namesArr[i]+'","companyNameSimple":"'+companyNamesArr[i]+'","officeName":"'+officeNamesArr[i]+'"}';
				jsons[codesArr[i]] = JSON.parse(str);
			}
			if(codesArr.length > 0){
				selectData = JSON.stringify(jsons);
				selectData = selectData.replace(new RegExp("\"","g"),"\'");
			}
		}
   		return selectData;
	}
	
	// 人员选择回调
	function employeeCallbackForMap(dataMap, v, h, f){
		var codes = [], names = [], companyNames = [], empNos = [], officeNames = [];
		$.each(dataMap, function(key, value){
			codes.push(value.empCode);
			names.push(value.empName);
			empNos.push(value.empNo);
			companyNames.push(value.companyNameSimple);
			officeNames.push(value.officeName);
		});
   		$('#employeeCode, #refCode').val(codes.join(','));
   		$('#employeeName, #refName, #userName').val(names.join(','));
   		$('#employeeEmpNo, #loginCode').val(empNos.join(','));
   		$('#employeeCompanyNameSimple').val(companyNames.join(','));
   		$('#employeeOfficeName').val(officeNames.join(','));
	}
</script>
	