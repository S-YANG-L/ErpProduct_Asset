<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="分组列表演示" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-user"></i> 分组列表演示</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnSearch" title="查询"><i class="fa fa-search"></i> 查询</a>
			<shiro:hasPermission name="sys:user:edit">
				<a href="${ctx}/sys/empUser/form?op=add" class="btn btn-default btn-sm btnTool" title="新增用户"><i class="fa fa-plus"></i> 新增</a>
			</shiro:hasPermission>
			<div class="btn-group">
				<!-- <a class="btn btn-default btn-sm" href="#" data-toggle="dropdown"><i class="fa fa-cogs"></i> 工具 <i class="fa fa-angle-down"></i></a>
				<ul class="dropdown-menu pull-right" style="width:100px;">
					<li><a href="#"> <i class="fa fa-pencil"></i> 导出</a></li>
					<li><a href="#"> <i class="fa fa-trash-o"></i> 导入</a></li>
				</ul> -->
			</div>
		</div>
	</div>
	<div class="portlet-body list">
		<form:form id="searchForm" modelAttribute="testData" action="${ctx}/sys/empUser/listData" method="post" class="breadcrumb form-inline hide"
				data-page-no="${page.pageNo}" data-page-size="${not empty page.pageSize ? page.pageSize : 100}" data-order-by="${not empty page.orderBy ? page.orderBy : 'o.office_name asc'}">
			<div class="form-group" > &nbsp;&nbsp;
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
	$('#dataGrid').dataGrid({
		
		// 当前页签编号
		tabPageId: '${param.tabPageId}',
		
		// 设置数据表格列
		columnModel: [
			{header:'用户名称', name:'loginInfo.userName', index:'u.user_name', width:250, align:"center", frozen:true, formatter: function(val, obj, row, act){
				if(obj.rowId == ''){
					return row.groupValue + '小计';
				}
				return '<a href="${ctx}/sys/empUser/form?userCode='+row.loginInfo.userCode+'" class="btnList" data-title="编辑用户">'+val+'</a>';
			},summaryTpl: "{0}", summaryType: "count"},
			{header:'登录账号', name:'loginInfo.loginCode', index:'u.login_code', width:250, align:"center", formatter: function(val, obj, row, act){
				if(obj.rowId == ''){
					return '<em>' + val + '</em>个'
				}
				return val;
			}, summaryTpl: "{0}", summaryType: "count"},
			{header:'所属机构', name:'office.officeName', index:'o.office_name', width:250},
			{header:'手机号码', name:'loginInfo.mobile', index:'u.mobile', width:250, align:"right", sortable:true, formatter: function(val, obj, row, act){
				if(obj.rowId == ''){
					var v = moneyFormat(val);
					return (v != '') ? ('￥' + v) : '';
				}
				return moneyFormat(val);
			}, summaryTpl: "<em>{0}</em>", summaryType: "sum"},
			{header:'电子邮箱', name:'email', index:'a.email', width:250, align:"center", sortable:false},
			{header:'状态', name:'status', index:'a.status', width:200, fixed:true, align:"center", formatter: function(val, obj, row, act){
				return getDictLabel(${fns:getDictListJson('user_status')}, val, '未知', true);
			}},
			{header:'操作', name:'actions', width:150, fixed:true, sortable:false, fixed:true, formatter: function(val, obj, row, act){
				var actions = [];
				actions.push('<a href="${ctx}/sys/empUser/form?userCode='+row.loginInfo.userCode+'" class="btnList" title="编辑用户"><i class="fa fa-pencil"></i></a>&nbsp;');
				return actions.join('');
			}}
		],

		// 设置多级表头
		groupHeaders: {
	 		twoLevel:[
	 			{startColumnName: 'loginInfo.loginCode', numberOfColumns: 3, titleText: '二级表头'},
	 			{startColumnName: 'email', numberOfColumns:2, titleText:'二级表头2'}
	 		],
	 		threeLevel:[
	 			{startColumnName: 'loginInfo.loginCode', numberOfColumns:5, titleText:'三级表头'}
	 		]
		},
		frozenCols: true, 	// 启用冻结列，并在colModel中设置frozen:true

		showRownum: false,	// 是否显示行号
		grouping: true, 	// 是否分组显示
		groupingView: {
			groupField: ["office.officeName"], // 需要分组的列
			groupColumnShow: [false],// 是否显示分组的列
			groupText: ["none"],	// 设置组标题，加粗标题：["<b>{0}</b>"]，不显示标题：["none"]
			groupSummary: [true],	// 是否显示小计列
			groupCollapse: false 	// fase为默认展开，true默认为折叠
		},
		
		showFooter: true,	// 是否显示底部合计行
		
		ajaxSuccess: function(data){ // 加载成功后执行方法
			// 启用合计行：全局showFooter属性设置为true，设置值有两种方式：
			// 第一种是：在返回结果集中设置 otherData属性，举例格式如下：
			/* {"pageNo":1,
			    "pageSize":30,
			    "list":[返回结果集数据],
				"otherData":{
					"loginInfo.userName":"合计：",
					"loginInfo.loginCode":"<em>1000</em>个",
					"loginInfo.mobile":"<em>￥100.00 &nbsp;</em>"
				}
			   }
			*/
			// 第二种是：请求完成之后通过js设置，举例如下：
			// 设置底部合计行数据(设置合计行)
			$('#dataGrid').dataGrid("footerData", "set", {
				'loginInfo.userName' : '合计：',
				'loginInfo.loginCode' : '<em>' + data.count + '</em>个',
				'loginInfo.mobile': '<em>￥900,000,000.00 &nbsp;</em>'
			}, false);
		}
	});
	
</script>