<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="单位信息列表" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
    <div class="portlet-title">
        <div class="caption">
            <form:form id="searchForm1" modelAttribute="btypeInfo" action="${ctx}/mdm/btypeInfo/listData" method="post"
                       class="breadcrumb form-inline searchForm"
                       data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
                <div class="form-group">
                    <label class="control-label">单位名称：</label>
                    <div class="input-inline">
                      	<form:input path="btypeName" htmlEscape="false" maxlength="50" class="form-control input-sm width-160"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label">单位分类：</label>
                    <div class="input-inline">
            	<form:select path="propertyCode" htmlEscape="false" maxlength="20" class="form-control width-160 selectHeight">
						 <form:option value=" ">&nbsp;</form:option>
						   <form:options items="${fns:getUserDictList('btype_sort')}" itemLabel="dictName" itemValue="dictValue" htmlEscape="false" />
						</form:select>
                    </div>
                </div>
                <div class="form-group" style="margin-left:10px;">
                    <button type="submit" class="btn btn-primary">查询</button>
                    <button type="reset" class="btn btn-warning">重置</button>
                    <a style="position: relative" href="#" id="colleaguedaohangg" class="btn btn-warning colleaguedaohangg">高级搜索
                        <div id="sanjiao" class="triangle_border_up sanjiao">
                        </div>
                    </a>
                </div>
            </form:form>
        </div>
        <div class="actions">
        	<shiro:hasPermission name="mdm:btypeInfo:edit">
				<a href="${ctx}/mdm/btypeInfo/form" class="btn btn-default btn-sm btnTool" title="新增单位信息"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
        </div>
    </div>
    <div class="portlet-body list">
        <table id="dataGrid"></table>
        <div id="dataGridPage"></div>
    </div>
</div>
<%--遮罩层--%>
<div id="fullScreen" onclick="clearLayer()" class="zhezhaoceng"></div>
<%--高级搜索--%>
<div id="iframe" class="gaoji">
    <div class="portlet-body form">
        <form:form id="searchForm" modelAttribute="btypeInfo" action="${ctx}/mdm/btypeInfo/listData" method="post"
                   class="form-horizontal searchForm"
                   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
            <div class="">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label class="control-label col-lg-4" title="">
                                单位属性：<i class="fa icon-question hide"></i></label>
                            <div class="col-lg-8">
                             	<form:select path="btypeSorts" htmlEscape="false" maxlength="64" class="form-control selectHeight">
						 <form:option value=" ">&nbsp;</form:option>
						   <form:options items="${fns:getDictList('mdm_btype_attr')}" itemLabel="label" itemValue="name" htmlEscape="false" />
						</form:select>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label class="control-label col-lg-4" title="">
                            状态：<i class="fa icon-question hide"></i></label>
                            <div class="col-lg-8">
                     	<form:select path="status" htmlEscape="false" maxlength="64" class="form-control selectHeight">
						   <form:options items="${fns:getDictList('status')}" itemLabel="name" itemValue="value" htmlEscape="false" />
						   <form:option value=" ">&nbsp;</form:option>
						</form:select>
                            </div>
                        </div>
                    </div>
                </div>                  
                    <%--保存按钮--%>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label class="control-label col-lg-4" title=""></label>
                            <div class="col-lg-8">
                                <%--<button id="btnSubmitBasicMsg" type="submit" class="btn btn-primary"><i
                                        class="fa fa-check"></i>保存
                                </button>
                                <button id="btnCancel" type="button" class="btn btn-danger"><i
                                        class="fa fa-reply-all"></i>返回
                                </button>--%>
                                    <button type="submit" class="btn btn-primary colleaguedaohangg">查询</button>
                                    <button type="reset" class="btn btn-warning">重置</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                    </div>
                </div>
            </div>
        </form:form>
    </div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	//重置
	function resetCondition(){
		$('#status').select2('val', Global.STATUS_NORMAL);
// 		alert(1);
	 	$('#tradeSortCode').select2('val', ' ');
 	 	$('#areaCodeCode').select2('val', ' ');
 	 	$('#btypeSorts').select2('val', ' ');
 	 	$('#propertyCode').select2('val', ' ');
		$('#searchForm input[type="hidden"]').val('');
	}
	
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $(".searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
            {header:'统一编码', name:'btypeCode', index:'a.btype_code',align:'center', width:60},
            {header:'状态', name:'status', index:'a.btype_code', width:10, hidden:true},
            {header:'单位分类编码', name:'propertyCode', index:'b.property_code', width:10, hidden:true},
			{header:'单位名称', name:'btypeName', index:'a.btype_name', width:200,  formatter: function(val, obj, row, act){
				return '<a href="${ctx}/mdm/btypeInfo/form?btypeCode='+row.id+'" class="btnList" data-title="编辑单位信息">'+val+'</a>';
			}},
			{header:'简称', name:'shortName', index:'a.short_name', width:200},
			{header:'单位分类', name:'propertyName', index:'b.property_name', width:100},
			{header:'单位属性', name:'btypeExt.btypeSorts', index:'b.btype_sorts', width:100},
			{header:'上级单位', name:'adminBtypeCode', index:'a.admin_btype_code', width:150},
			{header:'主户', name:'isAdmin', index:'a.is_admin',align:'center', width:60},
			{header:'操作', name:'actions', width:80, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];//<shiro:hasPermission name="mdm:btypeInfo:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/mdm/btypeInfo/form?btypeCode='+row.id+'" class="btnList" title="编辑单位"><i class="fa fa-pencil"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="mdm:btypeInfo:edit">
				if (row.status == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/mdm/btypeInfo/disable?btypeCode='+row.id+'" class="btnList" title="停用单位" data-confirm="确认要停用该单位吗？"><i class="glyphicon glyphicon-ban-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="mdm:btypeInfo:edit">
				if (row.status == Global.STATUS_DISABLE){
					actions.push('<a href="${ctx}/mdm/btypeInfo/enable?btypeCode='+row.id+'" class="btnList" title="启用单位" data-confirm="确认要启用该单位吗？"><i class="glyphicon glyphicon-ok-circle"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="mdm:btypeInfo:edit">
				if(row.isAdmin == Global.STATUS_NORMAL){
					actions.push('<a href="${ctx}/mdm/btypeInfo/isAdmin?btypeCode='+row.id+'" class="btnList" title="设置主管单位" data-confirm="确认要设置该主管单位吗"><i class="fa fa-star-o"></i></a>&nbsp;');
				}//</shiro:hasPermission><shiro:hasPermission name="mdm:btypeInfo:edit">
				if(row.isAdmin == Global.STATUS_DELETE){
					actions.push('<a href="${ctx}/mdm/btypeInfo/isNotAdmin?btypeCode='+row.id+'" class="btnList" title="取消主管单位" data-confirm="确认要取消该主管单位吗？"><i class="fa fa-star"></i></a>&nbsp;');
				}//</shiro:hasPermission>
				return actions.join('');
			}}
		],
		
		//双击编辑
		ondblClickRow:function(id){
			var url='${ctx}/mdm/btypeInfo/form?btypeCode='+id;
			addTabPage($(this), "编辑单位信息", url, '${param.tabPageId}');
		},
		ajaxSuccess: function(data){ // 加载成功后执行方法
			$("#dataGrid").find("tbody").eq(0).find("tr").each(function(){
    			if($(this).find("td").eq(2).html()=="2"){
    				$(this).find("td").css("color", "red");
    			}    			
    		});
		}
	});
</script>