<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,ztree"/>
<sys:header title="角色管理 - 角色数据权限授权" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa icon-roles"></i>角色数据权限授权</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/saveDataScope" method="post" class="form-horizontal">
			<input type="hidden" name="type" value="${type }" />
			<sys:message content="${message}"/>
			<div class="form-body">
				<h4 class="form-section ">基本信息</h4>
				<form:hidden path="roleCode"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 角色名称：</label>
							<div class="col-sm-8">
								<form:input path="roleName" htmlEscape="false" maxlength="50" readonly="true" class="form-control required"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 数据范围：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="dataScope" items="${fns:getDictList('role_data_scope')}" itemLabel="label" itemValue="value"
										htmlEscape="false" class="form-control required"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section extend_msg">自定义数据授权</h4>
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
			    <input type="hidden" id="roleDataScopeListJson" name="roleDataScopeListJson" />
				<div class="row"></div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:role:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
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
			submitHandler: function(form){
				//获取数据权限数据
				var udsData = [];
				$.each(udsTrees, function(key, udsTree){
					var treeNodes = udsTree.getCheckedNodes(true);
					for(var i=0; i<treeNodes.length; i++) {
						udsData.push({
							ctrlType: key, ctrlData: treeNodes[i].id
						});
					}
				});
				$("#roleDataScopeListJson").val(JSON.stringify(udsData));
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
				var nodes = tree.getNodesByParam("level", 0);
				for(var i=0; i<nodes.length; i++) {
					tree.expandNode(nodes[i], true, false, false);
				}
// 				// 展开第二级节点
// 	 			nodes = tree.getNodesByParam("level", 1);
// 	 			for(var i=0; i<nodes.length; i++) {
// 	 				tree.expandNode(nodes[i], true, false, false);
// 	 			}
				// 默认展开全部节点
				tree.expandAll(true);
				udsTrees[ud.ctrlType] = tree;
			}
		});
	}
	// 默认选择节点   <c:forEach items="${roleDataScopeList}" var="uds">
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
</script>