<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="表单查询列管理 - ${formQueryColumn.isNewRecord ? '新增' : '编辑'}表单查询列" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}2 autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formQueryColumn" action="${ctx}/form/formQueryColumn/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">字段名：${formQueryColumn.columnName }    &nbsp;&nbsp;&nbsp;字段描述：${formQueryColumn.columnComment }</h4>
				<form:hidden path="id"/>
				<form:hidden path="queryId"/>
				<div class="panel panel-default" id="dropdownID">
				    <div class="panel-heading">
				        <h3 class="panel-title">显示选项</h3>
				    </div>
				    <div class="panel-body">
				    	<div class="row">
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="即dataGird--columnModel--align 属性">
										 对齐方式：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<select name="showOptionsMap['align']" class="form-control ">
											<c:forEach items="${fns:getDictList('form_query_columshowoption_align')}" var="dict">
												<option value="${dict.value}" <c:if test="${formQueryColumn.showOptionsMap['align'] eq dict.value}">selected="selected"</c:if>>${dict.label}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="即dataGird--columnModel--width 属性">
										 列宽：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<form:input path="showOptionsMap['width']"  htmlEscape="false" maxlength="3" class="form-control digits" value="200"/>
										<div class="input-group-addon input-sm">px</div>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="即dataGird--columnModel--sortable 属性">
										 是否可排序：<i class="fa icon-question"></i></label>
									<div class="col-sm-8 input-group">
										<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
											<input type="radio" name="showOptionsMap['sortable']" value="${rdict.value }" <c:if test="${formQueryColumn.showOptionsMap['sortable'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
										</c:forEach>
									</div>
								</div>
							</div>
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="即dataGird--columnModel--index 属性">
										 排序索引字段：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<form:input path="showOptionsMap['index']"  htmlEscape="false" maxlength="32" class="form-control" value="${formQueryColumn.showOptionsMap['index'] }" />
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="即dataGird--columnModel--fixed 属性">
										 是否固定列宽：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
											<input type="radio" name="showOptionsMap['fixed']" value="${rdict.value }" <c:if test="${formQueryColumn.showOptionsMap['fixed'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
										</c:forEach>
									</div>
								</div>
							</div>
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="即dataGird--columnModel--hidden 属性">
										 是否隐藏：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
											<input type="radio" name="showOptionsMap['hidden']" value="${rdict.value }" <c:if test="${formQueryColumn.showOptionsMap['hidden'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="即dataGird--columnModel--formatter 属性，系统默认4中，自定义方式可以编辑自己需要返回的数据">
										 系统格式化：<i class="fa icon-question "></i></label>
									<div class="col-sm-10 input-group">
										<c:forEach items="${fns:getDictList('form_query_columshow_sysformatter')}" var="rdict">
											<input type="radio" name="showOptionsMap['sysFormatter']" value="${rdict.value }" <c:if test="${formQueryColumn.showOptionsMap['sysFormatter'] eq rdict.value}">checked="checked"</c:if> class="form-control" onclick="setFormatterVal(this.value);">${rdict.name }
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="">
										 格式化：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-10 input-group">
										<textarea id="formatterWby" name="showOptionsMap['formatter']" rows="4" htmlEscape="false" class="form-control" placeholder="格式要求：date、number、function(val, obj, row, act){//javascript 代码}">${formQueryColumn.showOptionsMap['formatter'] }</textarea>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="即dataGird--columnModel--formatoptions 属性">
										 格式化选项：<i class="fa icon-question"></i></label>
									<div class="col-sm-10 input-group">
										<textarea name="showOptionsMap['formatoptions']" rows="4" htmlEscape="false" class="form-control" placeholder="例如：{srcformat:'Y-m-d',newformat:'Y-m-d'}">${ formQueryColumn.showOptionsMap['formatoptions']}</textarea>
									<a href="${ctx }/form/formQuery/initUnifiedEntrance?pageName=ColumnHelp" target="_blank">帮助</a>&nbsp;
									</div>
								</div>
							</div>
						</div>
				    </div>
			    </div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	
	$("#inputForm").validate({
		submitHandler: function(form){
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				/* if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				} */
			}, "json");
	    }
	});
	
	var sysFormatter= '${formQueryColumn.showOptionsMap.sysFormatter}';
	setFormatterVal(sysFormatter);
	//设置formatter的值
	function setFormatterVal(val){
		if(val=='4'){
			$("#formatterWby").removeAttr("readonly");
			$("#formatterWby").val("function(val, obj, row, act){  //在这里编写你的javascript 代码}");
		}else if(val!='btnEdit' && val !='dict'){
			$("#formatterWby").removeAttr("readonly");
			$("#formatterWby").val(val);
		}else{
			$("#formatterWby").val('');
			$("#formatterWby").attr("readonly","readonly");
		}
	}
</script>