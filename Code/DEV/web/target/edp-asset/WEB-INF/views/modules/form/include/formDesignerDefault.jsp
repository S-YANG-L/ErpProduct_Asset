<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="defaultValue" value="${column.defaultValue}" />		<!-- 默认值 -->
<c:set var="cssClassName" value="${column.cssClass}" />		<!-- css类名 -->
<c:set var="cssStyleContent" value="" />	<!-- css样式 -->
<c:set var="isVirtual" value="isVirtual=\"${not empty column.isVirtual?column.isVirtual:0}\"" />
<c:if test="${not empty column.cssStyle}">
	<c:set var="cssStyleContent" >
		style="${column.cssStyle}"
	</c:set>
</c:if>
<!-- id -->
<c:set var="columnId" value="${column.formTableColumn.columnName}" />
<!-- name -->
<c:set var="columnName" value="formMap[${column.formTableColumn.columnName}]" />
<!-- columnComment -->
<c:set var="columnComment" value="${column.formTableColumn.columnComment}" />
<!-- 表名 -->
<c:set var="tableComment" value="${column.formTableColumn.tableComment}" />
<!-- 表英文名 -->
<c:set var="tableName">
	tableName="${column.formTableColumn.tableName}"
</c:set>
