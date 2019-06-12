<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="dictTypeName" value=""/>	 <!-- 字典名称 -->
<c:set var="dictItems" value=""/>		 <!-- 下拉select -->
<c:set var="selectMultiple" value=""/>  <!-- 下拉，是否为多选 -->
<c:set var="selectType" value="" />     <!-- 下拉类型，1.字典，2.方法，3.sql -->
<c:set var="selectSql" value="" />      <!-- 数据源为SQL时 sql语句 -->
<c:set var="beanname" value="" />  		<!-- 数据源为类方法时：bean名称 -->
<c:set var="methodName" value="" /> 	<!-- 数据源为类方法时：方法名 -->

<!-- 下拉，是否为多选 -->
<c:if test="${not empty column.optionMap['selectorMultipleChoice']}">
	<c:set var="selectMultiple" value="multiple=\"true\""/>
</c:if>
<c:if test="${column.optionMap['selector'] eq '1'}">
	<c:set var="selectType" value="selectType=\"1\""/>
	<c:set var="dictTypeName">
	 	dictTypeName="${column.optionMap['selectDictType']}"
	</c:set>
</c:if>
<c:if test="${column.optionMap['selector'] eq '2'}">
	<c:set var="selectType" value="selectType=\"2\""/>
	<c:set var="beanname">
		beanname="${column.optionMap['selectPackage']}"
	</c:set>
	<c:set var="methodName">
		methodName="${column.optionMap['selectMethod']}"
	</c:set>
</c:if>
<c:if test="${column.optionMap['selector'] eq '3'}">
	<c:set var="selectType" value="selectType=\"3\""/>
	<c:set var="selectSql" >
		selectSql="${column.optionMap['selectSql']}"
	</c:set>
</c:if>
<!-- 下拉 -->            	 
<c:if test="${not empty column.optionMap['selector']}">
	<c:set var="dictItems" value=" dictItems "/>
</c:if>
<!-- 单选按钮 字典 -->
<c:if test="${not empty column.optionMap['radio']}">
	<c:set var="dictTypeName">
		dictTypeName="${column.optionMap['radio']}"
	</c:set>
	<c:set var="dictItems" value=" radioDictItems "/>
</c:if>
<!-- 多选按钮 字典 -->
<c:if test="${not empty column.optionMap['checkbox']}">
	<c:set var="dictTypeName">
		dictTypeName="${column.optionMap['checkbox']}"
	</c:set>
	<c:set var="dictItems" value=" checkboxDictItems "/>
</c:if>