<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 行布局模板 -->
<script type="text/x-handlebars-template" id="rowLayoutTemplate">
<div class="lyrow ui-draggable">	
	<a href="#close" class="remove remove-h label label-danger">
		<i class="glyphicon-remove glyphicon"></i>
		删除
  	</a>
	<span class="drag label label-default">
		<i class="glyphicon glyphicon-move"></i>
		拖动
	</span>
	<span class="configuration"> 
    <span class="btn-group btn-group-xs layout1">
		<select class="noselect2 layouttype" title="布局方式">
		     <option value="">布局方式</option>
		<c:forEach items="${fns:getDictList('form_grid_layout')}" var="layout">
			  <c:if test="${layout.value ne 'basicInfo'}">
			 <option value="${layout.value}" <c:if test="${dict.value eq layout.value }"> selected="selected"</c:if>>${layout.label}</option>
		     </c:if>
	    </c:forEach>
	</select>
	</span>
  </span>
  <div class="preview">
	<input value="{{layoutType}}" class="form-control" type="text"></div>
  <div class="view">
	<div class="row clearfix">
	  {{cellHtml}}
	</div>
  </div>
	</div>
</div>
</script>
<!-- 列布局模板 -->
<script type="text/x-handlebars-template" id="cellLayoutTemplate">
<div class="box box-element ui-draggable" style="display: block;">
          <a href="#close" class="remove label label-danger">
            <i class="glyphicon glyphicon-remove"></i>
            	删除
          </a>
		<span class="drag label label-default">
			<i class="glyphicon glyphicon-move"></i>
			拖动
		</span>
       <span class="configuration">
		   {{#if_file_biz item.showType}}
			<span class="btn-group btn-group-xs layout3">
				{{#if item.optionMap.bizCategory}}
					<input type="text" class="fileUploadId" value="{{item.optionMap.bizCategory}}" style="width:130px;" />
				{{else}}
					<input type="text" class="fileUploadId" value="{{tableName}}_{{columnId}}" style="width:130px;" />
				{{/if}}
			</span>
		   {{/if_file_biz}}
       	   <span class="btn-group btn-group-xs layout4">
				<select class="noselect2 otherConfig" title="其它配置">
					<option value="">其它配置</option>
					<c:forEach items="${fns:getDictList('form_other_config')}" var="dict">
						<option value="${dict.value}">${dict.label}</option>
					</c:forEach>
				</select>
		   </span>  	   
	       <span class="btn-group btn-group-xs layout2">
				<select class="noselect2 layouttype" title="布局方式">
					<option value="">布局方式</option>
					<option value="4 8" {{{selected4_8}}}>4 8</option>
					<option value="2 10" {{{selected2_10}}}>2 10</option>
				</select>
			</span>
			<span class="btn-group btn-group-xs configField">
				<button id="btnConfigField" type="button" class="configField" title="业务实体字段配置">字段配置</button>
			</span>
          </span>
   <div class="preview" title="">{{columnComment}}</div>
   		<div class="view">
	<div class="form-group {{#if_hide_text item.showType}}hideDomain{{/if_hide_text}}">
	<label contenteditable="true" class="control-label {{leftClass}}" contenteditable="true" title="{{columnComment}}">
		{{!判断是否为必填，如果为必填，则显示*号 }}
		{{#if_required item.validType}}<span class="required">* </span>{{/if_required}}
		{{#if_required_virtual item.validType}}<span class="required">* </span>{{/if_required_virtual}}
		{{columnComment}}：<i class="fa icon-question hide"></i></label>
	<div class="{{rightClass}}">
		{{#if_dh_text item.showType}}
			<input type="text" id="{{columnId}}" name="{{columnName}}" value="" columnType="{{item.showType}}" class="form-control field permiConfig singleText {{validates}} {{item.cssClass}}" {{{attrHtml}}} />
		{{/if_dh_text}}
		{{#if_hide_text item.showType}}
			<input type="text" id="{{columnId}}" name="{{columnName}}" value="" columnType="{{item.showType}}" class="form-control field permiConfig hideDomain {{validates}} {{item.cssClass}}" {{{attrHtml}}} />
		{{/if_hide_text}}
		{{#if_dh_textarea item.showType}}
			<textarea id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="form-control field permiConfig textarea {{validates}} {{item.cssClass}}" {{{attrHtml}}} ></textarea>
		{{/if_dh_textarea}}
		{{#if_select_text item.showType}}
			<select id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="form-control field permiConfig noselect2 {{validates}} {{item.cssClass}}" {{{attrHtml}}} >
				<option></option>
			</select>
		{{/if_select_text}}
		{{#if_checkbox_btn item.showType}}
			<span id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="permiConfig field cbox radioChkBtn checkboxDictItems {{validates}} {{item.cssClass}}" {{{attrHtml}}} >
				<input type="checkbox" id="{{columnId}}" name="{{columnName}}" class="cbox radioChkBtn"/>是
				<input type="checkbox" id="{{columnId}}" name="{{columnName}}" class="cbox radioChkBtn"/>否
			</span>
		{{/if_checkbox_btn}}
		{{#if_radio_btn item.showType}}
			<span id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="permiConfig field star radioChkBtn radioDictItems {{validates}} {{item.cssClass}}" {{{attrHtml}}} >
				<input type="radio" id="{{columnId}}" name="{{columnName}}" class="star radioChkBtn"/>是
				<input type="radio" id="{{columnId}}" name="{{columnName}}" class="star radioChkBtn"/>否
			</span>
		{{/if_radio_btn}}
		{{#if_date_text item.showType}}
			<input type="text" id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="form-control field permiConfig Wdate {{validates}} {{item.cssClass}}" readonly="readonly" onclick="WdatePicker({dateFmt:'{{item.optionMap.date}}',isShowClear:false});" value="{{currDate}}" {{{attrHtml}}} />
		{{/if_date_text}}
		{{#if_module_text item.showType}}
			<input type="text" id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" readonly="readonly" class="form-control field permiConfig selectModule {{validates}} {{item.cssClass}}" {{{attrHtml}}}/>
		{{/if_module_text}}
		{{#if_file_upload item.showType}}
			<input type="file" id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="fileUpload permiConfig field upload {{validates}} {{item.cssClass}}" {{{attrHtml}}} />
		{{/if_file_upload}}
		{{#if_label_show item.showType}}
			<label id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="labelShow {{item.cssClass}}" {{{attrHtml}}}>标签名称</label>
		{{/if_label_show}}
		{{#if_showtype_empty item.showType}}
			<font color="red">还没有进行业务实体配置</font>
		{{/if_showtype_empty}}
	</div>
</div>
</div>
</div>
</script>
<!-- 头部标题模板 -->
<script type="text/x-handlebars-template" id="sectionLayoutTemplate">
<div class="lyrow ui-draggable">	
	<a href="#close" class="remove remove-h label label-danger">
		<i class="glyphicon-remove glyphicon"></i>
		删除
  	</a>
	<span class="drag label label-default">
		<i class="glyphicon glyphicon-move"></i>
		拖动
	</span>
	<span class="configuration"> 
    <span class="btn-group btn-group-xs layout1">
		<select class="noselect2 layouttype" title="布局方式">
		     <option value="">布局方式</option>
		<c:forEach items="${fns:getDictList('form_grid_layout')}" var="layout">
			  <c:if test="${layout.value ne 'basicInfo'}">
			 <option value="${layout.value}" <c:if test="${dict.value eq layout.value }"> selected="selected"</c:if>>${layout.label}</option>
		     </c:if>
	    </c:forEach>
	</select>
	</span>
  </span>
  <div class="preview">{{sectionName}}
  </div>
  <div class="view">
	<div class="row clearfix">
	  	<div class="col-md-12 column div_basicInfo">
			<h4 class="form-section" contenteditable="true">{{sectionName}}</h4>
		</div>
	</div>
  </div>
	</div>
</div>
</script>
<!-- 子表布局模板 -->
<script type="text/x-handlebars-template" id="childLayoutTemplate">
<div class="lyrow ui-draggable">	
	<a href="#close" class="remove remove-h label label-danger">
		<i class="glyphicon-remove glyphicon"></i>
		删除
  	</a>
	<span class="drag label label-default">
		<i class="glyphicon glyphicon-move"></i>
		拖动
	</span>
	<span class="configuration"> 
	    <span class="btn-group btn-group-xs child-table-span">
			<input type="button" class="child-table-config" value="子表配置" />
		</span>
		<span class="btn-group btn-group-xs layout3">
			
		</span>
	</span>
  </span>
  <div class="preview">{{subTableComment}}
  <input type="hidden" name="subTableComment" value="{{subTableComment}}" />
  <input type="hidden" name="subTableName" value="{{subTableName}}" />
  <input type="hidden" name="entitySubId" value="{{entitySubId}}" />
  <input type="hidden" name="subTableFk" value="{{subTableFk}}" />
  </div>
  <div class="view">
	<div class="row clearfix">
		<div class="col-md-12 column ui-sortable">
			<div class="box box-element ui-draggable">
              <div class="preview">表格
              <input type="hidden" name="subTableComment" value="{{subTableComment}}" />
              <input type="hidden" name="subTableName" value="{{subTableName}}" />
              </div>
              <div class="view" style="overflow: auto;">
              	<script type="text/template" class="childTable">{{childTableJson}}</{{scrEndVal}}>
                <table class="table haveConfig" style="margin-top: 5px;margin-bottom: 0px;">
                  <thead>
	                  <tr>
						{{#each childTitleList}}
							<th>{{this}}</th>
						{{/each}}
	                  </tr>
                  </thead>
                  <tbody>
	                  <tr>
						{{#each childDataList}}
							<td>{{this}}</td>
						{{/each}}
	                  </tr>
                  </tbody>
                </table>
              </div>
            </div>
		</div>
	</div>
  </div>
	</div>
</div>
</script>
<!-- 控件模板 -->
<script type="text/x-handlebars-template" id="controlTemplate">
{{#if_dh_text item.showType}}
	<input type="text" id="{{columnId}}" name="{{columnName}}" value="" columnType="{{item.showType}}" class="form-control field permiConfig singleText {{validates}} {{item.cssClass}}" {{{attrHtml}}} />
{{/if_dh_text}}
{{#if_hide_text item.showType}}
	<input type="text" id="{{columnId}}" name="{{columnName}}" value="" columnType="{{item.showType}}" class="form-control field permiConfig hideDomain {{validates}} {{item.cssClass}}" {{{attrHtml}}} />
{{/if_hide_text}}
{{#if_dh_textarea item.showType}}
	<textarea id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="form-control field permiConfig textarea {{validates}} {{item.cssClass}}" {{{attrHtml}}} ></textarea>
{{/if_dh_textarea}}
{{#if_select_text item.showType}}
	<select id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="form-control permiConfig noselect2 {{validates}} {{item.cssClass}}" {{{attrHtml}}} >
		<option></option>
	</select>
{{/if_select_text}}
{{#if_checkbox_btn item.showType}}
	<span id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="permiConfig field cbox radioChkBtn checkboxDictItems {{validates}} {{item.cssClass}}" {{{attrHtml}}} >
		<input type="checkbox" id="{{columnId}}" name="{{columnName}}" class="cbox radioChkBtn"/>是
		<input type="checkbox" id="{{columnId}}" name="{{columnName}}" class="cbox radioChkBtn"/>否
	</span>
{{/if_checkbox_btn}}
{{#if_radio_btn item.showType}}
	<span id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="permiConfig field star radioChkBtn radioDictItems {{validates}} {{item.cssClass}}" {{{attrHtml}}} >
		<input type="radio" id="{{columnId}}" name="{{columnName}}" class="star radioChkBtn"/>是
		<input type="radio" id="{{columnId}}" name="{{columnName}}" class="star radioChkBtn"/>否
	</span>
{{/if_radio_btn}}
{{#if_date_text item.showType}}
	<input type="text" id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="form-control field permiConfig Wdate {{validates}} {{item.cssClass}}" readonly="readonly" onclick="WdatePicker({dateFmt:'{{item.optionMap.date}}',isShowClear:false});" value="{{currDate}}" {{{attrHtml}}} />
{{/if_date_text}}
{{#if_module_text item.showType}}
	<input type="text" id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" readonly="readonly" class="form-control field permiConfig selectModule {{validates}} {{item.cssClass}}" {{{attrHtml}}}/>
{{/if_module_text}}
{{#if_file_upload item.showType}}
	<input type="file" id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="fileUpload permiConfig field upload {{validates}} {{item.cssClass}}" {{{attrHtml}}} />
{{/if_file_upload}}
{{#if_label_show item.showType}}
	<label id="{{columnId}}" name="{{columnName}}" columnType="{{item.showType}}" class="labelShow {{item.cssClass}}" {{{attrHtml}}}>标签名称</label>
{{/if_label_show}}
{{#if_showtype_empty item.showType}}
	<font color="red">还没有进行业务实体配置</font>
{{/if_showtype_empty}}
</script>