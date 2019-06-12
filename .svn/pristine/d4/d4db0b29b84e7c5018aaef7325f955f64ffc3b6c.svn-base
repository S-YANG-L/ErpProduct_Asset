<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="panel panel-default" >
    <div class="panel-heading">
        <h3 class="panel-title">其它配置</h3>
    </div>
    <div class="panel-body">
    	<div class="row">
    		<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title="为‘是’时在【表单设计】中参与生成表单，否则不参与">
						是否生成表单：<i class="fa icon-question"></i></label>
					<div class="col-sm-8" title="">
						<c:forEach items="${fns:getDictList('yes_no')}" var="dict">
							<input type="radio" name="optionMap['isFormDesigner']" value="${dict.value}" <c:if test="${formEntityColumn.optionMap.isFormDesigner eq dict.value}">checked="checked"</c:if>/>${dict.label}
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
    	<div class="row">
    		<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title="为‘是’时，需要选择流水号规则，优先级高于默认值，为‘是’时，默认值不起作用">
						是否流水号：<i class="fa icon-question"></i></label>
					<div class="col-sm-8" title="当[是否流水号]为[是]时，则默认值不起作用">
						<c:forEach items="${fns:getDictList('yes_no')}" var="dict">
							<input type="radio" name="optionMap['isSerialNum']" value="${dict.value}" <c:if test="${formEntityColumn.optionMap.isSerialNum eq dict.value}">checked="checked"</c:if> onclick="changeSerialNum(this.value)" />${dict.label}
						</c:forEach>
						&nbsp;<a href="javascript:void(0);" id="serial_a" class="hide" title="进入流水号规则管理界面">流水号规则</a>
					</div>
				</div>
			</div>
    		<div class="col-xs-6 <c:if test="${formEntityColumn.optionMap.isSerialNum eq '0'}">hide</c:if>" id="serial_div">
				<div class="form-group">
					<label class="control-label col-sm-4" title="是否流水号为‘是’时，需要选择流水号规则，
双击文本框弹出选择规则界面">
						<span class="required">*</span> 流水号规则：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<!-- 流水号规则id -->
						<input id="serialNumId" type="hidden" name="optionMap['serialNumId']" value="${formEntityColumn.optionMap.serialNumId}" />
						<!-- 流水号规则（组成：流水号规则+其它规则） -->
						<input id="serialRuleKey" type="hidden" name="optionMap['serialRuleKey']" class="" value="${formEntityColumn.optionMap.serialRuleKey}" readonly="readonly" />
						<!-- 流水号规则名称 -->
						<input id="serialNumName" type="text" name="optionMap['serialNumName']" class="" value="${formEntityColumn.optionMap.serialNumName}" readonly="readonly" />
					</div>
				</div>
			</div>
    	</div>
		<div class="row" id="mrzRow">
	        <div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title="优先级低于是否流水号，是否流水号为‘是’时，默认值不起作用，
若默认值类型为‘脚本’时则需要选择脚本">
						默认值类型：<i class="fa icon-question"></i></label>
					<div class="col-sm-8" title="">
						<%-- <form:input path="defaultValueIsScript" htmlEscape="false" maxlength="1" class="form-control"/>--%>
						<%-- <form:select path="defaultValueIsScript" id="defaultValueIsScript" class="form-control">
							<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select> --%>
						<form:radiobuttons path="defaultValueIsScript" items="${fns:getDictList('form_entity_default_type')}" itemLabel="label" itemValue="value" htmlEscape="false" onclick="changeDefaultScript(this.value)" />
						&nbsp;<a href="javascript:void(0);" id="openScript" class="openScript hide">脚本管理</a>
					</div>
				</div>
			</div>
	        
        </div>
        <div class="row">
        	<div class="col-xs-12">
	        	<div class="form-group">
					<label class="control-label col-sm-2" title="默认值类型为‘文本’时手工输入默认值，为‘脚本’时弹出选择脚本界面选择脚本，
