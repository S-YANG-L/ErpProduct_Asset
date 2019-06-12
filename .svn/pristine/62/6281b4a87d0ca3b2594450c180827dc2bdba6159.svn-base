<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="收发存明细" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i>收发存明细</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<a href="#" class="btn btn-default btn-sm" id="btnExport" title="导出"><i class="fa fa-external-link"></i> 导出</a>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="sendReceive" action="${ctx}/sendReceive/sendReceive/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${page.pageSize}" data-order-by="${page.orderBy}">
			<div class="form-group">
                  <label class="control-label">仓库：</label>
                    <div class="input-inline">
                                <form:select path="whCode" class="form-control selectHeight width-120"
                                             onChange="selWhName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${warehouses}" itemLabel="warehouseName"
                                                  itemValue="warehouseCode" htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="whName"/>
                            </div>
            </div>
			
			<%-- <div class="form-group">
                  <label class="control-label">物品：</label>
                    <div class="input-inline">
                                <form:select path="articlesCode" class="form-control selectHeight width-120"
                                             onChange="selProjectName()">
                                    <form:option value="" label=""/>
                                    <form:options items="${articlesFiles}" itemLabel="articlesName"
                                                  itemValue="articlesCode" htmlEscape="false"/>
                                </form:select>
                                <form:hidden path="articlesName"/>
                            </div>
            </div> --%>
            <div class="form-group">
				<label class="control-label">物品名称：</label>
				<div class="input-inline">
					<form:input path="articlesName" htmlEscape="false" maxlength="61" class="form-control input-sm width-160"/>
				</div>
			</div>	
            <%-- <div class="form-group">
				<label class="control-label">起止日期：</label>
				<div class="input-inline">
					<input name="beginDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						value="<fmt:formatDate value="${sendReceive.beginDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>-	
					<input name="endDate" type="text" readonly="readonly" maxlength="20" class="form-control input-sm Wdate width-150"
						value="<fmt:formatDate value="${sendReceive.endDate}" pattern="yyyy-MM-dd"/>"
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
    $("#articlesName").val("${warehouseArticlesName}");
    $("#whCode").val("${warehouseWhCodes}");
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
		        	{startColumnName: 'initialQty', numberOfColumns:3, titleText:'初始'},
		            {startColumnName: 'inoutQty', numberOfColumns:3, titleText:'入库'},
		            {startColumnName: 'outboundNumber', numberOfColumns:3, titleText:'出库'},
		            {startColumnName: 'balanceQty', numberOfColumns:3, titleText:'结存'}
		        ]
		    },
		// 设置数据表格列
		columnModel: [
			{header:'单据号', name:'inoutOrder', index:'a.sys_code', width:200, align:"left"},
			{header:'经办人', name:'inoutBy', index:'a.create_by', width:150, align:"center"},
			{header:'经办日期', name:'inoutDate', index:'a.create_date', width:150, align:"left",sortable:false},
			{header:'仓库', name:'whName', index:'c.wh_name', width:150, align:"center"},
			{header:'物品', name:'articlesName', index:'a.articles_name', width:150, align:"left"},
			
			{header:'初始数量', name:'inInitialQty', width:100, align:"left",
              formatter: function(value,row,index){
                  if (value == null){
                      return 0;
                  } else {
                      return value;
                  }
              }
},
			{header:'初始单价', name:'inInitialPrice', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			{header:'初始金额', name:'inInitialMoney', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			
			{header:'入库数量', name:'inoutQty', index:'a.qty', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			{header:'入库单价', name:'inoutPrice', index:'a.price', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			{header:'入库金额', name:'inoutMoney', index:'a.sum_money', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			
			{header:'出库数量', name:'costPrice', index:'a.cost_price', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			{header:'出库单价', name:'taxMoney', index:'a.tax_money', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			{header:'出库金额', name:'discount', index:'a.discount', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			
			{header:'结存数量', name:'balanceQty', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			{header:'结存单价', name:'balancePrice', width:100, align:"left",
  formatter: function(value,row,index){
      if (value == null){
          return 0;
      } else {
          return value;
      }
  }
},
			{header:'结存金额', name:'balanceSumMoney', width:100, align:"left",
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
        var whCode = $("#whCode").val();
        $.each(whList, function (key, value) {
            if (whCode == value.warehouseCode) {
                $("#whName").val(value.warehouseName);
            }
        });
        console.log("得到", $("#whName").val());
    }
    
/*     var productList = ${fns:toJson(articlesFiles)};
    function selProjectName() {
        var articlesCode = $("#articlesCode").val();
        $.each(productList, function (key, value) {
            if (articlesCode == value.articlesCode) {
                $("#articlesName").val(value.articlesName);
            }
        });
        console.log("得到", $("#articlesName").val());
    } */
    
	 //数据导出
    $("#btnExport").click(function(){
        top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
            if(v=="ok"){
                ajaxDownload('${ctx}/sendReceive/sendReceive/export',$("#searchForm").serialize());
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