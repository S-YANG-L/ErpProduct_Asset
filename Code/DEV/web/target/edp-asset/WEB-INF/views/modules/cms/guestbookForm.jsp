<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="公众留言 -审核留言" extLibs="${extLibs}"/>
<style type="text/css">
	/*  信息查看页样式*/
.blog-info {list-style: none;margin: 15px 0 12px 0; padding-left:0;}
.blog-item h2 {text-align: center;}
.blog-item blockquote { margin: 0px 10px 5px; border-color: #E84D1C; font-size: 12px;}
.blog-info li {padding: 0;color: #555;font-size: 13px; margin-right: 10px; display: inline-block;}
.blog-info li i { color: #E84D1C;}
.blog-item .blog-info {margin: 20px 0; padding: 8px 0;border-top: solid 1px #ECEBEB;border-bottom: solid 1px #ECEBEB;}
.blog-item .blog-info li { padding-left: 13px;   border-left: solid 1px #ECEBEB;}
.blog-item .blog-info li:first-child { padding-left: 0;  border-left: none; 	}
.blog-item .comments {border-top: solid 1px #ECEBEB;padding-top: 15px;}
</style>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${fns:text('审核留言')}</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="guestbook" action="${ctx}/cms/guestbook/auditing" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">${fns:text('留言信息')}</h4>
				<form:hidden path="id"/>
				<form:hidden path="status"/>
				<div class="row">
					<div class="col-md-12 col-sm-12 blog-item">
						<blockquote>
							<p>${guestbook.content}</p>
							<small>${fns:text('留言分类')}： <cite>${fns:getDictLabel(guestbook.type, 'cms_guestbook', '无')}</cite></small>
						</blockquote>
						<ul class="blog-info">
							<li><i class="fa fa-user"></i>${fns:text('留言者')}：${ guestbook.name}</li>
							<li><i class="fa fa-calendar"></i>${fns:text('留言时间')}： <fmt:formatDate value="${guestbook.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></li>
							<li><i class="fa fa-envelope"></i>${fns:text('邮箱')}：${ guestbook.email}</li>
							<li><i class="fa fa-phone"></i>${fns:text('电话')}：${guestbook.phone}</li>
							<li><i class="fa fa-home"></i>${fns:text('单位')}：${guestbook.workunit}</li>
							<li><i class="fa fa-tags"></i>IP：${ guestbook.ip}</li>
						</ul>
					</div>
				</div>
				<h4 class="form-section">${fns:text('回复信息')}</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" >
								<span class="required">*</span> ${fns:text('回复内容')}：</label>
							<div class="col-sm-9">
								<form:textarea path="reContent" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${not empty guestbook.reDate}">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" >
								 ${fns:text('回复时间')}：</label>
							<div class="col-sm-3">
							<input  type="text" readonly="readonly"  disabled="disabled" maxlength="20" class="form-control Wdate"
									value="<fmt:formatDate value="${guestbook.reDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
				</c:if>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-xs-12">
						<div class="col-sm-offset-3 col-sm-9">
						<c:if test="${guestbook.status eq '4'}">
							<shiro:hasPermission name="cms:guestbook:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary" onclick="$('#status').val('0')"><i class="fa fa-check"></i> ${fns:text('通 过')}</button>&nbsp;
							<button id="btnSubmit2" type="submit" class="btn btn-primary"  onclick="$('#status').val('5')"><i class="fa fa-power-off"></i> ${fns:text('驳 回')}</button>&nbsp;
							</shiro:hasPermission>
						</c:if>
							<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
						</div>
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
			if ($("#reContent").val() == ""){
                $("#reContent").focus();
                showMessage('请填写回复内容', '警告','warning');
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
</script>