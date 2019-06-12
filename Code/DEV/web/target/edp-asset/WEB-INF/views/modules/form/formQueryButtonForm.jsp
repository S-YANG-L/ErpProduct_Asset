<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="表单查询列管理 - ${formQueryButton.isNewRecord ? '新增' : '编辑'}表单查询列" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}2 autoHeight">
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formQueryButton" action="${ctx}/form/formQueryButton/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">按钮id：${formQueryButton.btnId }    &nbsp;&nbsp;&nbsp;按钮名称：${formQueryButton.btnName }</h4>
				<form:hidden path="id"/>
				<form:hidden path="queryId"/>
				<form:hidden path="btnId"/>
				<input type="hidden" id="ht" value="${formQueryButton.btnOptionsMap['hrefType']}">
				<div class="panel panel-default" id="dropdownID">
				    <div class="panel-heading">
				        <h3 class="panel-title">按钮选项</h3>
				    </div>
				    <div class="panel-body">
				    	<div class="row">
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="即按钮的title属性">
										 按钮标题：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<form:input path="btnOptionsMap['title']"  htmlEscape="false" maxlength="30" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="">
										 图标：<i class="fa icon-question hide"></i></label>
									<div class="col-sm-8 input-group">
										<sys:iconselect id="icon" name="btnOptionsMap['icon']" value="${formQueryButton.btnOptionsMap['icon']}" />
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="停用该按钮，不会清除数据库存储信息，只是生成页面时不显示，随时可以启用">
										是否停用：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
											<input type="radio" name="btnOptionsMap['disabled']" value="${rdict.value }" <c:if test="${formQueryButton.btnOptionsMap['disabled'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="链接方式分为3种，第1种跳转表单：即配置按钮的href属性
    
    第2种自定义：	直接在链接地址扩展栏中配置链接即可；

    第3种执行事件：可以在点击事件内容框中输入要执行的内容，

    如果是系统内置按钮可以不配置事件内容，系统提供默认的内置事件
									">
										链接方式：<i class="fa icon-question"></i></label>
									<div class="col-sm-8 input-group">
										<c:forEach items="${fns:getDictList('form_query_btn_hreftype')}" var="rdict">
											<input type="radio" name="btnOptionsMap['hrefType']" value="${rdict.value }" <c:if test="${formQueryButton.btnOptionsMap['hrefType'] eq rdict.value}">checked="checked"</c:if> class="form-control" onclick="changeDiv(this.value);" >${rdict.name }
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="为方法提供主键id的参数">
										参数：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<input type="checkbox" name="btnOptionsMap['pk']" value="3" <c:if test="${formQueryButton.btnOptionsMap['pk'] eq 3}">checked="checked"</c:if> class="form-control" >主键id
									</div>
								</div>
							</div>
						</div>
						<div id="formCsDiv" class="row hide">
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="为方法提供表单的参数，供表单进行选择配置">
										选择表单key：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<select name="btnOptionsMap['formKey']"  class="form-control">
											<option value=""></option>
											<c:forEach items="${formDefList}" var="def">
												<option value="${def.formKey}" <c:if test="${formQueryButton.btnOptionsMap['formKey']==def.formKey}">selected="selected"</c:if>>${def.formName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
					    	<div class="col-xs-6">
								<div class="form-group">
									<label class="control-label col-sm-4" title="提供表单的权限供表单界面判断是否可编辑、保存">
										选择表单权限：<i class="fa icon-question "></i></label>
									<div class="col-sm-8 input-group">
										<select name="btnOptionsMap['formPermi']"  class="form-control">
											<option value=""></option>
											<c:forEach items="${formPermiList}" var="permi">
												<option value="${permi.permiKey}" <c:if test="${formQueryButton.btnOptionsMap['formPermi']==permi.permiKey}">selected="selected"</c:if>>${permi.permiName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="自定义方式下可以自由配置跳转的地址">
										链接地址扩展：<i class="fa icon-question "></i></label>
									<div class="col-sm-10 input-group">
										<form:input path="btnOptionsMap['hrefExt']" id="hrefMap" htmlEscape="false" maxlength="200" class="form-control" />
									</div>
								</div>
							</div>
						</div>
						<div id="eventDiv" class="row hide">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="系统为导出、数据清洗提供的内置事件">
										系统默认事件：<i class="fa icon-question "></i></label>
									<div class="col-sm-10 input-group">
										<input type="radio" name="btnOptionsMap['event']" value="1" <c:if test="${formQueryButton.btnOptionsMap['event'] eq 1 }">checked="checked"</c:if> class="form-control">导出事件
										<input type="radio" name="btnOptionsMap['event']" value="1" <c:if test="${formQueryButton.btnOptionsMap['event'] eq 2 }">checked="checked"</c:if> class="form-control">数据清洗事件
									</div>
								</div>
							</div>
						</div>
						<div id="onclickDiv" class="row hide">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="在此编辑按钮的事件执行内容，系统自动绑定按钮click事件">
										点击事件内容：<i class="fa icon-question "></i></label>
									<div class="col-sm-10 input-group">
										<textarea id="onclickMap" name="btnOptionsMap['onclick']" rows="4" htmlEscape="false" class="form-control" placeholder="不用写function，直接写事件内容即可，系统自动绑定click事件">${formQueryButton.btnOptionsMap['onclick'] }</textarea>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="即按钮的data-confirm属性，删除、导出等提示框信息">
										确认框提示信息：<i class="fa icon-question "></i></label>
									<div class="col-sm-10 input-group">
										<form:input path="btnOptionsMap['data-confirm']"  htmlEscape="false" maxlength="100" class="form-control"/>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="按钮的class属性">
										 class样式：<i class="fa icon-question "></i></label>
									<div class="col-sm-10 input-group">
										<select name="btnOptionsMap['css']" class="form-control" multiple="multiple" >
											<c:forEach items="${fns:getDictList('form_query_btn_css')}" var="dict">
												<option value="${dict.value}" <c:if test="${fn:contains(formQueryButton.btnOptionsMap['css'],dict.value)}">selected="selected"</c:if>>${dict.label}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
				    	<div class="row">
					    	<div class="col-xs-12">
								<div class="form-group">
									<label class="control-label col-sm-2" title="按钮自定义样式 style 属性：例子：width: 300px;">
										自定义样式：<i class="fa icon-question "></i></label>
									<div class="col-sm-10 input-group">
										<textarea name="btnOptionsMap['zdycss']" rows="4" htmlEscape="false" class="form-control" placeholder="">${formQueryButton.btnOptionsMap['zdycss'] }</textarea>
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
	
	$(document).ready(function(){
		var pp=$("#ht").val();
		changeDiv(pp);
	}); 
	
	function changeDiv(v){
		if(v=='1'){
			$("#formCsDiv").removeClass('hide');
			$("#onclickDiv").addClass('hide');
			$("#eventDiv").addClass('hide');
		}
		else if(v=='2'){
			$("#hrefMap").val('');
			$("#formCsDiv").removeClass('hide');
			$("#onclickDiv").addClass('hide');
			$("#eventDiv").addClass('hide');
		}
		else if(v=='3'){
			$("#hrefMap").val('');
			$("#onclickDiv").removeClass('hide');
			if($("#btnId").val()=='btnExport' || $("#btnId").val()=='btnClear' ){
				$("#eventDiv").removeClass('hide');
			}
			$("#formCsDiv").addClass('hide');
		}
	}
	
</script>
