<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<sys:header title="查看知会结果" extLibs="${extLibs}" />
<style>
.title{line-height:30px;}
.content{text-indent:2em;}
</style>
<div style="margin:20px;">
	<div class="title">已知会人员</div>
	<div class="content">
		<c:if test="${empty notifyAllList }">无</c:if>
        <c:forEach items="${notifyAllList }" var="flowBusinessApproval" varStatus="stat">
			${flowBusinessApproval.approvalName }<c:if test="${!stat.last}">、</c:if>
        </c:forEach>
	</div>
	<div class="title">已读人员</div>
	<div class="content">
		<c:if test="${empty notifyReadList }">无</c:if>
		<c:forEach items="${notifyReadList }" var="flowBusinessApproval" varStatus="stat">
			${flowBusinessApproval.approvalName }<c:if test="${!stat.last}">、</c:if>
        </c:forEach>
    </div>
	<div class="title">未读人员</div>
	<div class="content">
		<c:if test="${empty notifyNotReadList }">无</c:if>
		<c:forEach items="${notifyNotReadList }" var="flowBusinessApproval" varStatus="stat">
			${flowBusinessApproval.approvalName }<c:if test="${!stat.last}">、</c:if>
        </c:forEach>
    </div>
</div>
<sys:footer extLibs="${extLibs}" />