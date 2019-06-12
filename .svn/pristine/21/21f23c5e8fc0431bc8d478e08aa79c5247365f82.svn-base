// 显示广告的函数
(function showads1() {
		var ads = $('body').attr('ads');
		var url='/manager.advertjson.list.phtml';
		if (ads != undefined && ads != "") {
			$.post(url,{'adver':ads},function(result){
				var arr = $.parseJSON(result);
				for(var i=0;i<arr.length;i++){
					//console.log(arr[i].adver_id);
					show(arr[i]);
				}
			});
			
		}
		
}());

function show(ads) {
	switch(ads.ad_type){
		case "浮动": fudong(ads); break;
		case "对联": duilian(ads); break;
		case "背投": beitou(ads); break;
		case "折叠": zhedie(ads); break;
		case "固定": guding(ads); break;
	}
}


function ad_head(onclick) {
		var h = document.createElement('div');
		h.style.textAlign = 'right';
		h.style.padding = '3px 3px 2px 3px';
		h.style.backgroundColor = 'transparent';
		h.style.zIndex = '1000';
		var a = document.createElement('a');
		a.href = 'javascript:void(0)';
		a.appendChild(document.createTextNode('关闭'));
		a.style.textDecoration = 'none';
		a.style.color="#000";
		a.onclick = onclick;
		h.appendChild(a);
		return h;
	}
	function ad_body(html) {
		var d = document.createElement('div');
		d.style.border = '1px solid #999';
		d.style.backgroundColor = '#fff';
		d.style.cursor = 'pointer';
		d.style.zIndex = '1000';
		d.innerHTML = html;
		return d;
	}

////////////////////////////对联广告//////////////////////////	
var duilian = function() {
	var ad1, ad2, adTop=200,adLeftRight=10;
	function duilian_close() {
		$(window).off('scroll',onscroll);
		$(ad1).empty();
		$(ad2).empty();
	}
	function duilian(ads) {
		var d = document.createElement('div');
		d.style.position = 'absolute';
		d.style.top = adTop + 'px';
		d.style.zIndex = '1000';
		d.appendChild(ad_head(null));
		d.appendChild(ad_body(ads.content));

		ad1 = d.cloneNode(true);
		ad1.style.left = adLeftRight+'px';
		document.body.appendChild(ad1);
		var a  = document.getElementsByClassName('container')[0];
		console.log(a);
		ad2 = d.cloneNode(true);
		ad2.style.right = adLeftRight+'px';
		document.body.appendChild(ad2);

		ad1.getElementsByTagName('a')[0].onclick = ad2.getElementsByTagName('a')[0].onclick = duilian_close;
		$(window).on('scroll',onscroll);
	}

	var onscroll = function() {
		var t = 0;
		function sad() {
			var T = (document.documentElement.scrollTop || document.body.scrollTop) + adTop;
			var x = ad1.offsetTop - T;
			x *= .8;
			if (-1 < x && 1 < 1) {
				x = 0;
				clearInterval(t);
			}
			ad1.style.top = ad2.style.top = (T + x) + 'px';
		}
		return function() {
			clearInterval(t);
			t = setInterval(sad, 30);
		};
	}();
	return duilian;
}();
////////////////////////////对联广告//////////////////////////	

