<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid,jbox" />
<sys:header title="表单设计器" extLibs="${extLibs}" />
<link href="${ctxStatic}/layoutit/css/layoutit.css" rel="stylesheet" />
<%-- <script src="${ctxStatic}/layoutit/lib/jquery/dist/jquery.min.js"></script> --%>
<script src="${ctxStatic}/layoutit/js/jquery-ui.js"></script>
<script src="${ctxStatic}/layoutit/js/jquery.htmlClean.js"></script>
<%-- <script src="${ctxStatic}/layoutit/lib/bootstrap/dist/js/bootstrap.min.js"></script> --%>
<script src="${ctxStatic}/layoutit/js/scripts.js"></script>
<div class="portlet box ${boxStyleColor}">
	<div class="navbar navbar-inverse navbar-fixed-top navbar-layoutit">
		<div class="navbar-header">
			<button data-target="navbar-collapse" data-toggle="collapse"
				class="navbar-toggle" type="button">
				<span class="glyphicon-bar"></span> <span class="glyphicon-bar"></span>
				<span class="glyphicon-bar"></span>
			</button>
			<a class="navbar-brand" href="#"> 表单设计 </a>
		</div>
		<div class="collapse navbar-collapse">
			<!-- 表单id -->
			<input type="hidden" id="formId" value="${formDef.formId}" /> <input
				type="hidden" id="entityId" value="${formDef.entityId}" /> <input
				type="hidden" id="formKey" value="${formDef.formKey}" />

			<ul class="nav pull-right">
				<li>
					<div class="btn-group btn-donate pull-right"></div>
					<div class="btn-group">
						<select id="autoLayoutCell" class="noselect2 btn btn-xs btn-primary active" title="自动布局：根据字段类型自动排版，先排版单行文本、日期、单选、多选、下拉、弹窗控件，再进行多行文本排版，再进行附件排版，最后进行子表排版；
