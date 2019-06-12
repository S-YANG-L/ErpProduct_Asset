<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<c:set var="extLibs" value="grid,ztree"/>
<sys:header title="权限审计" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor}" style="padding-bottom:0!important;">
    <div class="portlet-body list">
        <div class="row">
            <div class="col-xs-3" style="padding:0">
                <!-- <div style="position: absolute; right: 8px; top: 2px; cursor: pointer; font-size: 12px; color: #333;"
                     onclick="search();">
                    <label id="txt1" style="display: none;" title="展开搜索">︾</label><label
                        id="txt2" title="隐藏搜索">︽</label>
                </div> -->
                <div id="search">
                    <input id="key" type="text" placeholder="请输入搜索条件" class="span8"
                           style="margin:0px 0px 0px 20px; width: 100px; height: 29px; vertical-align: middle;"/>
                    <button type="button" class="btn btn-primary btn-sm"
                            onclick="searchNode()"
                            style="font-size: 12px; margin-left: 0px; margin-top: -1px">搜索
                    </button>&nbsp;
                    <label><input type="checkbox" id="isImportant"/> 敏感菜单</label>
                </div>
                <div style="position: absolute; top:35px; right:20px; font-size:12px; color: #333;">
                    <a href="javascript:" onclick="tree.expandAll(true);"
                       style="text-decoration: none; color: #333">展开</a>/<a
                        href="javascript:" onclick="tree.expandAll(false);"
                        style="text-decoration: none; color: #333">折叠</a>
                </div>
                <div id="tree" class="ztree" style="padding:10px 20px;margin-top:3px;width:100%"></div>
            </div>
            <div class="col-xs-9" style="padding-right:0">
	            <form:form id="searchForm" modelAttribute="user"
	                       action="${ctx}/sys/safetyAudit/permiAudit/listMenuUserData" method="post" class="form-inline"
	                       data-page-no="${page.pageNo}" data-page-size="${page.pageSize}"
	                       data-order-by="${page.orderBy}">
	                <form:hidden path="extendS1"/>
	                <div class="form-group">
		                <button type="button" class="btn btn-warning btn-sm" id="btnSetImportant">设置敏感菜单</button>
		                <div class="hide">
		                	<sys:treeselect id="menuSelect" name="menuSelectCode" value="${menuSelectCode}" labelName="menuSelectName" labelValue=""
								title="敏感菜单" url="/sys/menu/treeData" cssClass="" checked="true"/>
		                </div>
	                </div>
	                <div class="form-group">
	                    <label class="control-label" style="margin-left: 0px">登录账号：</label>
	                    <form:input path="userCode" htmlEscape="false" maxlength="50"
	                                class="form-control input-sm width-90"/>
	                </div>
	                <div class="form-group">
	                    <label class="control-label">用户名称：</label>
	                    <form:input path="userName" htmlEscape="false" maxlength="50"
	                                class="form-control input-sm width-90"/>
	                </div>
	                <div class="form-group">
	                    <label class="control-label">组织机构：</label>
	                    <div class="input-inline width-90">
	                        <sys:treeselect id="employeeOffice" name="employee.officeCode"
                                 value="" labelName="employee.office.officeName" labelValue=""
                                 title="组织机构" url="/sys/office/treeData" controlSize="sm"
                                 allowClear="true"/>
	                    </div>
	                </div>
	                <div class="form-group" style="margin-left: 10px;">
	                    <input class="btn btn-primary btn-sm" type="submit" value="查询"/>&nbsp;
	                    <input class="btn default btn-sm" type="reset" value="重置"
	                           onclick="resetCondition()"/>
	                </div>
	            </form:form>
                <table id="dataGrid"></table>
                <div id="dataGridPage"></div>
            </div>
        </div>
    </div>
