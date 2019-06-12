<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="收发存汇总" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>收发存汇总</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="report" action="${ctx}/report/report/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
                  <label class="control-label">仓库：</label>
                    <div class="input-inline">
                                <form:select path="warehouseWhCodes" class="form-control selectHeight width-120"
                                             onChange="selWhName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${warehouses}" itemLabel="warehouseName"
                                                  itemValue="warehouseCode" htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="warehouseWhNames"/>
                            </div>
            </div>
			
			<%-- <div class="form-group">
                  <label class="control-label">物品：</label>
                    <div class="input-inline">
                                <form:select path="warehouseArticlesCode" class="form-control selectHeight width-120"
                                             onChange="selProjectName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${articlesFiles}" itemLabel="articlesName"
                                                  itemValue="articlesCode" htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="warehouseArticlesName"/>
                            </div>
            </div> --%>
            <div class="form-group">
				<label class="control-label">物品名称：</label>
				<div class="input-inline">
					<form:input path="warehouseArticlesName" htmlEscape="false" maxlength="61" class="form-control input-sm width-160"/>
				</div>
			</div>	
            <%-- <div class="form-group">
				<label class="control-label">起止日期：</label>
				<div class="input-inline">
					<input name="beginDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						value="<fmt:formatDate value="${report.beginDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>-	
					<input name="endDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						value="<fmt:formatDate value="${report.endDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</div>
			</div> --%>
            
			<div class="form-group" style="margin-left:10px;"> 
				<input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
				<input class="btn default btn-sm" type="reset" value="重置"/>
			</div>
		</form:form>
		<form:form></form:form>
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
		 groupHeaders: {
		       
		       // 二级表头（startColumnName：开始的列名，numberOfColumns：跨列的数目，titleText：表头名称）
		        twoLevel:[
		            {startColumnName:'whName', numberOfColumns:1, titleText: '二级表头2'}
		        ],
		       
		       // 三级表头（属性同二级表头，如果不需要三级表头，则删除threeLevel）
		        threeLevel:[
		        	/* {startColumnName: 'initialQty', numberOfColumns:3, titleText:'初始'}, */
		            {startColumnName: 'bqty', numberOfColumns:3, titleText:'入库'},
		            {startColumnName: 'cqty', numberOfColumns:3, titleText:'出库'},
		            {startColumnName: 'jieCunQTY', numberOfColumns:3, titleText:'结存'}
		        ]
		    },
		// 设置数据表格列
		columnModel: [
			{header:'仓库名称', name:'warehouseWhNames', index:'a.wh_name', width:100, align:"center"},
			{header:'仓库编码',id:'warehouseWhCodes', name:'warehouseWhCodes', index:'a.wh_code', width:100, align:"center"},
			{header:'办公用品分类', name:'warehouseArticlesCode', index:'a.articles_code', width:200, align:"left", formatter: function(val, obj, row, act){
				return '<a href="${ctx}/sendReceive/sendReceive/listDetail?warehouseArticlesName='+row.warehouseArticlesName+'" class="btnList" data-title="查看明细">'+(val ? val : row.warehouseArticlesName)+'</a>';}},
			{header:'办公用品名称', name:'warehouseArticlesName', index:'a.articles_Name', width:150, align:"center"},
			{header:'规格型号', name:'version', index:'a.version', width:150, align:"center"},
			{header:'单位', name:'unit', index:'a.unit', width:100, align:"center"},
			
			/* {header:'初始数量', name:'initialQty', width:120, align:"left",
                formatter: function(value,row,index){
                    if (value == null){
                        return 0;
                    } else {
                        return value;
                    }
                }
},
			{header:'初始单价', name:'initialPrice', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			{header:'初始金额', name:'initialMoney', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
}, */
			
			{header:'入库数量', name:'bqty', index:'e.bqty', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			{header:'入库单价', name:'inoutPrice', index:'e.inoutPrice', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			{header:'入库金额', name:'bsumoney', index:'e.bsumoney', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			
			{header:'出库数量', name:'cqty', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			{header:'出库单价', name:'outboundPrice', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			{header:'出库金额', name:'outboundMoney', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			
			{header:'结存数量', name:'jieCunQTY', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			{header:'结存单价', name:'jieCunPrice', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
},
			{header:'结存金额', name:'jieCunMoney', width:120, align:"left",
    formatter: function(value,row,index){
        if (value == null){
            return 0;
        } else {
            return value;
        }
    }
}
			
			
		],
		ajaxSuccess: function(data){ // 加载成功后执行方法
			
		}
	});
    
    var whList = ${fns:toJson(warehouses)};
    function selWhName() {
        var warehouseWhCodes = $("#warehouseWhCodes").val();
        $.each(whList, function (key, value) {
            if (warehouseWhCodes == value.warehouseCodes) {
                $("#warehouseWhNames").val(value.warehouseName);
            }
        });
        console.log("得到", $("#warehouseWhNames").val());
    }
    
/*     var productList = ${fns:toJson(articlesFiles)};
    function selProjectName() {
        var warehouseArticlesCode = $("#warehouseArticlesCode").val();
        $.each(productList, function (key, value) {
            if (warehouseArticlesCode == value.articlesCode) {
                $("#warehouseArticlesName").val(value.articlesName);
            }
        });
        console.log("得到", $("#warehouseArticlesName").val());
    } */
    
	 //数据导出
    $("#btnExport").click(function(){
        top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
            if(v=="ok"){
                ajaxDownload('${ctx}/report/report/export',$("#searchForm").serialize());
            }
        },{buttonsFocus:1});
        top.$('.jbox-body .jbox-icon').css('top','55px');
    });
	 
    /**
     * Ajax 文件下载   ajaxDownload('ExcelDownload.do','find=commoncode','post' );
     * @param url
     * @param data
     * @param method
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

</script>