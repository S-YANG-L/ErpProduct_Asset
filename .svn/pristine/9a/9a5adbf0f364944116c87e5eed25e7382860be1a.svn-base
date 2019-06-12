<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate"/>
<sys:header title="流程审批" extLibs="${extLibs}" />
<style type="text/css">
	.btn-group li a{text-align: left;}
</style>
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="flowBusiness" action="" method="post" class="form-horizontal">
			<div class="form-body">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 会审审批人：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-4">
								<sys:treeselect id="jointUser" name="jointUserCode"  value="" labelName="jointUserName" labelValue="" title="会审人员" 
						url="/sys/office/treeData?type=4" checked="true" cssClass="required" allowClear="true" notAllowSelectParent="true" isAll="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								<span class="required">*</span> 会审通过人数：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-2">
								<input id="jointPassNum" name="jointPassNum" htmlEscape="false" class="form-control required number" min="1"/>
							</div>
							<label class="control-label col-sm-8 " style="text-align:left;color:#999;" title="">
								（通过人数达到该值时，即视为审批通过）<i class="fa icon-question hide"></i></label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span> 会审通过后：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input type="radio" name="jointPassType" id="jointPassType1" value="0" htmlEscape="false" maxlength="1" class="form-control" checked="checked"/><label for="jointPassType1">提交到自己</label>
								<c:if test="${flowBusiness.isEnd ne '1' }">
								<input type="radio" name="jointPassType" id="jointPassType2" value="1" htmlEscape="false" maxlength="1" class="form-control"/><label for="jointPassType2">提交到下一步</label>
								</c:if>
								<c:if test="${flowBusiness.isEnd eq '1' }">
								<input type="radio" name="jointPassType" id="jointPassType2" value="1" htmlEscape="false" maxlength="1" class="form-control"/><label for="jointPassType2">结束流程</label>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${flowBusiness.isEnd ne '1' }">
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								下一步审批人：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
							<sys:listselect id="nextApproval" name="nextApprovalCode" value="" labelName="nextApprovalName" labelValue=""
									boxHeight="500"	boxWidth="450"	returnCodeAttr="userCode" returnNameAttr="userName" url="${ctx}/eflow/flowBusiness/nextApprovalSelect?nextFlowBusinessId=${flowBusiness.nextFlowBusinessId }&" title="审批人" multiple="false" cssClass="form-control"  />
							</div>
						</div>
					</div>
				</div>
				</c:if>
			</div>
		</form:form>
	</div>
</div>

<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
$("#inputForm").validate({
	rules: { 
		jointPassNum: { min: 1 }
	}
});
function getDataMap(){
	var dataMap = {}; // 获取数据MAP
	dataMap["jointUserCodes"] = $("#jointUserCode").val();
	dataMap["jointUserNames"] = $("#jointUserName").val();
	dataMap["jointPassNum"] = $("#jointPassNum").val();
	dataMap["jointPassType"] = $('input[name="jointPassType"]:checked ').val();
	dataMap["nextApprovalCode"] = $("#nextApprovalCode").val();
	dataMap["nextApprovalName"] = $("#nextApprovalName").val();
    return dataMap;
}
</script>