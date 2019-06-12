<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,fileupload"/>
<sys:header title="测试 - ${testFlow.isNewRecord ? '新增' : '编辑'}测试工作流" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${testFlow.isNewRecord ? '新增' : '编辑'}测试工作流</div>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="testFlow" action="${ctx}/test/testFlow/save" method="post" class="form-horizontal">
			<div class="form-body">
				<form:hidden path="id"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title=""><span class="required">*</span>  申请人：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
							    		<sys:treeselect id="applicant" name="applicantCode" 
 									value="${testFlow.applicantCode}" labelName="applicantName" labelValue="${testFlow.applicantName}" title="用户" 
									url="/sys/office/treeData?type=4" cssClass="required" allowClear="true" checked="false" notAllowSelectParent="true" isAll="true"/> 
                        	</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title=""> <span class="required">*</span> 单据类型：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:select path="billtypeCode" class="form-control required">
										<form:option value="" label="" />
										<form:options items="${fns:getDictList('eflow_bill_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
									</form:select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
				   <div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 公司：</label>
							<div class="col-sm-8">
								<sys:treeselect id="company" name="companyCode" value="${testFlow.companyCode}" labelName="companyName" labelValue="${testFlow.companyName}"
									title="公司" url="/sys/company/treeData" allowClear="true" cssClass="required" />
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 部门：</label>
							<div class="col-sm-8">
								<sys:treeselect id="office" name="officeCode" value="${testFlow.officeCode}" labelName="officeName" labelValue="${testFlow.officeName}" 
								title="部门" url="/sys/office/treeData" isAll="true" cssClass="required" allowClear="true" notAllowSelectParent="true" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
				   <div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4"><span class="required">*</span> 单据日期：</label>
							<div class="col-sm-8">
								<input id="billDate" name="billDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate required"
									value="<fmt:formatDate value="${testFlow.billDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title=""> 金额：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
									 <form:input path="billAmt" htmlEscape="false" maxlength="18" class="form-control number"/>						
							</div>
						</div>
					</div>
				</div>				
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title=""> 业务描述：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">	
							      <form:textarea path="remarks" rows="4" htmlEscape="false" maxlength="500" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
				<div class="hide">
					<input type="hidden" id="flowId" name="flowId"/>
					<sys:listselect id="approval" name="approvalCode" value="" labelName="approvalName" labelValue=""
						boxHeight="500"	boxWidth="450" returnCodeAttr="userCode" returnNameAttr="userName"	title="审批人" url="" multiple="true" cssClass="form-control"  />
				</div>
				<div class="form-actions fluid">
					<div class="row">
						<div class="col-xs-12">
							<div class="col-sm-offset-5 col-sm-10"> 
<!-- 					            <button id="btnSave" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存 </button> &nbsp; -->
					            <button id="btnSubmit" type="button" class="btn btn-primary"><i class="fa fa-check"></i> 提交 </button> &nbsp;
								<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
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
				if(data.result == Global.TRUE){
					closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
						contentWindow.page();
					});
				}
			}, "json");
	    }
	});
  
	$('#btnSubmit').click(function(){
		$.post("${ctx}/eflow/flowTemplate/getFirstStep",
			{"billType":$("#billtypeCode").val(),
			 "companyCode":$("#companyCode").val(), 
			 "officeCode":$("#officeCode").val(),
			 "applicantCode":$("#applicantCode").val(),
			 "billAmt":$("#billAmt").val()},
			function(data){
				if(data.result  == Global.FALSE){
					showMessage(data.message);
				}else{
					$("#flowId").val(data.firstStep.flowId);
					// 指定到人，弹出审批人选择界面
					if(data.firstStep.isFixApproval){
						var url = "${ctx}/eflow/flowBusiness/approvalSelect?flowTemplatesId="+data.firstStep.id;
						$("#approvalDiv").attr("data-url",url);
						$("#approvalName").click();
					} else if(data.firstStep.approvalType == "1"){
						// 不指定人，直接提交
						$("#inputForm").submit();
					}
					
				}
			},"json"
		)
	});
		

	function approvalCallbackForMap(dataMap, v, h, f){
		$.each(dataMap, function(key, value){
			$("#approvalCode").val(value.userCode);
		})
		$("#inputForm").submit();
	}

</script>