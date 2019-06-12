<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html><head>
	<title>WebSocket/SockJS</title>
</head><body>
<div>
    <div id="connect-container">
        <div>
            <textarea id="message" style="width:350px;height:90px;">
{
	act: 'send',
	rec: 'system',
	msg: '发送消息内容'
}
			</textarea>
        </div>
        <div>
            <button id="connect" onclick="connect();">连接</button>
            <button id="disconnect" onclick="disconnect();" disabled="disabled">断开</button>
            <button id="send" onclick="send();" disabled="disabled">发送消息</button>
        </div>
    </div>
    <div id="console-container">
        <div id="console" style="height:190px;overflow-y:scroll;"></div>
    </div>
	<script src="${ctxStatic}/jquery/jquery-1.11.2.min.js"></script>
	<script src="${ctxStatic}/sockjs/sockjs.min.js"></script>
    <script type="text/javascript">
    
        var ws = null;
        
    	connect();

        function connect() {
        	
        	ws = new SockJS("${ctxPath}/websocket");
        	
            ws.onopen = function () {
                setConnected(true);
            };
            
            ws.onmessage = function (e) {
            	console.log(e)
                log('收到消息: ' + e.data);
            };
            
            ws.onclose = function (e) {
            	console.log(e)
                log('连接关闭: '+e.reason);
                setConnected(false);
            };
            
        }

        function disconnect() {
            if (ws != null) {
                ws.close();
                ws = null;
            }
            setConnected(false);
        }

        function setConnected(connected) {
            document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;
            document.getElementById('send').disabled = !connected;
        }

        function send() {
            if (ws != null) {
                var message = document.getElementById('message').value;
//                 log('发送: ' + message);
                ws.send(message);
            } else {
                log('还未建立连接.');
            }
        }
        
        function log(message) {
            var console = document.getElementById('console');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            console.appendChild(p);
            while (console.childNodes.length > 25) {
                console.removeChild(console.firstChild);
            }
            console.scrollTop = console.scrollHeight;
        }
    </script>
</div>
</body>
</html>