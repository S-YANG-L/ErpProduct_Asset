<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="jbox,ztree,grid,validate"/>
<sys:header title="${fns:text('用户管理')}- ${employee.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('用户')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} tabbable autoHeight">
	<div class="portlet-title">
		<div class="caption">
		<shiro:hasPermission name="sys:user:edit">
			<i class="fa fa-user"></i>${employee.isNewRecord ? fns:text('新增') : fns:text('编辑')}&nbsp;${fns:text('用户')}
		</shiro:hasPermission>
		<shiro:lacksPermission name="sys:user:edit">
			<i class="fa fa-user"></i>${employee.isNewRecord ? fns:text('新增') : fns:text('查看')}&nbsp;${fns:text('用户')}
		</shiro:lacksPermission>
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="employee" action="${ctx}/sys/empUser/save?op=${param.op}" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<c:if test="${param.op == 'add' || param.op == 'authorize'}">
						<li>
							<a href="#portlet_tab3" data-toggle="tab">${fns:text('数据授权')} </a>
						</li>
						<li class="${param.op == 'authorize' ? 'active' : ''}">
							<a href="#portlet_tab2"  data-toggle="tab">${fns:text('角色授权')} </a>
						</li>
					</c:if>
					<c:if test="${param.op != 'authorize'}">
						<li class="${param.op != 'authorize' ? 'active' : ''}">
							<a href="#portlet_tab1" data-toggle="tab">${fns:text('账号信息')} </a>
						</li>
					</c:if>
				</ul>
				<div class="tab-content">
					<div class="tab-pane ${param.op != 'authorize' ? 'active' : ''}" id="portlet_tab1">
						<div class="form-body">
							<h4 class="form-section">${fns:text('基本信息')}</h4>
							<div class="row">
								<c:if test="${fns:getModule('core_extend').isEnable}">
									<div class="col-xs-6">
										<div class="form-group">
											<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属公司')}：</label>
											<div class="col-sm-8">
												<sys:treeselect id="company" name="company.id" value="${employee.company.id}" labelName="company.companyNameSimple" labelValue="${employee.company.companyNameSimple}" 
													title="${fns:text('公司')}" url="/sys/company/treeData" cssClass="required" allowClear="true" notAllowSelectParent="false"/>
											</div>
										</div>
									</div>
								</c:if>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属机构')}：</label>
										<div class="col-sm-8">
											<sys:treeselect id="office" name="office.id" value="${employee.office.id}" labelName="office.officeName" labelValue="${employee.office.officeName}" 
												title="${fns:text('机构')}" url="/sys/office/treeData" cssClass="required"  allowClear="true"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('登录账号')}：</label>
										<div class="col-sm-8">
											<form:hidden path="isNewRecord"/>
											<input type="hidden" name="userCode" value="${employee.loginInfo.userCode}">
											<form:input path="loginInfo.loginCode" htmlEscape="false" placeholder="${fns:text('请输入登录账号')}" maxlength="30" readonly="${!employee.isNewRecord}" class="form-control abc required"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('用户名称')}：</label>
										<div class="col-sm-8">
											<form:input path="loginInfo.userName" htmlEscape="false" placeholder="${fns:text('请输入用户名称')}" maxlength="100" class="form-control required"/>
										</div>
									</div>
								</div>
							</div>
							<c:if test="${fns:getModule('core_extend').isEnable}">
								<div class="row">
									<div class="col-xs-6">
										<div class="form-group">
											<label class="control-label col-sm-4">${fns:text('所在岗位')}：</label>
											<div class="col-sm-8">
												<form:select path="postIdList" multiple="true" class="form-control input-sm"  >
													<form:options items="${allPosts}" itemLabel="postName" itemValue="postCode" htmlEscape="false"/>
												</form:select>
											</div>
										</div>
									</div>
								</div>
							</c:if>
							<h4 class="form-section">${fns:text('详细信息')}</h4>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('真实姓名')}：</label>
										<div class="col-sm-8">
											<form:input path="empName" htmlEscape="false" placeholder="${fns:text('请输入姓名')}" maxlength="100" class="form-control "/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('英文名')}：</label>
										<div class="col-sm-8">
											<form:input path="empNameEn" htmlEscape="false" placeholder="${fns:text('请输入英文名')}" maxlength="100" class="form-control "/>
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
												<form:input path="officePhone" htmlEscape="false" placeholder="${fns:text('请输入电话号码')}" maxlength="100" class="form-control "/>
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
												<form:input path="email" htmlEscape="false" placeholder="${fns:text('请输入电子邮箱')}" maxlength="100" class="form-control email"/>
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
												<form:input path="loginInfo.imei" htmlEscape="false" placeholder="${fns:text('请输入手机串号')}" maxlength="100" class="form-control "/>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4">${fns:text('用户排序（升序）')}：</label>
										<div class="col-sm-8">
											<form:input path="loginInfo.userSort" class="form-control "/>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane ${param.op == 'authorize' ? 'active' : ''}" id="portlet_tab2">
						<table id="roleGrid"></table>
					    <form:hidden id="roleCodes" path="loginInfo.roleCodes"/>
					</div>
					<div class="tab-pane " id="portlet_tab3">
						<div class="extend_msg" id="udsTrees"></div>
						<script type="text/template" id="udsTpl">
							<div class="_col-sm-8" style="float:left;padding:15px;">
								<div class="portlet">
									<div class="portlet-title">
										<div class="caption"><input type="checkbox" id="checkall_{{ud.ctrlType}}" 
											value="udsTree_{{ud.ctrlType}}" class="checkall"/><label 
											for="checkall_{{ud.ctrlType}}">{{ud.ctrlName}}</label></div>
										<div class="actions" style="float:left;margin:1px 10px;">
											<a href="javascript:" onclick="udsTree['{{ud.ctrlType}}'].expandAll(true);">展开</a>&nbsp;/
											<a href="javascript:" onclick="udsTree['{{ud.ctrlType}}'].expandAll(false);">折叠</a>
										</div>
									</div>
									<div class="portlet-body">
										<div id="udsTree_{{ud.ctrlType}}" class="ztree" style="margin-top: 3px; margin-bottom: 30px; float: left;"></div>
									</div>
								</div>
							</div>
						</script>
					    <input type="hidden" id="isDataScopeAll" name="isDataScopeAll" value="${isDataScopeAll}" />
					    <input type="hidden" id="userDataScopeListJson" name="loginInfo.userDataScopeListJson" />
						<div class="row"></div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:user:edit">
							<c:if test="${employee.status eq '0'}">
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
	$("#inputForm").validate({
		submitHandler: function(form){
			//获取选中角色
			$("#roleCodes").val($("#roleGrid").dataGrid('getSelectRows').join(','));
			//获取数据权限数据
			var udsData = [];
			$.each(udsTrees, function(key, udsTree){
				var treeNodes = udsTree.getCheckedNodes(true);
				for(var i=0; i<treeNodes.length; i++) {
					udsData.push({
						ctrlType: key, ctrlData: treeNodes[i].id,
					});
				}
			});
			$("#userDataScopeListJson").val(JSON.stringify(udsData));
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

	// 加载角色列表
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
	var rd = $("#roleGrid");<c:forEach items="${userRoleList}" var="role">
	rd.dataGrid('setSelectRow', '${role.roleCode}');</c:forEach>
	
	// 加载数据权限树结构
	var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
		data:{simpleData:{enable:true}},callback:{
			beforeClick: function (treeId, treeNode, clickFlag) {
				var tree = $.fn.zTree.getZTreeObj(treeId);
				tree.checkNode(treeNode, !treeNode.checked, true, true);
				return false;
			},
			onCheck: function (event, treeId, treeNode){
				var tid = treeNode.tId;
				if(!treeNode.checked){
					$(".checkall[value="+treeId+"]").each(function(){
						if(this.checked){
						    $.uniform.update($(this).removeAttr("checked"));
						}
						return false;
					}); 
				}
			}
		}
	},
	udsTrees = {},
	uds = ${fns:getConfig('user.dataScope')};
	for (var i=0; i<uds.length; i++){
		var ud = uds[i];
		$('#udsTrees').append(template('udsTpl', {ud: ud}));
           $('#checkall_'+ud.ctrlType).uniform();
		$.ajax({
			type: 'POST',
			url: "${ctx}"+ud.ctrlDataUrl,
			data: {/* isAll: true,  */managerDataScope: true},
			dataType: 'json',
			async: false,
			error: function(data){
				showErrorMessage(data.responseText);
			},
			success: function(data, status, xhr){
				// 初始化树结构
				var tree = $.fn.zTree.init($("#udsTree_"+ud.ctrlType), setting, data);
				tree.setting.check.chkboxType = ud.chkboxType;
				// 展开第一级节点
				ud.expandLevel = typeof ud.expandLevel != 'undefined' ? ud.expandLevel : 1;
				var nodes = tree.getNodesByParam("level", ud.expandLevel);
				for(var i=0; i<nodes.length; i++) {
					tree.expandNode(nodes[i], true, false, false);
				}
// 				// 默认展开全部节点
// 				tree.expandAll(true);
				udsTrees[ud.ctrlType] = tree;
			}
		});
	}
	// 默认选择节点   <c:forEach items="${userDataScopeList}" var="uds">
	var node = udsTrees['${uds.ctrlType}'].getNodeByParam("id","${uds.ctrlData}");
	try{udsTrees['${uds.ctrlType}'].checkNode(node, true, false);}catch(e){}</c:forEach>
	// 树结构：全选、取消全选
	$('#udsTrees').on('click', '.checkall', function(){
		var treeId = $(this).val();
		if(this.checked){
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
			treeObj.checkAllNodes(true);
		}else{
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
			treeObj.checkAllNodes(false);
		}
	});
	// 当前用户所属角色是否拥有全部数据权限
	if('${isDataScopeAll}' == 'true'){
		$('.checkall').click();
	}
</script>