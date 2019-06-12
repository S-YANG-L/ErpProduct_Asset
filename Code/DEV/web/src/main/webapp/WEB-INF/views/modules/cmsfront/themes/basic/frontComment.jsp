<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
<style type="text/css">
	.content-comment h5 {border-left:2px solid #d6d6d6;background-color:#ececec;padding:3px;margin:18px 0;line-height:20px;font-size:14px;}
	.content-comment h6 {padding:0;margin:10px 0;font-size:11.9px;color:#333;}
	.content-comment .form-horizontal .control-group {margin-bottom:15px;}
	.content-comment .form-horizontal .control-label {float:left;width:130px;padding-top:5px;text-align:right;}
	.content-comment .form-horizontal .controls {margin-left:150px;}
	.content-comment .reply{border:1px solid #ddd;padding:3px 8px;margin:10px;background:#fefefe;}
</style>
<div class="content-comment">
	<h5><strong>${fns:text('评论列表')}</strong></h5>
	<ul>
		<c:forEach items="${page.list}" var="comment">
			<li>
				<h6><strong>${fns:text('姓名')}: ${comment.name} &nbsp;${fns:text('时间')}：<fmt:formatDate value="${comment.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					&nbsp; <a href="javascript:comment('${comment.id}')">${fns:text('回复')}</a></strong></h6>
				<div>${comment.content}</div>
				<div id="commentForm${comment.id}" class="commentForm" style="display:none;"></div>
			</li>
		</c:forEach>
		<c:if test="${fn:length(page.list) eq 0}">
			<li>${fns:text('暂时还没有人评论')}！</li>
		</c:if>
	</ul>
	<div class="pagination">${page}</div>
	<h5><strong>${fns:text('我要评论')}</strong></h5>
	<div id="commentForm0"></div>
</div>
<script id="commentFormTpl" type="text/template"><!--/*-->
	<form:form action="${ctx}/comment" method="post" class="form-horizontal">
		<input type="hidden" name="category.categoryCode" value="${comment.category.categoryCode}"/>
		<input type="hidden" name="contentId" value="${comment.contentId}"/>
		<input type="hidden" name="title" value="${comment.title}"/>
		<input type="hidden" name="corpCode" value="${comment.corpCode}"/>
		<input type="hidden" name="corpName" value="${comment.corpName}"/>
		<input type="hidden" name="replyId"/>
		<div class="control-group">
			<label class="control-label">${fns:text('留言内容')}:</label>
			<div class="controls" style="position: relative;">
				<textarea name="content" rows="4" maxlength="200" class="txt required" style="width:450px;"></textarea>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">${fns:text('验证码')}:</label>
			<div class="controls" style="position: relative;">
				<sys:validateCode name="validateCode" isLazy="true" inputCssStyle="width:105px;"/>
				<label class="mid" style="display:inline;">&nbsp;&nbsp;&nbsp;${fns:text('姓名')}:</label>
				<input type="text" name="name" maxlength="11" class="txt required" style="width:75px;" value="${not empty comment.currentUser.userName ? comment.currentUser.userName : '匿名'}"/>
				<input class="btn mid" type="submit" value="${fns:text('提 交')}"/>&nbsp;
			</div>
		</div>
	</form:form><!--*/-->
</script>
<script type="text/javascript">
	$(document).ready(function() {
		comment(0);
	});
	function commentForm(form){
		$(form).validate({
			rules: {
				validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
			},
			messages: {
				content: {required: "${fns:text('请填写评论内容')}"},
				validateCode: {remote: "${fns:text('验证码不正确')}", required: "${fns:text('请填写验证码')}"}
			},
			submitHandler: function(form){
			    $.post($(form).attr("action"), $(form).serialize(), function(data){
			    	data = eval("("+data+")");
			    	alert(data.message);
			    	if (data.result==1){
			    		page(1);
			    	}
			    });
			}
		});
	}
	function comment(id){
		if ($("#commentForm"+id).html()==""){
			$(".commentForm").hide(500,function(){$(this).html("");});
			$("#commentForm"+id).html($("#commentFormTpl").html()).show(500);
			$("#commentForm"+id+" input[name='replyId']").val(id);
			commentForm("#commentForm"+id + " form");
			$(".validateCodeRefresh").click();
		}else{
			$("#commentForm"+id).hide(500,function(){$(this).html("");});
		}
	}
</script>