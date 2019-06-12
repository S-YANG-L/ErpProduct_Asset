<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid,validate"/>
<c:set var="extHead">
<style type="text/css">
<!--
div.tagsinput { border:1px solid #ccc; background:#fff; margin:9px 0; padding:5px; padding-bottom:0; overflow-y: auto;width:auto;min-height:42px; height:42px;}
div.tagsinput span.tag { border: 1px solid #a5d24a; -moz-border-radius:2px; -webkit-border-radius:2px; display: block; float: left; padding: 5px; text-decoration:none; background: #cde69c; color: #638421; margin-right: 5px; margin-bottom:5px;}
div.tagsinput span.tag a { font-weight: bold; color: #82ad2b; text-decoration:none; font-size: 11px;  } 
div.tagsinput input { width:80px; margin:0px; font-family: helvetica; font-size: 13px; border:1px solid transparent; padding:5px; background: transparent; color: #000; outline:0px;  margin-right:5px; margin-bottom:5px; }
div.tagsinput div { display:block; float: left; } 
.tags_clear { clear: both; width: 100%; height: 0px; }
.not_valid {background: #fbd8db !important; color: #90111a !important;}
-->
</style>
</c:set>
<sys:header title="用户授权角色" extLibs="${extLibs}" extHead="${extHead}"/>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> 用户授权角色(${role.roleName})</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/listData?isAll=true" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<c:choose>
				<c:when test="${fns:getModule('core_extend').isEnable}">
					<div class="form-group">
						<label class="control-label">用户名称：</label>
							<form:input path="userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">登录账号：</label>
							<form:input path="loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">所属公司：</label>
						<div class="input-inline width-160">
							<sys:treeselect id="employeeCompany" name="employee.companyCode" value="" labelName="employee.company.companyName" labelValue="" 
								title="公司" url="/sys/company/treeData" controlSize="sm" allowClear="true"/>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="form-group">
						<label class="control-label">员工姓名：</label>
							<form:input path="employee.empName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">员工编码：</label>
							<form:input path="employee.empNo" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">所属机构：</label>
						<div class="input-inline width-160">
							<sys:treeselect id="employeeOffice" name="employee.officeCode" value="" labelName="employee.office.officeName" labelValue="" 
								title="机构" url="/sys/office/treeData" controlSize="sm" allowClear="true"/>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-group">
						<label class="control-label">登录账号：</label>
							<form:input path="loginCode" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">用户名称：</label>
							<form:input path="userName" htmlEscape="false" maxlength="50" class="form-control input-sm width-90"/>
					</div>
					<div class="form-group">
						<label class="control-label">所属机构：</label>
						<div class="input-inline width-120">
							<sys:treeselect id="employeeOffice" name="employee.officeCode" value="" labelName="employee.office.officeName" labelValue="" 
								title="机构" url="/sys/office/treeData" controlSize="sm" allowClear="true"/>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="form-group" > &nbsp;&nbsp;
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<table id="dataGrid"></table>
	    <div id="dataGridPage"></div>
		<div id="selectUsers" class="tagsinput"></div>
		<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/saveRoleAuth" method="post" class="form-horizontal">
			<input type="hidden" id="userCodes" name="userCodes"  value=""/>
			<form:hidden path="roleCode"/>
			<div class="form-actions fluid">
				<div class="row">
					<div class="col-sm-offset-2 col-sm-10">
						<shiro:hasPermission name="sys:user:authorize">
							<button id="btnSubmit" type="submit" class="btn btn-primary " ><i class="fa fa-check"></i> 保存</button>&nbsp;
						</shiro:hasPermission>
						<button id="btnCancel" type="button" class="btn default" onclick="closeCurrentTabPage('${param.parentTabPageId}')"><i class="fa fa-reply-all"></i> 关 闭</button>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	var dataGrid; // 定义全局表格对象。
	// 获取数据MAP
	var dataMap = {}, dataSize = 0;
	$(document).ready(function() {
		//<c:if test="${not empty selectData }">
		dataMap = JSON.parse('${fns:toJson(selectData)}');
		selectUsers();
		//</c:if>
		// 初始化DataGrid对象
		dataGrid = new DataGrid({
			
			// 当前页签编号
			tabPageId: '${param.tabPageId}',
			
			// 设置数据表格列
			columnModel: [
				{header:'用户名称', name:'userName', index:'user_name', width:150},
				{header:'登录账号', name:'loginCode', index:'login_code', width:100},
				{header:'所属公司', name:'refObj.companyNameSimple', index:'c.company_name_simple', width:160, align:"center"},
				{header:'组织机构', name:'refObj.officeName', index:'d.office_name', width:160, align:"center"},
				{header:'员工姓名', name:'refObj.empNo', index:'emp_no', width:100},
				{header:'员工编码', name:'refObj.empName', index:'emp_name', width:100},
				{header:'电话', name:'phone', index:'phone', width:100, sortable:false},
				{header:'手机', name:'mobile', index:'mobile', width:100, sortable:false},
				{header:'行数据', name:'rowData', hidden:true, formatter: function(val, obj, row, act){
					return JSON.stringify(row);
				}}
			],
			multiboxonly: false,
			showCheckbox: '${mul}' == 'true',
			ajaxSuccess: function(data){ // 加载成功后执行方法
				$.each(dataMap, function(key, value){
					dataGrid.setSelectRow(key);
				});
			},
			onSelectRow: function(id, isSelect, event){
				if ('${mul}' == 'true'){
					if(isSelect){
						dataMap[id] = JSON.parse(dataGrid.getRowData(id).rowData);
					}else{
						delete dataMap[id];
					}
				}else{
					dataMap = {};
					dataMap[id] = JSON.parse(dataGrid.getRowData(id).rowData);
				}
				selectUsers();
			},
			onSelectAll: function(ids, isSelect){
				if ('${mul}' == 'true'){
					for (var i=0; i<ids.length; i++){
						if(isSelect){
							dataMap[ids[i]] = JSON.parse(dataGrid.getRowData(ids[i]).rowData);
						}else{
							delete dataMap[ids[i]];
						}
					}
				}
				selectUsers();
			},
			ondblClickRow: function(id, rownum, colnum, event){
				if ('${mul}' != 'true'){
					//var $jBox = getJBox();
					//$jBox.getBox().find("button[value='ok']").trigger("click");
				}
				selectUsers();
			}
		});
		
		$("#inputForm").validate({
			submitHandler: function(form){
				var userCodes=[];
				$.each(dataMap, function(key, value){
					userCodes.push(key);
				});
				$('#userCodes').val(userCodes.join(','));
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
	});
	
	function selectUsers(){
		dataSize = 0;
		var selectHtml = "";
		$.each(dataMap, function(key, value){
			dataSize ++;
			selectHtml += '<span class="tag" id="'+key+'_tagsinput"><span>'+value.userName+'&nbsp;&nbsp;</span><a href="#" onclick="removingTag(\''+key+'\');" title="Removing tag">x</a></span>';
		});
		selectHtml = '<span class="tag" style="border-color:#fff;background:#fff;"><span>&nbsp;当前已选择<span id="dataSize">'+dataSize+'</span>项：</span></span>' + selectHtml + '<div class="tags_clear"></div>';
		$('#selectUsers').empty().append(selectHtml); 
	}
	function removingTag(key){
		dataGrid.jqGrid("resetSelection",key);
		delete dataMap[key];
		$('#'+key+'_tagsinput').remove();
	}
	function getDataMap(){
		return dataMap;
	}
</script>