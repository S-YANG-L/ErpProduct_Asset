/**
 * 仪表盘
 * @param id 容器id
 * @param title 标题
 * @param value 值
 */
function initChart(id,title,value){
	//基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById(id));

	// 指定图表的配置项和数据
	var option = {
	title: {
	    text: title, //标题文本内容
	    bottom:20,
	    left:110,
	},
	animation:false,
	toolbox: { //可视化的工具箱
	    show: true,
	    feature: {
	        restore: { //重置
	            show: false
	        },
	        saveAsImage: {//保存图片
	            show: false
	        }
	    }
	},
	tooltip: { //弹窗组件
	    formatter: "{a} : {c}%"
	},
	grid:{
	    x:0,
	    y:0,
	    x2:0,
	    y2:0
	  },
	series: [{
	    name: title,
	    type: 'gauge',
	    radius:'90%',
	    detail: {formatter:value+'%'},
	    axisLine: {            // 坐标轴线  
            lineStyle: {       // 属性lineStyle控制线条样式  
                color: [[0.2, '#228b22'], [0.8, '#4389bc'], [1, '#ff4400']]
            }  
        },
	    data: [{value: value, name: ''}]
	}]
	};
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
}
/**
 * 半圆仪表盘
 * @param id 容器id
 * @param title 标题
 * @param value 值
 */
function cpuUsage(id,title,value){
	//基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById(id));

	// 指定图表的配置项和数据
	var option = {
	title: {
	    text: title, //标题文本内容
	    bottom:20,
	    left:170,
	},
	animation:false,
	toolbox: { //可视化的工具箱
	    show: true,
	    feature: {
	        restore: { //重置
	            show: false
	        },
	        saveAsImage: {//保存图片
	            show: false
	        }
	    }
	},
	tooltip: { //弹窗组件
	    formatter: "{a} : {c}%"
	},
	itemStyle:{
    	emphasis:{
    		color: {
    		    type: 'linear',
    		    x: 0,
    		    y: 0,
    		    x2: 0,
    		    y2: 1,
    		    colorStops: [{
    		        offset: 0, color: 'red' // 0% 处的颜色
    		    }, {
    		        offset: 1, color: 'blue' // 100% 处的颜色
    		    }],
    		    globalCoord: false // 缺省为 false
    		}
    	}
    },
	series: [{
	    name: title,
	    type: 'gauge',
	    startAngle: 180,
	    endAngle: 0,"center": ["50%", "80%"],
        radius:'140%',
	    detail: {formatter:value+'%',offsetCenter: [5, -56],fontSize:12},
	    axisLine: {            // 坐标轴线  
            lineStyle: {       // 属性lineStyle控制线条样式  
                color: [[0.2, '#228b22'], [0.8, '#4389bc'], [1, '#ff4400']],
                width: 80,
            }  
        },
        axisTick: {show:false},
        axisLabel: {            // 坐标轴小标记
            textStyle: {       // 属性lineStyle控制线条样式
                fontWeight: 'bolder',
                fontSize : 12,
                color: '#fff'
            }
        },
        splitLine: {           // 分隔线
            length : 30,         // 属性length控制线长
            lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                width:1,
                color: '#fff'
            }
        },
        axisTick: {
        	splitNumber:7,
        },
        pointer: {           // 分隔线
            color:'#fff',
            width: 5,
            length:140,
            itemStyle:{
            	emphasis:{
            		color: {
            		    type: 'linear',
            		    x: 0,
            		    y: 0,
            		    x2: 0,
            		    y2: 1,
            		    colorStops: [{
            		        offset: 0, color: 'red' // 0% 处的颜色
            		    }, {
            		        offset: 1, color: 'blue' // 100% 处的颜色
            		    }],
            		    globalCoord: false // 缺省为 false
            		}
            	}
            },
        },
	    data: [{value: value, name: ''}]
	}]
	};
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
}

/**
 * ajax获取使用率数据
 */
function ajaxUsageData(){
	$.ajax({
		url:ctx+'/state/stateServerLog/getMonitorInfo',
		type:'post',
		dataType:'json',
		success:function(data){
			initChart('jvmChart','JVM使用率',data.jvmUsage);
			cpuUsage('cpuChart','CPU使用率',data.cpuUsage);
			initChart('memoryChart','内存使用率',data.serverMemoryUsage);
			$("#jvmUsage_td").html(usageHtml(data.jvmUsage));
			$("#cpuUsage_td").html(usageHtml(data.cpuUsage));
			$("#serverMemoryUsage_td").html(usageHtml(data.serverMemoryUsage));
			$("#jvmCapacity_td").html(data.usedJvmMemory+'M/'+data.totalJvmMemory+'M');
			$("#memoryCapacity_td").html(data.usedMemory+'M/'+data.totalMemory+'M');
			$("#cpuCapaCity_td").html(data.cpuCurrGhz+"&nbsp;Ghz/"+data.cpuMaxGhz+'&nbsp;Ghz');
		}
	});
}
/**
 * 根据使用率，判断采用的颜色
 * @param usage
 * @returns {String}
 */