////////////////////////////浮动广告//////////////////////////	
var fudong = function() {
	var H, W;
	function resize() {
		H = Math.max(document.documentElement.scrollHeight,
			document.documentElement.clientHeight,
			document.body.scrollHeight,
			document.body.clientHeight);
		W = Math.max(document.documentElement.scrollWidth,
			document.documentElement.clientWidth,
			document.body.scrollWidth,
			document.body.clientWidth);
	}

	var ad;
	function fudong_close() {
		swimStop();
		$(window).off('resize',resize);
		//remove是把绑定到ad上的事件都删除掉
		$(ad).remove();
		//再将ad元素删除
		$(ad).empty();
		ad = null;
	}
	function fudong(ads) {
		var d = document.createElement('div');
		d.style.position = 'absolute';
		d.style.top = '0px';
		d.style.left = '0px';
		d.style.zIndex = '1000';
		d.appendChild(ad_head(fudong_close));
		d.appendChild(ad_body(ads.content));
		document.body.appendChild(ad = d);

		resize();
		$(window).on('resize',resize);
		$(ad).on('mouseover',swimStop);
		$(ad).on('mouseout',swimGo);
		swimGo();
	}

	var timer = 0;

	var top = 0;
	var left = 0;
	var _x = 2;
	var _y = 2;

	function f() {
		top += _y;
		if (_y > 0) {
			if (top + ad.offsetHeight >= H) {
				top = (H - ad.offsetHeight) * 2 - top;
				_y = -_y;
			}
		}
		else {
			if (top <= 0) {
				top = -top;
				_y = -_y;
			}
		}
		ad.style.top = top + 'px';

		left += _x;
		if (_x > 0) {
			if (left + ad.offsetWidth >= W) {
				left = (W - ad.offsetWidth) * 2 - left;
				_x = -_x;
			}
		}
		else {
			if (left <= 0) {
				left = -left;
				_x = -_x;
			}
		}
		ad.style.left = left + 'px';
	}
	function swimf(b) {
		clearInterval(timer);
		if (b) timer = setInterval(f, 40);
	}

	function swimGo() {
		swimf(1);
	}
	function swimStop() {
		swimf(0);
	}

	return fudong;
}();
////////////////////////////浮动广告//////////////////////////

////////////////////////////背投广告//////////////////////////
var beitou = function() {
	var ad, closed = false;
	function beitou(ads) {
		var d = document.createElement('div');
		d.appendChild(ad_head(beitou_close));
		d.appendChild(ad_body(ads.content));
		document.body.insertBefore(ad = d, document.body.firstChild);

		setTimeout(beitou_close, 3000);
	}
	function beitou_close() {
		if (closed) return;
		closed = true;

		var t, h = ad.offsetHeight;
		var v = 2;
		var a = 2;
		function f() {
			h -= v;
			if (h <= 0) {
				clearInterval(t);
				ad.parentNode.removeChild(ad);
				ad = null;
				return;
			}
			ad.style.height = h + 'px';
			v += a;
		}
		ad.style.overflow = 'hidden';
		t = setInterval(f, 10);
	}
	return beitou;
}();
////////////////////////////背投广告//////////////////////////

////////////////////////////固定广告//////////////////////////
var guding = function(){
	var ad;
	function guding_close(){
		$(ad).empty();
	}
	function guding(ads){
		var left = ads.site.split(',')[0];
		var top = ads.site.split(',')[1];
		var d = document.createElement('div');
		d.style.position='fixed';
		d.style.left=left+'px';
		d.style.top=top+'px';
		d.appendChild(ad_head(guding_close));
		d.appendChild(ad_body(ads.content));
		document.body.appendChild(ad = d);
	}
	return guding;
}();


////////////////////////////固定广告//////////////////////////

