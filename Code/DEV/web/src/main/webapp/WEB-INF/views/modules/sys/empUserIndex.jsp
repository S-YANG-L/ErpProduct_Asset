<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="ztree"/>
<sys:header title="${fns:text('用户管理')}" extLibs="${extLibs}" />
<div id="content" class="row-fluid">
	<div id="left">
		<div class="portlet box white autoHeight">
			<div class="portlet-title dropdown">
				<div class="caption">${fns:text('部门列表')}</div>
				<div class="tools">
					<a href="#" id="treeA" onclick="tree.expandAll(true);$('#treeA').hide();$('#treeB').show();" title="展开" class="expand nobind" style="display:none;"></a>
					<a href="#" id="treeB" onclick="tree.expandAll(false);$('#treeA').show();$('#treeB').hide();" title="折叠" class="collapse nobind"></a>
					<a href="#" onclick="refreshTree()" class="reload"></a>
				</div>
			</div>
			<div class="portlet-body">
				<div id="tree" class="ztree"></div>
			</div>
		</div>
	</div>
	<div id="openClose" class="close">&nbsp;</div>
	<div id="right">
		<iframe id="mainFrame" name="mainFrame" src="${ctx}/sys/empUser/list?isAll=${param.isAll}&title=${param.title}" style="overflow:visible;"
			scrolling="yes" frameborder="no" width="100%"></iframe>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	// 加载栏目数
	var setting = {view:{selectedMulti:false},data:{key:{title:"title"},simpleData:{enable:true}},
		callback:{onClick:function(event, treeId, treeNode){
// 			$('#mainFrame').attr("src", '${ctx}/sys/empUser/list?office.officeCode='
// 					+ treeNode.id + '&office.officeName=' + treeNode.name);
			tree.expandNode(treeNode);
			var win = $("#mainFrame")[0].contentWindow;
			win.$('input[type=reset]').click();
			win.$('#officeCode').val(treeNode.id);
			win.$('#officeName').val(treeNode.name);
			win.page();
		}}
	}, tree;
	var refreshTree = function(){
		$.getJSON("${ctx}/sys/office/treeData", {canAdmin: true, managerDataScope: true, isAll: '${param.isAll}'}, function(data){
			// 初始化树结构
			tree = $.fn.zTree.init($("#tree"), setting, data);//.expandAll(true);
			// 展开第一级节点
			var nodes = tree.getNodesByParam("level", 0);
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, false, false);
			}
			// 展开第二级节点
// 			nodes = tree.getNodesByParam("level", 1);
// 			for(var i=0; i<nodes.length; i++) {
// 				tree.expandNode(nodes[i], true, false, false);
// 			}
		});
	}
	refreshTree();
	
	// 调用子页分页函数
	function page(){
		mainFrame.page();
	}

	// 框架布局调整
	var leftWidth = "180"; // 左侧窗口大小
	var wSize = function(){
		var heightWidth = getWindowSize().toString().split(",");
		$("#mainFrame, #openClose").height(heightWidth[0]);
		$("#right").width(heightWidth[1] - $("#left").width()-$("#openClose").width() - 2);
		$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
	}
	// 鼠标移动到边界自动弹出左侧菜单
	$("#openClose").mouseover(function(){
		if($(this).hasClass("open")){
			$(this).click();
		}
	});
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>