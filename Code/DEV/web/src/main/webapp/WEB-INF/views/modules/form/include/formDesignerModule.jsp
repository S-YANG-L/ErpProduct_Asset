<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="moduleTitle" value="moduleTitle=\"${column.optionMap['selectorTitle']}\""/>      <!-- 弹窗组件-标题 -->
<c:set var="moduleUrl" value="moduleUrl=\"${column.optionMap['selectorUrl']}\""/>        		<!-- 弹窗组件-url -->
<c:set var="moduleMultiple" value="moduleMultiple=\"${column.optionMap['selectorMultipleChoice']}\"" />  <!-- 弹窗组件-是否多选 -->
<c:set var="moduleType" value="" />	  			<!-- 弹窗类型：用户组件、部门组件等 -->
<c:set var="moduleMode" value="" />				<!-- 弹窗方式：树形弹窗，列表弹窗 -->
<c:set var="allowClear" value="allowClear=\"${column.optionMap['allowClear']}\""/>     							<!-- 弹窗：是否可清除已选择内容 -->
<c:set var="allowInput" value="allowInput=\"${column.optionMap['allowInput']}\""/> 								<!-- 文本框可填写 -->
<c:set var="boxHeight" value="boxHeight=\"${column.optionMap['boxHeight']}\""/> 								<!-- 文本框高度 -->
<c:set var="boxWidth" value="boxWidth=\"${column.optionMap['boxWidth']}\""/> 									<!-- 文本框宽度 -->
<c:set var="isShowCode" value="isShowCode=\"${column.optionMap['isShowCode']}\""/> 								<!-- 是否显示编码 -->
<c:set var="returnFullPath" value="returnFullPath=\"${column.optionMap['returnFullPath']}\""/> 					<!-- 返回全路径 -->
<c:set var="returnFullPathSplit" value="returnFullPathSplit=\"${column.optionMap['returnFullPathSplit']}\""/> 	<!-- 返回全路径分割符 -->
<c:set var="isAll" value="isAll=\"${column.optionMap['isAll']}\""/> 											<!-- 是否显示全部 -->
<c:set var="relationLbName" value="labelName=\"${column.optionMap['relationLbName']}\"" />			<!-- 指定弹窗的labelName，存储中文名称 -->

<!-- 0.用户组件 -->
<c:if test="${column.optionMap['selectorType'] eq '0'}">
	<c:set var="moduleType" value="moduleType=\"selectUser\"" />
</c:if>
<!-- 1.部门组件 -->
<c:if test="${column.optionMap['selectorType'] eq '1'}">
	<c:set var="moduleType" value="moduleType=\"selectOffice\"" />
</c:if>
<!-- 2.公司组件 -->
<c:if test="${column.optionMap['selectorType'] eq '2'}">
	<c:set var="moduleType" value="moduleType=\"selectCompany\"" />
</c:if>
<!-- 3.岗位组件 -->
<%-- <c:if test="${column.optionMap['selectorType'] eq '3'}">
	<c:set var="moduleType" value="moduleType=\"selectPost\"" />
</c:if> --%>
<!-- 5.区域组件 -->
<c:if test="${column.optionMap['selectorType'] eq '5'}">
	<c:set var="moduleType" value="moduleType=\"selectArea\"" />
</c:if>
<!-- 6.自定义组件 -->
<c:if test="${column.optionMap['selectorType'] eq '6'}">
	<c:set var="moduleType" value="moduleType=\"selectCustom\"" />
</c:if>
<!-- 弹窗类型：1.树形弹窗，2.列表弹窗 -->
<c:if test="${column.showType eq '8' && column.optionMap['selector'] eq '1'}">
	<c:set var="moduleMode" value="moduleMode=\"1\"" />
</c:if>
<c:if test="${column.showType eq '8' && column.optionMap['selector'] eq '2'}">
	<c:set var="moduleMode" value="moduleMode=\"2\"" />
</c:if>