
<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="工作流日志管理" extLibs="${extLibs}" />
<style>
body{font:13px/1.4 Helvetica,arial,freesans,clean,sans-serif,"Segoe UI Emoji","Segoe UI Symbol";color:rgb(51,51,51);min-width:970px;font-size-adjust:none;font-stretch:normal;margin:0 auto;padding:15px 0;}
.process{padding:10px 15px;height:auto;overflow:hidden;background:#FBFBFB;border:1px solid #DDD;}
.container{width:950px;margin:20px auto 20px auto;}
.timeline-comment-wrapper>.timeline-comment::after{border-style:solid solid outset;border-color:transparent;left:-16px;top:11px;width:0px;height:0px;right:100%;display:block;position:absolute;content:" ";pointer-events:none;}
.timeline-comment-wrapper>.timeline-comment::before{border-style:solid solid outset;border-color:transparent;left:-16px;top:11px;width:0px;height:0px;right:100%;display:block;position:absolute;content:" ";pointer-events:none;}
.timeline-comment-wrapper>.timeline-comment::after{border-width:7px;margin-top:1px;margin-left:2px;border-right-color:rgb(247,247,247);}
.timeline-comment-wrapper>.timeline-comment::before{border-width:8px;border-right-color:rgb(221,221,221);}
.timeline-comment-wrapper{position:relative;padding-left:60px;margin-top:15px;margin-bottom:15px;padding-top:5px;}
:first-child.timeline-comment-wrapper{margin-top:0px;}
.timeline-comment-avatar{border-radius:4px;margin-left:-60px;float:left;}
img{border:0}
.timeline-comment{border-radius:3px;border:1px solid rgb(221,221,221);position:relative;background-color:rgb(255,255,255);}
.timeline-comment-header{color:rgb(153,153,153);padding-right:15px;padding-left:15px;border-bottom-color:rgb(238,238,238);border-bottom-width:0px;border-bottom-style:solid;border-top-left-radius:3px;border-top-right-radius:3px;background-color:rgb(247,247,247);}
.timeline-comment-header .author{color:rgb(85,85,85);font-weight:bold;}
.timeline-comment-header-text{padding-top:10px;padding-bottom:10px;max-width:78%;}
.discussion-timeline{width:760px;float:left;position:relative;}
.discussion-sidebar{top:0px;width:140px;float:right;z-index:21;}
.discussion-sidebar-item{color:rgb(153,153,153);padding-top:15px;font-size:12px;}
.discussion-sidebar-item .minibutton .octicon{margin-right:0px;}
.discussion-sidebar-item .button-block{margin-bottom:8px;}
.discussion-sidebar-item+.discussion-sidebar-item{margin-top:15px;border-top-color:rgb(238,238,238);border-top-width:1px;border-top-style:solid;}
.discussion-sidebar-item .select-menu{position:relative;}
.sidebar-labels .labels .label{padding:6px 10px;font-size:12px;max-width:100%;box-shadow:none;}
.sidebar-labels .labels .label+.label{margin-top:3px;}
.sidebar-labels:empty.labels::before{display:inline;content:"None yet";}
button.discussion-sidebar-toggle{display:block;width:150px;font-weight:bold;text-align:left;background:none;border:0;}
.discussion-sidebar-toggle{padding:5px;margin:-5px -5px 5px;}
.discussion-sidebar-heading{margin-top:0;margin-bottom:10px;font-size:12px;line-height:16px;color:#777;}
.css-truncate .css-truncate-target{display:inline-block;max-width:125px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;vertical-align:top;}
.comment-content {margin: 10px 10px 10px 15px;text-indent:2em;}
</style>
<div class="container process" id="processInfo">
	<input type="hidden" id="bizKey" value="${flowLog.bizKey}"/>
	<!-- 流程详细信息 -->
    <div class="discussion-timeline js-quote-selection-container" id="taskInforEle">
        <div style="border-bottom-style:solid;border-bottom-width:1px;border-bottom-color:#ddd;padding-bottom:4px;">
			<span style="padding-right:4px;padding-bottom:3px;padding-left:4px;font-size:11px;font-weight:bold;display:inline-block;line-height:1;padding-top:3px;color:rgb(255,255,255);padding-top:0.2em;padding-left:0.6em;padding-right:0.6em;padding-bottom:0.3em;font-size:75%;display:inline;background-color: rgb(153, 153, 153);">
			已完成</span>
        </div>
        <c:forEach items="${finishList }" var="flowLog">
		        <div class="js-discussion js-socket-channel">
		            <div class="timeline-comment-wrapper js-comment-container">
		                <a href="javascript:void(0);">
		                    <img width="42" height="42" class="timeline-comment-avatar" src="${ctxPath }/foxbpm/taskCommand/images/male.png" />
		                </a>
		                <div class="comment timeline-comment" >
		                    <div class="timeline-comment-header">
		                        <div class="timeline-comment-actions">
		                        </div>
		                        <div class="timeline-comment-header-text">
		                            <strong>
		                                <span class="author" >${flowLog.handleBy}<c:if test="${not empty flowLog.agentApprovalName}">【${flowLog.agentApprovalName}委托】</c:if></span>
		                            </strong>
		                            <strong>
		                                &nbsp;${flowLog.stepName }&nbsp;${flowLog.approvalStatusName }&nbsp;${fns:formatDate(flowLog.createDate, 'yyyy-MM-dd HH:mm')}</strong>
		                        </div>
		                    </div>
		                    <c:if test="${not empty flowLog.approvalMemo }">
		                    <div class="comment-content">
		                        ${flowLog.approvalMemo }
		                    </div>
		                    </c:if>
		                </div>
		            </div>
		        </div>
		</c:forEach>
		<c:if test="${not empty notFinishList }">
		        <div style="border-bottom-style:solid;border-bottom-width:1px;border-bottom-color:#ddd;padding-bottom:4px;">
					<span style="padding-right:4px;padding-bottom:3px;padding-left:4px;font-size:11px;font-weight:bold;display:inline-block;line-height:1;padding-top:3px;color:rgb(255,255,255);padding-top:0.2em;padding-left:0.6em;padding-right:0.6em;padding-bottom:0.3em;font-size:75%;display:inline;background-color: rgb(153, 153, 153);">
					未完成</span>
		        </div>
		        <c:forEach items="${notFinishList }" var="flowLog">
		        <div class="js-discussion js-socket-channel">
		            <div class="timeline-comment-wrapper js-comment-container">
		                <a href="javascript:void(0);">
		                    <img width="42" height="42" class="timeline-comment-avatar" src="${ctxPath }/foxbpm/taskCommand/images/male.png" />
		                </a>
		                <div class="comment timeline-comment" >
		                    <div class="timeline-comment-header">
		                        <div class="timeline-comment-actions">
		                        </div>
		                        <div class="timeline-comment-header-text">
		                            <strong>
		                                <span class="author" >${flowLog.handleBy }</span>
		                            </strong>
		                            <strong>
		                                &nbsp;${flowLog.stepName }&nbsp;${flowLog.approvalStatusName }&nbsp;${fns:formatDate(flowLog.createDate, 'yyyy-MM-dd HH:mm')}</strong>
		                        </div>
		                    </div>
		                    <c:if test="${not empty flowLog.approvalMemo }">
		                    <div class="comment-content">
		                        ${flowLog.approvalMemo }
		                    </div>
		                    </c:if>
		                </div>
		            </div>
		        </div>
		        </c:forEach>
        </c:if>
    </div>
    <!-- 流程信息 -->
    <div class="discussion-sidebar" id="flowInforEle">
    	<!-- 流程状态 -->
    	<div class="discussion-sidebar-item sidebar-labels">
    		<div class="select-menu label-select-menu ">
    			<button class="discussion-sidebar-heading discussion-sidebar-toggle js-menu-target">流程状态</button>
    		</div>
    		<div class="participation-avatars"> <b>
    			<c:choose>
    				<c:when test="${not empty notFinishList }">【进行中】</c:when>
    				<c:otherwise>【正常结束】</c:otherwise>
    			</c:choose></b></div>
    	</div>
    	<!-- 当前处理者 -->
    	<div class="discussion-sidebar-item sidebar-assignee" id="sidebarAssignee">
	    	<div class="select-menu ">
	    		<button class="discussion-sidebar-heading discussion-sidebar-toggle js-menu-target">当前处理者</button>
	    		<div class="participation-avatars"> <c:if test="${not empty notFinishList }"><b>${notFinishList[0].handleBy }</b></c:if></div>
	    	</div>
    	</div>
    </div>
</div>

<div style="width:83%; white-space:nowrap;margin: 0 auto;">
 <!-- 图例 -->
  <div style="padding:8px 5px 0 10px;">
    <span style="display:inline-block; height:12px; width:12px; background:#4fba4f; margin-left:6px; vertical-align:middle;"></span>
    <label style="vertical-align:middle;">已完成步骤</label>
    <span style="display:inline-block; height:12px; width:12px; background:#ff9001; margin-left:6px; vertical-align:middle;"></span>
    <label style="vertical-align:middle;">待处理步骤</label>
    <span style="display:inline-block; height:12px; width:12px; background:#7e7e7f; margin-left:6px; vertical-align:middle;"></span>
    <label style="vertical-align:middle;">未经过步骤</label>
  </div>
    <!--  显示面板 -->
    <span style="display: inline-block; vertical-align: top; padding: 5px; width:100%">
      <div id="myDisplayDiv" style="height: 320px"></div>
    </span>
</div>
<!-- <div id="myFlowDesignerDiv" style="border: solid 1px black; height: 420px"></div> -->
<!-- <div id="myDiagramDiv" style="width:98%; height:450px"></div> -->

<sys:footer extLibs="${extLibs}" />
<script src="${ctxStatic}/gojs/js/layer/layer.js" type="text/javascript"></script>
<script src="${ctxStatic}/gojs/js/go.js" type="text/javascript"></script>
<script src="${ctxStatic}/gojs/js/eflow-gojs.js" type="text/javascript"></script>
<script src="${ctxStatic}/gojs/js/flow-desinger.js" type="text/javascript"></script>
<script src="${ctxStatic}/gojs/js/flow-display.js" type="text/javascript"></script>
<script type="text/javascript">
var myDisplay = new FlowDisplay('myDisplayDiv');
//var  myDesigner= new FlowDesigner('myFlowDesignerDiv');
//myDesigner.initToolbar('myDisplayDiv');// 初始化控件面板
var ctx = '${ctx}';
ajaxData();
//initGojs();
function ajaxData(){
	//var isCompleted = $('#chkIsCompleted').is(':checked');
	$.post('${ctx}/eflow/flowLog/getFlowJson',{bizKey:'${flowLog.bizKey}'},function(data){
		log(data);
		myDisplay.loadFlow(data.flowInfo);
	    myDisplay.animateFlowPath(data.txtFlowPath, false);
	   // myDesigner.displayFlow(data.flowInfo);// 在设计面板中显示流程图
	},'json');
}
/* $.post('${ctx}/eflow/flowLog/getFlowJson',{bizKey:'${flowLog.bizKey}'},function(data){
	initGojs('${flowLog.bizKey}',data)
},'json'); */


</script>


