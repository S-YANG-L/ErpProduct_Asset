<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="panel panel-default" id="dateControlsID">
    <div class="panel-heading">
        <h3 class="panel-title">日期控件</h3>
    </div>
    <div class="panel-body">
        <div class="row">
	        <div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="选择日期格式，勾选默认值则默认为当前时间">
	        		日期格式：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
                           
                           <c:set var="flag" value="0"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='date'}">
								<c:set var="flag" value="${map.value}"></c:set>
							</c:if>
						</c:forEach>
						
                           <select name="optionMap['date']" class="form-control" id="optionMapDate">
                           		<option value="">请选择</option>
							<c:forEach items="${fns:getDictList('form_date_format')}" var="dict">
								<option value="${dict.value}">${dict.name}</option>
							</c:forEach>
						</select>
						
						<script>
							var obj="${flag}";
                           	if(obj !=null && "" != obj){
					            $("#optionMapDate option").each(function() {
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
					<div class="col-sm-12">
						<c:choose>
							<c:when test="${empty (formEntityColumn.showOptions)}">
								<input type="checkbox" value="0" name="optionMap['dateDefault']" />默认值(当前时间)
							</c:when>
							<c:otherwise>
								<!-- 设置标记位 -->
								<c:set var="flag" value="0"></c:set>
								<c:forEach items="${formEntityColumn.optionMap}" var="map">
									<c:if test="${map.key=='dateDefault'}">
										<input type="checkbox" id="ddfcheckd" onchange="setCheckd('ddfcheckd');" name="optionMap['dateDefault']" value="0" <c:if test="${map.value=='0'}"> checked="checked" </c:if>  />默认值(当前时间)
										<c:set var="flag" value="1"></c:set>
										<input type="checkbox" id="noddfcheckd" name="optionMap['dateDefault']" value="" class="hide"/>
									</c:if>
								</c:forEach>
								
								<c:if test="${flag==0}">
									<input type="checkbox" value="0" name="optionMap['dateDefault']"/>默认值(当前时间)
								</c:if>
							</c:otherwise>
						</c:choose>
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
