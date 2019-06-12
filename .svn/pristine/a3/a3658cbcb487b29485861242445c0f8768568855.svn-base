<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<link rel="stylesheet" href="${ctxStatic}/layim/css/layui.css">
<script src="${ctxStatic}/sockjs/sockjs.min.js"></script>
<script src="${ctxStatic}/layim/layui.js"></script>
<script>
var ws = null, layim, ctxPath = '${ctxPath}', ctx = '${ctx}', ctxStatic = '${ctxStatic}';
layui.use('layim', function(layimo){
	
	layim = layimo;
	
	//基础配置
	layim.config({

		//初始化接口
		init: {
			url: '${ctx}/layim/initData'
			,data: {
				userGroupName:'员工',
				userType:'1'
			}
		}
		
		//查看群员接口
		,members: {
			url: '${ctx}/layim/findGroupMember'
			,data: {}
		}
		
		//上传图片接口
		,uploadImage: {
			url: '${ctx}/layim/uploadFile' //（返回的数据格式见下文）
			,type: '' //默认post
		} 
		
		//上传文件接口
		,uploadFile: {
			url: '${ctx}/layim/uploadFile' //（返回的数据格式见下文）
			,type: '' //默认post
		}
		
		,isAudio: false //开启聊天工具栏音频
		,isVideo: false //开启聊天工具栏视频
		
		//扩展工具栏
		,tool: [{
			alias: 'code'
			,title: '代码'
			,icon: '&#xe64e;'
		}]
		
// 		,brief: true		//是否简约模式（若开启则不显示主面板）
// 		,title: '即时消息'	//自定义主面板最小化时的标题
// 		,right: '100px'	 	//主面板相对浏览器右侧距离
// 		,minRight: '90px'  	//聊天面板最小化时相对浏览器右侧距离
// 		,initSkin: '0.jpg' 	//1-5 设置初始背景
// 		,skin: ['aaa.jpg'] 	//新增皮肤
// 		,isfriend: false	//是否开启好友
// 		,isgroup: false	 	//是否开启群组
		,min: true			//是否始终最小化主面板，默认false
		,notice: true		//是否开启桌面消息提醒，默认false
		//,voice: 'default.mp3'		//声音提醒，默认开启，声音文件为：default.mp3
		,copyright: true	// 不显示版权
// 		,msgbox: layui.cache.dir + 'html/msgbox.html'	//消息盒子页面地址
// 		,find: layui.cache.dir + 'html/find.html'		//发现页面地址
		,chatLog: layui.cache.dir + 'html/chatlog.html' //聊天记录页面地址
		
		,groupAdd: top.ctx + '/msgim/msgImGroup/form' //添加群组页面地址
		,groupInfo: top.ctx + '/msgim/msgImGroup/form' //查看群组信息地址
		,groupDelete: top.ctx + '/msgim/msgImGroup/delete' //删除群组地址
		,groupAddMember: top.ctx + '/msgim/msgImGroup/formMember' //群组添加成员地址
		,groupDeleteMember: top.ctx + '/msgim/msgImGroup/deleteMember' //群组移出成员地址
		
	});

	//监听在线状态的切换事件
	layim.on('online', function(data){
		log('online↓');
		log(data);
		$.post('${ctx}/layim/setOnlineStatus', {status: data});
	});
	
	//监听签名修改
	layim.on('sign', function(value){
		log('sign↓');
		log(value);
		$.post('${ctx}/layim/updateUserSign', {sign: value}, function(data){
			log(data);
			if(data.result == 'true'){
				layer.msg('修改签名成功', {icon: 1});
			}
		}, 'json');
	});

	//监听自定义工具栏点击，以添加代码为例
	layim.on('tool(code)', function(insert){
		layer.prompt({
			title: '插入代码'
			,formType: 2
			,shade: 0
		}, function(text, index){
			layer.close(index);
			insert('[pre class=layui-code]' + text + '[/pre]'); //将内容插入到编辑器
		});
	});
	
	//监听layim建立就绪
	layim.on('ready', function(res){
		
		log('ready↓');
		log(res);
		
		// 建立Socket连接
		createSocketConnect();
		
	});
	
	// 建立Socket连接
	function createSocketConnect(){
		
		ws = new SockJS("${ctxPath}/websocket");
		
		ws.onopen = function () {
			log('onopen↓');
			log('success');
			
			// 当前用户状态通知其他用户
			$.post('${ctx}/layim/setOnlineStatus');
			
			// 获取所有在线用户列表
			$.getJSON('${ctx}/layim/findOnlineList', function(data){
				for (var i in data){
					layim.setFriendStatus(data[i], 'online');
				}
			});
			
			// 获取未读的消息记录列表
			$.getJSON('${ctx}/layim/findUnReadList', function(data){
				for (var i in data){
					var d = data[i], msg = {
						id: d.sender,
						username: d.senderName,
						avatar: d.senderAvatar,
						type: d.chatType,
						content: d.content,
						timestamp: d.timestamp
		 			};
					if (msg.type == 'group'){
						msg.id = d.groupId;
					}
					layim.getMessage(msg);
					// 收到反馈，更新接收时间
					sendSocketMessage({
						action: 'receiveMessage',
						cid: d.id
					});
				}
			});
			
		};
		
		ws.onmessage = function (e) {
			log('onmessage↓');
			log(e);
			
			var data = JSON.parse(e.data);
			
			// 设置某用户在线状态
			if ('setFriendStatus' == data.action){
				layim.setFriendStatus(data.to.id, data.content);
			}
			
			// 接收发送过来的消息
			else if ('sendMessage' == data.action){
				var msg = data.mine;
				msg.cid = data.cid;
				msg.type = data.type;
				msg.content = data.content;
				msg.timestamp = data.timestamp;
				if(data.type == 'group'){
					msg.id = data.group.id;
				}
				log('getMessage↓');
				log(msg);
				layim.getMessage(msg);
				// 收到反馈，更新接收时间
				sendSocketMessage({
					action: 'receiveMessage',
					cid: data.cid + "_" + data.to.id
				});
			}
			
			// 添加群组
			else if ('addGroup' == data.action){
				var msg = data.group;
				msg.type = 'group';
				layim.addList(msg);
				layer.alert('你已加入'+data.group.groupname+'群组', {icon:6});
			}
			
			// 解散群组
			else if ('deleteGroup' == data.action){
				layim.removeList({type:'group',id:data.group.id});
				layer.alert(data.group.groupname+'群组已被解散', {icon:6});
			}
			
		};
		
		ws.onclose = function (e) {
			log('onclose↓');
			log(e);
			
			// 重新建立Socket连接
			setTimeout(function(){
				createSocketConnect();
			}, 10000);
		};
		
	};

	//监听发送消息
	layim.on('sendMessage', function(data){
		log('sendMessage↓');
		log(data);
		
		data.action = 'sendMessage';
		$.ajax({url:'${ctxPath}/nextId',async:false,success:function(nextId){	
			data.cid = nextId;
		}});
		data.type = data.to.type;
		data.content = data.mine.content;
		sendSocketMessage(data);
	});
	
	// 发送消息
	function sendSocketMessage(message){
		log('sendSocketMessage↓');
		log(message);
		if (ws == null) {
        	createSocketConnect();
        }
        ws.send(JSON.stringify(message));
	}
	
	//监听查看群员
	layim.on('members', function(data){
		log('members↓');
		log(data);
	});
	
	//监听聊天窗口的切换
	layim.on('chatChange', function(res){
		log('chatChange↓');
		log(res)
		var data = res.data;
		if(data.type === 'friend'){
			// 当前用户状态通知其他用户
			$.ajax({url:'${ctx}/layim/getFriendStatus',data:{userCode:data.id},
				type:'post',async:false,success:function(status){
				layim.setChatStatus('['+(status == 'online'?'在线':'离线')+']&nbsp;'+(data.sign||''));
				layim.setFriendStatus(data.id, status);
			}});
		}
	});
	
});
</script>