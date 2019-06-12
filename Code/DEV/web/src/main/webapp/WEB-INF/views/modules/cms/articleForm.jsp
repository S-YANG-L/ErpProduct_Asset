<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,ueditor,fileupload"/>
<sys:header title="${fns:text('文章管理')} - ${article.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('文章')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-file-text-o"></i>${article.isNewRecord ? fns:text('新增') : fns:text('编辑')}${fns:text('文章')}</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="cms:article:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="article" action="${ctx}/cms/article/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<form:hidden path="id"/>
				<form:hidden path="status"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('所属栏目')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="category" name="category.categoryCode" value="${article.category.categoryCode}" labelName="category.categoryName" labelValue="${article.category.categoryName}"
									title="${fns:text('栏目')}" url="/cms/category/treeData?canAdmin=true" module="article" selectScopeModule="true"   notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="required"/>
							    <span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('来源')}：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="source" items="${fns:getDictList('cms_source')}" itemLabel="label" itemValue="value" htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row isSource">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('转载来源')}：</label>
							<div class="col-sm-10">
								<form:input path="copyfrom" htmlEscape="false" maxlength="255" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2"><span class="required">*</span> ${fns:text('文章标题')}：</label>
							<div class="col-sm-10">
								<div class="input-group">
									<form:input path="title" htmlEscape="false" maxlength="255" class="form-control measure-input required"/>
									<span class="input-group-btn">
										<span class="input-group color colorpicker-default" data-color="${not empty article.color ? article.color : '#666'}" data-color-format="hex">
											<span class="input-group-btn">
												<button class="btn default" type="button"><i></i>&nbsp;</button>
											</span>
											<input name="color" type="text" class="form-control" style="width:63px;" value="${article.color}" placeholder="${fns:text('标题颜色')}">
										</span>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="${fns:text('如果填写外部链接，点击该文章会直接跳转到该地址，不想不跳转请留空')}。">
								${fns:text('外部链接')}： <i class="fa icon-question"></i></label>
							<div class="col-sm-10">
								<form:input path="href" htmlEscape="false" maxlength="1000" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('数值越大排序越靠前，可设置权重过期时间')}。">
								${fns:text('权重/排序')}： <i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<div class="form-inline">
									<form:input path="weight" htmlEscape="false" maxlength="10" class="form-control width-90 digits"/> &nbsp;
									<input id="weightTop" type="checkbox" ${article.weight eq 9999 ? 'checked' : ''} 
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
									value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">${fns:text('详细信息')}</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-1">${fns:text('摘要')}：</label>
							<div class="col-sm-11">
								<form:textarea path="description" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-1">${fns:text('正文')}：</label>
							<div class="col-sm-11">
								<%-- <form:textarea id="content" htmlEscape="true" path="articleData.content" rows="4" maxlength="200" class="form-control"/>
								<sys:ckeditor replace="content" uploadPath="/cms/article" /> --%>
								<sys:ueditor id="content" name="articleData.content" value="${article.articleData.content}" height="300" outlineView="${param.outlineView}"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<%-- <div class="col-xs-6 ">
						<div class="form-group">
							<label class="col-sm-4 control-label">${fns:text('相关文章')}：</label>
							<div class="col-sm-8">
								<sys:listselect id="relation" name="articleData.relation" value="${articleData.relation}" labelName="aa" labelValue=""
									title="${fns:text('选择相关文章')}" url="${ctx}/cms/article/selectList" multiple="true" cssClass="form-control required"/>
							</div>
						</div>
					</div> --%>
				</div>
				<h4 class="form-section">${fns:text('其它信息')}</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="${fns:text('文章图片可在正文中选取（鼠标放在图片上，点击“设为文章图片”即可）')}。">
								${fns:text('文章图片')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-10">
<%-- 								<input type="hidden" id="image" name="image" value="${article.image}" /> --%>
<%-- 								<sys:ckfinder input="image" type="thumb" uploadPath="/cms/article" selectMultiple="false"/> --%>
<%-- 								<script type="text/javascript">$('#imageBtns').remove();</script> --%>
								<sys:fileupload id="image" bizCategory="image" bizKey="${article.image}" returnPath="true" uploadType="image" maxUploadNum="1"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('关键词')}：</label>
							<div class="col-sm-8">
								<form:input path="keywords" htmlEscape="false" maxlength="255" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('推荐位')}：</label>
							<div class="col-sm-8">
								<div class="checkbox-list">
									<form:checkboxes path="posidList" items="${fns:getDictList('cms_posid')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</div>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('文章的发布状态')}">${fns:text('状态')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<div class="form-control" readonly="true">
									${fns:getDictLabel(article.status, 'cms_article_status', '')}
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
									value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${article.category.allowComment == fns:getConst('YES')}">
					<div class="row">
						<div class="col-xs-6">
							<div class="form-group">
								<label class="control-label col-sm-4" title="${fns:text('必须栏目设置了允许评论，此设置才有效')}。">
									${fns:text('是否允许评论')}： <i class="fa icon-question"></i></label>
								<div class="col-sm-8">
									<div class="radio-list">
										<form:radiobuttons path="articleData.allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"
											htmlEscape="false" class="form-control required"/>
									</div>
									<span class="help-block">&nbsp;</span>
								</div>
							</div>
						</div>
						<c:if test="${not empty article.id && article.category.allowComment == fns:getConst('YES') && article.articleData.allowComment == fns:getConst('YES')}">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4">${fns:text('查看评论')}：</label>
									<div class="col-sm-8">
										<input id="btnComment" class="btn" type="button" value="${fns:text('查看评论')}" onclick="viewComment('${ctx}/cms/comment/?module=article&contentId=${article.id}&status=0')"/>
										<script type="text/javascript">
											function viewComment(href){
												var $jBox = getJBox();
												$jBox.open('iframe:'+href,'${fns:text("查看评论")}',$(top.document).width()-220,$(top.document).height()-180,{
													buttons:{"${fns:text('关闭')}":true},
													loaded:function(h){
														$(".jbox-content", top.document).css("overflow-y","hidden");
														$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
														$("body", h.find("iframe").contents()).css("margin","10px");
													}
												});
												return false;
											}
										</script>
										<span class="help-block">&nbsp;</span>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</c:if>
				<h4 class="form-section">${fns:text('高级配置')}</h4>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="${fns:text('自定义内容视图名称必须以')}“${article_DEFAULT_TEMPLATE}”${fns:text('开始')}">
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
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="${fns:text('例如视图参数设置为')}：count:2, titleShow:'yes' &nbsp; ${fns:text('则在视图文件中的获取方法是')}：\${viewConfig_count}、\${viewConfig_titleShow}">
								${fns:text('内容视图参数配置')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-10">
								<form:input path="viewConfig" htmlEscape="false" class="form-control"
									placeholder="${fns:text('如果视图参数设置为')}：count:2, titleShow:'yes' &nbsp; ${fns:text('则在视图文件中的获取方法是')}：\${viewConfig_count}、\${viewConfig_titleShow}"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<c:choose>
							<%-- 正常状态 --%>
							<c:when test="${article.status =='0'}">
								<shiro:hasPermission name="cms:article:edit">
									<shiro:hasPermission name="cms:article:audit">
										<button id="btnSubmit1" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保存发布')}</button>&nbsp;
									</shiro:hasPermission>
								 	<shiro:lacksPermission name="cms:article:audit">
								 		<button id="btnSubmit2" type="submit" class="btn btn-primary" onclick="$('#status').val('4');"><i class="fa fa-check"></i> ${fns:text('再次提交审核')}</button>&nbsp;
								 	</shiro:lacksPermission>
							 	</shiro:hasPermission>
							</c:when>
							<%-- 删除状态 --%>
							<c:when test="${article.status =='1'}">
								<shiro:hasPermission name="cms:article:edit">
									<shiro:hasPermission name="cms:article:audit">
										<button id="btnSubmit1" type="submit" class="btn btn-primary" onclick="$('#status').val('0');"><i class="fa fa-check"></i> ${fns:text('重新发布')}</button>&nbsp;
								 	</shiro:hasPermission>
								 	<shiro:lacksPermission name="cms:article:audit">
								 		<button id="btnSubmit2" type="submit" class="btn btn-primary" onclick="$('#status').val('4');"><i class="fa fa-check"></i> ${fns:text('再次提交审核')}</button>&nbsp;
								 	</shiro:lacksPermission>
							 	</shiro:hasPermission>
							</c:when>
							<%-- 审核状态 --%>
							<c:when test="${article.status =='4'}">
								<shiro:hasPermission name="cms:article:audit">
									<button id="btnSubmit1" type="submit" class="btn btn-primary" onclick="$('#status').val('0');"><i class="fa fa-check"></i> ${fns:text('通 过')}</button>&nbsp;
									<button id="btnSubmit2" type="submit" class="btn btn-primary"  onclick="$('#status').val('5');"><i class="fa fa-save"></i> ${fns:text('驳 回')}</button>&nbsp;
								</shiro:hasPermission>
							</c:when>
							<%-- 驳回状态 --%>
							<c:when test="${article.status =='5'}">
								<shiro:hasPermission name="cms:article:edit">
									<button id="btnSubmit1" type="submit" class="btn btn-primary" onclick="$('#status').val('4');"><i class="fa fa-check"></i> ${fns:text('再次提交')}</button>&nbsp;
							 	</shiro:hasPermission>
							</c:when>
							<%-- 草稿状态 --%>
							<c:when test="${article.status =='9'}">
								<shiro:hasPermission name="cms:article:edit">
									<%-- 栏目展现方式为简介类的栏目，不能存为草稿 --%>
									<c:if test="${param['category.showModes'] ne '2'}">
										<button id="btnSubmit1" type="submit" class="btn btn-info"  onclick="$('#status').val('9');"><i class="fa fa-save"></i> ${fns:text('暂存草稿')}</button>&nbsp;
								 	</c:if>
								 	<shiro:hasPermission name="cms:article:audit">
										<button id="btnSubmit2" type="submit" class="btn btn-primary" onclick="$('#status').val('0');"><i class="fa fa-check"></i> ${fns:text('保存发布')}</button>&nbsp;
								 	</shiro:hasPermission>
								 	<shiro:lacksPermission name="cms:article:audit">
								 		<button id="btnSubmit3" type="submit" class="btn btn-primary" onclick="$('#status').val('4');"><i class="fa fa-check"></i> ${fns:text('提交审核')}</button>&nbsp;
								 	</shiro:lacksPermission>
							 	</shiro:hasPermission>
							</c:when>
							<c:otherwise> 
						 	</c:otherwise>
						</c:choose>
						<%-- 栏目展现方式为简介类的栏目，不能关闭窗口 --%>
						<c:if test="${param['category.showModes'] ne '2'}">
							<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
						</c:if>
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
				showMessage('请选择归属栏目', '警告', 'warning');
				return false;
// 			}else if (!contentUE.hasContents() && $("#href").val().trim() == ""){
// 				contentUE.focus();
//  				showMessage('请填写正文！', '警告', 'warning');
// 				return false;
			}
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					if (${param['category.showModes'] ne '2'}){
						closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
							contentWindow.page();
						});
					}else{
						location = location.href;
					}
				}
			}, "json");
	    }
	});

	// 设置文章图片按钮事件方法（UEditor）
	function onSetArticleImage(src){
		try{
			$("#image").val(src);
			$('#imageUploader').webuploader('refreshFileListByPath');
			showMessage('设置文章图片成功！');
		}catch(ex){
			showMessage('设置文章图片失败！');
		}
	}
	
	// 如果填写了外部链接，则可以不填写正文
	$("#href").change(function(){
		if ($(this).val() == ""){
			$('#content').addClass('required');
		}else{
			$('#content').removeClass('required');
		}
	}).change();

	// 来源选中第一个
	if ('${article.isNewRecord}' == 'true'){
		$("input[name=source]:eq(0)").attr("checked",'checked');
	}
	
	// 颜色控件初始化
	$('.colorpicker-default').colorpicker();

	// 根据来源类型显示不同的元素
	var refreshSource = function (val){
		if (val == '2'){
			$('.isSource').show();
		}else{
			$('.isSource').hide();
		}
	}
	refreshSource($('input[name=source]:checked').val());
	$('input[name=source]').click(function(){
		refreshSource($(this).val());
	});
</script>