选择脚本时点击【检查脚本】检查脚本是否正确,点击【确认】自动检查脚本是否正确，正确则选择成功，如果错误则提示是否选择，确认后选择">
						默认值：<i class="fa icon-question"></i></label>
					<div class="col-sm-10">
						<!-- 脚本 -->
						<c:if test="${formEntityColumn.defaultValueIsScript eq '1'}">
							<form:textarea path="defaultValue" id="defaultValue" rows="3" htmlEscape="false" maxlength="2000" class="form-control" readonly="true" ondblclick="openSelectScript(this.value,'Groovy')"/>
						</c:if>
						<c:if test="${formEntityColumn.defaultValueIsScript eq '0'}">
							<form:textarea path="defaultValue" id="defaultValue" rows="1" htmlEscape="false" maxlength="2000" class="form-control"/>
						</c:if>
					</div>
				</div>
	        </div>
        </div>
        <div class="row">
			<div class="col-xs-12">
				<div class="form-group">
					<label class="control-label col-sm-2" title="表单中控件的验证类型">
						字段验证类型：<i class="fa icon-question"></i></label>
					<div class="col-sm-10">
                        <select name="validType" multiple class="form-control">
							<c:forEach items="${fns:getDictList('form_field_check_type')}" var="dict">
								<option value="${dict.value}" <c:if test="${fn:contains(formEntityColumn.validType,dict.value)}">selected="selected"</c:if>>${dict.name}</option>
							</c:forEach>
						</select>
                        <input type="hidden" name="!validType" value="" />   
                           <!-- <script>
                           	if(""!="${formEntityColumn.validType}"){
                           		//var obj = eval("("+"${formEntityColumn.validType}"+")"); 
                           		var valid= "${formEntityColumn.validType}";
                           		var obj = valid.split(",");
                            	if(null != obj){				                            
		                            for(var i = 0; i < obj.length; i++){
							            $("#optionMapVerify option").each(function() {
							                if ($(this).val() == obj[i]) {  
							                    $(this).attr("selected", "selected");
							                }  
							            });
		                            }
                            	} 
                           	}else{
                           		// 字段是否允许为空
                           		var isNull="${formEntityColumn.formTableColumn.isNull}";
                           		var columnType="${formEntityColumn.formTableColumn.columnType}";
                           		var columnSize="${formEntityColumn.formTableColumn.columnSize}";
                           		var validType="${formEntityColumn.validType}";
                           		if(null == validType || "" == validType){
                           			// 必填验证
                           			if("1"==isNull){
                           				$("#optionMapVerify option").each(function() {
							                if ($(this).text() == '必填') {  
							                    $(this).attr("selected", "selected");
							                }  
							            });
                           			}
                           			// 数字校验
                           			if("numeric"==columnType){
                           				var cols=columnSize.split(",");
                           				if(cols.length>1){
                           					// 带小数点
                           					$("#optionMapVerify option").each(function() {
								                if ($(this).text() == '数字') {  
								                    $(this).attr("selected", "selected");
								                }  
								            });
                           				}else{
                           					// 整数
                           					$("#optionMapVerify option").each(function() {
								                if ($(this).text() == '整数') {  
								                    $(this).attr("selected", "selected");
								                }  
								            });
                           				}
                           			}else if("timestamp"==columnType){
                           				// 时间校验
                           				$("#optionMapVerify option").each(function() {
							                if ($(this).text() == '日期时间') {  
							                    $(this).attr("selected", "selected");
							                }  
							            });
                           			}	 
                           		}
                           	}
					    </script> -->
						
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="form-group">
					<label class="control-label col-sm-2" title="手工输入正则表达式，或者点击【选择脚本】按钮选择已有正则表达式">
						验证正则表达式：<i class="fa icon-question"></i></label>
					<div class="col-sm-10">
						<form:textarea path="validRegx" id="validRegex" htmlEscape="false" cssClass="form-control"/>
						<div>
							<a href="javascript:void(0);" onclick="openSelectScriptDef('validRegex')">选择脚本</a>&nbsp;
							<a href="javascript:void(0);" title="进入脚本管理" onclick="openScriptPage()">脚本管理</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="form-group">
					<label class="control-label col-sm-2" title="正则表达式的验证提示信息，为空则默认为'验证不通过'">
						正则验证提示信息：<i class="fa icon-question"></i></label>
					<div class="col-sm-10">
						<input id="validRegexTip" name="optionMap['validRegexTip']" value="${formEntityColumn.optionMap.validRegexTip}" class="form-control" />
					</div>
				</div>
			</div>
		</div>
        <div class="row">
	        <div class="col-xs-12">
	        	<div class="form-group">
	        		<label class="control-label col-sm-2" title="如果选择格式化类型，则在表单界面对指定字段进行格式化">
	        		格式化类型：<i class="fa icon-question"></i></label>
					<div class="col-sm-10">
						<%-- <c:choose>
							<c:when test="${empty (formEntityColumn.showOptions)}">
								<input name="optionMap['format']" id="optionMapFormat" htmlEscape="false" maxlength="500" class="form-control"/>
							</c:when>
							<c:otherwise>
								<!-- 设置标记位 -->
								<c:set var="flag" value="0"></c:set>
								<c:forEach items="${formEntityColumn.optionMap}" var="map">
									<c:if test="${map.key=='format'}">
										<input name="optionMap['format']" id="optionMapFormat" value="${map.value}" htmlEscape="false" maxlength="500" class="form-control"/>
										<c:set var="flag" value="1"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${flag==0}">
									<input name="optionMap['format']" id="optionMapFormat" htmlEscape="false" maxlength="500" class="form-control"/>
								</c:if>
							</c:otherwise>
						</c:choose> --%>
						<select id="number_pattern" name="optionMap['format']" class="form-control">
							<option value=""></option>
							<c:forEach items="${fns:getDictList('form_entity_format_pattern')}" var="dict">
								<option value="${dict.value}" <c:if test="${not empty formEntityColumn.optionMap && formEntityColumn.optionMap['format'] eq dict.value}"> selected="selected" </c:if>>${dict.label}</option>
							</c:forEach>
						</select>
					</div>
	        	</div>
	        </div>
        </div>
    </div>
</div>
<div class="panel panel-default" >
<div class="panel-heading">
    <h3 class="panel-title">样式</h3>
</div>
<div class="panel-body">
<div class="row">
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title="输入css类型，多个以空格分割">
				CSS类名：<i class="fa icon-question"></i></label>
			<div class="col-sm-8">
				<form:input path="cssClass" htmlEscape="false" maxlength="500" class="form-control"/>
			</div>
		</div>
	</div>
	<div class="col-xs-6">
		<div class="form-group">
			<label class="control-label col-sm-4" title="输入css样式，多个以英文分号分割">
				CSS样式：<i class="fa icon-question"></i></label>
			<div class="col-sm-8">
				<form:input path="cssStyle" htmlEscape="false" maxlength="500" class="form-control"/>
				</div>
			</div>
		</div>
	</div>	
</div>
</div>
