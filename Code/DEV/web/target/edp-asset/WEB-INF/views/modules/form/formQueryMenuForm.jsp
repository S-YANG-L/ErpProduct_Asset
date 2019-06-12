<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="${fns:text('菜单管理')} - ${menu.isNewRecord ? fns:text('新增菜单') : fns:text('编辑菜单')}" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-list-alt"></i> ${menu.isNewRecord ? fns:text('新增菜单') : fns:text('编辑菜单')}（
			<div class="dropdown input-inline">
				<div class="dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
					<span id="sysCodeName">${fns:getDictLabel(menu.sysCode, 'menu_sys_code', fns:text('全部菜单'))}</span><b class="caret"></b>
				</div>
				<ul class="dropdown-menu">
					<c:forEach items="${fns:getDictList('menu_sys_code')}" var="dict">
						<li><a href="javascript:" onclick="$('#sysCode').val('${dict.value}');$('#sysCodeName').text('${dict.name}');
								$('#parentDiv').attr('data-url','${ctx}/sys/menu/treeData?sysCode=${dict.value}');">
							<i class="fa fa-angle-right"></i> ${dict.label}</a></li>
					</c:forEach>
				</ul>
			</div> ）
		</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="menu" action="${ctx}/form/formQuery/menuSave" method="post" class="form-horizontal">
			<form:hidden path="sysCode"/>
			<div class="form-body">
				<h4 class="form-section">${fns:text('基本信息')}</h4>
				<form:hidden path="menuCode"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('上级菜单')}：</label>
							<div class="col-sm-8">
								<sys:treeselect id="parent" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
									title="${fns:text('上级菜单')}" url="/sys/menu/treeData?sysCode=${menu.sysCode}" extCode="${menu.id}" cssClass="" allowClear="true"/>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
				
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="标识当前是否是个菜单，还是只是设置权限">
								<span class="required">*</span> ${fns:text('菜单类型')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="type" items="${fns:getDictList('menu_type')}" itemLabel="label" itemValue="value"
										htmlEscape="false" class="form-control required"/>
								</div>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> ${fns:text('菜单名称')}：</label>
							<div class="col-sm-8">
								<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="指定菜单所属的模块，在开启和禁用模块的时候停用所属菜单">
								<span class="required">*</span> ${fns:text('归属模块')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:select path="moduleCodeList" multiple="true" class="form-control required input-sm"  >
									<form:options items="${moduleList}" itemLabel="moduleName" itemValue="moduleCode" htmlEscape="false"/>
								</form:select>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="超级链接的URL地址，跟路径在管理路径下，外部链接需加“http://”;
   1、以  /// 开头，则代表是网站根路径（结果：http://localhost/{href}）
   2、以  // 开头，则代表是工程根路径（结果：http://localhost/{ctx}/{href}）
   3、以  / 开头，则代表是管理根路径（结果：http://localhost/{ctx}{adminPath}/{href}）
 可带变量，变量格式  {变量名}
   1、app.properties中的key可作为变量设置
   2、{ssoToken} : 单点登录的token编码，url参数中的参数分隔符请使用“%26”进行转义，
	例如：{projectUrl}/sso/{ssoToken}?url=/sys/user/list?p1=v1%26p2=v2&relogin=true
   3、{userCode} : 当前用户编码 
   4、{userName} : 当前用户名称 
   5、{userType} : 当前用户类型 ">
								${fns:text('链接(Href)')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="href" htmlEscape="false" maxlength="2000" class="form-control"/>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="链接打开的目标，默认addTabPage方式（新窗口中打开如：_blank）">
								${fns:text('目标(Target)')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:input path="target" htmlEscape="false" maxlength="10" class="form-control"/>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('排序(升序)')}：</label>
							<div class="col-sm-8">
								<form:input path="sorts" htmlEscape="false" maxlength="50" class="required form-control"/>
								<span class="help-block">升序排序，只能输入数值。&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6 isPerm2">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('权限标识')}：</label>
							<div class="col-sm-8">
								<%-- <form:input path="permission" htmlEscape="false" maxlength="100" class="form-control"/> --%>
								<select name="permission" multiple="true" class="form-control input-sm ">
									<c:forEach items="${permiList}" var="permi">
										<option value="${permi.permiKey}"  htmlEscape="false">${permi.permiKey}</option>
									</c:forEach>
								</select>
								<input type="hidden" name="!permission" value="" />
								<span class="help-block">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6 isMenu">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('字体颜色')}：</label>
							<div class="col-sm-8">
								<div class="input-group color colorpicker-default" data-color="${not empty menu.color ? menu.color : '#fff'}" data-color-format="hex">
									<input name="color" type="text" class="form-control" value="${menu.color}">
									<span class="input-group-btn">
										<button class="btn default" type="button"><i></i>&nbsp;</button>
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-6 isMenu">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('菜单图标')}：</label>
							<div class="col-sm-8">
								<sys:iconselect id="icon" name="icon" value="${menu.icon}" />
							</div>
						</div>
					</div>
				</div>
				<div class="row isMenu2">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4">${fns:text('可见')}：</label>
							<div class="col-sm-8">
								<div class="radio-list">
									<form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" 
										htmlEscape="false" class="required form-control"/>
								</div>
								<span class="help-block">该菜单或操作是否显示到系统菜单中</span>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="菜单权重：默认20；>=40一般管理员；>=60系统管理员；>=80超级管理员">
								<span class="required">*</span> ${fns:text('菜单权重')}：<i class="fa icon-question"></i></label>
							<div class="col-sm-8">
								<form:select path="weight" class="form-control required input-sm"  >
									<form:options items="${fns:getDictList('menu_weight')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
				</div>
				<h4 class="form-section">${fns:text('其它信息')}</h4>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('备注')}：</label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								<span class="help-block"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2">${fns:text('快速授权角色')}：</label>
							<div class="col-sm-10">
								<style>.fix-width span{width:200px;display:inline-block;}</style>
								<div class="checkbox fix-width">
									<form:checkboxes path="roleCodes" items="${roleList}" itemLabel="roleName" itemValue="roleCode" class="form-control"/>
								</div>
								<div class="alert alert-warning" style="margin-top:10px;">
									${fns:text('此功能仅提供快速授权角色，不提供快速取消授权，如果取消角色，请进入角色管理里进行菜单授权设置。')}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> ${fns:text('保 存')}</button>&nbsp;
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> ${fns:text('关 闭')}</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
<link href="${ctxStatic}/assets/global/plugins/bootstrap-colorpicker/css/colorpicker.css" rel="stylesheet" type="text/css"/>
<script src="${ctxStatic}/assets/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
<script type="text/javascript">
	$("#inputForm").validate({
		submitHandler: function(form){
			if ($('#moduleCodeList').val() == null){
				showMessage('请选择归属模块！');
				return;
			}
			ajaxSubmitForm($(form), function(data){
				showMessage(data.message);
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}
			}, "json");
	    }
	});
	// 颜色控件初始化
	$('#inputForm .colorpicker-default').colorpicker();
	// 根据类型显示不同的元素
	$('#inputForm input[name=type]').click(function(){
		refreshType($(this).val());
	});
	refreshType($('#inputForm input[name=type]:checked').val());
	
	// 根据类型显示不同的元素
	function refreshType(val){
		if (val == '2'){
			$('.isMenu').hide();
			$('.isPerm').show();
		}else{
			$('.isPerm').hide();
			$('.isMenu').show();
		}
	}
</script>