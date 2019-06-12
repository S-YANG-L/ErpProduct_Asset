// JScript 文件

function getRootPath() {
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    return (localhostPaht + projectName);
}



function add(a, b) {
    var c, d, e;
    try {
        c = a.toString().split(".")[1].length;
    } catch (f) {
        c = 0;
    }
    try {
        d = b.toString().split(".")[1].length;
    } catch (f) {
        d = 0;
    }
    return e = Math.pow(10, Math.max(c, d)), (mul(a, e) + mul(b, e)) / e;
}
 
function sub(a, b) {
    var c, d, e;
    try {
        c = a.toString().split(".")[1].length;
    } catch (f) {
        c = 0;
    }
    try {
        d = b.toString().split(".")[1].length;
    } catch (f) {
        d = 0;
    }
    return e = Math.pow(10, Math.max(c, d)), (mul(a, e) - mul(b, e)) / e;
}
 
function mul(a, b) {
    var c = 0,
        d = a.toString(),
        e = b.toString();
    try {
        c += d.split(".")[1].length;
    } catch (f) {}
    try {
        c += e.split(".")[1].length;
    } catch (f) {}
    return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
}
 
function div(a, b) {
    var c, d, e = 0,
        f = 0;
    try {
        e = a.toString().split(".")[1].length;
    } catch (g) {}
    try {
        f = b.toString().split(".")[1].length;
    } catch (g) {}
    return c = Number(a.toString().replace(".", "")), d = Number(b.toString().replace(".", "")), mul(c / d, Math.pow(10, f - e));
}

Number.prototype.div = function (arg) {
    return div(this, arg);
};
Number.prototype.mul = function (arg) {
    return mul(this, arg);
};
Number.prototype.add = function (arg) {
    return add(this, arg);
}
Number.prototype.sub = function (arg) {
    return sub(this, arg);
}

function IsNullOrEmpty(str) {
    var result = false;
    if (str == null || str == '') {
        result = true;
    }
    return result;
}

//同C# padLeft函数
String.prototype.padLeft = function (len, ch) {
    ch = typeof (ch) === 'undefined' ? ' ' : ch;
    var s = String(this);
    while (s.length < len)
        s = ch + s;
    return s;
}

//转成人民币大写金额形式
function cmycurd(num) {  //转成人民币大写金额形式
    var str1 = '零壹贰叁肆伍陆柒捌玖';  //0-9所对应的汉字
    var str2 = '万仟佰拾亿仟佰拾万仟佰拾元角分'; //数字位所对应的汉字
    var str3;    //从原num值中取出的值
    var str4;    //数字的字符串形式
    var str5 = '';  //人民币大写金额形式
    var i;    //循环变量
    var j;    //num的值乘以100的字符串长度
    var ch1;    //数字的汉语读法
    var ch2;    //数字位的汉字读法
    var nzero = 0;  //用来计算连续的零值是几个

    num = Math.abs(num).toFixed(2);  //将num取绝对值并四舍五入取2位小数
    str4 = (num * 100).toFixed(0).toString();  //将num乘100并转换成字符串形式
    j = str4.length;      //找出最高位
    if (j > 15) { return '溢出'; }
    str2 = str2.substr(15 - j);    //取出对应位数的str2的值。如：200.55,j为5所以str2=佰拾元角分

    //循环取出每一位需要转换的值
    for (i = 0; i < j; i++) {
        str3 = str4.substr(i, 1);   //取出需转换的某一位的值
        if (i != (j - 3) && i != (j - 7) && i != (j - 11) && i != (j - 15)) {    //当所取位数不为元、万、亿、万亿上的数字时
            if (str3 == '0') {
                ch1 = '';
                ch2 = '';
                nzero = nzero + 1;
            }
            else {
                if (str3 != '0' && nzero != 0) {
                    ch1 = '零' + str1.substr(str3 * 1, 1);
                    ch2 = str2.substr(i, 1);
                    nzero = 0;
                }
                else {
                    ch1 = str1.substr(str3 * 1, 1);
                    ch2 = str2.substr(i, 1);
                    nzero = 0;
                }
            }
        }
        else { //该位是万亿，亿，万，元位等关键位
            if (str3 != '0' && nzero != 0) {
                ch1 = "零" + str1.substr(str3 * 1, 1);
                ch2 = str2.substr(i, 1);
                nzero = 0;
            }
            else {
                if (str3 != '0' && nzero == 0) {
                    ch1 = str1.substr(str3 * 1, 1);
                    ch2 = str2.substr(i, 1);
                    nzero = 0;
                }
                else {
                    if (str3 == '0' && nzero >= 3) {
                        ch1 = '';
                        ch2 = '';
                        nzero = nzero + 1;
                    }
                    else {
                        if (j >= 11) {
                            ch1 = '';
                            nzero = nzero + 1;
                        }
                        else {
                            ch1 = '';
                            ch2 = str2.substr(i, 1);
                            nzero = nzero + 1;
                        }
                    }
                }
            }
        }
        if (i == (j - 11) || i == (j - 3)) {  //如果该位是亿位或元位，则必须写上
            ch2 = str2.substr(i, 1);
        }
        str5 = str5 + ch1 + ch2;

        if (i == j - 1 && str3 == '0') {   //最后一位（分）为0时，加上“整”
            str5 = str5 + '整';
        }
    }
    if (num == 0) {
        str5 = '零元整';
    }
    return str5;
}

