<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="extLibs" type="java.lang.String" required="false" description="扩展库（jbox、ztree、fileupload、validate、grid、tabpanel、ueditor、supcan）"%>
<%@ attribute name="useTheme" type="java.lang.String" required="false" description="使用主题风格，设置为true为当前主题，否则为主题名称，自动引用主题下的/include/head.jsp文件"%>
<c:set var="extLibs" value=",${extLibs}," />
<%-- 加载主题的footer.jsp文件 --%>
<c:choose><c:when test="${!fn:contains(extLibs, ',custom,') || (not empty useTheme && useTheme eq 'true')}">
	<c:set var="includeThemeName" value="${not empty useTheme && useTheme eq 'true' ? themeName : 'metronic'}"/>
	<jsp:include page="/WEB-INF/views/themes/${includeThemeName}/include/footer.jsp">
		<jsp:param name="extLibs" value="${extLibs}"/>
	</jsp:include>
</c:when><c:otherwise>
	<jsp:include page="/WEB-INF/views/include/jslibs.jsp">
		<jsp:param name="extLibs" value="${extLibs}"/>
	</jsp:include>
</c:otherwise></c:choose>