</div>
<sys:footer extLibs="${extLibs}"/>
<script type="text/javascript">
	var $tree = $('#tree');
	$(window).resize(function(){
		$tree.css('overflow', 'scroll').height($(window).height() - 60);
	}).resize();
    <c:set var="url" value="${ctx}/sys/menu/treeData"/>
    var key, lastValue = "", nodeList = [], type = getQueryString("type", "${url}");
    var tree, setting = {
        view: {selectedMulti: false, dblClickExpand: false}, check: {enable: false, nocheckInherit: true},
        data: {simpleData: {enable: true}}, callback: {
            onClick: function (event, treeId, treeNode) {
                $("#extendS1").val(treeNode.id);
                $("#searchForm").submit();
            }, onCheck: function (e, treeId, treeNode) {
                var nodes = tree.getCheckedNodes(true);
                for (var i = 0, l = nodes.length; i < l; i++) {
                    tree.expandNode(nodes[i], true, false, false);
                }
                return false;
            }, onAsyncSuccess: function (event, treeId, treeNode, msg) {
                var nodes = tree.getNodesByParam("pId", treeNode.id, null);
                for (var i = 0, l = nodes.length; i < l; i++) {
                    try {
                        tree.checkNode(nodes[i], treeNode.checked, true);
                    } catch (e) {
                    }
                    //tree.selectNode(nodes[i], false);
                }
                selectCheckNode();
            }, onDblClick: function () {//<c:if test="${!checked}">
                var $jBox = getJBox();
                $jBox.getBox().find("button[value='ok']").trigger("click");
                //$("input[type='text']", top.mainFrame.document).focus();//</c:if>//
            }
        }
    };
    
    $('#isImportant').click(function(){
    	var isImportant = $(this).is(':checked')
        $.get("${url}${fn:indexOf(url,'?')==-1?'?':'&'}isImportant="+isImportant+"&t=" + new Date().getTime() + "${urlParam}", function (zNodes) {
            // 初始化树结构
            tree = $.fn.zTree.init($("#tree"), setting, zNodes);//.expandAll(true);

            // 默认展开一级节点
            var nodes = tree.getNodesByParam("level", ${not empty showLevel ? showLevel : 0});
            for (var i = 0; i < nodes.length; i++) {
                tree.expandNode(nodes[i], true, false, false);
            }
            //后台异步加载子节点（加载用户）
            if (type == 3) {
                var nodesOne = tree.getNodesByParam("isParent", true);
                for (var j = 0; j < nodesOne.length; j++) {
                    tree.reAsyncChildNodes(nodesOne[j], "!refresh", true);
                }
            }
            selectCheckNode();
        });
    });

    $(document).ready(function () {
    	$('#isImportant').click();
        // 搜索输入框绑定
        key = $("#key");
        key.bind("focus", focusKey).bind("blur", blurKey).bind("change cut input propertychange", searchNode);
        key.bind('keydown', function (e) {
            if (e.which == 13) {
                searchNode();
            }
        });
    });

    // 默认选择节点
    function selectCheckNode() {
        var ids = "${selectCodes}".split(",");
        for (var i = 0; i < ids.length; i++) {
            var node = tree.getNodeByParam("id", (type == 3 || type == 4 ? "u_" : "") + ids[i]);
            if ("${checked}" == "true") {
                try {
                    tree.checkNode(node, true, true);
                } catch (e) {
                }
                tree.selectNode(node, false);
            } else {
                tree.selectNode(node, true);
            }
        }
    }

    // ======================== 搜索开始 ========================
    // 关键词输入框获取焦点
    function focusKey(e) {
        if (key.hasClass("empty")) {
            key.removeClass("empty");
        }
    }

    // 关键词输入框焦点离开
    function blurKey(e) {
        if (key.get(0).value === "") {
            key.addClass("empty");
        }
        searchNode(e);
    }

    //搜索节点
    function searchNode() {
        // 取得输入的关键字的值
        var value = $.trim(key.get(0).value);

        // 按名字查询
        var keyType = "name";

        // 如果和上次一次，就退出不查了。
        if (lastValue === value) {
            return;
        }

        // 保存最后一次
        lastValue = value;

        var nodes = tree.getNodes();
        // 如果要查空字串，就退出不查了。
        if (value == "") {
            showAllNode(nodes);
            return;
        }
        hideAllNode(nodes);
        nodeList = tree.getNodesByParamFuzzy(keyType, value);
        updateNodes(nodeList);
    }

    //隐藏所有节点
    function hideAllNode(nodes) {
        nodes = tree.transformToArray(nodes);
        for (var i = nodes.length - 1; i >= 0; i--) {
            tree.hideNode(nodes[i]);
        }
    }

    //显示所有节点
    function showAllNode(nodes) {
        nodes = tree.transformToArray(nodes);
        for (var i = nodes.length - 1; i >= 0; i--) {
            if (nodes[i].getParentNode() != null) {
                tree.expandNode(nodes[i], false, false, false, false);
            } else {
                tree.expandNode(nodes[i], true, true, false, false);
            }
            tree.showNode(nodes[i]);
            showAllNode(nodes[i].children);
        }
    }

    //更新节点状态
    function updateNodes(nodeList) {
        tree.showNodes(nodeList);
        for (var i = 0, l = nodeList.length; i < l; i++) {
            var treeNode = nodeList[i];

            //显示当前节点的子节点
            showChildren(treeNode);

            //显示当前节点所有的父节点
            showParent(treeNode)
        }
    }

    // 显示所有子节点
    function showChildren(treeNode) {
        if (treeNode.isParent) {
            for (var idx in treeNode.children) {
                var node = treeNode.children[idx];
                tree.showNode(node);
                showChildren(node);
            }
        }
    }

    // 显示所有子节点
    function showParent(treeNode) {
        var parentNode;
        while ((parentNode = treeNode.getParentNode()) != null) {
            tree.showNode(parentNode);
            tree.expandNode(parentNode, true, false, false);
            treeNode = parentNode;
        }
    }

    // 开始搜索
    function search() {
        $("#search").slideToggle(200);
        $("#txt1").toggle();
        $("#txt2").toggle();
        $("#key").focus();
    }
    // ======================== 搜索结束 ========================
    $('#dataGrid').dataGrid({
        // 当前页签编号
        tabPageId: '${param.tabPageId}',
        lazyLoad: true,
        autoGridHeight: function(){
        	return $tree.height() - 65;
        },
        // 设置数据表格列
        columnModel: [
            { header: '登录账号', name: 'userCode', index: 'c.user_code', width: 200, align: "left"  },
            { header: '用户名称', name: 'userName', index: 'c.user_name', width: 200, align: "left"  },
            { header: '组织机构', name: 'refObj.officeName', index: 'e.office_name', width: 200, align: "left"  }
        ],
        ajaxSuccess: function (data) { // 加载成功后执行方法

        }
    });
    //重置
    function resetCondition() {
        $('#employeeOfficeCode').val('');
    }
    
    // 敏感菜单设置
    $('#btnSetImportant').click(function(){
    	$('#menuSelectName').click();
    });
    function menuSelectTreeselectCallBack(v, h, f){
    	if (v=='ok'){
    		ajaxSubmit('${ctx}/sys/safetyAudit/permiAudit/setImportant', {
    			menuSelectCode: $('#menuSelectCode').val()
    		}, function(data){
    			showMessage(data.message);
    		});
    	}
    }
    
    
</script>