//获取当前日期
function GetCurrDate() {
    var today = new Date();
    var years = today.getFullYear();
    var month = today.getMonth() + 1;
    var days = today.getDate();
    return years.toString() + "-" + month.toString() + "-" + days.toString();
}

/***格式化
 *@params money {Number or String} 金额
	*@params digit {Number} 小数点的位数，不够补0
 *@returns {String} 格式化后的金额	  
**/
function formatMoney(money, digit){
var tpMoney = '0.00';
if(undefined != money){
    tpMoney = money;
}
tpMoney = new Number(tpMoney);
if(isNaN(tpMoney)){
  return '0.00';
}
if(digit==null||digit==''){
	digit=2;
}
tpMoney = tpMoney.toFixed(digit) + '';
var re = /^(-?\d+)(\d{3})(\.?\d*)/;
while(re.test(tpMoney)){
	 tpMoney = tpMoney.replace(re, "$1,$2$3")
	}
		
return tpMoney;
}

//金额格式转换,保留两位小数
function parseMoney(s) { 
var n = 2 //设置保留的小数位数 
s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + ""; 
var l = s.split(".")[0].split("").reverse(); 
var r = s.split(".")[1]; 
var t = ""; 
for (i = 0; i < l.length; i++) { 
t += l[i]; 
} 
return t.split("").reverse().join("") + "." + r; 
} 

/**
 * Ajax 文件下载   ajaxDownload('ExcelDownload.do','find=commoncode','post' );
 * @param url
 * @param data
 * @param method
 */
function ajaxDownload(url, data, method) {
	// 获取url和data
	if (url && data) {
		
		// data 是 string 或者 array/object
		data = typeof data == 'string' ? data : jQuery.param(data);
		
		// 把参数组装成 form的 input
		var inputs = '';
		$.each(data.split('&'), function() {
			var pair = this.split('=');
			inputs += '<input type="hidden" name="' + pair[0] + '" value="'
					+ pair[1] + '" />';
		});
		// request发送请求
		$('<form action="' + url + '" method="' + (method || 'post')
				+ '" >' + inputs + '</form>').appendTo('body').submit().remove();
	}
}

//判断对象是否是数组的方法
var isArray = function(obj) { 
	return Object.prototype.toString.call(obj) === '[object Array]'; 
}

/**
 * 获取用户字典标签
 */
function getUserDictLabel(data, value, defaultValue, inCss){
	var result = [];
	for (var i=0; i<data.length; i++){
		var row = data[i];
//		if (row.value == value){
		if ((','+value+',').indexOf(','+row.dictValue+',') != -1){
			var str = '';
			if (inCss && (row.cssClass || row.cssStyle)){
				str += '<span';
				if (row.cssClass){
					str += ' class="'+row.cssClass+'"';
				}
				if (row.cssStyle){
					str += ' style="'+row.cssStyle+'"';
				}
				result.push(str + '>' + row.label + '</span>');
			}else{
				result.push(row.dictName);
			}
		}
	}
	return result.length > 0 ? result.join(',') : defaultValue;
}

/**
 * 存储当前用户，是否是财务经理，是否是部门经理，全局变量
 */
var isPostInit = false, isCaiwuJingli = false, isBumenJingli = false , isRenshiJingli = false;

/**
 * 获取下一步处理人数据源（请勿删除，工作流中选择下一步处理人使用）
 * 总经理 101     财务经理 104     部门经理 103     出纳 106  人事105
 * 加入离职申请，人事节点 
 *  nodeName == '部门经理审批离职' 为了 与部门经理审批节点 区别
 * @param nodeName 节点名称
 */
function selectUserTreeDataUrl(nodeName){
	// 初始化岗位变量
	if (!isPostInit){
		// 当前用户是否是财务经理
		$.ajax({url:ctx+'/sys/post/containsUserPost?postCode=104',async:false,success:function(data){
			isCaiwuJingli = (data == true);
		}});
		// 当前用户是否是部门经理
		$.ajax({url:ctx+'/sys/post/containsUserPost?postCode=103',async:false,success:function(data){
			isBumenJingli = (data == true);
		}});
		// 当前用户是否是人事
		$.ajax({url:ctx+'/sys/post/containsUserPost?postCode=105',async:false,success:function(data){
			isRenshiJingli = (data == true);
		}});
		isPostInit = true;
	}
	var postCode = '';
	if (nodeName == '填写申请单' || nodeName == '部门经理审批' || nodeName == '财务经理审批' || nodeName == '人事审批' || nodeName == '部门经理审批离职'){
		if(isCaiwuJingli){
			postCode = '101';
		}else if (isBumenJingli){
			postCode = '104';
			if(nodeName.indexOf("离职") > -1){
				postCode = '105';
			}
		}else if (isRenshiJingli){
			postCode = '104';
		}else{
			postCode = '103';
		}
	}else if (nodeName == '总经理审批'){
		postCode = '106';
	}
	return '/sys/user/treeData?postCode='+postCode+'&isAll=true&isShowCode=2';
}