<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="jbox,ztree,grid,validate"/>
<sys:header title="${fns:text('用户管理')}" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} tabbable autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-user"></i>${fns:text('用户菜单授权')}
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="employee" action="${ctx}/sys/empUser/saveUserMenu" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<c:if test="${fns:getModule('core_extend').isEnable}">
						<div class="col-xs-6">
							<div class="form-group">
								<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属公司')}：</label>
								<div class="col-sm-8">
									<sys:treeselect id="company" name="company.id" value="${employee.company.id}" labelName="company.companyNameSimple" labelValue="${employee.company.companyNameSimple}" 
										title="${fns:text('公司')}" url="/sys/company/treeData" cssClass="required" allowClear="true" notAllowSelectParent="false" disabled="disabled"/>
								</div>
							</div>
						</div>
					</c:if>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属机构')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="office" name="office.id" value="${employee.office.id}" labelName="office.officeName" labelValue="${employee.office.officeName}" 
									title="${fns:text('机构')}" url="/sys/office/treeData" cssClass="required"  allowClear="true" disabled="disabled"/>
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
								<form:input path="loginInfo.loginCode" htmlEscape="false" placeholder="${fns:text('请输入登录账号')}" maxlength="30" readonly="true" class="form-control abc required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('用户名称')}：</label>
							<div class="col-sm-8">
								<form:input path="loginInfo.userName" htmlEscape="false" placeholder="${fns:text('请输入用户名称')}" maxlength="100" readonly="true" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">${fns:text('菜单授权')}</h4>
				<div class="row extend_msg" id="menuTree" style="margin-left:20px;">
					<c:forEach items="${menuKeys}" var="key">
						<div class="_col-sm-8" style="float:left;padding:15px;">
							<div class="portlet">
								<div class="portlet-title">
									<div class="caption"><input type="checkbox" id="checkall_${key}" 
										value="menuTree_${key}" class="checkall"/><label 
										for="checkall_${key}">${fns:getDictLabel(key, 'menu_sys_code', '未知')}</label></div>
									<div class="actions" style="float:left;margin:1px 10px;">
										<a href="javascript:" onclick="tree_${key}.expandAll(true);">${fns:text('展开')}</a>&nbsp;/
										<a href="javascript:" onclick="tree_${key}.expandAll(false);">${fns:text('折叠')}</a>
									</div>
								</div>
								<div class="portlet-body">
									<div id="menuTree_${key}" class="ztree" style="margin-top: 3px; margin-bottom: 30px; float: left;"></div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="row" style="height: 40px;"></div>
				<form:hidden id="menuCodes" path="loginInfo.menuCodes"/>
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
			var ids = [], nodes;
			<c:forEach items="${menuKeys}" var="key">
			nodes = tree_${key}.getCheckedNodes(true);
			for(var i=0; i<nodes.length; i++) {
				ids.push(nodes[i].id);
			}
			</c:forEach>
			$("#menuCodes").val(ids);
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
	
	var setting = {
		check:{enable:true,nocheckInherit:true,chkboxType:{"Y":"ps","N":"ps"}},
		view:{selectedMulti:false,nameIsHTML: true},
		data:{simpleData:{enable:true},key:{title:"title"}},
		callback:{
			beforeClick:function(treeId, node){
		        var treeObj = $.fn.zTree.getZTreeObj(treeId);
				treeObj.checkNode(node, !node.checked, true, true);
				return false;
			}
		}
	};
	
	// 已选择的节点编号
	var menuCodes = $('#menuCodes').val().split(",");
	
	// 遍历生成树结构
	<c:forEach items="${menuKeys}" var="key">
	var zNodes_${key} = ${fns:toJson(menuMap[key])};
	// 初始化树结构
	tree_${key} = $.fn.zTree.init($("#menuTree_${key}"), setting, zNodes_${key});
	// 默认选择节点
	for(var i=0; i<menuCodes.length; i++) {
		var node = tree_${key}.getNodeByParam("id", menuCodes[i]);
		try{tree_${key}.checkNode(node, true, false);}catch(e){}
	}
	// 默认展开一级节点
	var nodes_${key} = tree_${key}.getNodesByParam("level", 0);
	for(var i=0; i<nodes_${key}.length; i++) {
		tree_${key}.expandNode(nodes_${key}[i], true, false, false);
	}
	</c:forEach>
	// 全选、取消全选
	$('#menuTree').on('click', '.checkall', function(){
		var treeId = $(this).val();
		if(this.checked){
	        var treeObj = $.fn.zTree.getZTreeObj(treeId);
	        treeObj.checkAllNodes(true);
		}else{
	        var treeObj = $.fn.zTree.getZTreeObj(treeId);
	        treeObj.checkAllNodes(false);
		}
	});
</script>