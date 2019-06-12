<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="grid"/>
<sys:header title="服务器监控" extLibs="${extLibs}" />
<link href="${ctxStatic}/modules/state/css/style.css?${_version}" type="text/css" rel="stylesheet"/>
<div class="portlet box ${boxStyleColor}">
	<div class="portlet-title">
		<div class="caption"><i class="fa fa-coffee"></i> 服务器监控</div>
		<div class="actions">
			<a href="#" class="btn btn-default btn-sm" id="btnServerLog" title="查看日志"><i class="fa fa-book"></i> 查看日志</a>
		</div>
	</div>
	<div class="portlet-body list">
		<table class="chart_table">
			<tr>
				<td class="chart_td">
					<div id="jvmChart" style="width: 320px;height:300px;"></div>
				</td>
				<td class="chart_td">
					<div id="cpuChart" style="width: 430px;height:300px;"></div>
				</td>
				<td class="chart_td">
					<div id="memoryChart" style="width: 320px;height:300px;"></div>
				</td>
			</tr>
		</table>
		<table class="caveat_table">
			<tr>
				<td colspan="5" class="caveat_config">
					&nbsp;&nbsp;&nbsp;<i class="fa fa-briefcase"></i>&nbsp;警告设置
				</td>
			</tr>
			<tr>
				<td class="caveat_title">名称</td>
				<td class="caveat_title">容量大小(已用/总共)</td>
				<td class="caveat_title">使用率</td>
				<td class="caveat_title">预警设置</td>
				<td class="caveat_title">手机/邮箱设置</td>
			</tr>
			<tr>
				<td align="center">JVM内存</td>
				<td align="center" id="jvmCapacity_td">${maps.usedJvmMemory}M/${maps.totalJvmMemory}M</td>
				<td align="center" id="jvmUsage_td">${maps.jvmUsage}%</td>
				<td align="center">
					使用率超出<input type="text" id="jvmUsage" value="${montiors.jvm}" class="input_wd"/>,发送短信或邮件提醒
					<button value="修改" id="jvmUsageBtn" onclick="updateUsage()" class="btn_update">修改</button>
				</td>
				<td>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">手机：</span>
						<input type="text" id="phoneNumbers" value="${phones}" class="input_wd1" placeholder="支持多个手机,以英文逗号分隔" aria-describedby="basic-addon1"/>
					<button value="修改" id="phoneBtn" onclick="updatePhone()" class="btn_update">修改</button>
					</div>
				</td>
			</tr>
			<tr>
				<td align="center">CPU</td>
				<td align="center" id="cpuCapaCity_td">${maps.cpuCurrGhz}&nbsp;Ghz/${maps.cpuMaxGhz}&nbsp;Ghz</td>
				<td align="center" id="cpuUsage_td">${maps.cpuUsage}%</td>
				<td align="center">
					使用率超出<input type="text" id="cpuUsage" value="${montiors.cpu}" class="input_wd" />,发送短信或邮件提醒
					<button value="修改" id="cpuUsageBtn" onclick="updateUsage()" class="btn_update">修改</button>
				</td>
				<td>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon2">邮箱：</span>
						<input type="text" id="emails" value="${emails}" class="input_wd1" placeholder="支持多个邮箱,以英文逗号分隔" aria-describedby="basic-addon2"/>
						<!-- <span class="input-group-addon" id="basic-addon2">@example.com</span> -->
						<button value="修改" id="emailBtn" onclick="updateEmail()" class="btn_update">修改</button>
					</div>
				</td>
			</tr>
			<tr>
				<td align="center">服务器内存</td>
				<td align="center" id="memoryCapacity_td">${maps.usedMemory}M/${maps.totalMemory}M</td>
				<td align="center" id="serverMemoryUsage_td">${maps.serverMemoryUsage}%</td>
				<td align="center">
					使用率超出<input type="text" id="memoryUsage" value="${montiors.memory}" class="input_wd"/>,发送短信或邮件提醒
					<button value="修改" id="memoryUsageBtn" onclick="updateUsage()" class="btn_update">修改</button>
				</td>
				<td>
					支持多个,以英文逗号","分隔
				</td>
			</tr>
			<tr>
				<td colspan="5" class="caveat_config">
					&nbsp;&nbsp;&nbsp;<i class="fa fa-desktop"></i>&nbsp;服务器信息
				</td>
			</tr>
			<tr>
				<td align="center">服务器IP</td>
				<td>
					${maps.serverIp}
				</td>
				<td align="center">服务器名称</td>
				<td colspan="2">
					${maps.serverName}
				</td>
			</tr>
			<tr>
				<td align="center">操作系统</td>
				<td>
					${maps.systemName}
				</td>
				<td align="center">CPU个数</td>
				<td colspan="2">
					${maps.cpuNum}
				</td>
			</tr>
			<tr>
				<td align="center">JDK版本</td>
				<td>
					${maps.javaVersion}
				</td>
				<td align="center">JDK供应商</td>
				<td colspan="2">
					${maps.javaVendor}
				</td>
			</tr>
			<tr>
				<td align="center">JDK安装路径</td>
				<td colspan="4">
					${maps.javaHome}
				</td>
			</tr>
			<tr>
				<td align="center">容器名称</td>
				<td colspan="4">
					${maps.containerName}
				</td>
			</tr>
			<tr>
				<td align="center">容器路径</td>
				<td colspan="4">
					${maps.containerPath}
				</td>
			</tr>
			<tr>
				<td align="center">日志路径</td>
				<td colspan="4">
					${maps.logPath}/logs<br/>
				</td>
			</tr>
		</table>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script src="${ctxStatic}/echarts/3.2/echarts.min.js"></script>
<script src="${ctxStatic}/modules/state/js/state.js"></script>
<script type="text/javascript">
var ctx = '${ctx}';
/* initChart('jvmChart','JVM使用率','${maps.jvmUsage}');
cpuUsage('cpuChart','CPU使用率','${maps.cpuUsage}');
initChart('memoryChart','内存使用率','${maps.serverMemoryUsage}'); */
ajaxUsageData();
setInterval(function (){
	ajaxUsageData();
},5000);
</script>