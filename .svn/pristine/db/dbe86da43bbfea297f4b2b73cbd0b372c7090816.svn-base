<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="requiredSpan" value=""/>	<!-- 必填span，在标签前加红色* -->
<c:set var="validateCss" value=""/>
<%-- <c:set var="digitsVal" value=""/>
<c:set var="numberVal" value=""/>
<c:set var="phoneVal" value=""/>
<c:set var="emailVal" value=""/>
<c:set var="urlVal" value=""/>
<c:set var="dateVal" value=""/> --%>

<c:set var="regexCheckVal" value=""/>  <!-- 是否正则表达式验证 -->
<c:set var="regexCheckHtml" value="" />  <!-- 如果为正则表达式验证，则验证方法 -->
<c:if test="${fn:contains(column.validType, 'required')}">
<c:set var="requiredSpan" >
	<span class="required">*&nbsp;</span>
</c:set>
</c:if>
<c:if test="${not empty column.validType}">
	<c:set var="validateCss" value="${column.validType}"/>
</c:if>
<%-- <c:if test="${fn:contains(column.validType, 'digits')}">
	<c:set var="digitsVal" value="digits " />
</c:if>
<c:if test="${fn:contains(column.validType, 'number')}">
	<c:set var="numberVal" value="number " />
</c:if>
<c:if test="${fn:contains(column.validType, 'phone')}">
	<c:set var="phoneVal" value="phone " />
</c:if>
<c:if test="${fn:contains(column.validType, 'email')}">
	<c:set var="emailVal" value="email " />
</c:if>
<c:if test="${fn:contains(column.validType, 'url')}">
	<c:set var="urlVal" value="url " />
</c:if>
<c:if test="${fn:contains(column.validType, 'date')}">
	<c:set var="dateVal" value=" date " />
</c:if> --%>

<c:if test="${not empty column.validRegx}">
	<c:set var="regexCheckVal" value=" regexCheck " />
	<c:set var="regexCheckHtml">
		onblur="regexCheckInput('${column.validRegx}','${columnName}','')"
	</c:set>
</c:if>

