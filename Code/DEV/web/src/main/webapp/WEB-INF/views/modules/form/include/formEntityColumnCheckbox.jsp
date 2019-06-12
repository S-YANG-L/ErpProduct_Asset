<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="panel panel-default" id="dropdownID">
    <div class="panel-heading">
        <h3 class="panel-title">复选框</h3>
    </div>
    <div class="panel-body">
    	<div class="row">
    		<div class="col-xs-12">
	        	<div class="form-group">
	        		<label class="control-label col-sm-2" title="指定复选框的数据来源：
系统字典：从系统字典中进行选择；
用户字典：从用户字典中进行选择；
Bean方法：输入Bean名称、Bean方法名称，如：formDefService、findList；
自定义SQL：输入sql语句，或者从脚本管理中选择已有sql语句；">
	        		数据来源：<i class="fa icon-question"></i></label>
					<div class="col-sm-10">
						<c:set var="shlyF" value="1"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='selector'}">
								<c:set var="shlyF" value="${map.value}"></c:set>
							</c:if>
						</c:forEach>
						<c:forEach items="${fns:getDictList('form_select_sjly')}" var="rdict">
							<input type="radio" name="optionMap['selector']" value="${rdict.value }" <c:if test="${rdict.value==shlyF}">checked="checked"</c:if> class="form-control" onchange="radioChange(this.value);" >${rdict.name }
						</c:forEach>
					</div>
	        	</div>
	        </div>
    	</div>
    
    
        <div class="row hide" id="dictRow">
        	<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="">
	        		<span class="required">*</span>字典类型：<i class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						
						<c:set var="flag" value="0"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='selectDictType'}">
								<c:set var="flag" value="${map.value}"></c:set>
							</c:if>
						</c:forEach>
						<select name="optionMap['selectDictType']" class="form-control" id="optionMapSelect">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeList}" var="dictType">
								<option value="${dictType}" <c:if test="${dictType eq formEntityColumn.optionMap['selectDictType']}"> selected="selected" </c:if> >${dictType}</option>
							</c:forEach>
						</select>
					</div>
	        	</div>
	        </div>
        </div>
        
        <div class="row hide" id="classRow">
        	<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="">
	        		<span class="required">*</span>Bean名称：<i class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						<c:choose>
						<c:when test="${empty (formEntityColumn.showOptions)}">
							<input name="optionMap['selectPackage']" id="cPackage" htmlEscape="false" class="form-control"/>
						</c:when>
						<c:otherwise>
							<!-- 设置标记位 -->
							<c:set var="flag" value="0"></c:set>
							<c:forEach items="${formEntityColumn.optionMap}" var="map">
								<c:if test="${map.key=='selectPackage'}">
									<input name="optionMap['selectPackage']" id="cPackage" htmlEscape="false" class="form-control" value="${map.value}" />
									<c:set var="flag" value="1"></c:set>
								</c:if>
							</c:forEach>
							<c:if test="${flag==0}">
								<input name="optionMap['selectPackage']" id="cPackage" htmlEscape="false" class="form-control" />
							</c:if>
						</c:otherwise>
					</c:choose>
					</div>
	        	</div>
	        </div>
	        <div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="">
	        		<span class="required">*</span>方法名：<i class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						<c:choose>
						<c:when test="${empty (formEntityColumn.showOptions)}">
							<input name="optionMap['selectMethod']" id="cMethod" htmlEscape="false" class="form-control"/>
						</c:when>
						<c:otherwise>
							<!-- 设置标记位 -->
							<c:set var="flag" value="0"></c:set>
							<c:forEach items="${formEntityColumn.optionMap}" var="map">
								<c:if test="${map.key=='selectMethod'}">
									<input name="optionMap['selectMethod']" id="cMethod" htmlEscape="false" class="form-control" value="${map.value}" />
									<c:set var="flag" value="1"></c:set>
								</c:if>
							</c:forEach>
							<c:if test="${flag==0}">
								<input name="optionMap['selectMethod']" id="cMethod" htmlEscape="false" class="form-control" />
							</c:if>
						</c:otherwise>
					</c:choose>
					</div>
	        	</div>
	        </div>
        </div>
        <div class="row hide" id="methodRow">
        	<div class="col-xs-12">
	        	<div class="form-group">
	        		<label class="control-label col-sm-8" title="">
	        		<span class="required">方法的返回类型必须是List&lt;Map&lt;String,Object&gt;，key必须包含value、label </span> <i class="fa icon-question hide"></i></label>
        		</div>
       		</div>
        </div>
        
        <div class="row hide" id="sqlRow">
        	<div class="col-xs-12">
	        	<div class="form-group">
	        		<label class="control-label col-sm-2" title="">
	        		<span class="required">*</span>SQL语句：<i class="fa icon-question hide"></i></label>
					<div class="col-sm-10">
						<c:choose>
						<c:when test="${empty (formEntityColumn.showOptions)}">
							<textarea name="optionMap['selectSql']" id="sqlInp" rows="4" htmlEscape="false" class="form-control" placeholder="返回值必须包含value和label，如：select xh AS value ,xm AS label from stu "></textarea>
						</c:when>
						<c:otherwise>
							<!-- 设置标记位 -->
							<c:set var="flag" value="0"></c:set>
							<c:forEach items="${formEntityColumn.optionMap}" var="map">
								<c:if test="${map.key=='selectSql'}">
									<textarea name="optionMap['selectSql']" id="sqlInp" rows="4" htmlEscape="false" class="form-control"  placeholder="返回值必须包含value和label，如：select xh AS value ,xm AS label from stu ">${map.value}</textarea>
									<c:set var="flag" value="1"></c:set>
								</c:if>
							</c:forEach>
							<c:if test="${flag==0}">
								<textarea name="optionMap['selectSql']" id="sqlInp" rows="4" htmlEscape="false" class="form-control" placeholder="返回值必须包含value和label，如：select xh AS value ,xm AS label from stu "></textarea>
							</c:if>
						</c:otherwise>
					</c:choose>
					<div>
						<a href="javascript:void(0);" onclick="openSelectScriptDef('sqlInp')">选择脚本</a>&nbsp;
						<a href="javascript:void(0);" title="进入脚本管理" onclick="openScriptPage()">脚本管理</a>
					</div>
					</div>
	        	</div>
	        </div>
        </div>
    </div>
