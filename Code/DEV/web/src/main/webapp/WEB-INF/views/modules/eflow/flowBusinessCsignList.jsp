<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<sys:header title="查看会签结果" extLibs="${extLibs}" />
<style>
body{font:13px/1.4 Helvetica,arial,freesans,clean,sans-serif,"Segoe UI Emoji","Segoe UI Symbol";color:rgb(51,51,51);min-width:760px;font-size-adjust:none;font-stretch:normal;margin:0 auto;padding:15px 0;}
.process{padding:10px 15px;height:auto;overflow:hidden;background:#FBFBFB;border:1px solid #DDD;}
.container{width:760px;margin:20px auto 20px auto;}
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
.discussion-timeline{width:730px;float:left;position:relative;}
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
    <div class="discussion-timeline js-quote-selection-container" id="taskInforEle">
    	<c:if test="${empty flowBusinessApprovalList }">会签人员列表为空</c:if>
        <c:forEach items="${flowBusinessApprovalList }" var="flowBusinessApproval">
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
		                                <span class="author" >${flowBusinessApproval.approvalName }</span>
		                            </strong>
		                            <strong>
		                               &nbsp;${fns:formatDate(flowBusinessApproval.approvalDate, 'yyyy-MM-dd HH:mm')}
		                            </strong>
		                        </div>
		                    </div>
		                    <div class="comment-content">
		                        ${flowBusinessApproval.approvalMemo }&nbsp;
		                    </div>
		                </div>
		            </div>
		        </div>
        </c:forEach>
    </div>

</div>
<sys:footer extLibs="${extLibs}" />

