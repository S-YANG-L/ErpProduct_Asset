<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<sys:header title="栏目管理 - 栏目授权" extLibs="validate,ztree"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-gear"></i>目录<c:choose><c:when test="${fileDirRole.ctrlType=='edit'}">【编辑】</c:when><c:otherwise>【查看】</c:otherwise></c:choose>权限（${fileDirRole.role.roleName}）</div>
	</div>
	<div class="portlet-body form">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="fileDirRole" action="${ctx}/file/fileDirRole/save" method="post" class="form-horizontal">
			<div class="form-body">
				<%-- <h4 class="form-section ">角色信息</h4>
				<div class="row">
					<c:choose><c:when test="${fileDirRole.currentUser.admin}">
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
				<form:hidden path="ctrlType"/>
				<div class="row extend_msg" id="roleTree">
					<c:forEach items="${fileDirRole.groupList}" var="site">
						<div class="_col-sm-8" style="float:left;padding:15px;">
							<div class="portlet">
								<div class="portlet-title">
									<div class="caption"><input type="checkbox" id="checkall_${site.value}" 
										value="siteTree_${site.value}" class="checkall"/><label 
										for="checkall_${site.value}">${site.name}</label></div>
								</div>
								<div class="portlet-body">
									<div id="siteTree_${site.value}" class="ztree" style="margin-top: 3px; margin-bottom: 30px; float: left;"></div>
									<%-- <form:hidden path="site.value" /> --%>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="row" style="height: 40px;"></div>
				<form:hidden path="fileDirIds"/>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="file:fileDirRole:edit">
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
				<c:forEach items="${fileDirRole.groupList}" var="site">
				var nodes_${site.value} = tree_${site.value}.getCheckedNodes(true);
				for(var i=0; i<nodes_${site.value}.length; i++) {
					ids.push(nodes_${site.value}[i].id);
				}
				</c:forEach>
				$("#fileDirIds").val(ids);
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
		<c:forEach items="${fileDirRole.groupList}" var="site">
			var zNodes_${site.value}=[<c:forEach items="${site.fileDirList}" var="fileDir" varStatus="status"><c:if test="${status.index!=0}">,</c:if>{id:"${fileDir.dirId}", pId:"${not empty fileDir.parentCode?fileDir.parentCode:0}", name:"${not empty fileDir.parentCode?fileDir.dirName:'栏目列表'}"}</c:forEach>];
			// 初始化树结构
			var tree_${site.value} = $.fn.zTree.init($("#siteTree_${site.value}"), setting, zNodes_${site.value});
			// 不选择父节点
			tree_${site.value}.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
			// 默认选择节点
			<c:forEach items="${site.fileDirCodes}" var="dirId">
			var node = tree_${site.value}.getNodeByParam("id","${dirId}" );
			try{tree_${site.value}.checkNode(node, true, false);}catch(e){}
			</c:forEach>
			// 默认展开全部节点
			tree_${site.value}.expandAll(true);
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