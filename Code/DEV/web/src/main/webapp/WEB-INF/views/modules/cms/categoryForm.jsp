<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload"/>
<sys:header title="${fns:text('栏目管理')} - ${category.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('栏目')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-gear"></i>${category.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('栏目')}</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="cms:category:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="category" action="${ctx}/cms/category/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('父级编码')}：</label>
							<div class="col-sm-8">
				                <sys:treeselect id="parent" name="parent.id" value="${category.parent.id}" labelName="parent.categoryName" labelValue="${category.parent.categoryName}"
									title="栏目" url="/cms/category/treeData" extCode="${category.id}" allowClear="true"/>
								<form:hidden path="parent.site.siteCode"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('栏目编码')}：</label>
							<div class="col-sm-8">
								<form:hidden path="isNewRecord"/>
								<form:input path="categoryCode" htmlEscape="false" maxlength="30" readonly="${!category.isNewRecord}" class="form-control abc required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('栏目名称')}：</label>
							<div class="col-sm-8">
								<form:input path="categoryName" htmlEscape="false" maxlength="100" class="form-control required"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('排序（升序）')}：</label>
							<div class="col-sm-8">
								<form:input path="sorts" htmlEscape="false" maxlength="10" class="form-control digits"/>
								<span class="help-block">${fns:text('栏目的排列次序')}</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="${fns:text('指定栏目的模型，是文章还是链接，将来还会有图片和视频')}">
								${fns:text('模块类型')}：</label>
							<div class="col-sm-10">
								<form:select path="module" class="form-control">
									<form:option value="" label="${fns:text('公共模型')}"/>
									<form:options items="${fns:getDictList('cms_module')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('栏目图片')}：</label>
							<div class="col-sm-10">
<%-- 								<form:hidden path="image" htmlEscape="false" maxlength="255" class="form-control"/> --%>
<%-- 								<sys:ckfinder input="image" type="thumb" uploadPath="/cms/category"/> --%>
								<sys:fileupload id="image" bizCategory="image" bizKey="${category.image}" returnPath="true" uploadType="image" maxUploadNum="1"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('栏目超链接地址，优先级“高”与默认链接地址')}">
								${fns:text('外部链接')}： <i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="href" htmlEscape="false" maxlength="255" class="form-control"/>
								<span class="help-block">${fns:text('栏目超链接地址，优先级“高”')}</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('栏目超链接打开的目标窗口，新窗口打开，请填写：“_blank”')}">
								${fns:text('超链接目标窗口')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="target" htmlEscape="false" maxlength="20" class="form-control"/>
								<span class="help-block">${fns:text('栏目超链接打开的目标窗口，新窗口打开，请填写：“_blank”')}</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('栏目描述信息')}：</label>
							<div class="col-sm-8">
								<form:input path="description" htmlEscape="false" maxlength="255" class="form-control"
									placeholder="${fns:text('填写描述，有助于搜索引擎优化')}"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('栏目关键字')}：</label>
							<div class="col-sm-8">
								<form:input path="keywords" htmlEscape="false" maxlength="255" class="form-control"
									placeholder="${fns:text('填写描述，有助于搜索引擎优化')}"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">${fns:text('栏目配置')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('是否在导航中显示')}：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="inMenu" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value"
										htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('是否允许评论')}：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"
										htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('是否在分类页中显示')}：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="inList" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value"
										htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('是否需要审核')}：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="isAudit" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"
										htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="${fns:text('默认展现方式：有子栏目显示栏目列表，无子栏目显示内容列表')}。">
								${fns:text('栏目的展现方式')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-10">
								<div class="radio-list">
									<form:radiobuttons path="showModes" items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value"
										htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('自定义列表视图名称必须以')}“${category_DEFAULT_TEMPLATE}”${fns:text('开始')}">
								${fns:text('自定义列表视图')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
				                <form:select path="customListView" class="form-control">
				                    <form:option value="" label="${fns:text('默认视图')}"/>
				                    <form:options items="${listViewList}" htmlEscape="false"/>
				                </form:select>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('自定义内容视图名称必须以')}“${category_DEFAULT_TEMPLATE}”${fns:text('开始')}">
								${fns:text('自定义内容视图')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
				                <form:select path="customContentView" class="form-control">
				                    <form:option value="" label="${fns:text('默认视图')}"/>
				                    <form:options items="${contentViewList}" htmlEscape="false"/>
				                </form:select>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="${fns:text('例如视图参数设置为')}：count:2, titleShow:'yes' &nbsp; ${fns:text('则在视图文件中的获取方法是')}：\${viewConfig_count}、\${viewConfig_titleShow}">
								${fns:text('栏目视图参数配置')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-10">
								<form:input path="viewConfig" htmlEscape="false" class="form-control"
									placeholder="${fns:text('如果视图参数设置为')}：count:2, titleShow:'yes' &nbsp; ${fns:text('则在视图文件中的获取方法是')}：\${viewConfig_count}、\${viewConfig_titleShow}"/>
								<div class="alert alert-warning" style="margin:10px 0 0 0">
									<ul style="padding:0 0 0 20px;">
										<li>${fns:text('例如视图参数设置为')}：count:2, titleShow:'yes' &nbsp; ${fns:text('则在视图文件中的获取方法是')}：\${viewConfig_count}、\${viewConfig_titleShow}。</li>
										<li>${fns:text('设置栏目的管理地址：若设置')}【adminUrl:false】${fns:text('表示无管理地址，在内容发布栏目列表中不显示该栏目')}；
											${fns:text('设置')}【adminUrl:'/cms/guestbook'】${fns:text('表示有管理地址，在内容发布栏目列表中点击该栏目链接到该地址')}。</li>
										<li>${fns:text('管理地址参数：若设置')}【adminUrlParam:'fileDownload=true'】${fns:text('则代表链接模型为文件下载的栏目，新增链接的时出现文件上传对话框')}。</li>
										<li>${fns:text('管理地址参数：若设置')}【adminUrlParam:'outlineView=true'】${fns:text('则代表文章模型开启大纲视图编辑，在线编辑器左侧显示大纲视图')}。</li>
									</ul>
								</div>
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
						<shiro:hasPermission name="cms:category:edit">
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
// 				showMessage('本次操作之后仅显示本级数据，若想查看全部数据，请点击“全部”按钮。', '', 'info', 3000);
				closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
// 					contentWindow.dataGrid.refreshTree(1, $('#parentCode').val());
					contentWindow.$('#dataGrid').dataGrid('refreshTreeChildren',
							$('#parentCode').val(), ${category.isNewRecord});
				});
			}
		}, "json");
    }
});
</script>