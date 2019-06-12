<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="查询列表字段配置属性帮助页" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-body form">
		<div id="main">
	<div id="mainContent">
	<div class="forFlow">
		
<div id="post_detail">
<!--done-->
<div id="topics">
	<div class = "post">
		<h1 class = "postTitle">
			<a id="cb_post_title_url" class="postTitle2" >jqGrid预定义的格式化类型formatter</a>
		</h1>
		<div class="clear"></div>
		<div class="postBody">
			<div id="cnblogs_post_body" class="blogpost-body"><div>
<blockquote>
<p>所有预定义类型和编辑模式兼容，就是说数字，链接和email等需要转换，才能使他们被正确编辑</p>
</blockquote>
<table class="table table-bordered  "  cellspacing="1" cellpadding="1">
<tbody>
<tr><th>类型</th><th>选项</th><th>描述</th></tr>
<tr>
<td>integer</td>
<td>thousandsSeparator,<br />defaulValue</td>
<td><ol>
<li>thousandsSeparator：指定千位分隔符号</li>
<li>defaultValue ：指定数据为空时默认显示的值</li>

</ol></td>

</tr>
<tr>
<td>number</td>
<td>decimalSeparator,<br />thousandsSeparator,<br />decimalPlaces,<br />defaulValue</td>
<td><ol>
<li>decimalSeparator ：指定小数分隔符</li>
<li>thousandsSeparator：指定千位分隔符号</li>
<li>decimalPlaces：指定需要显示多少个小数位</li>
<li>defaultValue ：指定数据为空时默认显示的值</li>

</ol></td>

</tr>
<tr>
<td>currency</td>
<td>decimalSeparator,<br />thousandsSeparator,<br />decimalPlaces,<br />defaulValue,<br />prefix,<br />suffix</td>
<td>和number一样，知识多了2个选项<ol>
<li>prefix：数字前面显示的文本内容</li>
<li>suffix：数字后显示的文本内容</li>

</ol></td>

</tr>
<tr>
<td>date</td>
<td>srcformat,<br />newformat,<br />parseRe</td>
<td><ol>
<li>srcformat ：源格式，应该被转换成的日期格式【就是将数据源中的原始格式转为这个定义的格式】</li>
<li>newformat： 输出格式，使用PHP的日期格式化参数，也可以使用预定义好的日期格式，查看默认值参考语言选项</a>配置中的date-》masks配置。</li>
<li>parseRe：一个解析日期字符串的表达式</li>

</ol></td>

</tr>
<tr>
<td>email</td>
<td>none</td>
<td>设置email将会给内容添加链接，链接地址为mailto:emai内容</td>

</tr>
<tr>
<td>link</td>
<td>target</td>
<td>&nbsp;target 默认值为null。设置为这个，会构造一个连接，添加target属性，单元格内容作为href属性值</td>

</tr>
<tr>
<td>showlink</td>
<td>baseLinkUrl,<br />showAction,<br />addParam,<br />target,<br />idName</td>
<td><ol>
<li>baseLinkUrl：链接地址</li>
<li>showAction：添加到 baseLinkUrl后的附加值</li>
<li>addParam：添加到idName属性后的附加参数</li>
<li>target：链接在哪个窗口打开，给链接添加target属性</li>
<li>idName：showAction后第一个被添加的参数，默认值为&ldquo;id"</li>

</ol></td>

</tr>
<tr>
<td>checkbox</td>
<td>disabled</td>
<td>disabled默认值为true。控制checkbox是否能被改变。设置为false，可以膝盖checkbox的值。</td>

</tr>
<tr>
<td>select</td>
<td>none</td>
<td>不是真实的select，仅为一个特例，看下面的说明</td>

</tr>
<tr>
<td>actions</td>
<td>{<br />keys: false,<br />editbutton : true,<br />delbutton : true,<br />editformbutton: false,<br />onEdit : null,<br />onSuccess: null,<br />afterSave:null,<br />onError: null,<br />afterRestore: null,<br />extraparam: {oper:'edit'},<br />url: null,<br />delOptions: {},<br />editOptions : {}<br />}</td>
<td>在行编辑模式这个类型的格式化函数很容易给指定的列添加一个按钮。<br />有2中类型的动作，编辑和删除。<br />editformbutton设置为true 将医用表单编辑对话框，取代行编辑模式<br />editOptions仅用于配置表单编辑模式。</td>

