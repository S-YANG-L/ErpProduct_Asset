<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="费用报销管理 - ${baoxiao.isNewRecord ? '新增' : '编辑'}费用报销" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>${baoxiao.isNewRecord ? '新增' : '编辑'}费用报销</div>
	</div>	
	<div class="portlet-body form">
		<form:form id="inputForm" modelAttribute="baoxiao" action="${ctx}/jflow/baoxiao/save" method="post" class="form-horizontal">
			<div class="form-body">
				<h4 class="form-section">基本信息</h4>
				<form:hidden path="id"/>
				<form:hidden path="baoxiaoHj"/>
				<form:hidden path="FK_Flow"/>
				<form:hidden path="WorkID"/>
				<form:hidden path="FK_Node"/>
				<form:hidden path="FID"/>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								公司：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="company" name="company.companyCode" value="${baoxiao.company.companyCode}" labelName="company.companyName" labelValue="${baoxiao.company.companyName}"
									title="公司" url="/sys/company/treeData" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span>预算部门：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="office" name="office.officeCode" value="${baoxiao.office.officeCode}" labelName="office.officeName" labelValue="${baoxiao.office.officeName}"
									title="部门" url="/sys/office/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span>申请人：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<sys:treeselect id="user" name="user.userCode" value="${baoxiao.user.userCode}" labelName="user.userName" labelValue="${baoxiao.user.userName}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="required"  allowClear="true" notAllowSelectParent="true"/>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								<span class="required">*</span>申请日期：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<input name="sqDate" type="text" readonly="readonly" maxlength="20" class="form-control Wdate required"
									value="<fmt:formatDate value="${baoxiao.sqDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<%-- <div class="col-xs-6">
						<div class="form-group">
							<label class="control-label col-sm-4" title="">
								报销金额合计：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-8">
								<form:input path="baoxiaoHj" htmlEscape="false" class="form-control number"/>
							</div>
						</div>
					</div>
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label col-sm-2" title="">
								备注信息：<i class="fa icon-question hide"></i></label>
							<div class="col-sm-10">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
							</div>
						</div>
					</div> --%>
					<table id="dataGrid"></table>
				</div>
			</div>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<%-- <shiro:hasPermission name="jflow:baoxiao:edit">
							<button id="btnSubmit" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保 存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button> --%>
						<a href="#" class="btn btn-default btn-sm" id="btnAddRow" title="增行"><i class="fa fa-plus"></i> 增行</a>
						<jsp:include page="/WF/SDKComponents/Toolbar.jsp"/> 
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
	// 报销总金额
	var tatalApplyMoney=0;
	$('#dataGrid').dataGrid({
		// 当前页签编号
			datatype: "local",
			data:${fns:toJson(childList)},
			shrinkToFit: false,//按百分比自动调整列宽
			showRownum: true,
			showFooter: true,
			frozenCols: false, 	// 冻结列，在colModel指定frozen: true
			columnModel: [
				{header:'费用项目', name:'baoxiaoType',  width:200,editable: true }, 
				{header:'项目名称', name:'projCode',  width:200, editable: true },
	            {header:'金额', name:'jine', width:200, align:"right", editable: true ,
		        	 editoptions:{
		        		 'class':'number required',
						 dataEvents: [
		                   {
		                       type: 'blur',     //blur,focus,change........焦点失去事件
		                       fn: calcSumMoney  
		                   }
					     ]
					}}, 
				 {header:'摘要', name:'zhaiyao', width:300, editable: true },
				 {header:'操作', name:'actions', width:100, align:'center', sortable:false, formatter: function(val, obj, row, act){
					var actions = [];
					actions.push('<a href="#" onclick="confirmx(\'你确认要删除这条数据吗？\', function(){$(\'#dataGrid\').dataGrid(\'delRowData\',\''+obj.rowId+'\')});return false;"><i class="fa fa-trash-o"></i></a>&nbsp;');
					return actions.join('');
				}}
			],
			onSelectRow: function(id) {
				if (id){
		        	var dg = $('#dataGrid');
					// 按回车焦点向下获取，到最后一列时，调用此方法新增一行空数据，若不需要新增行，则不需要此代码
		        	if (id == 'new'){
		            	var dg = $('#dataGrid');
		            	dg.dataGrid('addRow', { position: 'last', 
		            		addRowParams: { keys: true, focusField: true}
		            	});
		            }
		        }
			},
			ajaxSuccess: function(data){ // 加载成功后执行方法
				//console.log(data)
				if(data && data.rows.length > 0){//判断是否有数据（判断的方法可以跟踪console.log(data)来决定）
						tatalApplyMoney=0;
						// 初始化后编辑所有行
						var dg = $("#dataGrid");
						var ids = dg.dataGrid('getDataIDs');
						for (var i = 0; i < ids.length; i++) {
							dg.dataGrid('editRow', ids[i], {keys:true,focusField:false});
						}
						$("#dataGrid").find("input[name$='jine']").each(function(){
							tatalApplyMoney=tatalApplyMoney+(Number($(this).val()));
							
						});
						
						$('#dataGrid').dataGrid("footerData", "set", {	
							'baoxiaoType': '<em class="pull-right">合计：</em>',
							'jine': '<em class="pull-right">'+tatalApplyMoney+'</em>' 
						}, false);
					 
				}else{  //没有数据默认新增一行
						$('#dataGrid').dataGrid('getParam','onSelectRow')('new');
						//重新计算底部合计行
						$('#dataGrid').dataGrid("footerData", "set", {		
							'baoxiaoType': '<em class="pull-right">合计：</em>',
							'jine': '<em class="pull-right">'+tatalApplyMoney+'</em>'
						}, false);	
						$("#baoxiaoHj").val(tatalApplyMoney);
				} 
			}
		});
	//提交前更新列表字段名字，以方便后台接受
	function updateListFieldName(dg, listName, fieldName){
		dg.find('[name$="'+fieldName+'"]:not(div,a)').each(function(key, val){
			$(this).attr('name',listName + '['+key+'].' + fieldName);
		});
	}
	
	function calcSumMoney(){
		//计算比例合计
		tatalApplyMoney=0;
		$("#dataGrid").find("input[name$='jine']").each(function(){
			tatalApplyMoney=tatalApplyMoney+(Number($(this).val()));
			
		});
		$('#dataGrid').dataGrid("footerData", "set", {	
			'baoxiaoType': '<em class="pull-right">合计：</em>',
			'jine': '<em class="pull-right">'+tatalApplyMoney+'</em>' 
		}, false);
		
		$("#baoxiaoHj").val(tatalApplyMoney);
	}
	
	
	

	//增行
	$("#btnAddRow").click(function(){
		$('#dataGrid').dataGrid('getParam','onSelectRow')('new');
	});
	
	//重写执行发送的方法.
	 function Send() {
		 var dg = $('#dataGrid');
		 updateListFieldName(dg, 'childList', 'baoxiaoType');
		 updateListFieldName(dg, 'childList', 'projCode');
		 updateListFieldName(dg, 'childList', 'jine');
		 updateListFieldName(dg, 'childList', 'zhaiyao');
		 $("#inputForm").attr("action", "${ctx}/jflow/baoxiao/send"); 
		 $("#inputForm").submit();
	 }
	 //重写保存的方法.
   function Save() {
	   var dg = $('#dataGrid');
	   updateListFieldName(dg, 'childList', 'baoxiaoType');
	   updateListFieldName(dg, 'childList', 'projCode');
	   updateListFieldName(dg, 'childList', 'jine');
	   updateListFieldName(dg, 'childList', 'zhaiyao');
	   $("#inputForm").submit();
   }
</script>