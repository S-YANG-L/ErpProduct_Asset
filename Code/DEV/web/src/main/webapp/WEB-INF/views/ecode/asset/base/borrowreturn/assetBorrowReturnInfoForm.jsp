<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="资产归还" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>资产归还</div>
		<%-- <div class="actions">
			<shiro:hasPermission name="borrow:assetBorrowInfo:edit">
				<a href="#" class="btn btn-default btn-sm" onclick="$('#btnSubmit').click();return false;"><i class="fa fa-check"></i> 保 存</a>
			</shiro:hasPermission>
			<a href="#" class="btn btn-default btn-sm" onclick="$('#btnCancel').click();return false;"><i class="fa fa-reply-all"></i> 关 闭</a>
		</div> --%>
	</div>
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="assetBorrowReturn" action="${ctx}/return/assetBorrowReturn/save" method="post" class="form-horizontal">
		<div class="form-body">
			<form:hidden path="id"/>
			<form:hidden path="companyCode" />
			<form:hidden path="step"/>
			<div class="row">
				<div class="col-xs-6">
					<div class="form-group">
						<label class="control-label col-sm-4" title="">
							<span class="required">*</span> 借用人：<i class="fa icon-question hide"></i></label>
						<div class="col-sm-8">
							<sys:treeselect id="borrower" name="borrowerCode"
											value="${assetBorrowReturn.borrowerCode}" labelName="borrowerName"
											labelValue="${assetBorrowReturn.borrowerName}"
											title="借用人" url="/sys/office/treeData?type=3" cssClass=""
											allowClear="true" notAllowSelectParent="true" isAll="true"/>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="form-group">
						<label class="control-label col-sm-4" title="">
							归还人：<i class="fa icon-question hide"></i></label>
						<div class="col-sm-8">
								<%--<form:input path="restituerName" htmlEscape="false" maxlength="100" class="form-control"/>--%>
							<sys:treeselect id="restituerCode" name="restituerCode"
											value="${assetBorrowReturn.restituerCode}" labelName="restituerName"
											labelValue="${assetBorrowReturn.restituerName}"
											title="借用人" url="/sys/office/treeData?type=3" cssClass=""
											allowClear="true" notAllowSelectParent="true" isAll="true"/>
						</div>
					</div>
				</div>

			</div>
			<div class="row">
				<div class="col-xs-6">
					<div class="form-group">
						<label class="control-label col-sm-4" title="">
							<span class="required">*</span> 归还日期：<i class="fa icon-question hide"></i></label>
						<div class="col-sm-8">
							<input name="factReturnDate" id="factReturnDate" type="text" readonly="true"  maxlength="20" class="form-control Wdate required"
								   value="<fmt:formatDate value="${assetBorrowReturn.factReturnDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,maxDate:'#F{$dp.$D(\'expectedReturnDate\')}'});"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<div class="form-group">
						<label class="control-label col-sm-2" title="">说明:</label>
						<div class="col-sm-10">
							<form:textarea path="notes" htmlEscpace="false" rows="4" maxlength="255" class="form-control" />
						</div>
					</div>
				</div>
			</div>
			<c:choose>
			<c:when test="${assetBorrowReturn.isNewRecord == true}">
					<div class="row">
						<div class="col-sm-6" hidden="hidden">
							<a href="#" id="btnAddRow" class="btn btn-default"><i
									class="fa fa-plus"></i></a>
						</div>
						<div class="col-sm-6">
							<a href="#" id="btnAddRowinfo" onclick="selectInvWindow()" class="btn btn-default"><i
									class="fa fa-plus"></i>选择资产</a>
						</div>
					</div>
			</c:when>
			</c:choose>

					<div class="row">
						<div class="col-sm-12">
							<table id="dataGrid"></table>
							<div id="dataGridPage"></div>
						</div>
					</div>



			<div style="padding-top: 10px;"></div>
			<div class="hide">
				<input type="hidden" id="flowId" name="flowId" />
				<sys:listselect id="approval" name="approvalCode" value=""
								labelName="approvalName" labelValue="" returnCodeAttr="userCode"
								returnNameAttr="userName" title="审批人" url="" multiple="false"
								cssClass="form-control" />
			</div>
			<div class="hide">
				<sys:listselect id="nextApproval" name="nextApprovalCode" value=""
								labelName="nextApprovalName" labelValue="" boxHeight="500"
								boxWidth="450" returnCodeAttr="userCode" returnNameAttr="userName"
								title="审批人" url="" multiple="false" cssClass="form-control" />
			</div>
			<c:if test="${assetUsedInfo.pageFlag == 1||assetUsedInfo.pageFlag == 2}">
				<div class="row">
					<div class="col-xs-12">
						<div class="form-group"hidden="hidden">
							<label class="control-label col-sm-2">处理意见：</label>
							<div class="col-sm-8">
								<form:textarea path="approvalMemo"  htmlEscape="false" rows="4" maxlength="255" value=""
											   class="form-control"/>
								<span class="help-block">&nbsp;</span>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<c:choose>
							<c:when test="${assetBorrowReturn.isNewRecord == true}">
								<button id="btnSubmit" type="button" class="btn btn-primary">
									<i class="fa fa-reply-all"></i> 提 交
								</button>
							</c:when>

							<c:when test="${assetBorrowReturn.pageFlag == 0}">
								<!-- 我的申请 -->
								<button id="btnSubmit" type="button" class="btn btn-primary">
									<i class="fa fa-reply-all"></i> 提 交
								</button>
								<button id="btnUnSubmit" type="button"
										class="btn btn-primary">
									<i class="fa fa-reply-all"></i> 撤回申请
								</button>
							</c:when>
							<c:when test="${assetBorrowReturn.pageFlag == 1}">
								<!-- 我的待办 -->
								<button id="btnAuditPass" type="button"
										class="btn btn-primary">
									<i class="fa fa-check"></i></i> 审批通过
								</button>
								<button id="btnReject" type="button" class="btn btn-primary">
									<i class="fa fa-times"></i> 驳回
								</button>
							</c:when>
							<c:when test="${assetBorrowReturn.pageFlag == 2}">
								<!-- 我的已办 -->
								<button id="btnUndo" type="button" class="btn btn-primary">
									<i class="fa fa-reply-all"></i> 撤回审批
								</button>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${assetBorrowReturn.pageFlag == 0}">
								<button id="btnDelete" type="button" class="btn btn-primary">
									<i class="fa fa-reply-all"></i> 删除申请
								</button>
							</c:when>
						</c:choose>
						<button id="btnCancel" type="button" class="btn btn-danger"
								onclick="closeCurrentTabPage('${param.parentTabPageId}')">
							<i class="fa fa-reply-all"></i> 关 闭
						</button>
					</div>
				</div>
			</div>
			</form:form>
			<form:form id="searchForm2" method="post" action="${ctx}/return/assetBorrowReturn/getDtlData?borrowCode=${borrowCode}">
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
        // 初始化DataGrid对象
        var codes="";
        var assetcodes = [];
        $("#dataGrid").dataGrid({
            searchForm: $("#searchForm2"), // 数据来源表单
            // 设置数据表格列
            columnModel: [
                /* {header:'借用编码', name:'borrowCode', index:'a.borrow_code', width:50, align: "left"}, */
                {header:'资产编码', name:'assetCode', index:'a.asset_code', width:50,  align: "left", formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="assetCode" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }},
                {header:'资产名称', name:'assetName', index:'a.asset_name', width:50, align: "left",
                    formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="assetName" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }},
                {
                    header: '资产分类编码',
                    name: 'sortCode',
                    width: 200,
                    align: "left",
                    hidden:true,
                    formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="sortCode" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }
                },
                {header:'资产分类名称', name:'sortName', index:'a.sort_name', width:70,  align: "left",
                    formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="sortName" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }},
                {header:'品牌', name:'brand', index:'a.brand', width:50, align: "left", formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="brand" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }},
                {header:'型号', name:'version', index:'a.version', width:50,align: "left", formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="version" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }},
                /* {header:'存放地点', name:'storagePlace', index:'a.storage_place', width:50, editable : true}, */
                {header:'公司名称', name:'companyName', index:'a.company_name', width:50,  align: "left",
                    formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="companyName" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }},
                { header: '行数据', name: 'rowData', hidden: true, formatter: function (val, obj, row, act) {
                        return JSON.stringify(row);
                    }
                },
                {
                    header: '资产状态',
                    name: 'assetStatus',
                    index: 'a.asset_status',
                    width: 50,
                    hidden:true,
                    align: "left",
                    formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="assetStatus" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }
                },
                {
                    header: '原使用人',
                    name: 'yuanuserName',
                    index: 'a.yuanuser_name',
                    width: 50,
                    hidden:true,
                    align: "left",
                    formatter: function (val, obj, row, act) {
                        var actions = [];
                        actions.push('<input type="hidden" name="yuanuserName" value="' + val + '" />');
                        actions.push(val);
                        return actions.join('');
                    }
                },
                {header:'操作', name:'actions', width:50, fixed:true, sortable:false,
                    hidden: ${assetBorrowInfo.step==2 ? 'false' : 'true'},
					formatter: function(val, obj, row, act){
                        var actions = [];
                        <c:choose>
                        <c:when test="${assetBorrowReturn.isNewRecord == true}">
                        actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\'' + obj.rowId + '\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
                        </c:when>
                        </c:choose>
                        return actions.join('');
                    }}
            ],
            // 编辑表格参数
            editGrid: true,				// 是否是编辑表格
            editGridInitRowNum: 0,		// 编辑表格的初始化新增行数
            editGridAddRowBtn: $('#btnAddRow'),	// 子表增行按钮
            ajaxSuccess: function (data) { // 加载成功后执行方法
                $('#dataGrid').dataGrid('getParam', 'onSelectRow')('new');
            }, onSelectRow: function (id, isSelect, event) {
                var dg = $('#dataGrid');
                codes = dg.dataGrid('getDataIDs');
                console.log("UU",codes);
            }


        });


        //选择资产
        function selectInvWindow() {
            getexisting();
            var assetcode =assetcodes.join(',')
            var selectData = "";
            console.log("assetClassCodeCode",$("#assetClassCodeCode").val());
            console.log("assetClassCodeName",$("#assetClassCodeName").val());
            var $jBox = getJBox();
            $jBox.open("iframe:${ctx}/return/assetBorrowReturn/getusedDtllist?assetCode="+ assetcode+"&user=" + $("#borrowerCode").val(), "选择资产", $(window).width() - 100, $(window).height() - 100,
                {
                    ajaxData: {selectData: selectData},
                    buttons: {
                        "<i class=glyphicon glyphicon-ok></i>&nbsp;确定": "ok",
                        /* "<i class=\"fa fa-eraser\"></i>&nbsp;清除":"clear", */
                        '<i class=glyphicon glyphicon-remove></i>&nbsp;关闭': "close"
                    },
                    submit: function (v, h, f) { // v表示所点的按钮的返回值，h表示窗口内容的jQuery对象，f表示窗口内容里的form表单键值
                        var w = h.find("iframe")[0].contentWindow;
                        var dataMap = w.getDataMap();
                        $.each(dataMap, function (key, value) {
                            $('#btnAddRow').click();
                            var selRow = $("#dataGrid").dataGrid("getSelectRow");
                            $("#dataGrid").dataGrid("setRowData", selRow, {assetCode: value.assetCode});
                            $("#dataGrid").dataGrid("setRowData", selRow, {assetName: value.assetName});
                            $("#dataGrid").dataGrid("setRowData", selRow, {sortCode: value.sortCode});
                            $("#dataGrid").dataGrid("setRowData", selRow, {sortName: value.sortName});
                            $("#dataGrid").dataGrid("setRowData", selRow, {brand: value.brand});
                            $("#dataGrid").dataGrid("setRowData", selRow, {version: value.version});
                            $("#dataGrid").dataGrid("setRowData", selRow, {companyCode: value.companyCode});
                            $("#dataGrid").dataGrid("setRowData", selRow, {companyName: value.companyName});
                            $("#dataGrid").dataGrid("setRowData", selRow, {yuanuserName: value.yuanuserName});
                            $("#dataGrid").dataGrid("setRowData", selRow, {assetStatus: value.assetStatus});
                        });

                    },
                    loaded: function (h) {
                        $(".jbox-content", $jBox.getBox()).css("overflow-y", "hidden");
                    }
                });

        }



        //提交前更新列表字段名字，以方便后台接受
        function updateListFieldName(dg, listName, fieldName) {
            dg.find('[name$="' + fieldName + '"]:not(div,a)').each(
                function(key, val) {
                    $(this).attr('name',listName + '[' + key + '].' + fieldName);
                });
        }
        function getexisting() {
            assetcodes= [];
            $("#dataGrid").find("[name$='assetCode']").each(function () {
                assetcodes.push($(this).val());
            });
        }
        //工作流对应模板
        $('#btnSubmit').click(function(){
            $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
                {"billType":"ZCJYGH", // 对应工作流模板的单据类型
                    "companyCode":$("#companyCode").val(),// 申请人公司编码
                    "officeCode":$("#officeCode").val() // 申请人部门编码
                },
                function(data){
                    if(data.result  == Global.FALSE){
                        showMessage(data.message);
                    }else{
                        console.log("cc",data.message);
                        $("#flowId").val(data.message);
                        var url = "${ctx}/return/assetBorrowReturn/approvalSelect?applicantCode="+$("#applicantCode").val()+"&flowId="+data.message;
                        $("#approvalDiv").attr("data-url",url);
                        $("#approvalName").click();
                    }
                },"json"
            )
        });
        //审批通过
        $("#btnAuditPass").click(function(){
            $.post("${ctx}/eflow/flowTemplate/getFlowTemplate",
                {"billType":"ZCJYGH", // 对应工作流模板的单据类型
                    "companyCode":$("#companyCode").val(),// 申请人公司编码
                    "officeCode":$("#officeCode").val() // 申请人部门编码
                },
                function(data){
                    if(data.result  == Global.FALSE){
                        showMessage(data.message);
                    }else{
                        $("#flowId").val(data.message);
                        var flowId = data.message;
                        var url="${ctx}/return/assetBorrowReturn/getNextFlowBusiness?bizKey="+$("#id").val()+"&step=${assetBorrowReturn.step}";
                        $.post(url,function(data){
                            if(data==0){//审批最后一步
                                <%--var stepId="${param.stepId}";--%>
                                <%--var url="${ctx}/return/assetBorrowReturn/agreePc?flowBusinessId="+stepId+"&nextApprovalCode="+nextApprovalCode+"&approvalMemo1="+$("#approvalMemo").val()+"&isEnd=1"+"&sysCode="+$("#id").val()+"&id="+$("#id").val()+"&nextApprovalName="+nextApprovalName;--%>

                                var stepId="${param.stepId}";
                                var stepId="${param.stepId}";
                                var urls="${ctx}/return/assetBorrowReturn/agreePc?flowBusinessId="+stepId+"&approvalMemo1="+$("#approvalMemo").val()+"&isEnd=0"+"&sysCode="+$("#id").val()+"&id="+$("#id").val();
                                $.post(urls,function(data){
                                    showMessage(data.message);
                                    if(data.result==Global.TRUE){
                                        closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
                                            contentWindow.page();
                                        });

                                    }
                                },"json");
                            }
                            else if(data==1){
                                var url = "${ctx}/return/assetBorrowReturn/nextApprovalSelect?bizKey=${assetBorrowReturn.id}&flowId="+flowId+"&step=${assetBorrowReturn.step}&";
                                $("#nextApprovalDiv").attr("data-url",url);
                                $("#nextApprovalName").click();
                            }
                        });

                    }
                },"json"
            )


        });

        //驳回
        $("#btnReject").click(function(){
            var stepId="${param.stepId}";
            var url="${ctx}/return/assetBorrowReturn/disagreePc?flowBusinessId="+stepId+"&approvalMemo1="+$("#approvalMemo").val()+"&sysCode="+$("#id").val()+"&id="+$("#id").val();
            $.post(url,function(data){
                showMessage(data.message);
                if(data.result==Global.TRUE){
                    closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
                        contentWindow.page();
                    });

                }
            },"json");

        });

        //撤回审批
        $("#btnUndo").click(function(){
            var stepId="${param.stepId}";
            var url="${ctx}/return/assetBorrowReturn/unDo?bizKey="+$("#id").val();
            $.post(url,function(data){
                showMessage(data.messagePc);
                if(data.code=="200"){
                    closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
                        contentWindow.page();
                    });

                }
            },"json");

        });
        function nextApprovalCallbackForMap(dataMap, v, h, f){
            $.each(dataMap, function(key, value){
                $("#nextApprovalCode").val(value.userCode);
                $("#nextApprovalName").val(value.userName);
            })
            var nextApprovalCode = $("#nextApprovalCode").val();
            var nextApprovalName = $("#nextApprovalName").val();
            var stepId="${param.stepId}";
            var url="${ctx}/return/assetBorrowReturn/agreePc?flowBusinessId="+stepId+"&nextApprovalCode="+nextApprovalCode+"&approvalMemo1="+$("#approvalMemo").val()+"&isEnd=1"+"&sysCode="+$("#id").val()+"&id="+$("#id").val()+"&nextApprovalName="+nextApprovalName;
            $.post(url,function(data){
                console.log(data);
                showMessage(data.message);
                if(data.result==Global.TRUE){
                    closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
                        contentWindow.page();
                    });

                }
            },"json");
        }
        function approvalCallbackForMap(dataMap, v, h, f){
            $.each(dataMap, function(key, value){
                $("#approvalCode").val(value.userCode);
            })
            var dg = $('#dataGrid');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'borrowCode');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'assetCode');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'assetName');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'sortCode');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'sortName');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'brand');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'version');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'companyCode');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'companyName');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'yuanuserName');
            updateListFieldName(dg, 'assetBorrowReturnDtl', 'assetStatus');
            $("#inputForm").submit();
        }
        function assetBorrowInfoDetailCallbackForMap(dataMap, v, h, f) {
            var codes = [], names = [], empCode = [];
            $.each(dataMap, function(key, value) {
                codes.push(value.empCode);
                names.push(value.empName);
            });
            $('#assetBorrowInfoDetailCode').val(codes.join(','));
            $('#assetBorrowInfoDetailName').val(names.join(','));
        }

        //撤回申请
        $("#btnUnSubmit").click(function(){
            var url="${ctx}/return/assetBorrowReturn/unSubmit?bizKey="+$("#id").val();
            $.post(url,function(data){
                if(data.message=="success"){
                    showMessage(data.true);
                    closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
                        contentWindow.page();
                    });

                }else{
                    showMessage(data.false);
                }
            },"json");

        });
        //删除申请
        $("#btnDelete").click(function(){
            var stepId="${param.stepId}";
            var url="${ctx}/return/assetBorrowReturn/delete?id="+$("#id").val();
            $.post(url,function(data){
                showMessage(data.message);
                if(data.result==Global.TRUE){
                    closeCurrentTabPage('${param.parentTabPageId}', function(contents, contentWindow){
                        contentWindow.page();
                    });
                }
            },"json");

        });
	</script>