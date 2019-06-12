<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 循环 -->
<c:forEach items="${columnList}" var="column">
   	 
   	 <!-- 多行文本[普通多行文本、富文本] -->
   	 <%@ include file="/WEB-INF/views/modules/form/include/formDesignerTextarea.jsp"%>
   	 <!-- 下拉框、单选、复选[需要进行选择的指定选择类型、字典名称等] -->
   	 <%@ include file="/WEB-INF/views/modules/form/include/formDesignerSelector.jsp"%>
   	 <!-- 验证类[必填、数值、手机号、邮箱等] -->
   	 <%@ include file="/WEB-INF/views/modules/form/include/formDesignerValidate.jsp"%>
   	 <!-- 弹窗类[用户选择、部门选择、区域选择、自定义等] -->
   	 <%@ include file="/WEB-INF/views/modules/form/include/formDesignerModule.jsp"%>
   	 <!-- 默认设置[默认值、默认css样式、默认style] -->
   	 <%@ include file="/WEB-INF/views/modules/form/include/formDesignerDefault.jsp"%>
   	 
   	
  <div class="box box-element ui-draggable">
          <a href="#close" class="remove label label-danger">
            <i class="glyphicon glyphicon-remove"></i>
            	删除
          </a>
		<span class="drag label label-default">
			<i class="glyphicon glyphicon-move"></i>
			拖动
		</span>
       <span class="configuration">
       	   <c:if test="${column.showType eq '11'}">
				<span class="btn-group btn-group-xs layout3">
					<input type="text" class="fileUploadId" value="formdef01" />
				</span>
       	   </c:if>
	       <span class="btn-group btn-group-xs layout4">
				<select class="noselect2 otherConfig" title="其它配置">
					<option value="">其它配置</option>
					<c:forEach items="${fns:getDictList('form_other_config')}" var="dict">
						<option value="${dict.value}">${dict.label}</option>
					</c:forEach>
				</select>
		   </span>   	   
	       <span class="btn-group btn-group-xs layout2">
				<select class="noselect2 layouttype" title="布局方式">
					<option value="">布局方式</option>
					<option value="4 8" selected="selected">4 8</option>
					<option value="2 10">2 10</option>
				</select>
			</span>
	       <span class="btn-group btn-group-xs configField">
				<button id="btnConfigField" type="button" class="configField" title="业务实体字段配置">字段配置</button>
			</span>
          </span>

   <div class="preview" title="${tableComment}-${columnComment}(${fns:getDictLabel(column.showType, 'form_tag_type', '未配置')})">${columnComment}</div>
   		<div class="view">
	<div class="form-group <c:if test="${column.showType eq '1'}">hideDomain</c:if>">
	<label contenteditable="true" class="control-label col-sm-4" title="${columnComment}">
		${requiredSpan}${columnComment}：<i class="fa icon-question hide"></i></label>
	<div class="col-sm-8">
		<c:choose>
			<c:when test="${column.showType eq '0'}">
				<!-- 单行文本 -->
				<input type="text" id="${columnId}" name="${columnName}" value="" columnType="${column.showType}" class="form-control field permiConfig singleText ${validateCss} ${cssClassName}" ${cssStyleContent} ${tableName} ${isVirtual} />
			</c:when>
			<c:when test="${column.showType eq '1'}">
				<!-- 隐藏域 -->
				<input type="text" id="${columnId}" name="${columnName}" value="" columnType="${column.showType}" class="form-control field permiConfig hideDomain ${validateCss} ${cssClassName} " ${cssStyleContent} ${tableName} ${isVirtual} />
			</c:when>
			<c:when test="${column.showType eq '2'}">
				<!-- 多行文本  0.富文本-->
				<textarea id="${columnId}" name="${columnName}" columnType="${column.showType}" class="form-control field permiConfig textarea ${validateCss} ${cssClassName} " ${textAreaWidth} ${textAreaHeight} ${cssStyleContent} ${tableName} ${isVirtual} ></textarea>
			</c:when>
			<c:when test="${column.showType eq '3'}">
				<!-- 下拉选择框(多选) -->
				<select id="${columnId}" name="${columnName}" columnType="${column.showType}" class="form-control field permiConfig noselect2 dictItems ${validateCss} ${cssClassName} " ${selectMultiple} ${cssStyleContent} ${tableName} ${isVirtual} >
					<option value=""></option>
				</select>
			</c:when>
			<c:when test="${column.showType eq '5'}">
				<!-- 复选框 -->
				<span id="${columnId}" name="${columnName}" columnType="${column.showType}" class="permiConfig field cbox radioChkBtn checkboxDictItems ${validateCss} ${cssClassName} " ${cssStyleContent} ${tableName} ${isVirtual} >
					<input type="checkbox" id="${columnId}" name="${columnName}" class="cbox radioChkBtn"/>是
					<input type="checkbox" id="${columnId}" name="${columnName}" class="cbox radioChkBtn"/>否
				</span>
			</c:when>
			<c:when test="${column.showType eq '6'}">
				<!-- 单选框 -->
				<span id="${columnId}" name="${columnName}" columnType="${column.showType}" class="permiConfig field star radioChkBtn radioDictItems ${validateCss} ${cssClassName} " ${cssStyleContent} ${tableName} ${isVirtual} >
					<input type="radio" id="${columnId}" name="${columnName}" class="star radioChkBtn"/>是
					<input type="radio" id="${columnId}" name="${columnName}" class="star radioChkBtn"/>否
				</span>
			</c:when>
			<c:when test="${column.showType eq '7'}">
				<!-- 日期控件 -->
				<input type="text" id="${columnId}" name="${columnName}" columnType="${column.showType}" class="form-control field permiConfig Wdate ${validateCss} ${dateVal} ${cssClassName} " readonly="readonly" onclick="WdatePicker({dateFmt:'${column.optionMap['date']}',isShowClear:false});" value="<fmt:formatDate value="${column.optionMap['currDate']}" pattern="${column.optionMap['date']}"/>" ${cssStyleContent}  ${tableName} ${isVirtual} />
			</c:when>
			<c:when test="${column.showType eq '8'}">
				<!-- 弹窗组件 -->
				<input type="text" id="${columnId}" name="${columnName}" columnType="${column.showType}" readonly="readonly" class="form-control field permiConfig selectModule ${dictItems} ${validateCss} ${cssClassName} " ${cssStyleContent} ${tableName} ${isVirtual} />
			</c:when>
			<c:when test="${column.showType eq '11'}">
				<!-- 文件上传 -->
				<input type="file" id="${columnId}" name="${columnName}" columnType="${column.showType}" bizCategory="${columnName}" class="fileUpload field permiConfig upload ${dictItems} ${validateCss} ${cssClassName} " ${cssStyleContent} ${tableName} ${isVirtual} />
			</c:when>
			<c:when test="${column.showType eq '12'}">
				<!-- 标签控件 -->
				<label id="${columnId}" name="${columnName}" columnType="${column.showType}" class="labelShow permiConfig ${cssClassName}" ${cssStyleContent} ${tableName} ${isVirtual} >标签名称</label>
			</c:when>
			<c:otherwise>
				<font color="red">还没有进行业务实体配置</font>				
			</c:otherwise>
		</c:choose>
	</div>
</div>
         </div>
       </div>
</c:forEach>