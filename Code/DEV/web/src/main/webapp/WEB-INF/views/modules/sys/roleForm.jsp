<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,ztree"/>
<sys:header title="${fns:text('角色管理')} - ${role.isNewRecord ? fns:text('新增') : fns:text('编辑')}角色" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-users"></i>${role.isNewRecord ? fns:text('新增') : type eq '2' ? fns:text('授权') : fns:text('编辑')}${fns:text('角色')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/save" method="post" class="form-horizontal">
			<input type="hidden" name="type" value="${type }" />
			<sys:message content="${message}"/>
			<div class="form-body">
				<h4 class="form-section ">${fns:text('基本信息')}</h4>
				<c:choose><c:when test="${role.currentUser.admin}">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('角色编码')}：</label>
								<div class="col-sm-8">
									<form:hidden path="isNewRecord"/>
									<form:input path="roleCode" htmlEscape="false" maxlength="64" readonly="${!role.isNewRecord}" class="form-control abc required"/>
									<span class="help-block">&nbsp;</span>
								</div>
							</div>
						</div>
					</div>
				</c:when><c:otherwise>
					<form:hidden path="roleCode"/>
				</c:otherwise></c:choose>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('角色名称')}：</label>
							<div class="col-sm-8">
								<input id="oldName" name="oldName" type="hidden" value="${role.roleName}">
								<form:input path="roleName" htmlEscape="false" maxlength="50" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<%-- <div class="row basic_msg">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 英文名称：</label>
							<div class="col-sm-8">
								<input id="oldEnname" name="oldEnname" type="hidden" value="${role.nameEn}">
								<form:input path="nameEn" htmlEscape="false" maxlength="50" class="form-control required"/>
							</div>
						</div>
					</div>
				</div> --%>
				<div class="row basic_msg">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('备注信息')}：</label>
							<div class="col-sm-8">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section extend_msg">${fns:text('角色授权')}</h4>
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
				<form:hidden path="menuIds"/>
								
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:role:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	$(document).ready(function() {
		$("#inputForm").validate({
			rules: {
				roleName: {remote: "${ctx}/sys/role/checkName?oldName=" + encodeURIComponent("${role.roleName}")}/* ,
				nameEn: {remote: "${ctx}/sys/role/checkEnname?oldEnname=" + encodeURIComponent("${role.nameEn}")} */
			},
			messages: {
				roleName: {remote: "角色名已存在"}/* ,
				nameEn: {remote: "英文名已存在"} */
			},
			submitHandler: function(form){
				if("${type}" == "0" || "${type}" == "2"){
					var ids = [], nodes;
					<c:forEach items="${menuKeys}" var="key">
					nodes = tree_${key}.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++) {
						ids.push(nodes[i].id);
					}
					</c:forEach>
					$("#menuIds").val(ids);
				}
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
		
		//  ======== 加载授权树结构  ========
		if("${type}" == "0" || "${type}" == "2"){
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
			var menuIds = $('#menuIds').val().split(",");
			
			// 遍历生成树结构
			<c:forEach items="${menuKeys}" var="key">
			var zNodes_${key} = ${fns:toJson(menuMap[key])};
			// 初始化树结构
			tree_${key} = $.fn.zTree.init($("#menuTree_${key}"), setting, zNodes_${key});
			// 默认选择节点
			for(var i=0; i<menuIds.length; i++) {
				var node = tree_${key}.getNodeByParam("id", menuIds[i]);
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
		}

		if("${type}" == "1"){
// 			$('#inputForm').action='${ctx}/sys/role/saveGrant';
			$('#inputForm .extend_msg').hide();
		}else if("${type}" == "2"){
// 			$('#inputForm').action='${ctx}/sys/role/saveBasic';
			$('#inputForm .basic_msg').hide();
			$('#oldName').parent().parent().find('span.required').css('display','none');
			$('#roleName').attr("disabled","disabled");
		}
	});
</script>