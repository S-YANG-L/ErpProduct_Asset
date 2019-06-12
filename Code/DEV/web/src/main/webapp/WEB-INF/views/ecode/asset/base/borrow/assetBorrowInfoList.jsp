<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="资产借用" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 资产借用</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>

			<a href="${ctx}/borrow/assetBorrowInfo/form" class="btn btn-default btn-sm btnTool" title="新增资产借用"><i class="fa fa-plus"></i> 新增</a>
			<%--<a href="${ctx}/return/assetBorrowReturn/list" class="btn btn-default btn-sm btnTool" title="资产归还"><i class="fa fa-external-link"></i> 归还</a>--%>

		</div>
	</div>

	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="assetBorrowInfo" action="${ctx}/borrow/assetBorrowInfo/listData" method="post" class="breadcrumb form-inline hide"
				   data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<%--<div class="form-group">--%>
				<%--<label class="control-label">借用编码：</label>--%>
				<%--<div class="input-inline">--%>
					<%--<form:input path="borrowCode" htmlEscape="false" maxlength="64" class="form-control input-sm width-160"/>--%>
				<%--</div>--%>
			<%--</div>--%>
            <div class="form-group">
                <label class="control-label">流程状态：</label>
                <div class="input-inline">
                    <form:select path="approvalStatus" class="form-control input-sm width-160">
						<form:option value="" label="全部"/>
						<form:option value="1" label="进行中"/>
						<form:option value="2" label="审批结束"/>

                    </form:select>
                </div>
            </div>

			<div class="form-group" style="margin-left:10px;">
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<table id="dataGrid"></table>
		<div id="dataGridPage"></div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
    // 初始化DataGrid对象
    $("#dataGrid").dataGrid({

        searchForm: $("#searchForm"), // 数据来源表单
        tabPageId: '${param.tabPageId}',// 当前页签编号

        // 设置数据表格列
        columnModel: [
            {header:'状态', name:'approvalStatus', index:'a.approval_status', width:200, align:"left",formatter: function(val, obj, row, act){
                    var approvalStatus = ["进行中","进行中","审批结束","进行中"]
                    return approvalStatus[row.approvalStatus]
                }},
            {header:'借用单编码', name:'borrowCode', index:'a.borrow_code', width:200, align:"left", frozen:true},
            {header:'借用人', name:'borrowerName', index:'a.borrower_name', width:200, align:"left"},
            {header:'借用日期', name:'borrowDate', index:'a.borrow_date', width:200, align:"left"},
            {header:'预计归还日期', name:'expectedReturnDate', index:'a.expected_return_date', width:200, align:"left"},
            {header:'归还人', name:'restituerName', index:'a.restituer_name', width:200, align:"left"},
            {header:'说明', name:'notes', index:'a.notes', width:200, align:"left"},
            {header:'操作', name:'actions', width:100, fixed:true, sortable:false, formatter: function(val, obj, row, act){
                    var actions = [];
                    if (row.status == Global.STATUS_NORMAL){
                        actions.push('<a href="${ctx}/borrow/assetBorrowInfo/form?id='+row.id+'&isWrite=false" class="btnList" title="编辑资产借用"><i class="fa fa-pencil"></i></a>&nbsp;');
                        actions.push('<a href="${ctx}/borrow/assetBorrowInfo/delete?id='+row.id+'" class="btnList" title="删除该资产借用" data-confirm="确认要删除该资产借用吗？"><i class="fa fa-trash-o"></i></a>&nbsp;');
                    }
                    return actions.join('');
                }}
        ],
        ajaxSuccess: function(data){ // 加载成功后执行方法
        }
    });
</script>