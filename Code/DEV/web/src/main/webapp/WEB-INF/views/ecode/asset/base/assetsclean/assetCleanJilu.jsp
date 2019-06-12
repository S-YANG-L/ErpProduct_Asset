<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="清理清单" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 清理清单</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>

		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="assetClean" action="${ctx}/assetsclean/assetClean/CleanData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
				<label class="control-label">清理日期：</label>
				<div class="input-inline">
					<input name="beginDate" id="beginDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						   value="<fmt:formatDate value="${assetCleanDtl.beginDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>-
					<input name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						   value="<fmt:formatDate value="${assetCleanDtl.endDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,minDate:'#F{$dp.$D(\'beginDate\')}'});"/>
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
<script src="${ctxStatic}/common/layer/layer.js" type="text/javascript"></script>
<script type="text/javascript">
	// 初始化DataGrid对象
	$("#dataGrid").dataGrid({
		
		searchForm: $("#searchForm"), // 数据来源表单
		tabPageId: '${param.tabPageId}',// 当前页签编号
		
		// 设置数据表格列
		columnModel: [
            {header:'资产编码', name:'assetCode', index:'a.asset_code', width:300, align:"left", frozen:true},
            {header:'清理编码', name:'cleanCode', hidden:true,index:'a.clean_code', width:200, align:"left", frozen:true},
            {header:'资产名称', name:'assetName', index:'a.asset_name', width:200, align:"left"},
            {header:'资产小类', name:'sortName', index:'a.sort_name', width:200, align:"left"},
            {header:'型号', name:'version', index:'a.version', width:200, align:"left"},
            {header:'品牌', name:'brand', index:'a.brand', width:200, align:"left"},
            {header:'清理日期', name:'cleanDate', index:'a.clean_date', width:200, align:"left"},
            {header:'公司名称', name:'companyName',hidden:true, index:'a.companyName', width:200, align:"left"},
            {header:'使用部门', name:'officeName', index:'a.office_name',hidden:true, width:200, align:"left"},
			{header:'操作', name:'actions', width:60, fixed:true, sortable:false, formatter: function(val, obj, row, act){
				var actions = [];
				if (row.status == Global.STATUS_NORMAL){
                    actions.push('<a href="javascript:void(0);" id="" onclick="openLable(&apos;'+row.cleanCode+'&apos;);" class="" title="清理标签"><i class="fa fa-arrow-right"></i></a>&nbsp;');

				}
				return actions.join('');
			}}
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
    //数据导出
    $("#btnExport").click(function(){
        top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
            if(v=="ok"){
                ajaxDownload('${ctx}/assetsclean/assetClean/export',$("#searchForm").serialize());
            }
        },{buttonsFocus:1});
        top.$('.jbox-body .jbox-icon').css('top','55px');
    });
    /**
     * Ajax 文件下载
     */
    function ajaxDownload(url, data, method) {
        // 获取url和data
        if (url && data) {
            // data 是 string 或者 array/object
            data = typeof data == 'string' ? data : jQuery.param(data);
            // 把参数组装成 form的 input
            var inputs = '';
            $.each(data.split('&'), function() {
                var pair = this.split('=');
                inputs += '<input type="hidden" name="' + pair[0] + '" value="'
                    + pair[1] + '" />';
            });
            // request发送请求
            $('<form action="' + url + '" method="' + (method || 'post')
                + '" >' + inputs + '</form>').appendTo('body').submit().remove();
        }
    }
    function openLable(cleanCode){
        <%--var assetCode= '${fns:getUser().userCode}';--%>
        layer.open({
            type: 2,
            skin: 'layui-layer-rim',
            closeBtn: 1,
            time: 30000,
            scrollbar: false,
            shadeClose: true,
            area: ['850px', '350px'],
            content: ['${ctx}' + '/assetsclean/assetClean/assetCleanJiluDtl?cleanCode=' + cleanCode, 'no']
        });
    }
</script>