<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,ueditor,fileupload"/>
<sys:header title="${fns:text('站点管理')}- ${site.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('站点')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-sitemap"></i>${site.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('站点')}</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="cms:site:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="site" action="${ctx}/cms/site/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('站点编码')}：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:input path="siteCode" htmlEscape="false" maxlength="30" readonly="${!site.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('站点名称')}：</label>
							<div class="col-sm-8">
								<form:input path="siteName" htmlEscape="false" maxlength="100" class="form-control required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('站点标题')}：</label>
							<div class="col-sm-8">
								<form:input path="title" htmlEscape="false" maxlength="100" class="form-control required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('站点域名')}：</label>
							<div class="col-sm-8">
								<form:input path="domain" htmlEscape="false" maxlength="255" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('站点Logo')}：</label>
							<div class="col-sm-10">
<%-- 								<form:hidden path="logo" htmlEscape="false" maxlength="255" class="form-control"/> --%>
<%-- 								<sys:ckfinder input="logo" type="images" uploadPath="/cms/site"/> --%>
								<sys:fileupload id="logo" bizCategory="logo" bizKey="${site.logo}" returnPath="true" uploadType="image" maxUploadNum="1"/>
								<span class="help-block">${fns:text('建议Logo大小')}：1000 × 145（${fns:text('像素')}）</span>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">${fns:text('详细信息')}</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('描述')}：</label>
							<div class="col-sm-10">
								<form:input path="description" htmlEscape="false" maxlength="255" class="form-control"
									placeholder="${fns:text('填写描述，有助于搜索引擎优化')}"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('关键字')}：</label>
							<div class="col-sm-10">
								<form:input path="keywords" htmlEscape="false" maxlength="255" class="form-control"
									placeholder="${fns:text('填写关键字，有助于搜索引擎优化')}"/>
								<span class="help-block">${fns:text('填写描述及关键字，有助于搜索引擎优化')}</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('主题风格')}：</label>
							<div class="col-sm-8">
								<form:select path="theme" class="form-control">
									<form:options items="${fns:getDictList('cms_theme')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('自定义站点首页视图名称必须以')}“${site_DEFAULT_TEMPLATE}”${fns:text('开始')}">
								${fns:text('首页视图')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
				                <form:select path="customIndexView" class="form-control">
				                    <form:option value="" label="${fns:text('默认视图')}"/>
				                    <form:options items="${indexViewList}" htmlEscape="false"/>
				                </form:select>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('版权信息')}：</label>
							<div class="col-sm-10">
								<sys:ueditor id="copyright" name="copyright" value="${site.copyright}" height="200" simpleToolbars="true"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">${fns:text('其它信息')}</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('备注信息')}：</label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="cms:site:edit">
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