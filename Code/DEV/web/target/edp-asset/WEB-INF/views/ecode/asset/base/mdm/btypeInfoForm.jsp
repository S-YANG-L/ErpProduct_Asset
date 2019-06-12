<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate" />
<sys:header title="单位信息管理 - ${btypeInfo.isNewRecord ? '新增' : '编辑'}单位信息"
	extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-coffee"></i>${btypeInfo.isNewRecord ? '新增' : '编辑'}单位信息</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="mdm:btypeInfo:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="btypeInfo"
			action="${ctx}/mdm/btypeInfo/save" method="post"
			class="form-horizontal">
			<div class="form-body">
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> <span
								class="required starBold">* </span> 单位名称：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="btypeName" htmlEscape="false" maxlength="100"
									class="form-control required" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> <span
								class="required starBold">* </span>统一代码：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:hidden path="isNewRecord" />
								<form:input path="btypeCode" htmlEscape="false" maxlength="64"
									readonly="${!btypeInfo.isNewRecord}"
									class="form-control required" />
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> <span
								class="required starBold">* </span>简称：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="shortName" htmlEscape="false" maxlength="64"
									class="form-control required" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 注册资金：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="btypeExt.registerCapital" htmlEscape="false"
									placeholder="单位：万元" maxlength="64" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">单位分类：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:select path="propertyCode" htmlEscape="false"
									maxlength="64" class="form-control">
									<form:option value=" ">&nbsp;</form:option>
									<form:options items="${userDictList}" itemLabel="dictName"
										itemValue="dictValue" htmlEscape="false" />
								</form:select>
								<span class="help-block"></span>
								<form:input path="propertyName" type="hidden" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">成立时间：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<input name="registerDate" type="text" readonly="readonly"
									maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${btypeInfo.registerDate}" pattern="yyyy-MM-dd"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">注册地址：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="registerAddr" htmlEscape="false"
									maxlength="64" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">所在区市：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<sys:treeselect id="areaCode" name="btypeExt.areaCode"
									value="${btypeInfo.btypeExt.areaCode}"
									labelName="btypeExt.areaName"
									labelValue="${btypeInfo.btypeExt.areaName}" title="所在区市"
									url="/sys/area/treeData" cssClass="form-control rightBorder"
									returnFullPath="true" allowClear="true"
									notAllowSelectParent="true" />
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">所属行业：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="registerAddr" htmlEscape="false"
									maxlength="64" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">上级单位：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<sys:listselect id="btypeInfo" name="adminBtypeCode"
									value="${btypeInfo.adminBtypeCode}" labelName="adminBtypeName"
									labelValue="${btypeInfo.adminBtypeName}" title="上级单位"
									url="${ctx}/mdm/select/btypeSelect?isAdmin=1" multiple="false"
									cssClass="form-control rightBorder" />
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">法人代表：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="lagerPersonName" htmlEscape="false"
									maxlength="64" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">身份证：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="lagerPersonIdNo" htmlEscape="false"
									maxlength="64" class="form-control card" />
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">通讯地址：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="contactAddress" htmlEscape="false"
									maxlength="64" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">单位属性：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:select path="btypeSortsList" multiple="true"
									htmlEscape="false" maxlength="64" class="form-control"
									items="${fns:getDictList('mdm_btype_attr')}" itemLabel="label"
									itemValue="name">
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 邮编：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="fa fa-envelope-o"></i></span>
									<form:input path="postCode" htmlEscape="false"
										placeholder="请输入邮编" maxlength="20"
										class="form-control zipCode" />
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">传真：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-print"></i></span>
									<form:input path="fax" htmlEscape="false" placeholder="请输入传真"
										maxlength="20" class="form-control number" />
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 联系人：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<div class="input-group">
									<span class="input-group-addon"> <i class="fa fa-male"></i>
									</span>
									<form:input path="linkman" htmlEscape="false"
										placeholder="请输入联系人" maxlength="64"
										class="form-control realName" />
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">联系电话：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<div class="input-group">
									<span class="input-group-addon"> <i class="fa fa-phone"></i>
									</span>
									<form:input path="linkmanTel" htmlEscape="false"
										placeholder="请输入电话" maxlength="64"
										class="form-control simplePhone" />
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 手机：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="fa fa-mobile-phone"></i></span>
									<form:input path="linkmanMobile" htmlEscape="false"
										placeholder="请输入手机" maxlength="100"
										class="form-control mobile" />
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">邮箱：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<div class="input-group">
									<span class="input-group-addon"><i
										class="fa fa-envelope"></i></span>
									<form:input path="linkmanEmail" htmlEscape="false"
										placeholder="请输入邮箱" maxlength="100" class="form-control email" />
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">办公地址：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="workAddress" htmlEscape="false" maxlength="64"
									class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 官网：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:input path="btypeExt.btypeUrl" htmlEscape="false"
									maxlength="200" class="form-control url" />
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">单位简介：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:textarea path="btypeExt.btypeIntro" htmlEscape="false"
									rows="4" maxlength="225" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 主营业务：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:textarea path="btypeExt.mainBusiness" htmlEscape="false"
									rows="4" maxlength="225" class="form-control" />
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row isMenu">
					<div class="col-lg-1"></div>
					<div class="col-lg-4 isMenu">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 所在园区：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:select path="gardenCode" htmlEscape="false" maxlength="64"
									class="form-control">
									<form:option value=" ">&nbsp;</form:option>
									<form:options items="${userDictList4}" itemLabel="dictName"
										itemValue="dictValue" />
								</form:select>
								<form:input path="gardenName" type="hidden" />
							</div>
						</div>
					</div>
					<div class="col-lg-4 isMenu">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">所在孵化器：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:select path="btypeExt.incubatorCode" maxlength="64"
									class="form-control">
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row isMenu">
					<div class="col-lg-1"></div>
					<div class="col-lg-4 isMenu">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""> 孵化状态：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<form:select path="btypeExt.incubateStatus" htmlEscape="false"
									maxlength="64" class="form-control">
									<form:option value=" ">&nbsp;</form:option>
									<form:options items="${fns:getDictList('fh_status')}"
										itemLabel="label" itemValue="value" />
								</form:select>
							</div>
						</div>
					</div>
					<div class="col-lg-4 isMenu">
						<div class="form-group">
							<label class="control-label col-lg-4" title="">入驻时间：<i
								class="fa icon-question hide"></i></label>
							<div class="col-lg-8">
								<input name="btypeExt.joinIncubateDate" type="text"
									readonly="readonly" maxlength="20" class="form-control Wdate "
									value="<fmt:formatDate value="${btypeInfo.btypeExt.joinIncubateDate}" pattern="yyyy-MM-dd"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
							</div>
						</div>
					</div>
					<div class="col-lg-2"></div>
				</div>
				<div class="row">
					<div class="col-lg-1"></div>
					<div class="col-lg-4">
						<div class="form-group">
							<label class="control-label col-lg-4" title=""></label>
							<div class="col-lg-8 hengxian">
								<shiro:hasPermission name="mdm:btypeInfo:edit">
									<button id="btnSubmit" type="submit" class="btn btn-primary">
										<i class="fa fa-check"></i> 保 存
									</button>&nbsp;
								</shiro:hasPermission>
								<button id="btnCancel" type="button" class="btn btn-danger"
									onclick="closeCurrentTabPage('${param.parentTabPageId}')">
									<i class="fa fa-close"></i> 关 闭
								</button>
							</div>
						</div>
					</div>
					<div class="col-lg-4 hengxian"></div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	$(document).ready(function() {
		$('.isMenu').hide();
	});
	$("#inputForm")
			.validate(
					{
						rules : {
							btypeCode : {
								remote : "${ctx}/mdm/btypeInfo/checkCode?oldCode="
										+ encodeURIComponent("${btypeInfo.btypeCode}")
							},
						},
						messages : {
							btypeCode : {
								remote : "编码已存在"
							},
						},
						submitHandler : function(form) {
							$("#btypeSortName").val(
									$("#btypeSortCode").select2("data").text);
							$("#propertyName").val(
									$("#propertyCode").select2("data").text);
							$("#tradeSortName").val(
									$("#tradeSortCode").select2("data").text);
							$("#gardenName").val(
									$("#gardenCode").select2("data").text);
							$("#countryName").val(
									$("#countryCode").select2("data").text);
							$("#marketSortName").val(
									$("#marketSortCode").select2("data").text);
							ajaxSubmitForm($(form), function(data) {
								showMessage(data.message);
								if (data.result == Global.TRUE) {
									closeCurrentTabPage(
											'${param.parentTabPageId}',
											function(contents, contentWindow) {
												contentWindow.page();
											});
								}
							}, "json");
						}
					});

	// 根据单位类型不同选择元素
	$('#btypeSortsList').change(function() {
		//alert($(this).val().split(","));
		refreshType($(this).val());
	});

	// 根据单位类型选择不同的元素
	function refreshType(val) {
		for ( var p in val) {
			//  			 alert(val[p]);
			if (val[p] == '孵化器企业') {
				$('.isMenu').show();
			} else {
				$('.isMenu').hide();
			}
		}
	}

	//主管单位回调函数
	function btypeInfoCallbackForMap(dataMap, v, h, f) {
		var codes = [], names = [];
		$.each(dataMap, function(key, value) {
			codes.push(value.btypeCode);
			names.push(value.btypeName);
		});
		$('#btypeInfoCode').val(codes.join(','));
		$('#btypeInfoName').val(names.join(','));
	}
</script>