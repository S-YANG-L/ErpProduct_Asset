<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<sys:header title="${fns:text('栏目管理')} - ${fns:text('栏目授权')}" extLibs="validate,ztree"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-gear"></i>${fns:text('栏目授权')}（${categoryRole.role.roleName}）</div>
	</div>
	<div class="portlet-body form">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="categoryRole" action="${ctx}/cms/categoryRole/save" method="post" class="form-horizontal">
			<div class="form-body">
				<%-- <h4 class="form-section ">角色信息</h4>
				<div class="row">
					<c:choose><c:when test="${categoryRole.currentUser.admin}">
						<div class="col-xs-6">
							<div class="form-group">
								<label class="control-label col-sm-4"><span class="required">*</span> 角色编码：</label>
								<div class="col-sm-8">
									<form:input path="role.roleCode" htmlEscape="false" maxlength="64"  disabled="disabled" readonly="true" class="form-control "/>
									<span class="help-block">&nbsp;</span>
								</div>
							</div>
						</div>
					</c:when><c:otherwise>
						<form:hidden path="role.roleCode"/>
					</c:otherwise></c:choose>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 角色名称：</label>
							<div class="col-sm-8">
								<form:input path="role.roleName" htmlEscape="false" disabled="disabled" maxlength="50" readonly="true" class="form-control "/>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section extend_msg">栏目授权</h4> --%>
				<form:hidden path="role.roleCode"/>
				<form:hidden path="role.roleName"/>
				<div class="row extend_msg" id="roleTree">
					<c:forEach items="${categoryRole.siteList}" var="site">
						<div class="_col-sm-8" style="float:left;padding:15px;">
							<div class="portlet">
								<div class="portlet-title">
									<div class="caption"><input type="checkbox" id="checkall_${site.siteCode}" 
										value="siteTree_${site.siteCode}" class="checkall"/><label 
										for="checkall_${site.siteCode}">${site.siteName}</label></div>
								</div>
								<div class="portlet-body">
									<div id="siteTree_${site.siteCode}" class="ztree" style="margin-top: 3px; margin-bottom: 30px; float: left;"></div>
									<form:hidden path="site.siteCode" />
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="row" style="height: 40px;"></div>
				<form:hidden path="categoryIds"/>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="cms:categoryRole:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="validate,ztree"/>
<script type="text/javascript">
	$(document).ready(function() {
		// 全选、取消全选
		$('#roleTree').on('click', '.checkall', function(){
			var treeId = $(this).val();
			if(this.checked){
		        var treeObj = $.fn.zTree.getZTreeObj(treeId);
		        treeObj.checkAllNodes(true);
			}else{
		        var treeObj = $.fn.zTree.getZTreeObj(treeId);
		        treeObj.checkAllNodes(false);
			}
		});
		$("#inputForm").validate({
			submitHandler: function(form){
				var ids = [];
				<c:forEach items="${categoryRole.siteList}" var="site">
				var nodes_${site.siteCode} = tree_${site.siteCode}.getCheckedNodes(true);
				for(var i=0; i<nodes_${site.siteCode}.length; i++) {
					ids.push(nodes_${site.siteCode}[i].id);
				}
				</c:forEach>
				$("#categoryIds").val(ids);
				ajaxSubmitForm($(form), function(data){
					if(data.result == Global.TRUE){
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}
					showMessage(data.message);
				}, "json");
		    }
		});
		
		//  ======== 加载授权树结构  ========
		var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
				data:{simpleData:{enable:true}},callback:{beforeClick:zTreeBeforeCheck,onCheck:zTreeOnCheck}};
		<c:forEach items="${categoryRole.siteList}" var="site">
			var zNodes_${site.siteCode}=[<c:forEach items="${site.categoryList}" var="category" varStatus="status"><c:if test="${status.index!=0}">,</c:if>{id:"${category.categoryCode}", pId:"${not empty category.parentCode?category.parentCode:0}", name:"${not empty category.parentCode?category.categoryName:'栏目列表'}"}</c:forEach>];
			// 初始化树结构
			var tree_${site.siteCode} = $.fn.zTree.init($("#siteTree_${site.siteCode}"), setting, zNodes_${site.siteCode});
			// 不选择父节点
			tree_${site.siteCode}.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
			// 默认选择节点
			<c:forEach items="${site.categoryCodes}" var="categoryCode">
			var node = tree_${site.siteCode}.getNodeByParam("id","${categoryCode}" );
			try{tree_${site.siteCode}.checkNode(node, true, false);}catch(e){}
			</c:forEach>
			// 默认展开全部节点
			tree_${site.siteCode}.expandAll(true);
		</c:forEach>
		
		function zTreeOnCheck(event, treeId, treeNode) {
			var tid=treeNode.tId;
			if(!treeNode.checked){
				tid=tid.substring(0, tid.lastIndexOf('_')); 
				$(".checkall").each(function(){
					if(tid==$(this).val()){
						if(this.checked){
						    $.uniform.update($(this).removeAttr("checked"));
						}
						return false;
					}
				}); 
			}
			//treeId=tid.substring(0, tid.lastIndexOf('_')); 
		    //alert(treeNode.tId + ", " + treeId + "," + treeNode.checked); 
		}
		
		// 禁止所有勾选操作，保持初始化的勾选状态
		function zTreeBeforeCheck(treeId, treeNode){
			//tree.checkNode(node, !node.checked, true, true);
			return false;
		}
	});
</script>