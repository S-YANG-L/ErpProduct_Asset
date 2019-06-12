<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/modules/cmsfront/include/taglib.jsp"%>
<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
<style type="text/css">.reply{border:1px solid #ddd;background:#fefefe;margin:10px;}</style>
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
			},
			errorContainer: form + " .messageBox",
			errorPlacement: function(error, element) {
				if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
					error.appendTo(element.parent().parent());
				} else {
					error.insertAfter(element);
				}
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

<h5>${fns:text('评论列表')}</h5>
<ul>
	<c:forEach items="${page.list}" var="comment">
		<li>
			<h6>
				${fns:text('姓名')}: ${comment.name} &nbsp;${fns:text('时间')}：
				<fmt:formatDate value="${comment.createDate}"
					pattern="yyyy-MM-dd HH:mm:ss" />
				<a href="javascript:comment('${comment.id}')">${fns:text('回复')}</a>
			</h6>
			<div>${comment.content}</div>
			<div id="commentForm${comment.id}" class="commentForm hide"></div>
		</li>
	</c:forEach>
	<c:if test="${fn:length(page.list) eq 0}">
		<li>${fns:text('暂时还没有人评论')}！</li>
	</c:if>
</ul>
<div class="pagination">${page}</div>
<div class="message">
<span>${fns:text('我要评论')}</span>
<div id="commentForm0"></div>
<script id="commentFormTpl" type="text/template"><!--/*-->
	<form:form action="${ctx}/comment" method="post">
		<input type="hidden" name="category.categoryCode" value="${comment.category.categoryCode}"/>
		<input type="hidden" name="contentId" value="${comment.contentId}"/>
		<input type="hidden" name="title" value="${comment.title}"/>
		<input type="hidden" name="replyId"/>
		<p>
			<label>${fns:text('内容')}：</label>
			<textarea name="content" cols="55" rows="4" maxlength="200" class="message_txt required"></textarea>
		</p>
		<p>
			<label>${fns:text('姓名')}：</label>
			<input type="text" name="name" maxlength="11" class="required" value="匿名"/>
			<label>${fns:text('验证码')}：</label><sys:validateCode name="validateCode" noRefresh="true"/>
			<input class="message_btn" type="submit" value="${fns:text('提 交')}"/>&nbsp;
		</p>
		<div class="alert alert-error messageBox" style="display:none">${fns:text('输入有误，请先更正')}。</div>
	</form:form><!--*/-->
</script>
</div>
