<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="validate,fileupload"/>
<sys:header title="资产入库 - ${assetInfo.isNewRecord ? '新增' : '查看'}资产入库" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
    <div class="portlet-title">
        <div class="caption"><i class="fa fa-coffee"></i>${assetInfo.isNewRecord ? '新增资产' : '查看资产'}</div>
       <div class="actions">
        </div>
    </div>
    <div class="portlet-body form">
        <form:form id="inputForm" modelAttribute="assetInfo" action="${ctx}/ass/assetInfo/save" method="post" class="form-horizontal">
            <div class="form-body">
                <form:hidden path="id"/>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 资产名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="assetName" htmlEscape="false" maxlength="100" onclick=""
                                            class="form-control required"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                             财务编码：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="financeCode" htmlEscape="false" maxlength="100"
                                            class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 购入日期：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <input name="buyDate" type="text" readonly="readonly" maxlength="20"
                                       class="form-control Wdate required"
                                       value="<fmt:formatDate value="${assetInfo.buyDate}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 资产大类：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect url="${ctx}/ass/assetSort/treeDataTop" id="topSortCode"
                                                value="${assetInfo.topSortCode}" labelName="topSortName"
                                                labelValue="${assetInfo.topSortName}" title="资产大类"
                                                name="topSortCode"
                                                cssClass="rightBorder" allowClear="true"
                                                notAllowSelectParent="true" isAll="true">
                                </sys:treeselect>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 资产小类：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect url="${ctx}/ass/assetSort/treeDataXiaoNULL" id="sortCode"
                                                value="${assetInfo.sortCode}" labelName="sortName"
                                                labelValue="${assetInfo.sortName}" title="资产小类" name="sortCode"
                                                cssClass="rightBorder" allowClear="true"
                                                notAllowSelectParent="true" isAll="true">
                                </sys:treeselect>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 存放地点：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:select path="storagePlaceCode" class="form-control required selectHeight"
                                             onchange="selProjectName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${locations}" itemLabel="localeName" itemValue="localeCode"
                                                  htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="storagePlace"/>
                            </div>
                        </div>
                    </div>
                </div>

                 <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 计量单位：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="unit" htmlEscape="false" maxlength="64"
                                            class="form-control required"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                品牌：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="brand" htmlEscape="false" maxlength="100"
                                            class="form-control "/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                型号：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="version" htmlEscape="false" maxlength="64"
                                            class="form-control "/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                使用部门：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect id="office" name="office"
                                                value="${assetInfo.office}"
                                                labelName="officeName" labelValue="${assetInfo.officeName}"
                                                title="部门" url="/sys/office/treeData?type=2" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                使用人名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <sys:treeselect id="user" name="user" value="${assetInfo.user}"
                                                labelName="userName" labelValue="${assetInfo.userName}"
                                                title="使用人" url="${ctx}/ass/assetSort/treeDataXiaoNULL" cssClass=""
                                                allowClear="true" notAllowSelectParent="true" isAll="true"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 区域名称：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:select path="regionCode" htmlEscape="false" maxlength="20"
                                             class="form-control required" onclick="getregionCode()">
                                    <form:option value=" ">&nbsp;</form:option>
                                    <form:options items="${fns:getUserDictList('ass_area')}"
                                                  itemLabel="dictName" itemValue="dictValue" htmlEscape="false"/>
                                </form:select>
                            </div>
                            <form:input path="regionName" type="hidden"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span>供货商:<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:select path="supplierCode" class="form-control required selectHeight"
                                             onchange="supplierInfoName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${supplierInfos}" itemLabel="supplierName"
                                                  itemValue="id"
                                                  htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="supplier"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span>是否折旧:<i
                                    class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:radiobuttons path="accountStatus" htmlEscape="false"
                                                 class="form-control required"
                                                 items="${fns:getDictList('isDepreciation')}" itemLabel="label"
                                                 itemValue="value"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 净残值率<span class="required">(%)</span> ：<i
                                    class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="residualValue" htmlEscape="false" maxlength="64"
                                            onblur="unResidualValue()"
                                            class="form-control number required"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 原值：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="unitPrice" htmlEscape="false" class="form-control number required"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 数量：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="quantity" htmlEscape="false" maxlength="64"
                                            class="form-control required digits"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4" title="">
                                <span class="required">*</span> 使用期限(月)：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-8">
                                <form:input path="ageLimit" htmlEscape="false" class="form-control required digits"/>
                            </div>
                        </div>
                    </div>

                </div>
               
                <div class="row">
                    <div class="col-xs-8">
                        <div class="form-group">
                            <label class="control-label col-sm-2" title="">
                                备注信息：<i class="fa icon-question hide"></i></label>
                            <div class="col-sm-10">
                                <form:textarea path="remarks" htmlEscape="false" rows="6" maxlength="1000"
                                               class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label class="control-label col-sm-4">图片： </label>
                            <div class="col-sm-8">
                                <sys:fileupload maxUploadNum="1" id="picturePath" bizCategory="picturePath"
                                                bizKey="${assetInfo.picturePath}" uploadType="image" returnPath="true"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-actions fluid">
                <div class="row">
                    <div class="col-sm-offset-2 col-sm-10">
                        <shiro:hasPermission name="ass:assetInfo:edit">
                            <c:choose>
                                <c:when test="${assetInfo.isNewRecord == true}">
                                    <button id="btnSubmit" type="submit" class="btn btn-primary"><i
                                            class="fa fa-check"></i> 保 存
                                    </button>
                                    &nbsp;
                                </c:when>
                            </c:choose>
                        </shiro:hasPermission>
                        <button id="btnCancel" type="button" class="btn default"
                                onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i
                                class="fa fa-reply-all"></i> 关 闭
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">


    $("#inputForm").validate({
        submitHandler: function (form) {
            ajaxSubmitForm($(form), function (data) {
                showMessage(data.message);
                if (data.result == Global.TRUE) {
                    closeCurrentTabPage('${param.parentTabPageId}', function (contents, contentWindow) {
                        contentWindow.page();
                    });
                }
            }, "json");
        }
    });

    //customerCode为id
    $("#sortCodeName").click(function(){
        var topSortCode = $("#topSortCodeCode").val();
        if(topSortCode == null || topSortCode == ""){
            showMessage("请先选择资产大类！");
        }
    })

    //customerCode为id
    $("#userName").click(function(){
        var office = $("#officeCode").val();
        if(office == null || office == ""){
            showMessage("请先选择使用部门！");
        }
    })
    function unResidualValue() {
        if (parseInt($("#residualValue").val()) > 100) {
            showMessage("不能超过100");
            $("#residualValue").val("0");
        } else {

        }
    }
    // extCode
    function topSortCodeTreeselectCallBack(v, h, f) {
        console.log("asasas")
        var url = "${ctx}/ass/assetSort/treeDataXiao?id=" + $("#topSortCodeCode").val();
        $("#sortCodeDiv").attr("data-url", url);
        $("#sortCodeCode").val("");
        $("#sortCodeName").val("");
    }

    function officeTreeselectCallBack(v, h, f) {
        console.log("asasas")
        var url = "${ctx}/ass/assetInfo/treeData?type=3&extCode=" + $("#officeCode").val();
        $("#userDiv").attr("data-url", url);
        $("#userCode").val("");
        $("#userName").val("");
    }
    function getregionCode() {
        $("#regionName").val($("#regionCode").select2("data").text);
    }

    var supplierInfoList =${fns:toJson(supplierInfos)};

    function supplierInfoName() {
        var supplierCode = $("#supplierCode").val();
        $.each(supplierInfoList, function (key, value) {
            if (supplierCode == value.id) {
                $("#supplier").val(value.supplierName);
            }
        });
    }

    var voucherList =${fns:toJson(locations)};

    function selProjectName() {
        var storagePlaceCode = $("#storagePlaceCode").val();
        $.each(voucherList, function (key, value) {
            if (storagePlaceCode == value.localeCode) {
                $("#storagePlace").val(value.localeName);
            }
        });
    }

</script>
