<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="row">
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 弹框宽度：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8">
				<c:choose>
					<c:when test="${empty (formEntityColumn.showOptions)}">
						<input name="optionMap['boxWidth']" value="300" class="form-control digits" />
					</c:when>
					<c:otherwise>
						<!-- 设置标记位 -->
						<c:set var="flag" value="0"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='boxWidth'}">
								<input name="optionMap['boxWidth']" class="form-control digits" value="${map.value}" />
								<c:set var="flag" value="1"></c:set>
							</c:if>
						</c:forEach>
						<c:if test="${flag==0}">
							<input name="optionMap['boxWidth']" value="300" class="form-control digits" />
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 弹框高度：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8 input-group">
				<c:choose>
					<c:when test="${empty (formEntityColumn.showOptions)}">
						<input name="optionMap['boxHeight']" value="400" class="form-control digits" />
					</c:when>
					<c:otherwise>
						<!-- 设置标记位 -->
						<c:set var="flag" value="0"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='boxHeight'}">
								<input name="optionMap['boxHeight']" class="form-control digits" value="${map.value}" />
								<c:set var="flag" value="1"></c:set>
							</c:if>
						</c:forEach>
						<c:if test="${flag==0}">
							<input name="optionMap['boxHeight']" value="400" class="form-control digits" />
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
  <div class="row">
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 默认展开层级：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8">
				<c:choose>
					<c:when test="${empty (formEntityColumn.showOptions)}">
						<input name="optionMap['showLevel']" class="form-control digits" range="0,8"/>
					</c:when>
					<c:otherwise>
						<!-- 设置标记位 -->
						<c:set var="flag" value="0"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='showLevel'}">
								<input name="optionMap['showLevel']" class="form-control digits" range="0,8" value="${map.value}" />
								<c:set var="flag" value="1"></c:set>
							</c:if>
						</c:forEach>
						<c:if test="${flag==0}">
							<input name="optionMap['showLevel']" class="form-control digits" range="0,8" />
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 是否显示编码：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8 input-group">
			
				<c:set var="isShowCodeVal" value="false"></c:set>
				<c:forEach items="${formEntityColumn.optionMap}" var="map">
					<c:if test="${map.key=='isShowCode'}">
						<c:set var="isShowCodeVal" value="${map.value}"></c:set>
					</c:if>
				</c:forEach>

				<select name="optionMap['isShowCode']" class="form-control" id="isShowCodeSel">
					<option value="">请选择</option>
					<c:forEach items="${fns:getDictList('form_window_select_showcode')}" var="dict">
						<option value="${dict.value}" title="${dict.name}" >${dict.name}</option>
					</c:forEach>
				</select>

				<script>
					var obj = "${isShowCodeVal}";
					if (obj != null && "" != obj) {
						$("#isShowCodeSel option").each(function() {
							if ($(this).val() == obj) {
								$(this).attr("selected", "selected");
							}
						});
					}
				</script>
			</div>
		</div>
	</div>
</div>
  <div class="row">
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 是否允许清除：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8">
				<c:set var="allowClearVal" value="true"></c:set>
				<c:forEach items="${formEntityColumn.optionMap}" var="map">
					<c:if test="${map.key=='allowClear'}">
						<c:set var="allowInputVal" value="${map.value}"></c:set>
					</c:if>
				</c:forEach>

				<select name="optionMap['allowClear']" class="form-control" id="allowClearSel">
					<option value="">请选择</option>
					<c:forEach items="${fns:getDictList('form_true_fasle')}" var="dict">
						<option value="${dict.value}" title="${dict.name}" >${dict.name}</option>
					</c:forEach>
				</select>

				<script>
					var obj = "${allowClearVal}";
					if (obj != null && "" != obj) {
						$("#allowClearSel option").each(function() {
							if ($(this).val() == obj) {
								$(this).attr("selected", "selected");
							}
						});
					}
				</script>
			</div>
		</div>
	</div>
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 文本框可填写：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8 input-group">

				<c:set var="allowInputVal" value="true"></c:set>
				<c:forEach items="${formEntityColumn.optionMap}" var="map">
					<c:if test="${map.key=='allowInput'}">
						<c:set var="allowInputVal" value="${map.value}"></c:set>
					</c:if>
				</c:forEach>

				<select name="optionMap['allowInput']" class="form-control" id="allowInputSel">
					<option value="">请选择</option>
					<c:forEach items="${fns:getDictList('form_true_fasle')}" var="dict">
						<option value="${dict.value}" title="${dict.name}" >${dict.name}</option>
					</c:forEach>
				</select>

				<script>
					var obj = "${allowInputVal}";
					if (obj != null && "" != obj) {
						$("#allowInputSel option").each(function() {
							if ($(this).val() == obj) {
								$(this).attr("selected", "selected");
							}
						});
					}
				</script>
			</div>
		</div>
	</div>
</div>
  <div class="row">
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 是否返回全路径：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8">

				<c:set var="returnFullPathVal" value="false"></c:set>
				<c:forEach items="${formEntityColumn.optionMap}" var="map">
					<c:if test="${map.key=='allowInput'}">
						<c:set var="returnFullPathVal" value="${map.value}"></c:set>
					</c:if>
				</c:forEach>
				<select name="optionMap['returnFullPath']" class="form-control" id="returnFullPathSel">
					<option value="">请选择</option>
					<c:forEach items="${fns:getDictList('form_true_fasle')}" var="dict">
						<option value="${dict.value}" title="${dict.name}" >${dict.name}</option>
					</c:forEach>
				</select>

				<script>
					var obj = "${returnFullPathVal}";
					if (obj != null && "" != obj) {
						$("#returnFullPathSel option").each(function() {
							if ($(this).val() == obj) {
								$(this).attr("selected", "selected");
							}
						});
					}
				</script>
			</div>
		</div>
	</div>
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title=""> 分隔符：<i
				class="fa icon-question hide"></i></label>
			<div class="col-sm-8 input-group">
				<c:choose>
					<c:when test="${empty (formEntityColumn.showOptions)}">
						<input name="optionMap['returnFullPathSplit']" value="/" class="form-control" />
					</c:when>
					<c:otherwise>
						<!-- 设置标记位 -->
						<c:set var="flag" value="0"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='returnFullPathSplit'}">
								<input name="optionMap['returnFullPathSplit']" class="form-control" value="${map.value}" />
								<c:set var="flag" value="1"></c:set>
							</c:if>
						</c:forEach>
						<c:if test="${flag==0}">
							<input name="optionMap['returnFullPathSplit']" value="/" class="form-control" />
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    if (window.Select2 !== undefined){
		$("#extendDiv select:not(.noselect2)").select2().on('change', function(){
			try{$(this).valid();}catch(e){}//未定义抛异常
		});
	}
	if (jQuery().uniform) {
		$("#extendDiv input[type=checkbox], #centerPage input[type=radio]").uniform();
    }
</script>
		