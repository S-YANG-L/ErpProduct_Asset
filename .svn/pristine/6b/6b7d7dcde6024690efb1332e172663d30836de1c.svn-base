<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称"%>
<%@ attribute name="value" type="java.util.Date" required="true" description="隐藏域值（年-月-日）"%>
<%@ attribute name="dateType" type="java.lang.String" required="false" description="1年;2年月;3年月日"%>
<%@ attribute name="yearName" type="java.lang.String" required="false" description="年"%>
<%@ attribute name="monthName" type="java.lang.String" required="false" description="月"%>
<%@ attribute name="dayName" type="java.lang.String" required="false" description="年"%>
<%@ attribute name="minYear" type="java.lang.Integer" required="false" description="最小年份"%>
<%@ attribute name="maxYear" type="java.lang.Integer" required="false" description="最大年份"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<input id="${id}" type="hidden" name="${name}" value="${fns:formatDate(value, 'yyyy-MM-dd')}"/>
<select id="${id}Year" name="${not empty yearName ? yearName : 'year'}" style="width:70px" class="${cssClass}"><option>年</option></select>
<c:if test="${empty dateType or dateType eq '2' or dateType eq '3'}">
&nbsp;<select id="${id}Month" name="${not empty monthName ? monthName : 'month'}" style="width:55px" class="${cssClass}"><option>月</option></select>
</c:if>
<c:if test="${dateType eq '3'}">
&nbsp;<select id="${id}Day" name="${not empty dayName ? dayName : 'day'}" style="width:55px" class="${cssClass}"><option>日</option></select>
</c:if>
<script type="text/javascript">
$(function(){
	$('#${id}').dateselect({
		selYear : $('#${id}Year'),
		selMonth : $('#${id}Month'),
		selDay : $('#${id}Day'),
		minYear : ${not empty minYear ? minYear : 0},
		maxYear : ${not empty maxYear ? maxYear : 0}
	});
})
</script>