1列：手工布局，除子表外，都是按照一列（col-sm-10）的布局方式；
2列：手工布局，除子表外，都是按照两列的布局方式；
3列：手工布局，除子表外，都是按照三列的布局方式；"
						style="height: 21px;margin-right: 2px;">
								<option value="" selected="selected">选择布局方式</option>
								<option value="fieldType">自动布局</option>
								<option value="10">1列</option>
								<option value="6 6">2列</option>
								<option value="4 4 4">3列</option>
						</select>
					</div>
				</li>
			</ul>
			<ul class="nav" id="menu-layoutit">
				<li>
					<div class="btn-group" data-toggle="buttons-radio">
						<button type="button" id="edit" class="btn btn-xs btn-primary active hide">
							<i class="glyphicon glyphicon-edit "></i>&nbsp;编辑
						</button>
						<!-- <button type="button" class="btn btn-xs btn-primary" id="devpreview">
            <i class="glyphicon-eye-close glyphicon"></i>
            开发
          </button> -->
						<!-- <button type="button" class="btn btn-xs btn-primary" id="sourcepreview">
            <i class="glyphicon-eye-open glyphicon"></i>
            预览
          </button> -->
					</div>
					<div class="btn-group">
						<button type="button" class="btn btn-xs btn-primary"
							id="btn-back" data-toggle="modal" title="返回表单配置界面">
							<i class="fa fa-reply-all"></i>&nbsp;返回
						</button>
					</div>					
					<div class="btn-group">
						<!-- <button type="button" class="btn btn-xs btn-primary" id="button-download-modal" data-target="#downloadModal"
                  role="button" data-toggle="modal"><i class="glyphicon-chevron-down glyphicon"></i>
            下载
          </button> -->
						<button type="button" class="btn btn-xs btn-primary"
							id="button-save" data-toggle="modal" title="保存当前排版布局">
							<i class="glyphicon glyphicon-floppy-save"></i>&nbsp;保存
						</button>
						<button type="button" class="btn btn-xs btn-primary"
							id="btn-saveAndClose" data-toggle="modal" title="保存当前排版布局并关闭设计器界面">
							<i class="glyphicon glyphicon-floppy-save"></i>&nbsp;保存并关闭
						</button>
						<button class="btn btn-xs btn-primary" href="#clear" id="clear" title="清空当前布局">
							<i class="glyphicon-trash glyphicon"></i>&nbsp;清空
						</button>
						<button type="button" class="btn btn-xs btn-primary"
							id="htmlPreView" title="先保存布局，然后预览表单">
							<i class="glyphicon-eye-open glyphicon"></i>&nbsp;预览表单
						</button>
					</div>
				</li>
			</ul>
		</div>
		<!--/.navbar-collapse -->
	</div>
	<!--/.navbar-fixed-top -->

	<div class="container">
		<div class="row">
			<div class="">
				<div class="sidebar-nav">
					<ul class="nav nav-list accordion-group">
						<li class="nav-header">
							<div class="pull-right popover-info">
								<i class="glyphicon glyphicon-question-sign"></i>
								<div class="popover fade right">
									<div class="arrow"></div>
									<h3 class="popover-title">帮助</h3>
									<div class="popover-content">在这里设置栅格布局，指定每行几列，指定标题</div>
								</div>
							</div> <i class="glyphicon-minus glyphicon"></i> 布局设置
						</li>
						<li class="rows" id="estRows"><c:forEach
								items="${fns:getDictList('form_grid_layout')}" var="dict">
								<div class="lyrow ui-draggable">
									<a href="#close" class="remove remove-h label label-danger">
										<i class="glyphicon-remove glyphicon"></i> 删除
									</a> <span class="drag label label-default"> <i
										class="glyphicon glyphicon-move"></i> 拖动
									</span> <span class="configuration"> <span
										class="btn-group btn-group-xs layout1"> <select
											class="noselect2 layouttype" title="布局方式">
												<option value="">布局方式</option>
												<c:forEach items="${fns:getDictList('form_grid_layout')}" var="layout">
													<c:if test="${layout.value ne 'basicInfo'}">
														<option value="${layout.value}"
															<c:if test="${dict.value eq layout.value }"> selected="selected"</c:if>>${layout.label}</option>
													</c:if>
												</c:forEach>
										</select>
									</span>
									</span>
									<div class="preview">
										<c:choose>
											<c:when test="${dict.value eq 'basicInfo'}">
						              			基本信息
						              		</c:when>
											<c:otherwise>
												<input value="${dict.value}" class="form-control"
													type="text" readonly="readonly">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="view">
										<div class="row clearfix">
											<c:choose>
												<c:when test="${dict.value eq 'basicInfo'}">
													<div class="col-md-12 column div_basicInfo">
														<h4 class="form-section" contenteditable="true">基本信息</h4>
													</div>
												</c:when>
												<c:otherwise>
													<c:forEach items="${fn:split(dict.value, ' ')}" var="col">
														<div class="col-md-${col} column"></div>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</c:forEach></li>
					</ul>

					<ul class="nav nav-list accordion-group">
						<li class="nav-header"><i class="glyphicon glyphicon-plus"></i>
							基本字段
							<div class="pull-right popover-info">
								<i class="glyphicon glyphicon-question-sign "></i>

								<div class="popover fade right">
									<div class="arrow"></div>
									<h3 class="popover-title">帮助</h3>

									<div class="popover-content">
										选择基本字段拖放入你需要放入的栅格列中</div>
								</div>
							</div></li>
						<li class="boxes boxes-overflow" id="elmBase">
							<%@ include file="/WEB-INF/views/modules/form/include/formDesignerBasicField.jsp"%>
						</li>
					</ul>

					<ul class="nav nav-list accordion-group">
						<li class="nav-header"><i class="glyphicon glyphicon-plus"></i>
							扩展字段
							<div class="pull-right popover-info">
								<i class="glyphicon glyphicon-question-sign "></i>

								<div class="popover fade right">
									<div class="arrow"></div>
									<h3 class="popover-title">帮助</h3>

									<div class="popover-content">选择扩展组件拖放入你需要放入的栅格列中。</div>
								</div>
							</div></li>
						<li class="boxes boxes-overflow" id="elmBase">
							<%@ include file="/WEB-INF/views/modules/form/include/formDesignerExtendField.jsp"%>
						</li>
					</ul>
					<ul class="nav nav-list accordion-group">
						<li class="nav-header"><i class="glyphicon glyphicon-plus"></i>
							子表布局
							<div class="pull-right popover-info">
								<i class="glyphicon glyphicon-question-sign "></i>

								<div class="popover fade right">
									<div class="arrow"></div>
									<h3 class="popover-title">帮助</h3>

									<div class="popover-content">选择子表拖放入你需要放入的栅格列中，之后点击【子表配置】进行子表详细配置</div>
								</div>
							</div></li>
						<li class="boxes boxes-overflow" id="elmBase">
							<%@ include file="/WEB-INF/views/modules/form/include/formDesignerChildTable.jsp"%>
						</li>
					</ul>
				</div>
			</div>
			<!--/span-->

			<!--/span-->
		</div>
		<div style="padding-left: 183px;">
			<div id="htmlContainer"
				style="min-height: 321px;"
				class="demo ui-sortable">
				<!-- 是否修改表单设计 -->
				<c:set var="isFormUpdate" value="F" />
				<c:choose>
					<c:when test="${not empty formDef.formContent}">
						<c:set var="isFormUpdate" value="T" />
		  	  			${formDef.formContent}
		  	  		</c:when>
					<c:otherwise>
						<div class="lyrow">
							<a href="#close" class="remove remove-h label label-danger"> <i
								class="glyphicon glyphicon-remove"></i> 删除
							</a> <span class="drag label label-default"> <i
								class="glyphicon glyphicon-move"></i> 拖动
							</span> <span class="configuration"> <span
								class="btn-group btn-group-xs layout1"> <select
									class="noselect2 layouttype" title="布局方式">
										<option value="">布局方式</option>
										<c:forEach items="${fns:getDictList('form_grid_layout')}"
											var="layout">
											<c:if test="${layout.value ne 'basicInfo'}">
												<option value="${layout.value}"
													<c:if test="${layout.value eq '6 6'}"> selected="selected"</c:if>>${layout.label}</option>
											</c:if>
										</c:forEach>
								</select>
							</span>
							</span>
							<div class="preview">6 6</div>
							<div class="view">
								<div class="row clearfix">
									<div class="col-md-6 column"></div>
									<div class="col-md-6 column"></div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<input type="hidden" id="isFormUpdate" value="${isFormUpdate}"/>
		<!--/row-->
	</div>
	<!--/.fluid-container-->
	
