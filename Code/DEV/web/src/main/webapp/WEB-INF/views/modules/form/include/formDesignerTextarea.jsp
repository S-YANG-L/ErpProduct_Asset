<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="textAreaVal" value=""/>	 	 <!-- 是否富文本 -->
<c:set var="textAreaWidth" value=""/>	 <!-- 多行文本宽度 -->
<c:set var="textAreaHeight" value=""/>   <!-- 多行文本高度 -->
<c:if test="${column.optionMap['textarea'] eq '0'}"> 
	<c:set var="textAreaVal" value="textarea "/>
</c:if>
<c:if test="${not empty column.optionMap['textareaWidth']}"> 
	<c:set var="textAreaWidth">
		width="${column.optionMap['textareaWidth']}"
	</c:set>
</c:if>
<c:if test="${not empty column.optionMap['textareaheight']}"> 
	<c:set var="textAreaHeight">
		height="${column.optionMap['textareaheight']}"
	</c:set>
</c:if>