</div>
<script type="text/javascript">
       
	var obj = "${shlyF}";
	if (obj == '1') {
		//显示字典类型
		$("#dictRow").removeClass("hide");
		$("#optionMapSelect").addClass("required");
	} else if (obj == '2') {
		//显示方法
		$("#classRow").removeClass("hide");
		$("#methodRow").removeClass("hide");
		$("#cPackage").addClass("required");
		$("#cMethod").addClass("required");
	} else if (obj == '3') {
		//显示自定义SQL
		$("#sqlRow").removeClass("hide");
		$("#sqlInp").addClass("required");
	}
	function radioChange(v) {
		if (v == '1') {
			//显示字典类型
			$("#dictRow").removeClass("hide");
			$("#optionMapSelect").addClass("required");
			//隐藏自定义SQL
			$("#sqlRow").addClass("hide");
			$("#sqlInp").removeClass("required");
			$("#sqlInp").val('');
			//隐藏方法
			$("#classRow").addClass("hide");
			$("#methodRow").addClass("hide");
			$("#cPackage").removeClass("required");
			$("#cMethod").removeClass("required");
			$("#cPackage").val('');
			$("#cMethod").val('');
		} else if (v == '2') {
			//显示方法
			$("#classRow").removeClass("hide");
			$("#methodRow").removeClass("hide");
			$("#cPackage").addClass("required");
			$("#cMethod").addClass("required");
			//隐藏字典类型
			$("#dictRow").addClass("hide");
			$("#optionMapSelect").select2('val', '');
			$("#optionMapSelect").removeClass("required");
			//隐藏自定义SQL
			$("#sqlRow").addClass("hide");
			$("#sqlInp").removeClass("required");
			$("#sqlInp").val('');
		} else if (v == '3') {
			//显示自定义SQL
			$("#sqlRow").removeClass("hide");
			$("#sqlInp").addClass("required");
			//隐藏字典类型
			$("#dictRow").addClass("hide");
			$("#optionMapSelect").removeClass("required");
			$("#optionMapSelect").select2('val', '');

			//隐藏方法
			$("#classRow").addClass("hide");
			$("#methodRow").addClass("hide");
			$("#cPackage").removeClass("required");
			$("#cMethod").removeClass("required");
			$("#cPackage").val('');
			$("#cMethod").val('');
		}
	}
</script>	
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
		
