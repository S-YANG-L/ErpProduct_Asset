<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="type" type="java.lang.String" required="false" description="控件类型（text、textarea）"%>
<%@ attribute name="rows" type="java.lang.String" required="false" description="行数"%>
<%@ attribute name="cols" type="java.lang.String" required="false" description="列数"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="列数"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="列数"%>
<c:if test="${not empty type && type eq 'text'}">
	<input type="text" name="_taskComment" id="_taskComment" class="${empty cssClass ? 'form-control' : cssClass}" style="${cssStyle}" />
</c:if>
<c:if test="${empty type || type eq 'textarea'}">
	<textarea name="_taskComment" id="_taskComment" maxlength="2000" class="${empty cssClass ? 'form-control' : cssClass}" rows="${not empty rows ? rows : 3}" cols="${not empty cols ? cols : 50}" style="${cssStyle}"></textarea>
</c:if>