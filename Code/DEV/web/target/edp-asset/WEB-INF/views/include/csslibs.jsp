<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="${param.extLibs}" />
<%-- Global Constant --%>
<script type="text/javascript">
	var ctxPath = '${ctxPath}', ctx = '${ctx}', ctxStatic='${ctxStatic}', lang = '${fns:lang()}', Global = {${fns:getConst('Global.Fields')}};
</script>
<%-- jQuery Library --%>
<c:if test="${fn:contains(extLibs, ',jquery,') || !fn:contains(extLibs, ',custom,')}">
	<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
</c:if>
<%-- Fonts CSS，非自定义设置时默认加载 --%>
<c:if test="${fn:contains(extLibs, ',fonts,') || !fn:contains(extLibs, ',custom,')}">
	<link href="${ctxStatic}/fonts/fonts-common.min.css?${_version}" rel="stylesheet" type="text/css"/>
</c:if>
<%-- jBox CSS，非自定义设置时默认加载 --%>
<c:if test="${fn:contains(extLibs, ',jbox,') || !fn:contains(extLibs, ',custom,')}">
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.css?${_version}" rel="stylesheet" type="text/css"/>
</c:if>
<%-- zTree CSS --%>
<c:if test="${fn:contains(extLibs, ',ztree,')}">
	<link href="${ctxStatic}/jquery-ztree/3.5.12/css/metro/zTreeStyle.css?${_version}" rel="stylesheet" type="text/css"/>
</c:if>
<%-- WebUploader CSS --%>
<c:if test="${fn:contains(extLibs, ',fileupload,') || fn:contains(extLibs, ',webuploader,')}">
	<link href="${ctxStatic}/webuploader/0.1.5/webuploader.css?${_version}" rel="stylesheet" type="text/css"  />
	<link href="${ctxStatic}/webuploader/attachment/css/webuploader.extend.css?${_version}" rel="stylesheet" type="text/css"  />
</c:if>
<%-- jqGrid DataGrid CSS --%>
<c:if test="${fn:contains(extLibs, ',grid,') || fn:contains(extLibs, ',datagrid,')}">
	<link href="${ctxStatic}/jqGrid/4.7/css/ui.jqgrid.css?${_version}" rel="stylesheet"/>
</c:if>
<%-- wdScrollTab TabPanel CSS --%>
<c:if test="${fn:contains(extLibs, ',tabpanel,')}">
	<link href="${ctxStatic}/wdScrollTab/css/bootstrap/TabPanel.css?${_version}" rel="stylesheet" type="text/css" /> 
</c:if>
<%-- Common CSS--%>
<c:if test="${fn:contains(extLibs, ',jeesite,') || !fn:contains(extLibs, ',custom,')}">
	<link href="${ctxStatic}/common/jeesite.css?${_version}" rel="stylesheet"/>
	<link href="${ctxStaticTheme}/common/theme.css?${_version}" rel="stylesheet"/>
	<link href="${ctxStatic}/common/common.css?${_version}" rel="stylesheet"/>
</c:if>