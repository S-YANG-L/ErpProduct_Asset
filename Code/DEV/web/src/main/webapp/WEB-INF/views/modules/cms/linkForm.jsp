<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload"/>
<sys:header title="链接管理 - ${link.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('链接')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-file-text-o"></i>${link.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('链接')}</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="cms:link:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="link" action="${ctx}/cms/link/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属栏目')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="category" name="category.categoryCode" value="${link.category.categoryCode}" labelName="category.categoryName" labelValue="${link.category.categoryName}"
									title="${fns:text('栏目')}" url="/cms/category/treeData?canAdmin=true" module="link" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="required"/>
			                    <span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"><span class="required">*</span> ${fns:text('链接标题')}：</label>
							<div class="col-sm-10">
								<div class="input-group">
									<form:input path="title" htmlEscape="false" maxlength="255" class="form-control measure-input required"/>
									<span class="input-group-btn">
										<span class="input-group color colorpicker-default" data-color="${not empty link.color ? link.color : '#666'}" data-color-format="hex">
											<span class="input-group-btn">
												<button class="btn default" type="button"><i></i>&nbsp;</button>
											</span>
											<input name="color" type="text" class="form-control" style="width:63px;" value="${link.color}" placeholder="${fns:text('标题颜色')}">
										</span>
									</span>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${param.fileDownload ne 'true'}">
					<div class="row">
						<div class="col-xs-12">
							<div class="form-group">
								<label class="control-label col-sm-2"><span class="required">*</span> ${fns:text('链接地址')}：</label>
								<div class="col-sm-10">
									<form:input path="href" htmlEscape="false" maxlength="1000" class="form-control required"/>
									<span class="help-block">&nbsp;</span>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${param.fileDownload eq 'true'}">
					<div class="row isUpload">
						<div class="col-xs-12">
							<div class="form-group">
								<label class="control-label col-sm-2">${fns:text('上传文件')}：</label>
								<div class="col-sm-10">
									<form:hidden path="href" htmlEscape="false" maxlength="1000" class="form-control required"/>
									<sys:fileupload id="upload" bizCategory="" bizKey="" returnPath="true"
										filePathInputId="href" fileNameInputId="title" uploadType="all" maxUploadNum="1"/>
									<span class="help-block">&nbsp;</span>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('数值越大排序越靠前，可设置权重过期时间')}。">
								${fns:text('权重/排序')}： <i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<div class="form-inline">
									<form:input path="weight" htmlEscape="false" maxlength="10" class="form-control width-90 digits"/> &nbsp;
									<input id="weightTop" type="checkbox" ${link.weight eq 9999 ? 'checked' : ''} 
										onclick="$('#weight').val(this.checked?'9999':'0')"><label for="weightTop">${fns:text('置顶')}</label>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('时间到期后，权重自动恢复为0，如果为空，则权重永不过期')}。">
								${fns:text('权重过期时间')}： <i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<input id="weightDate" name="weightDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
									value="<fmt:formatDate value="${link.weightDate}" pattern="yyyy-MM-dd"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">${fns:text('详细信息')}</h4>
				<c:if test="${param.fileDownload ne 'true'}">
					<div class="row">
						<div class="col-xs-12">
							<div class="form-group">
								<label class="control-label col-sm-2" title="${fns:text('图片链接情况下使用')}">
									${fns:text('链接图片')}： <i class="fa icon-question"></i></label>
								<div class="col-sm-10">
	<%-- 				                <input type="hidden" id="image" name="image" value="${link.image}" /> --%>
	<%-- 								<sys:ckfinder input="image" type="thumb" uploadPath="/cms/link" selectMultiple="false"/> --%>
										<sys:fileupload id="image" bizCategory="image" bizKey="${link.image}" returnPath="true" uploadType="image" maxUploadNum="1"/>
									<span class="help-block">&nbsp;</span>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('链接的发布状态')}">${fns:text('状态')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-7">
								<div class="radio-list">
									<form:radiobuttons path="status" items="${fns:getDictList('cms_status')}" itemLabel="label" 
										itemValue="value" htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('可修改发布时间，不填则使用当前时间')}">
								${fns:text('发布时间')}： <i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
									value="<fmt:formatDate value="${link.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="cms:link:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('提 交')}</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<link href="${ctxStatic}/assets/global/plugins/bootstrap-colorpicker/css/colorpicker.css" rel="stylesheet" type="text/css"/>
<script src="${ctxStatic}/assets/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler: function(form){
			if ($("#categoryCode").val() == ""){
                $("#categoryName").focus();
                showMessage('请选择归属栏目', '警告','warning');
                return false;
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
	// 颜色控件初始化
	$('.colorpicker-default').colorpicker();
</script>