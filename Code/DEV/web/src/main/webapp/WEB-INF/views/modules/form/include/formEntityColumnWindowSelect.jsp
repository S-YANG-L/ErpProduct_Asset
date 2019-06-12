<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="panel panel-default" id="selectorID">
    <div class="panel-heading">
        <h3 class="panel-title">弹窗选择器</h3>
    </div>
    <div class="panel-body">
    	<div class="row">
    		<div class="col-xs-6">
	        	<div class="form-group">
	        		<label class="control-label col-sm-4" title="弹窗选择器的显示方式：
树形结构：弹出树结构选择窗口；
列表：弹出列表选择窗口；">
	        		显示方式：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<c:set var="xsfsF" value="1"></c:set>
						<c:forEach items="${formEntityColumn.optionMap}" var="map">
							<c:if test="${map.key=='selector'}">
								<c:set var="xsfsF" value="${map.value}"></c:set>
							</c:if>
						</c:forEach>
						<c:forEach items="${fns:getDictList('form_windowSel_sxfs')}" var="rdict">
							<input type="radio" name="optionMap['selector']" value="${rdict.value }" <c:if test="${rdict.value==xsfsF}">checked="checked"</c:if> onchange="radioChange(this.value);" class="form-control" >${rdict.name }
						</c:forEach>
					</div>
	        	</div>
	        </div>
    	</div>
        <div class="row">
			<div class="col-xs-6">
	        	<div class="form-group">
	        	<label class="control-label col-sm-4" title="弹窗显示的数据：
