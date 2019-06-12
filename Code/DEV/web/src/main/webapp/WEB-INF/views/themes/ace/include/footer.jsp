<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="${param.extLibs}" />
<jsp:include page="/WEB-INF/views/include/jslibs.jsp">
	<jsp:param name="extLibs" value="${extLibs}"/>
</jsp:include>
<script src="${ctxStaticTheme}/js/bootstrap.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace-extra.js?${_version}"></script>
<script src="${ctxStaticTheme}/js/ace/ace.js?${_version}"></script>