<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- 默认设置[默认值、默认css样式、默认style、id、name] -->
<%@ include file="/WEB-INF/views/modules/form/include/formDesignerDefault.jsp"%>
<c:forEach items="${childList}" var="child">
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
			<!-- <select id="table-style" class="noselect2" >
				<option value="">默认</option>
				<option value="table-striped">条纹</option>
				<option value="table-bordered">边框</option>
				<option value="table-condensed">紧凑</option>
			</select> -->
		</span>
	    <%-- <span class="btn-group btn-group-xs layout1">
			<select class="noselect2 layouttype" title="布局方式">
			     <option value="">布局方式</option>
			<c:forEach items="${fns:getDictList('form_grid_layout')}" var="layout">
				  <c:if test="${layout.value ne 'basicInfo'}">
				 <option value="${layout.value}" <c:if test="${dict.value eq layout.value }"> selected="selected"</c:if>>${layout.label}</option>
			     </c:if>
		    </c:forEach>
		</select> --%>
		</span>
  </span>
  <div class="preview">${child.subTableComment}
  <input type="hidden" name="subTableComment" value="${child.subTableComment}" />
  <input type="hidden" name="subTableName" value="${child.subTableName}" />
  <input type="hidden" name="entitySubId" value="${child.entitySubId}" />
  <input type="hidden" name="subTableFk" value="${child.subTableFk}" />
  </div>
  <div class="view">
	<div class="row clearfix">
		<div class="col-md-12 column ui-sortable">
			<div class="box box-element ui-draggable">
              <div class="preview">表格
              <input type="hidden" name="subTableComment" value="${child.subTableComment}" />
              <input type="hidden" name="subTableName" value="${child.subTableName}" />
              </div>
              <div class="view" style="overflow: auto;">
              	<script type="text/template" class="childTable"></script>
                <table class="table notConfig" style="margin-top: 5px;margin-bottom: 0px;">
                  <thead>
	                  <tr>
	                    <th align="center">列1</th>
	                    <th align="center">列2</th>
	                    <th align="center">列3</th>
	                    <th align="center">列N</th>
	                    <th align="center">操作</th>
	                  </tr>
                  </thead>
                  <tbody>
	                  <tr>
	                    <td>数据1</td>
	                    <td>数据1</td>
	                    <td>数据3</td>
	                    <td>数据4</td>
	                    <td>删除</td>
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
</c:forEach>