<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="仓库物品信息管理 - ${warehouseItems.isNewRecord ? '新增' : '编辑'}仓库物品信息" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${warehouseItems.isNewRecord ? '新增' : '编辑'}仓库物品信息</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="wareitems:warehouseItems:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="warehouseItems" action="${ctx}/wareitems/warehouseItems/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								办公物品编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="articlesCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								办公用品名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="articlesName" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								仓库编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="whCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								仓库名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="whName" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								类别编码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sortCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								类别名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sortName" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								品牌名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="brand" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								规格型号：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="version" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								单位：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="unit" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								单价：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="price" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								数量：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="qty" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								合计金额：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="sumMoney" htmlEscape="false" maxlength="100" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="wareitems:warehouseItems:edit">
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
	
	$("#inputForm").validate({
		submitHandler: function(form){
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
</script>