用户组件：显示用户数据；
部门组件：显示部门数据；
公司：显示公司数据；
区域：显示区域数据；
自定义：自定义链接，指定一个已经存在的链接；
数据源：数据源sql，输入sql语句或者选择已有sql脚本；
表单自定义数据源：指定一个表单中配置的列表，需指定返回code、返回name；">
	        		<span class="required">*</span> 数据类型：<i class="fa icon-question"></i></label>
					<div class="col-sm-8">
					
                    <c:set var="flag" value=""></c:set>
					<c:forEach items="${formEntityColumn.optionMap}" var="map">
						<c:if test="${map.key=='selectorType'}">
							<c:set var="flag" value="${map.value}"></c:set>
						</c:if>
					</c:forEach>
					
					<select name="optionMap['selectorType']" class="form-control required" id="optionMapSelector" onchange="setInfoTof(this);">
						<option value="">请选择</option>
						<c:forEach items="${fns:getDictList('form_window_select_type')}" var="dict">
							<option value="${dict.value}" title="${dict.name}" dir="${dict.description }" lang="${dict.cssStyle }">${dict.name}</option>
						</c:forEach>
					</select>
					
					<script>
						var obj="${flag}";
                       	if(obj !=null && "" != obj){
				            $("#optionMapSelector option").each(function() {
				                if ($(this).val() == obj) {  
				                    $(this).attr("selected", "selected");
				                }  
				            });
                       	}
					</script>
				</div>
        	</div>
        </div>
        <div class="col-xs-6">
			<div class="form-group">
				<div class="col-sm-12">
					<c:choose>
						<c:when test="${empty (formEntityColumn.showOptions)}">
							<input type="checkbox"  value="0" name="optionMap['selectorMultipleChoice']"/>是否多选
						</c:when>
						<c:otherwise>
							<!-- 设置标记位 -->
							<c:set var="flag" value="0"></c:set>
							
							<c:forEach items="${formEntityColumn.optionMap}" var="map">
								<c:if test="${map.key=='selectorMultipleChoice'}">
									<input type="checkbox" id="smcheckbox" onchange="setCheckd('smcheckbox');" name="optionMap['selectorMultipleChoice']" value="0" <c:if test="${map.value=='0'}"> checked="checked" </c:if> />是否多选
									<c:set var="flag" value="1"></c:set>
									<input type="checkbox" id="nosmcheckbox" name="optionMap['selectorMultipleChoice']" value="" class="hide"/>
								</c:if>
							</c:forEach>
							
							<c:if test="${flag==0}">
								<input type="checkbox"  value="0" name="optionMap['selectorMultipleChoice']" />是否多选
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${empty (formEntityColumn.showOptions)}">
							<input type="checkbox"  value="true" name="optionMap['selectorMultipleChoice']"/>是否显示全部数据
						</c:when>
						<c:otherwise>
							<!-- 设置标记位 -->
							<c:set var="flag" value="0"></c:set>
							
							<c:forEach items="${formEntityColumn.optionMap}" var="map">
								<c:if test="${map.key=='isAll'}">
									<input type="checkbox" id="isAllCheckbox" onchange="setCheckd('isAllCheckbox');" name="optionMap['isAll']" value="true" <c:if test="${map.value=='true'}"> checked="checked" </c:if> />是否显示全部数据
									<c:set var="flag" value="1"></c:set>
									<input type="checkbox" id="nosisAllCheckbox" name="optionMap['isAll']" value="" class="hide"/>
								</c:if>
							</c:forEach>
							
							<c:if test="${flag==0}">
								<input type="checkbox"  value="true" name="optionMap['isAll']" />是否显示全部数据
							</c:if>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
       </div>
       <div class="row hide" id="formQueryKeyDiv">
       		<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title=""> <span class="required">*</span> 选择列表key：<i
						class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						<select id="formQueryKey" name="optionMap['formQueryKey']" class="form-control" onchange="setHrefVal(this.value,'0');">
							<option value="" label=""></option>
						</select>
					</div>
				</div>
			</div>
       </div>
       <div class="row hide" id="returnAttrDiv">
       		<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title=""> <span class="required">*</span> 返回结果code属性名：<i
						class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						<select id="returnCodeAttr" name="optionMap['returnCodeAttr']" class="form-control">
							<option value="" label=""></option>
						</select>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title=""> <span class="required">*</span>返回结果name属性名：<i
						class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						<select id="returnNameAttr" name="optionMap['returnNameAttr']" class="form-control">
							<option value="" label=""></option>
						</select>
					</div>
				</div>
			</div>
       </div>
	   <div class="row">
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title=""> <span class="required">*</span> 标题：<i
						class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						<c:choose>
							<c:when test="${empty (formEntityColumn.showOptions)}">
								<input name="optionMap['selectorTitle']" class="form-control required" />
							</c:when>
							<c:otherwise>
								<!-- 设置标记位 -->
								<c:set var="flag" value="0"></c:set>
								<c:forEach items="${formEntityColumn.optionMap}" var="map">
									<c:if test="${map.key=='selectorTitle'}">
										<input name="optionMap['selectorTitle']" id="w0bt" class="form-control required" value="${map.value}" />
										<c:set var="flag" value="1"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${flag==0}">
									<input name="optionMap['selectorTitle']" id="w0bt" class="form-control required" />
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title=""> <span class="required">*</span> 链接：<i
						class="fa icon-question hide"></i></label>
					<div class="col-sm-8 input-group">
						<c:choose>
							<c:when test="${empty (formEntityColumn.showOptions)}">
								<input name="optionMap['selectorUrl']" class="form-control required" />
							</c:when>
							<c:otherwise>
								<!-- 设置标记位 -->
								<c:set var="flag" value="0"></c:set>
								<c:forEach items="${formEntityColumn.optionMap}" var="map">
									<c:if test="${map.key=='selectorUrl'}">
										<input name="optionMap['selectorUrl']" id="w0lj" class="form-control required" value="${map.value}" />
										<c:set var="flag" value="1"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${flag==0}">
									<input name="optionMap['selectorUrl']" id="w0lj" class="form-control required" />
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div id="extendDiv">
	   </div>
		   	<div class="row hide" id="dataSourceDiv">
		   		<div class="col-xs-12">
					<div class="form-group">
						<label class="control-label col-sm-2" title=""> 数据源sql：<i
							class="fa icon-question hide"></i></label>
						<div class="col-sm-10">
							<textarea id="dataSourceSql" name="optionMap['dataSourceSql']" class="form-control" style="width: 102.5%;" rows="2" placeholder="sql字段顺序按照如下顺序编写：id、pId、pIds、name" >${formEntityColumn.optionMap.dataSourceSql}</textarea>
							<div>
								<a href="javascript:void(0);" onclick="openSelectScriptDef('dataSourceSql')">选择脚本</a>&nbsp;
								<a href="javascript:void(0);" title="进入脚本管理" onclick="openScriptPage()">脚本管理</a>
							</div>
						</div>
					</div>
				</div>
		   	</div>
		  <%-- <div class="row">
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title=""> 关联label名称：<i
						class="fa icon-question hide"></i></label>
					<div class="col-sm-8">
						<c:choose>
							<c:when test="${empty (formEntityColumn.showOptions)}">
								<input name="optionMap['relationLbName']" class="form-control" />
							</c:when>
							<c:otherwise>
								<!-- 设置标记位 -->
								<c:set var="flag" value="0"></c:set>
								<c:forEach items="${formEntityColumn.optionMap}" var="map">
									<c:if test="${map.key=='relationLbName'}">
										<input name="optionMap['relationLbName']" class="form-control" value="${map.value}" />
										<c:set var="flag" value="1"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${flag==0}">
									<input name="optionMap['relationLbName']" class="form-control" />
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div> --%>
		<div class="row">
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title="选择关联的表"> 
					<span class="required hide" id="joinTableSpan">*</span> 标签关联表：<i
						class="fa icon-question"></i></label>
					<div class="col-sm-8">
						<select id="joinTableName" name="optionMap['joinTableName']" class="form-control">
							<option value=""></option>
							<c:forEach items="${subList}" var="tab">
								<option value="${tab.tableName}" tbByName="${tab.tableByName}" <c:if test="${formEntityColumn.optionMap.joinTableName eq tab.tableName}"> selected="selected"</c:if>>${tab.tableName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="form-group">
					<label class="control-label col-sm-4" title="选择关联的字段">
					<span class="required hide" id="joinColumnNameSpan">*</span> 标签关联字段：<i
						class="fa icon-question"></i></label>
					<div class="col-sm-8 input-group">
						<select id="joinColumnName" name="optionMap['relationLbName']" class="form-control">
							<option value=""></option>
						</select>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var xsfs=1;
	function radioChange(v){
		xsfs=v;
		setInfoTof(v);
		getFormQueryList();
		if(v=='1'){
			$.get("${ctx}/form/formEntityColumn/initSecPage?pageId=WindowSelectSec&id="+id+"&tableName="+tableName,function(data){
	           	$("#extendDiv").html(data);
		 	});
		}else{
			$("#extendDiv").empty();
		}
	}
	
	//弹出选择框时设置标题和链接
	function setInfoTof(val){
		var data_type = $("#optionMapSelector").val();
		if(data_type=="7"){
			$("#dataSourceDiv").removeClass('hide');
			$("#dataSourceSql").addClass('required');
			$("#w0lj").attr("readOnly","true");
			$("#returnAttrDiv").addClass('hide');
			$("#formQueryKeyDiv").addClass('hide');
			$("#formQueryKey").removeClass('required');
			$("#returnCodeAttr").removeClass('required');
			$("#returnNameAttr").removeClass('required');
		}
		else if(data_type=="8"){
			getFormQueryList();
			$("#returnAttrDiv").removeClass('hide');
			$("#formQueryKeyDiv").removeClass('hide');
			$("#formQueryKey").addClass('required');
			$("#returnCodeAttr").addClass('required');
			$("#returnNameAttr").addClass('required');
			$("#w0lj").attr("readOnly","true");
		}
		else{
			$("#dataSourceSql").val('');
			$("#dataSourceDiv").addClass('hide');
			$("#dataSourceSql").removeClass('required');
			$("#w0lj").removeAttr("readOnly");
			$("#returnAttrDiv").addClass('hide');
			$("#formQueryKeyDiv").addClass('hide');
			$("#formQueryKey").removeClass('required');
			$("#returnCodeAttr").removeClass('required');
			$("#returnNameAttr").removeClass('required');
		}
		$("#w0bt").val($("#optionMapSelector").find("option:selected").attr("title"));
		if(xsfs=='1'){
			$("#w0lj").val($("#optionMapSelector").find("option:selected").attr("dir"));
		}else{
			$("#w0lj").val($("#optionMapSelector").find("option:selected").attr("lang"));
		}
	}
	
	var obj = "${xsfsF}";
	if (obj != null && "" != obj) {
		radioChange(obj);
	}
	// 表名change事件
	$("#joinTableName").change(function(){
		changeTableName();
	});
	changeTableName();
	
	function changeTableName(){
		var tbName = $("#joinTableName").val();
		var tbByName = $("#joinTableName").find("option:selected").attr("tbByName");
		var entityId = '${formEntityColumn.entityId}';
		if(entityId != '' && tbName != ''){
			var selectColumnName = '${formEntityColumn.optionMap.relationLbName}';
			$.post('${ctx}/form/formEntityColumn/findTableColumnList',{'formEntity.entityId':entityId,'formTableColumn.tableName':tbName,'tableByName':tbByName},function(data){
				$("#joinColumnName").empty();
				$("#joinColumnName").append('<option value=""></option>');
				$.each(data,function(k,item){
					if(selectColumnName==item.columnName){
						$("#joinColumnName").append('<option value="'+item.columnName+'" selected="selected">'+item.columnComment+'('+item.columnName+')</option>');
					}else{
						$("#joinColumnName").append('<option value="'+item.columnName+'">'+item.columnComment+'('+item.columnName+')</option>');
					}
				})
				$("#joinColumnName").select2();
			},'json');
		}
	}
	
	var formQueryKey = '${formEntityColumn.optionMap.formQueryKey}';
	//获取选择列表信息
	function getFormQueryList(){
		var type;
		if(xsfs=='1'){
			type="2";
		}else{type="3";}
		$.post('${ctx}/form/formQuery/getFormQueryList',{'queryGenerationType':type},function(data){
			$("#formQueryKey").empty();
			$("#formQueryKey").append('<option value=""></option>');
			$.each(data,function(k,item){
				if(formQueryKey==item.queryId){
					$("#formQueryKey").append('<option value="'+item.queryId+'" selected="selected" label="'+item.queryKey+'">'+item.queryName+'</option>');
				}else{
					$("#formQueryKey").append('<option value="'+item.queryId+'" label="'+item.queryKey+'">'+item.queryName+'</option>');
				}
			})
			$("#formQueryKey").select2();
		},'json');
	}
	
	setHrefVal(formQueryKey,'1');
	//根据选择获取字段信息供列表返回
	function setHrefVal(queryId,type){
		if(type=='0'){
			var href=$("#optionMapSelector").find("option:selected").attr("dir");
			var queryKey=$("#formQueryKey").find("option:selected").attr("label");
			$("#w0bt").val($("#formQueryKey").find("option:selected").text());
			$("#w0lj").val(href+queryKey);
		}else{
			var selectorUrl = '${formEntityColumn.optionMap.selectorUrl}';
			$("#w0lj").val(selectorUrl);
		}
		var returnCodeAttr = '${formEntityColumn.optionMap.returnCodeAttr}';
		var returnNameAttr = '${formEntityColumn.optionMap.returnNameAttr}';
		$.post('${ctx}/form/formQueryColumn/getQueryColumnList',{'queryId':queryId},function(data){
			$("#returnCodeAttr").empty();
			$("#returnCodeAttr").append('<option value=""></option>');
			$("#returnNameAttr").empty();
			$("#returnNameAttr").append('<option value=""></option>');
			$.each(data,function(k,item){
				if(returnCodeAttr==item.columnName){
					$("#returnCodeAttr").append('<option value="'+item.columnName+'" selected="selected">'+item.columnComment+'('+item.columnName+')</option>');
				}else{
					$("#returnCodeAttr").append('<option value="'+item.columnName+'">'+item.columnComment+'('+item.columnName+')</option>');
				}
				if(returnNameAttr==item.columnName){
					$("#returnNameAttr").append('<option value="'+item.columnName+'" selected="selected">'+item.columnComment+'('+item.columnName+')</option>');
				}else{
					$("#returnNameAttr").append('<option value="'+item.columnName+'">'+item.columnComment+'('+item.columnName+')</option>');
				}
			})
			$("#returnCodeAttr").select2();
			$("#returnNameAttr").select2();
		},'json'); 
	}
</script>
<script type="text/javascript">
    if (window.Select2 !== undefined){
		$("#centerPage select:not(.noselect2)").select2().on('change', function(){
			try{$(this).valid();}catch(e){}//未定义抛异常
		});
	}
	if (jQuery().uniform) {
		$("#centerPage input[type=checkbox], #centerPage input[type=radio]").uniform();
    }
</script>
