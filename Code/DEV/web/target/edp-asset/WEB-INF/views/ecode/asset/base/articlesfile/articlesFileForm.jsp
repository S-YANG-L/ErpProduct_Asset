<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload"/>
<sys:header title="办公用品档案管理管理 - ${articlesFile.isNewRecord ? '新增' : '编辑'}办公用品档案管理" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${articlesFile.isNewRecord ? '新增' : '编辑'}办公用品档案</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="articlesfile:articlesFile:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="articlesFile" action="${ctx}/articlesfile/articlesFile/save" method="post" class="form-horizontal">
			<div class="form-body">
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
							<span class="required">*</span>	办公用品名称：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="articlesName" htmlEscape="false" maxlength="64" class="form-control required"/>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span>	办公用品分类：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
							  <sys:treeselect url="${ctx}/articlesfile/articlesFile/sortTreeData" id="sortCode"
                                   value="${articlesFile.sortCode}" labelName="sortName"
                                   labelValue="${articlesFile.sortName}" title="办公用品分类" name="sortCode"
                                   cssClass="rightBorder required" allowClear="true"
                                   notAllowSelectParent="true" isAll="true">
                                </sys:treeselect>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								单位：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="unit" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<%-- <div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								商品条码：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="barCode" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div> --%>
				</div>
				<div class="row">
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								品牌：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="brand" htmlEscape="false" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								规格型号：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="version" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								用品库存上限：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="upperLimit" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<%-- <div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								单价：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="unitPrice" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div> --%>
					
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								用品库存下限：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="lowerLimit" htmlEscape="false" maxlength="64" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
                    <div class="col-xs-8">
                        <div class="form-group">
                            <label class="control-label col-sm-2" title="">
                                                                                                       备注信息：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-10">
                                <form:textarea path="remarks" htmlEscape="false" rows="6" maxlength="1000" class="form-control"/>
                            </div>
                        </div>
                    </div>
					<div class="col-xs-4">
						<div class="form-group">
                            <label class="control-label col-sm-4">图片路径： </label>
                            <div class="col-sm-8">
                                <sys:fileupload  maxUploadNum="1" id="picture" bizCategory="picture"
                                                bizKey="${articlesFile.picture}" uploadType="image" returnPath="true"/>
                            </div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="articlesfile:articlesFile:edit">
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