</div>
<sys:footer extLibs="${extLibs}" />
<script src="${ctxStatic}/layoutit/js/handlebars/handlebars-v4.0.11.js" type="text/javascript"></script>
<!-- 自定义模板helper js文件 -->
<script src="${ctxStatic}/layoutit/js/handlebars/handlebars-custom-helper.js" type="text/javascript"></script>
<!-- 自动布局js -->
<script src="${ctxStatic}/layoutit/js/handlebars/autoLayout.js" type="text/javascript"></script>
<!-- 布局模板 -->
<%@ include file="/WEB-INF/views/modules/form/include/formDesignerTemplate.jsp"%>
<script type="text/javascript">
	$(document).on('hidden.bs.modal', function(e) {
		$(e.target).removeData('bs.modal');
	});

	$('body').on('click', '#continue-share-non-logged', function() {
		$('#share-not-logged').hide();
		$('#share-logged').removeClass('hide');
		$('#share-logged').show();
	});

	$('body').on('click', '#continue-download-non-logged', function() {
		$('#download-not-logged').hide();
		$('#download').removeClass('hide');
		$('#download').show();
		$('#downloadhtml').removeClass('hide');
		$('#downloadhtml').show();
		$('#download-logged').removeClass('hide');
		$('#download-logged').show();
	});
</script>
<script type="text/javascript">
	var ctx = '${ctx}';
	$(document).ready(function() {
		if ('${isFormUpdate}' == 'T') {
			$('#htmlContainer').css("height",
					parseInt($('.demo').height()) + 10);
		}
		$("#edit").click();
	});
</script>