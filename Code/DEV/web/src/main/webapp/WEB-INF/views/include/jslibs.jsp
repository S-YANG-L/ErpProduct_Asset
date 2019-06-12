<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="${param.extLibs}" />
<%-- jBox JS，非自定义设置时默认加载 --%>
<c:if test="${fn:contains(extLibs, ',jbox,') || !fn:contains(extLibs, ',custom,')}">
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?${_version}"></script>
	<script src="${ctxStatic}/jquery-jbox/2.3/i18n/jquery.jBox-${fns:lang()}.js?${_version}"></script>
</c:if>
<%-- My97Date JS，非自定义设置时默认加载 --%>
<c:if test="${fn:contains(extLibs, ',my97date,') || !fn:contains(extLibs, ',custom,')}">
	<script src="${ctxStatic}/My97DatePicker/WdatePicker.js?${_version}"></script>
</c:if>
<%-- zTree JS --%>
<c:if test="${fn:contains(extLibs, ',ztree,')}">
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js?${_version}"></script>
</c:if>
<%-- WebUploader JS --%>
<c:if test="${fn:contains(extLibs, ',fileupload,') || fn:contains(extLibs, ',webuploader,')}">
	<script src="${ctxStatic}/webuploader/0.1.5/webuploader.js?${_version}"></script>
	<script src="${ctxStatic}/webuploader/attachment/js/webuploader.extend.js?${_version}"></script>
</c:if>
<%-- Validate JS --%>
<c:if test="${fn:contains(extLibs, ',validate,')}">
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.js?${_version}"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js?${_version}"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/localization/messages_${fns:lang()}.js?${_version}"></script>
</c:if>
<%-- InputMask JS --%>
<c:if test="${fn:contains(extLibs, ',inputmask,')}">
	<script src="${ctxStatic}/jquery-plugin/jquery.inputmask.bundle.js?${_version}"></script>
</c:if>
<%-- jqGrid DataGrid JS --%>
<c:if test="${fn:contains(extLibs, ',grid,') || fn:contains(extLibs, ',datagrid,')}">
	<script src="${ctxStatic}/jqGrid/4.7/js/jquery.jqGrid.js?${_version}"></script>
	<script src="${ctxStatic}/jqGrid/4.7/js/jquery.jqGrid.extend.js?${_version}"></script>
	<script src="${ctxStatic}/jqGrid/4.7/js/i18n/grid.locale-${fns:lang()}.js?${_version}"></script>
</c:if>
<%-- wdScrollTab TabPanel JS --%>
<c:if test="${fn:contains(extLibs, ',tabpanel,')}">
	<script src="${ctxStatic}/wdScrollTab/js/TabPanel.js?${_version}"></script>
</c:if>
<%-- PinYin JS --%>
<c:if test="${fn:contains(extLibs, ',pinyin,')}">
	<script src="${ctxStatic}/assets/global/plugins/jquery-select2/pinyin.min.js?${_version}"></script>
</c:if>
<%-- Baidu UEditor JS --%>
<c:if test="${fn:contains(extLibs, ',ueditor,')}">
	<script src="${ctxStatic}/ueditor/1.4.3/ueditor.config.js?${_version}"></script>
	<script src="${ctxStatic}/ueditor/1.4.3/ueditor.all.min.js?${_version}"></script>
	<script src="${ctxStatic}/ueditor/1.4.3/lang/${fns:lang()}/${fns:lang()}.js?${_version}"></script>
</c:if>
<%-- Common JS --%>
<c:if test="${fn:contains(extLibs, ',jeesite,') || !fn:contains(extLibs, ',custom,')}">
	<script src="${ctxStatic}/common/messages/i18n_${fns:lang()}.js"></script>
	<script src="${ctxStatic}/common/jeesite.js?${_version}"></script>
	<script src="${ctxStaticTheme}/common/theme.js?${_version}"></script>
	<script src="${ctxStatic}/common/common.js?${_version}"></script>
</c:if>