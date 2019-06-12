<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="panel panel-default" id="multiLineID">
    <div class="panel-heading">
        <h3 class="panel-title">多行文本</h3>
    </div>
    <div class="panel-body">
        <div class="row">
	        <div class="col-xs-6">
	        	<div class="form-group">
					<div class="col-sm-12">
						<c:choose>
							<c:when test="${empty (formEntityColumn.showOptions)}">
								<input type="checkbox" name="optionMap['textarea']" value="0" />是否富文本 
							</c:when>
							<c:otherwise>
								<!-- 设置标记位 -->
								<c:set var="flag" value="0"></c:set>
								
								<c:forEach items="${formEntityColumn.optionMap}" var="map">
									
									<c:if test="${map.key=='textarea'}">
										 <input type="checkbox" name="optionMap['textarea']" value="0" <c:if test="${map.value=='0'}"> checked="checked" </c:if>  />是否富文本
										<c:set var="flag" value="1"></c:set>
									</c:if>
								</c:forEach>
								
								<c:if test="${flag==0}">
									 <input type="checkbox" name="optionMap['textarea']" value="0" />是否富文本
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
	        	</div>
	        </div>
	        <div class="col-xs-6">
	        	<div class="form-group">
					<div class="col-sm-6">
						<div class="input-group">
							<div class="input-group-addon white-bg">&nbsp; 宽 &nbsp;</div>
							
							<c:choose>
								<c:when test="${empty (formEntityColumn.showOptions)}">
									<input name="optionMap['textareaWidth']" maxlength="200" class="form-control"/>
								</c:when>
								<c:otherwise>
									<!-- 设置标记位 -->
									<c:set var="flag" value="0"></c:set>
									
									<c:forEach items="${formEntityColumn.optionMap}" var="map">
										
										<c:if test="${map.key=='textareaWidth'}">
											<input name="optionMap['textareaWidth']" value="${map.value}" maxlength="500" class="form-control"/>
											<c:set var="flag" value="1"></c:set>
										</c:if>
									</c:forEach>
									
									<c:if test="${flag==0}">
										<input name="optionMap['textareaWidth']" maxlength="200" class="form-control"/>
									</c:if>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="input-group">
							<div class="input-group-addon white-bg">&nbsp; 高 &nbsp;</div>

							<c:choose>
								<c:when test="${empty (formEntityColumn.showOptions)}">
									<input name="optionMap['textareaheight']" maxlength="200" class="form-control"/>
								</c:when>
								<c:otherwise>
									<!-- 设置标记位 -->
									<c:set var="flag" value="0"></c:set>
									
									<c:forEach items="${formEntityColumn.optionMap}" var="map">
										
										<c:if test="${map.key=='textareaheight'}">
											<input name="optionMap['textareaheight']" value="${map.value}" maxlength="500" class="form-control"/>
											<c:set var="flag" value="1"></c:set>
										</c:if>
									</c:forEach>
									
									<c:if test="${flag==0}">
										<input name="optionMap['textareaheight']" maxlength="200" class="form-control"/>
									</c:if>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
	        </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    if (window.Select2 !== undefined){
		$("#centerPage select:not(.noselect2)").select2().on('change', function(){
			try{$(this).valid();}catch(e){}//未定义抛异常
		});
	}
	if (jQuery().uniform) {
		$("#centerPage input[type=checkbox], #centerPage input[type=radio]").uniform();
    }
</script>
