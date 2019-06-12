<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 附件编号 -->
<c:set var="bizCategoryId" value="" />
<c:set var="bizCategory" value="" />
<c:if test="${not empty column.optionMap['bizCategory']}">
	<c:set var="bizCategory">
		bizCategory="${column.optionMap['bizCategory']}"
	</c:set>
	<c:set var="bizCategoryId" value="${column.optionMap['bizCategory']}"></c:set>
</c:if>
<!-- 上传文件类型 -->
<c:set var="uploadType" value="" />
<c:if test="${not empty column.optionMap['uploadType']}">
	<c:set var="uploadType">
		uploadType="${column.optionMap['uploadType']}"
	</c:set>
</c:if>
<!-- 是否只读模式 -->
<c:set var="readonly" value="" />
<c:if test="${column.optionMap['readonly'] eq '1'}">
	<c:set var="readonly">
		readonly="true"
	</c:set>
</c:if>
<!-- 附件最大上传个数 -->
<c:set var="maxUploadNum" value="" />
<c:if test="${not empty column.optionMap['maxUploadNum']}">
	<c:set var="maxUploadNum">
		maxUploadNum="${column.optionMap['maxUploadNum']}"
	</c:set>
</c:if>
<!-- 预览方式 -->
<c:set var="preview" value="" />
<c:if test="${!column.optionMap['preview']}">
	<c:set var="preview">
		preview="${column.optionMap['preview']}"
	</c:set>
</c:if>
<!-- 是否为精简上传 -->
<c:set var="isMini" value="" />
<c:if test="${column.optionMap['isMini'] eq '1'}">
	<c:set var="isMini">
		isMini="true"
	</c:set>
</c:if>
<!-- 允许上传的后缀 -->
<c:set var="allowSuffixs" value="" />
<c:if test="${not empty column.optionMap['allowSuffixs']}">
	<c:set var="allowSuffixs">
		allowSuffixs="${column.optionMap['allowSuffixs']}"
	</c:set>
</c:if>
<!-- 上传方式 -->
<c:set var="lazyUpload" value="" />
<c:if test="${column.optionMap['lazyUpload']}">
	<c:set var="lazyUpload">
		lazyUpload="true"
	</c:set>
</c:if>
<!-- 验证提示信息 -->
<c:set var="dataMsgRequired" value="" />
<c:if test="${not empty column.optionMap['dataMsgRequired']}">
	<c:set var="dataMsgRequired">
		dataMsgRequired="${column.optionMap['dataMsgRequired']}"
	</c:set>
</c:if>
<!-- css 类名，如果包含required则为必填 -->
<c:set var="requiredFileSpan" value="" />
<c:set var="requiredFile" value=""/>
<c:if test="${fn:contains(column.cssClass,'required')}">
	<c:set var="requiredFileSpan">
		<span class="required">*&nbsp;</span>
	</c:set>
	<c:set var="requiredFile" value="required "/>
</c:if>
<!-- css 类 -->
<c:set var="cssClass" value="${column.cssClass}"/>
<!-- css 样式 -->
<c:set var="cssStyle" value="" />
<c:if test="${not empty column.cssStyle}">
	<c:set var="cssStyle">
		style="${column.cssStyle}"
	</c:set>
</c:if>
<!-- image width -->
<c:set var="imageMaxWidth" value="" />
<c:if test="${not empty column.optionMap['imageMaxWidth']}">
	<c:set var="imageMaxWidth">
		imageMaxWidth="${column.optionMap['imageMaxWidth']}"
	</c:set>
</c:if>
<!-- image height -->
<c:set var="imageMaxHeight" value="" />
<c:if test="${not empty column.optionMap['imageMaxHeight']}">
	<c:set var="imageMaxHeight">
		imageMaxHeight="${column.optionMap['imageMaxHeight']}"
	</c:set>
</c:if>
