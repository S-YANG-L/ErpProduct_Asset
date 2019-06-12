<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extHead">
	<link rel="stylesheet" type="text/css" href="css/taskDetailInfor.css" />
	<script src="js/foxbpmframework.js?${_version}"></script>
	<script src="js/taskInfor.js?${_version}"></script>
	<script src="js/flowInfor.js?${_version}"></script> 
	<script src="js/flowGraphicInfor.js?${_version}"></script>
	<script src="js/flowRunTrackInfor.js?${_version}"></script>
</c:set>
<sys:header title="流程跟踪" extLibs="custom,jquery" extHead="${extHead}"/>
<div class="container process" id="processInfo">
	<div class="repository-with-sidebar repo-container new-discussion-timeline">
		<div class="repository-content context-loader-container"
			id="js-repo-pjax-container" data-pjax-container="">
			<div class="issues-listing" >
				<div class="context-loader-container" id="issues-container">
					<div class="issues-listing">
						<div class="js-issues-results" id="show_issue">
							<div class="tab-content clearfix" id="discussion_bucket">
								<!-- 流程信息 -->
								<div class="discussion-sidebar" id="flowInforEle">
								</div>
								<!-- 任务详细信息 -->
								<div class="discussion-timeline js-quote-selection-container" id="taskInforEle">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<br>
<div class="container process">
	<div id="process">
		<div id="flowRunTrackInforEle" style="display: none;" class="proc_bg"></div>
		<div id="flowGraphicInforEle" class="proc_bg"></div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		var isIELowVer = window.ActiveXObject && ($.browser.msie && $.browser.version < 8.0); 
		if (_processInstanceId != ''){
			//流程信息
			var flowInfor = new FlowInfor({
				eleId:'flowInforEle',
			    action : _bpmServiceUrl,
				processInstanceId : _processInstanceId
			});
			flowInfor.init();
			//流程运行轨迹信息
			var flowRunTrackInfor = new FlowRunTrackInfor({
				eleId:'flowRunTrackInforEle',
				isIELowVer:isIELowVer,
				action : _bpmServiceUrl + '/task/runTrack',
				processInstanceId : _processInstanceId
			});
			flowRunTrackInfor.init();
		}
		//流程图信息
		var flowGraphicInfor = new FlowGraphicInfor({
			eleId:'flowGraphicInforEle',
			isIELowVer : isIELowVer,
			action : _bpmServiceUrl,
			processInstanceId : _processInstanceId,
			processDefinitionKey : _processDefinitionKey,
			runTrackObj:flowRunTrackInfor
		});
		flowGraphicInfor.init();
		//任务信息
	    var taskInfor = new TaskInfor({
	    	eleId:'taskInforEle',
	    	action : _bpmServiceUrl,
			processInstanceId : _processInstanceId,
			processDefinitionKey : _processDefinitionKey,
			flowInforObj:flowInfor,
			flowGraphicInforObj:flowGraphicInfor
		}).init();
	});
</script>
