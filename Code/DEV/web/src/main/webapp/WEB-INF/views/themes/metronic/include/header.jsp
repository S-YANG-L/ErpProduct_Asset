<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%-- <link href="${ctxStatic}/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/assets/global/plugins/select2/select2.css" rel="stylesheet" type="text/css"/> --%>
<link href="${ctxStatic}/assets/global/plugins/common.min.css?${_version}" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic}/assets/global/css/metronic.min.css?${_version}" rel="stylesheet" type="text/css"/>
<c:set var="extLibs" value="${param.extLibs}" />
<jsp:include page="/WEB-INF/views/include/csslibs.jsp">
	<jsp:param name="extLibs" value="${extLibs}"/>
</jsp:include>
<!--[if lte IE 8]><script src="${ctxStatic}/common/respond.min.js"></script><![endif]-->