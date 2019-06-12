<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 循环 -->
<c:forEach items="${extendColumnList}" var="column">
<!-- 默认设置[默认值、默认css样式、默认style、id、name] -->
<%@ include file="/WEB-INF/views/modules/form/include/formDesignerDefault.jsp"%>
<!-- 附件上传 -->
<%@ include file="/WEB-INF/views/modules/form/include/formDesignerFileUpload.jsp"%>
<div class="box box-element ui-draggable">
	<a href="#close" class="remove label label-danger"> <i class="glyphicon glyphicon-remove"></i> 删除
	</a> <span class="drag label label-default"> <i
		class="glyphicon glyphicon-move"></i> 拖动
	</span> <span class="configuration"> <span
		class="btn-group btn-group-xs layout3"> <input
			type="text" class="fileUploadId" value="${bizCategoryId}" style="width: 130px;" />
	</span> <span class="btn-group btn-group-xs layout2"> <select
			class="noselect2 layouttype" title="布局方式">
				<option value="">默认</option>
				<option value="4 8">4 8</option>
				<option value="2 10" selected="selected">2 10</option>
		</select>
	</span>
	</span>

	<div class="preview">${columnComment}</div>
	<div class="view">
		<div class="form-group">
			<label class="control-label col-sm-2" contenteditable="true"
				title=""> ${requiredFileSpan}${columnComment}：<i class="fa icon-question hide"></i></label>
			<div class="col-sm-10">
				<input type="file" id="${columnId}" class="form-control field upload permiConfig ${cssClass}" ${tableName} ${isVirtual} />
			</div>
		</div>
	</div>
</div>
</c:forEach>