////////////////////////////折叠广告//////////////////////////
var zhedie = function(){
	var ads;
	var expanded=true;
	//折叠广告在右侧的折叠事件
	function zhedie_expanded_right(){
		if (expanded) {
			$('#ads_zhedie').animate({right:'0'},500);
			$('#ads_head_a').attr('src','/image/mini_close.png');

		}else {
			$('#ads_zhedie').animate({right:'-260px'},500);
			$('#ads_head_a').attr('src','/image/mini_open.png');
		}
		expanded=!expanded;
	}
	//折叠广告在左侧的折叠事件
	function zhedie_expanded_left(){
		if (expanded) {
			$('#ads_zhedie').animate({left:'0'},500);
			$('#ads_head_a').attr('src','/image/mini_open.png');

		}else {
			$('#ads_zhedie').animate({left:'-260px'},500);
			$('#ads_head_a').attr('src','/image/mini_close.png');
		}
		expanded=!expanded;
	}
	
	function zhedie(ads){
		var ads_site = ads.site;
		if(ads_site=='left'){
			left(ads);
		}else{
			right(ads);
		}
		
	}
	function left(ads){
		//最大div
		var ad = document.createElement('div');
		ad.setAttribute('id','ads_zhedie');
		ad.style.position='fixed';
		ad.style.width='290px';
		ad.style.left='-260px';
		ad.style.bottom='120px';
		ad.style.zIndex = '1000';
		
		var d = document.createElement('div');
		d.style.width='290px';
		d.style.minheight='220px';
		d.style.position='relative';
		
		//广告标题竖列显示
		var title='';
		//string转数组
		var title_arr = ads.title.split('');
		for(var i=0;i<title_arr.length;i++){
			title+=title_arr[i]+'<br />';
		}
		
		var d_head = document.createElement('div');
		d_head.setAttribute('id','ads_head');
		d_head.style.width='30px';
		d_head.style.float='right';
		d_head.style.backgroundColor='#297AD0';
		d_head.style.color='#FFFFFF';
		d_head.style.cursor = 'pointer';
		d_head.onclick=zhedie_expanded_left;
		
		var d_head_a = document.createElement('img');
		d_head_a.setAttribute('id','ads_head_a');
		d_head_a.style.position='relative';
		d_head_a.style.float='right';
		d_head_a.src='/image/mini_close.png';
		//d_head_a.innerHTML='&nbsp;&nbsp;';
		var d_head_span = document.createElement('span');
		
		d_head_span.style.display='block';
		d_head_span.style.width='100%';
		d_head_span.style.textAlign='center';
		d_head_span.innerHTML=title;
		
		d_head.appendChild(d_head_a);
		d_head.appendChild(d_head_span);
		
		
		var d_body =document.createElement('div');
		d_body.setAttribute('id','ads_body');
		d_body.style.borderColor='#ccc';
		d_body.style.borderTopWidth='1px';
		d_body.style.borderBottomWidth='1px';
		d_body.style.borderLeftWidth='1px';
		d_body.style.borderRightWidth='1px';
		d_body.style.borderStyle='solid';
		
		
		
		d_body.style.width='260px';
		d_body.style.height='100%';
		d_body.style.backgroundColor='#FFFFFF';
		d_body.style.float='left';
		d_body.style.padding='10px';
		d_body.innerHTML=ads.content;
		
		d.appendChild(d_head);
		d.appendChild(d_body);
		ad.appendChild(d);
		
		
		document.body.appendChild(ads = ad);
	}
	function right(ads){
		var ad = document.createElement('div');
		ad.setAttribute('id','ads_zhedie');
		ad.style.position='fixed';
		ad.style.width='290px';
		ad.style.right='-260px';
		ad.style.bottom='120px';
		ad.style.zIndex = '1000';
		
		var d = document.createElement('div');
		d.style.width='290px';
		d.style.minheight='220px';
		d.style.position='relative';
		
		
		var title='';
		var title_arr = ads.title.split('');
		for(var i=0;i<title_arr.length;i++){
			title+=title_arr[i]+'<br />';
		}
		
		var d_head = document.createElement('div');
		d_head.setAttribute('id','ads_head');
		d_head.style.width='30px';
		d_head.style.float='left';
		d_head.style.backgroundColor='#297AD0';
		d_head.style.color='#FFFFFF';
		d_head.style.cursor = 'pointer';
		d_head.onclick=zhedie_expanded_right;
		
		var d_head_a = document.createElement('img');
		d_head_a.setAttribute('id','ads_head_a');
		d_head_a.style.position='relative';
		d_head_a.style.float='left';
		d_head_a.src='/image/mini_open.png';
		//d_head_a.innerHTML='&nbsp;&nbsp;';
		var d_head_span = document.createElement('span');
		
		d_head_span.style.display='block';
		d_head_span.style.width='100%';
		d_head_span.style.textAlign='center';
		d_head_span.innerHTML=title;
		d_head.appendChild(d_head_a);
		d_head.appendChild(d_head_span);
		
		var d_body =document.createElement('div');
		d_body.setAttribute('id','ads_body');
		d_body.style.borderColor='#ccc';
		d_body.style.borderTopWidth='1px';
		d_body.style.borderBottomWidth='1px';
		d_body.style.borderLeftWidth='1px';
		d_body.style.borderRightWidth='1px';
		d_body.style.borderStyle='solid';
		
		
		
		d_body.style.width='260px';
		d_body.style.height='100%';
		d_body.style.backgroundColor='#FFFFFF';
		d_body.style.float='left';
		d_body.style.padding='10px';
		d_body.innerHTML=ads.content;
		
		d.appendChild(d_head);
		d.appendChild(d_body);
		ad.appendChild(d);
		
		
		document.body.appendChild(ads = ad);
	}
	return zhedie;
}();

////////////////////////////折叠广告//////////////////////////