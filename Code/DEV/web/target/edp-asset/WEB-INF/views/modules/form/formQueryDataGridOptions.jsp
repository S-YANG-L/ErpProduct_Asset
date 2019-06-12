<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="表单查询列管理 - ${formQueryColumn.isNewRecord ? '新增' : '编辑'}表单查询列" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>表格选项配置</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="formQuery" action="${ctx}/form/formQuery/saveDataGridOptions" method="post" class="form-horizontal">
			<div class="portlet-tabs">
				<ul class="nav nav-tabs">
					<li><a id="btn_portlet_tab6" href="${ctx}/form/formQueryDataScope/form?queryId=${formQuery.queryId}">数据权限配置</a></li>
					<li><a id="btn_portlet_tab5" href="${ctx}/form/formQueryPermi/list?queryId=${formQuery.queryId}">按钮权限配置</a></li>
					<li class="active"><a id="btn_portlet_tab4" href="javascript:void(0);">表格选项配置</a></li>
					<li><a id="btn_portlet_tab3" href="${ctx}/form/formQueryButton/list?queryId=${formQuery.queryId}">按钮详细配置</a></li>
					<li><a id="btn_portlet_tab2" href="${ctx}/form/formQueryColumn/list?queryId=${formQuery.queryId}">列表字段配置</a></li>
					<li><a id="btn_portlet_tab1" href="${ctx}/form/formQuery/form?queryId=${formQuery.queryId}">&lt;&lt;基本信息</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="portlet_tab4">
						<div class="form-body">
							<h4 class="form-section">表格选项配置</h4>
							<form:hidden path="queryId"/>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="表格lazyLoad 属性，默认初始列表后不及时加载数据，（仅对url远程请求数据有效），当调用 dataGrid.refresh()时再进行加载。">
											是否懒加载Grid数据：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['lazyLoad']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['lazyLoad'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-5" title="表格shrinkToFit属性，当列比较多时可设置为false">
											是否按百分比自动调整列宽：<i class="fa icon-question"></i></label>
										<div class="col-sm-7">
											<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['shrinkToFit']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['shrinkToFit'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="表格showRownum属性，默认显示">
											是否显示行号：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['showRownum']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['showRownum'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="表格showCheckbox 属性，默认不显示">
											是否显示复选框：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['showCheckbox']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['showCheckbox'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="表格sortableColumn 属性，设置为false后，整个列表不允许排序">
											列表是否允许排序：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['sortableColumn']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['sortableColumn'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="是否分页显示默认是生成分页信息">
											是否分页显示：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<c:forEach items="${fns:getDictList('form_true_fasle')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['dataGridPage']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['dataGridPage'] eq rdict.value}">checked="checked"</c:if> class="form-control" >${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="表格autoGridHeight属性，设置为false后，不自动调整表格高度，为函数时返回'100%',则自动高度">
											自动表格高度：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<c:forEach items="${fns:getDictList('form_true_false_fun')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['autoGridHeight']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['autoGridHeight'] eq rdict.value}">checked="checked"</c:if> class="form-control" onclick="funClick(this.value,'autoGridHeightFun')">${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="即表格autoGridHeight 属性 例子：function(){return 200;}">
											配置函数：<i class="fa icon-question "></i></label>
										<div class="col-sm-8">
											<input type="text" id="autoGridHeightFun" name="dataGridOptionsMap['autoGridHeightFun']" value="${formQuery.dataGridOptionsMap['autoGridHeightFun']}" class="form-control" readonly="readonly"/>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="表格autoGridWidth属性，设置为false后，不自动调整表格宽度">
											自动表格宽度：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<c:forEach items="${fns:getDictList('form_true_false_fun')}" var="rdict">
												<input type="radio" name="dataGridOptionsMap['autoGridWidth']" value="${rdict.value }" <c:if test="${formQuery.dataGridOptionsMap['autoGridWidth'] eq rdict.value}">checked="checked"</c:if> class="form-control" onclick="funClick(this.value,'autoGridWidthFun')">${rdict.name }
											</c:forEach>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="即表格autoGridWidth 属性 例子：function(){return 700;} ">
											配置函数：<i class="fa icon-question "></i></label>
										<div class="col-sm-8">
											<input type="text" id="autoGridWidthFun" name="dataGridOptionsMap['autoGridWidthFun']" value="${formQuery.dataGridOptionsMap['autoGridWidthFun']}" class="form-control" readonly="readonly"/>
										</div>
									</div>
								</div>
							</div>
							<%-- <div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="自动表格修复高度（自动调整高度时修正的高度值）">
											自动表格修复高度：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<input type="text" name="dataGridOptionsMap['autoGridHeightFix']" value="${formQuery.dataGridOptionsMap['autoGridHeightFix']}" class="form-control number"/>
										</div>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="自动表格修复宽度（自动调整宽度时修正的宽度值）">
											自动表格修复宽度：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<input type="text" name="dataGridOptionsMap['autoGridWidthFix']" value="${formQuery.dataGridOptionsMap['autoGridWidthFix']}" class="form-control number"/>
										</div>
									</div>
								</div>
							</div> --%>
							<div class="row">
								<div class="col-xs-6">
									<div class="form-group">
										<label class="control-label col-sm-4" title="给list界面选择一个图标">
											列表图标：<i class="fa icon-question"></i></label>
										<div class="col-sm-8">
											<sys:iconselect id="icon" name="dataGridOptionsMap['icon']" value="${formQuery.dataGridOptionsMap['icon']}" />
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-2" title="即dataGrid --ajaxSuccess 属性">
											加载成功后执行方法：<i class="fa icon-question"></i></label>
										<div class="col-sm-10">
											<textarea name="dataGridOptionsMap['ajaxSuccess']" rows="4" htmlEscape="false" class="form-control" placeholder="格式要求：function(data){//javascript 代码}">${formQuery.dataGridOptionsMap['ajaxSuccess']}</textarea>
											<a href="${ctx }/form/formQuery/initUnifiedEntrance?pageName=DataGridHelp" target="_blank">帮助</a>&nbsp;
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-2" title="即dataGrid --onSelectRow 属性">
											选择行/单击时执行方法：<i class="fa icon-question"></i></label>
										<div class="col-sm-10">
											<textarea name="dataGridOptionsMap['onSelectRow']" rows="4" htmlEscape="false" class="form-control" placeholder="格式要求： function(id, isSelect, event){//javascript 代码}">${formQuery.dataGridOptionsMap['onSelectRow']}</textarea>
											<a href="${ctx }/form/formQuery/initUnifiedEntrance?pageName=DataGridHelp" target="_blank">帮助</a>&nbsp;
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-sm-2" title="即dataGrid --ondblClickRow 属性">
											双击行时执行方法：<i class="fa icon-question"></i></label>
										<div class="col-sm-10">
											<textarea name="dataGridOptionsMap['ondblClickRow']" rows="4" htmlEscape="false" class="form-control" placeholder="格式要求： function(id, rownum, colnum, event){//javascript 代码}">${formQuery.dataGridOptionsMap['ondblClickRow']}</textarea>
											<a href="${ctx }/form/formQuery/initUnifiedEntrance?pageName=DataGridHelp" target="_blank">帮助</a>&nbsp;
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
				/*  if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				} */
			}, "json");
	    }
	});
	
	var autoGridHeight='${formQuery.dataGridOptionsMap.autoGridHeight}';
	var autoGridWidth='${formQuery.dataGridOptionsMap.autoGridWidth}';
	$(document).ready(function(){
		funClick(autoGridHeight,"autoGridHeightFun");
		funClick(autoGridWidth,"autoGridWidthFun");
	});
	//自动表格高度和自动表格宽度切换函数选项时处理
	function funClick(val,inptId){
		if(val=='fun'){
			$("#"+inptId).removeAttr("readonly");
			$("#"+inptId).addClass("required");
		}else{
			$("#"+inptId).attr("readonly","readonly");
			$("#"+inptId).removeClass("required");
			$("#"+inptId).val("");
		}
	}
	
</script>