function usageHtml(usage){
	var usageHtml = '';
	if(usage >= 0 && usage <= 20){
		usageHtml='<font color="#228c20">'+usage+'%</font>';
	}else if(usage >= 20 && usage <= 80){
		usageHtml='<font color="#4389bc">'+usage+'%</font>';
	}else{
		usageHtml='<font color="#ff4401">'+usage+'%</font>';
	}
	return usageHtml;
}
/**
 * 修改配置
 * @param val
 * @param key
 * @returns
 */
function updateServerConfig(val,key){
	$.ajax({
		url:ctx+'/state/stateServerLog/updateServerConfig',
		type:'post',
		data:{value:val,keys:key},
		dataType:'json',
		success:function(data){
			showMessage(data.message);
		}
	});
}
/**
 * 获取预警超出值
 * @returns
 */
function updateConfig(){
	var value = "{";
	var jvmUsage = $("#jvmUsage").val();
	var cpuUsage = $("#cpuUsage").val();
	var memoryUsage = $("#memoryUsage").val();
	if(jvmUsage==''){
		showMessage("jvm内存超出率不能为空！");
		return;
	}else if(isNaN(jvmUsage)){
		showMessage("jvm内存超出率只能为数值，不能为负数");
		return;
	}
	if(cpuUsage==''){
		showMessage("cpu超出率不能为空！");
		return;
	}else if(isNaN(cpuUsage)){
		showMessage("cpu超出率只能为数值，不能为负数");
		return;
	}
	if(memoryUsage==''){
		showMessage("内存超出率不能为空！");
		return;
	}else if(isNaN(memoryUsage)){
		showMessage("内存超出率只能为数值，不能为负数");
		return;
	}
	value +="cpu:"+cpuUsage+",memory:"+memoryUsage+",jvm:"+jvmUsage+"}";
	return value;
}

/**
 * 预警值修改
 */
function updateUsage(){
	if(updateConfig()!=undefined){
		updateServerConfig(updateConfig(),'sys.state.warning.peak');
	}
}
/**
 * 手机号修改
 * @returns
 */
function updatePhone(){
	var phone = $("#phoneNumbers").val();
	if(phone==''){
		phone='无';
	}else if(!checkPhone(phone)){
		return;
	}
	updateServerConfig(phone,'sys.state.warning.mobile');
}
/**
 * 邮箱修改
 * @returns
 */
function updateEmail(){
	var email = $("#emails").val();
	if(email==''){
		email='无';
	}else if(!checkEmail(email)){
		return;
	}
	updateServerConfig(email,'sys.state.warning.email');
}

/**
 * 手机号码验证
 * @param val
 * @returns
 */
function checkPhone(val){
	if(val!=''){
		if(val.indexOf("，")!=-1){
			showMessage("请使用英文逗号！");
			return false;
		}
		var res= /^(13[0-9]{9})|(15[0-9][0-9]{8})|(18[0-9][0-9]{8})|(17[0-9][0-9]{8})$/;
		if(val.indexOf(",")!=-1){
			var vls = val.split(",");
			for(var i=0;i<vls.length;i++){
				if(!res.test(vls[i])){
					showMessage("手机号码["+vls[i]+"]格式不正确!");
					return false;
				}
			}
		}else{
			if(!res.test(val)){
				showMessage("手机号码["+val+"]格式不正确!");
				return false;
			}
		}
	}
	return true;
}
/**
 * 验证邮箱
 * @param val
 * @returns {Boolean}
 */
function checkEmail(val){
	if(val!=''){
		if(val.indexOf("，")!=-1){
			showMessage("请使用英文逗号！");
			return false;
		}
		var res = /\w@\w*\.\w/;
		if(val.indexOf(",")!=-1){
			var els = val.split(",");
			for (var i = 0; i < els.length; i++) {
				if(!res.test(els[i])){
					showMessage("邮箱["+els[i]+"]格式不正确！");
					return false;
				}
			}
		}else{
			if(!res.test(val)){
				showMessage("邮箱["+val+"]格式不正确！");
				return false;
			}
		}
		
	}
	return true;
}
// 点击查看日志跳转到查看服务器监控日志界面
$("#btnServerLog").click(function(){
	top.addTabPage(top.$(this), '服务器监控日志',ctx+'/state/stateServerLog/list');
});