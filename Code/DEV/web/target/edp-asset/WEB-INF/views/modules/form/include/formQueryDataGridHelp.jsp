<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="validate,grid"/>
<sys:header title="查询列表字段配置属性帮助页" extLibs="${extLibs}"/>
<div class="portlet box ${boxStyleColor} autoHeight">
	<style type="text/css">
body{
	font-size: 14px;
	font-family: 'Microsoft Yahei';
	margin: 8px;
}
p{
	text-indent: 30px;
}
</style>
	<body >
		<h2>jqGrid 事件</h2>
		<hr /> 
		<span>使用方法</span>
		<xmp>
var lastSel;  

jQuery("#gridid").jqGrid({  

...  

	onSelectRow: function(id){   

		if(id && id!==lastSel){   

			jQuery('#gridid').restoreRow(lastSel);   

			lastSel=id;   

		}   

		jQuery('#gridid').editRow(id, true);   

	},  

...  

})
		</xmp>
		<span>事件大全</span>
		<table class="table table-bordered">
			<tbody> 
				<tr >
					<td  valign="top">事件</td>
					<td  valign="top">参数</td>
					<td  valign="top">备注</td>
	
				</tr>
				<tr class="">
					<td  valign="top">afterInsertRow</td>
					<td  valign="top">rowidrowdatarowelem</td>
					<td  valign="top"><span>当插入每行时触发。</span><span>rowid</span><span>插入当前行的</span><span>id</span><span>；</span><span>rowdata</span><span>插入行的数据，格式为</span><span>name:
							value</span><span>，</span><span>name</span><span>为</span><span>colModel</span><span>中的名</span><span>字</span>
	
					</td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">beforeRequest</td>
					<td  valign="top">none</td>
					<td  valign="top"><span>向服务器端发起请求之前触发此事件但如果</span><span>datatype</span><span>是一个</span><span>function</span><span>时例</span><span>外</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">beforeSelectRow</td>
					<td  valign="top">rowid, e</td>
					<td  valign="top"><span>当用户点击当前行在未选择此行时触发。</span><span>rowid</span><span>：此行</span><span>id</span><span>；</span><span>e</span><span>：事件对象。返回值为</span><span>ture</span><span>或者</span><span>false</span><span>。如果返回</span><span>true</span><span>则选择完成，如果返回</span><span>false</span><span>则不会选择此行也不会触发其他事</span><span>件</span>
	
					</td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">gridComplete</td>
					<td  valign="top">none</td>
					<td  valign="top"><span>当表格所有数据都加载完成而且其他的处理也都完成时触发此事件，排序，翻页同样也会触发此事</span><span>件</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">loadComplete</td>
					<td  valign="top">xhr</td>
					<td  valign="top"><span>当从服务器返回响应时执行，</span><span>xhr</span><span>：</span><span>XMLHttpRequest&nbsp;</span><span>对</span><span>象</span>
	
					</td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">loadError</td>
					<td  valign="top">xhr,status,error</td>
					<td  valign="top"><span>如果请求服务器失败则调用此方法。</span><span>xhr</span><span>：</span><span>XMLHttpRequest&nbsp;</span><span>对象；</span><span>satus</span><span>：错误类型，字符串类型；</span><span>error</span><span>：</span><span>exception</span><span>对</span><span>象</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">onCellSelect</td>
					<td  valign="top">rowid,iCol,cellcontent,e</td>
					<td  valign="top"><span>当点击单元格时触发。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>iCol</span><span>：当前单元格索引；</span><span>cellContent</span><span>：当前单元格内容；</span><span>e</span><span>：</span><span>event</span><span>对</span><span>象</span>
	
					</td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">ondblClickRow</td>
					<td  valign="top">rowid,iRow,iCol,e</td>
					<td  valign="top"><span>双击行时触发。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>iRow</span><span>：当前行索引位置；</span><span>iCol</span><span>：当前单元格位置索引；</span><span>e:event</span><span>对</span><span>象</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">onHeaderClick</td>
					<td  valign="top">gridstate</td>
					<td  valign="top"><span>当点击显示</span><span>/</span><span>隐藏表格的那个按钮时触发；</span><span>gridstate</span><span>：表格状态，可选值：</span><span>visible
							or hidden</span></td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">onPaging</td>
					<td  valign="top">pgButton</td>
					<td  valign="top"><span>点击翻页按钮填充数据之前触发此事件，同样当输入页码跳转页面时也会触发此事</span><span>件</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">onRightClickRow</td>
					<td  valign="top">rowid,iRow,iCol,e</td>
					<td  valign="top"><span>在行上右击鼠标时触发此事件。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>iRow</span><span>：当前行位置索引；</span><span>iCol</span><span>：当前单元格位置索引；</span><span>e</span><span>：</span><span>event</span><span>对</span><span>象</span>
	
					</td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">onSelectAll</td>
					<td  valign="top">aRowids,status</td>
					<td  valign="top"><span>multiselect</span><span>为</span><span>ture</span><span>，且点击头部的</span><span>checkbox</span><span>时才会触发此事件。</span><span>aRowids</span><span>：所有选中行的</span><span>id</span><span>集合，为一个数组。</span><span>status</span><span>：</span><span>boolean</span><span>变量说明</span><span>checkbox</span><span>的选择状态，</span><span>true</span><span>选中</span><span>false</span><span>不选中。无论</span><span>checkbox</span><span>是否选择，</span><span>aRowids</span><span>始终有</span>&nbsp;<span>值</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">onSelectRow</td>
					<td  valign="top">rowid,status</td>
					<td  valign="top"><span>当选择行时触发此事件。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>status</span><span>：选择状</span><span>态</span><span>，当</span><span>multiselect&nbsp;</span><span>为</span><span>true</span><span>时此参数才可</span><span>用</span>
	
					</td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">onSortCol</td>
					<td  valign="top">index,iCol,sortorder</td>
					<td  valign="top"><span>当点击排序列但是数据还未进行变化时触发此事件。</span><span>index</span><span>：</span><span>name</span><span>在</span><span>colModel</span><span>中位置索引；</span><span>iCol</span><span>：当前单元格位置索引；</span><span>sortorder</span><span>：排序状态：</span><span>desc</span><span>或者</span><span>asc</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">resizeStart</td>
					<td  valign="top">event, index</td>
					<td  valign="top"><span>当开始改变一个列宽度时触发此事件。</span><span>event</span><span>：</span><span>event</span><span>对象；</span><span>index</span><span>：当前列在</span><span>colModel</span><span>中位置索</span><span>引</span>
	
					</td>
	
				</tr>
				<tr class="warning">
					<td  valign="top">resizeStop</td>
					<td  valign="top">newwidth, index</td>
					<td  valign="top"><span>当列宽度改变之后触发此事件。</span><span>newwidth</span><span>：列改变后的宽度；</span><span>index</span><span>：当前列在</span><span>colModel</span><span>中的位置索</span><span>引</span>
	
					</td>
	
				</tr>
				<tr class="">
					<td  valign="top">serializeGridData</td>
					<td  valign="top">postData</td>
					<td  valign="top"><span>向服务器发起请求时会把数据进行序列化，用户自定义数据也可以被提交到服务器</span><span>端</span>
	
					</td>
	
				</tr>
	
			</tbody>
	
		</table>



	

	</body>

</div>
<sys:footer extLibs="${extLibs}"/>