</tr>

</tbody>

</table>

</div>
<h3>"Select"格式化函数</h3>
<div>
<p>select类型不是真实的select。这个用于使用某些编辑模式下，设置了edittype:'select'的情况。这个版本之前grid显示select的值，而不是键（Before this release we pass the value of the select in grid and not the key），例如:</p>
<div class="XParse" lang="JavaScript">
<div class="xcode">jQuery(<span class="str">"#grid_id").jqGrid({<br />...<br />&nbsp;&nbsp;&nbsp;colModel&nbsp;:&nbsp;[&nbsp;{name:<span class="str">'myname',&nbsp;edittype:<span class="str">'select',&nbsp;editoptions:{value:<span class="str">"1:One;2:Two"}}&nbsp;...&nbsp;],<br />...<br />});</span></span></span></span></div>

</div>
<pre>这个情况下，grid的数据需要包含"One"或者"Two"，设在myname这个列里面。配置formatter为select的代码如下</pre>
<div class="XParse" lang="JavaScript">
<div class="xcode">jQuery(<span class="str">"#grid_id").jqGrid({<br />...<br />&nbsp;&nbsp;&nbsp;colModel&nbsp;:&nbsp;[&nbsp;{name:<span class="str">'myname',&nbsp;edittype:<span class="str">'select',&nbsp;formatter:<span class="str">'select',&nbsp;editoptions:{value:<span class="str">"1:One;2:Two"}}&nbsp;...&nbsp;]<br />...<br />});</span></span></span></span></span></div>

</div>
<p>数据包含键名称(&ldquo;1&rdquo; or &ldquo;2&rdquo;)，但是值 (&ldquo;One&rdquo;, or &ldquo;Two&rdquo;) 将会显示在grid里面。</p>

</div>
<h3>showlink 示例</h3>
<p>看下面的代码</p>
<div class="XParse" lang="JavaScript">
<div class="xcode">jQuery(<span class="str">"#grid_id").jqGrid({<br />...<br />&nbsp;&nbsp;&nbsp;colModel:&nbsp;[&nbsp;{name:<span class="str">'myname',&nbsp;formatter:<span class="str">'showlink',&nbsp;formatoptions:{baseLinkUrl:<span class="str">'someurl.php',&nbsp;addParam:&nbsp;<span class="str">'&amp;action=edit'},&nbsp;...}&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;...&nbsp;<br />&nbsp;&nbsp;&nbsp;]<br />...<br />});</span></span></span></span></span></div>

</div>
<p>上面将会得到下面的输出</p>
<blockquote>
<pre>http://localhost/someurl.php?id=123&amp;action=edit</pre>
</blockquote>
<p>如果你想将生成的url中id键名称修改为myid，可以这样设置</p>
<div class="XParse" lang="JavaScript">
<div class="xcode">jQuery(<span class="str">"#grid_id").jqGrid({<br />...<br />&nbsp;&nbsp;&nbsp;colModel:&nbsp;[&nbsp;{name:<span class="str">'myname',&nbsp;formatter:<span class="str">'showlink',&nbsp;formatoptions:{baseLinkUrl:<span class="str">'someurl.php',&nbsp;addParam:&nbsp;<span class="str">'&amp;action=edit',&nbsp;idName:<span class="str">'myid'},&nbsp;...}&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;...&nbsp;<br />&nbsp;&nbsp;&nbsp;]<br />...<br />});</span></span></span></span></span></span></div>

</div>
<pre></pre>
<p>上面将会得到下面的输出</p>
<blockquote>
<pre>http://localhost/someurl.php?myid=123&amp;action=edit</pre>
</blockquote></div><div id="MySignature"></div>
<div class="clear"></div>
<div id="blog_post_info_block">
<div id="BlogPostCategory"></div>
<div id="EntryTag"></div>
<div id="blog_post_info">
</div>
<div class="clear"></div>
<div id="post_next_prev"></div>
</div>
	
	</div>
</div>
<sys:footer extLibs="${extLibs}"/>
