<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="ztree"/>
<sys:header title="文件管理" extLibs="${extLibs}" />
<div id="content" class="row-fluid">
	<div id="left">
		<div class="portlet box white autoHeight">
			<div class="portlet-title dropdown">
				&nbsp;<div class="caption dropdown-toggle" data-toggle="dropdown" style="cursor:pointer;">
				<i class="fa fa-gear"></i> <span id='fz'>公共文件柜</span> <b class="caret"></b>
				</div>
				<ul class="dropdown-menu">
					<c:forEach items="${fns:getDictList('sys_file_group')}" var="value">
						<li><a href="#" onclick="chaxun('${value.value}','${value.label}')">
							<i class="fa fa-angle-right"></i> ${value.label}</a></li>
					</c:forEach>
				</ul>
				<!-- <div class="caption">目录列表</div> -->
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
		<iframe id="mainFrame" name="mainFrame" src="${ctx}/file/fileEntityList?fileDir.globalId=global" style="overflow:visible;"
			scrolling="yes" frameborder="no" width="100%"></iframe>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	var group = "global";
	// 加载栏目数
	var setting = {view:{selectedMulti:false},data:{key:{title:"name"},simpleData:{enable:true}},
		callback:{onClick:function(event, treeId, treeNode){
// 			$('#mainFrame').attr("src", '${ctx}/file/fileEntityList');
			var ifr = $("#mainFrame"), win = ifr[0].contentWindow, conts = ifr.contents();
			conts.find('input[type=reset]').click();
			conts.find('#dirId').val(treeNode.id);
			var qx = quanxian(treeNode.id);
			if('global'==group && treeNode.isEdit.length==0){
				win.isEdit=false;
				conts.find("#btnImport").hide();
				conts.find("#btnImportFx").hide();
				conts.find("#btnImportZy").hide();
			}else{
				win.isEdit=true;
				conts.find("#btnImport").show();
				conts.find("#btnImportFx").show();
				conts.find("#btnImportZy").show();
			}
			//console.info(treeNode);
			//conts.find('#globalId').val(group);
			//conts.find('#officeName').val(treeNode.name);
			win.page();
		}}
	}, tree;
	var refreshTree = function(){
		$.getJSON("${ctx}/file/fileDir/treeData?typex=1&globalId="+group, {canAdmin: true, managerDataScope: true, isAll: '${param.isAll}'}, function(data){
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
	var leftWidth = "200"; // 左侧窗口大小
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
	
	function chaxun(idg,name){
		group = idg;
		$("#fz").text(name);
		refreshTree();
		$('#mainFrame').attr("src", '${ctx}/file/fileEntityList?fileDir.globalId='+group);
	}
	function quanxian(dirId){
		var isEdit = "";
		//异步获取该用户对文件夹的写权限
		$.ajax({
	        type:"post",//使用get方法访问后台
	        //dataType:"json",//返回json格式的数据
	        url:"${ctx}/file/fileDir/userDirRead?dirId="+dirId,//要访问的后台地址
	        //data: {dirId:dirId},
	        async:false,
	        success:function(msg){//msg为返回的数据
	        	isEdit = msg;
	        },
	        error:function(mes){
	        	isEdit = mes;
	        }
		 });
		return isEdit;
	}
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>