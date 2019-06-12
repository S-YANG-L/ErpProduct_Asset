/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.codingrule.entity;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 编码规范子表Entity
 * @author zhaohongbin
 * @version 2018-09-10
 */
public class CodeRules extends DataEntity<CodeRules> {
	
	private static final long serialVersionUID = 1L;
	private String rulesItemCode;		// 规则项编码
	private String rulesItemName;		// 规则编码名称
	private String codeFormat;		// 编码格式
	private String codeFormatContent;		// 编码格式内容
	private Long codeLen;		// 编码长度
	private String rulesRemarks;		// 规则备注
	private String codeSort;		// 排序
	private String category1;		// 分类码1
	private String category2;		// 分类码2
	private String lastMax;		// 上次最大值
	private String flowComplement;		// 流水号补齐字符
	private String flowComplementMode;		// 流水号补齐方式
	private String codeId;		// 编码主键
	
	public CodeRules() {
		super();
	}

	public CodeRules(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="规则项编码长度不能超过 64 个字符")
	public String getRulesItemCode() {
		return rulesItemCode;
	}

	public void setRulesItemCode(String rulesItemCode) {
		this.rulesItemCode = rulesItemCode;
	}
	
	@Length(min=0, max=64, message="规则编码名称长度不能超过 64 个字符")
	public String getRulesItemName() {
		return rulesItemName;
	}

	public void setRulesItemName(String rulesItemName) {
		this.rulesItemName = rulesItemName;
	}
	
	@Length(min=0, max=64, message="编码格式长度不能超过 64 个字符")
	public String getCodeFormat() {
		return codeFormat;
	}

	public void setCodeFormat(String codeFormat) {
		this.codeFormat = codeFormat;
	}
	
	@Length(min=0, max=64, message="编码格式内容长度不能超过 64 个字符")
	public String getCodeFormatContent() {
		return codeFormatContent;
	}

	public void setCodeFormatContent(String codeFormatContent) {
		this.codeFormatContent = codeFormatContent;
	}
	
	public Long getCodeLen() {
		return codeLen;
	}

	public void setCodeLen(Long codeLen) {
		this.codeLen = codeLen;
	}
	
	@Length(min=0, max=255, message="规则备注长度不能超过 255 个字符")
	public String getRulesRemarks() {
		return rulesRemarks;
	}

	public void setRulesRemarks(String rulesRemarks) {
		this.rulesRemarks = rulesRemarks;
	}
	
	@Length(min=0, max=64, message="排序长度不能超过 64 个字符")
	public String getCodeSort() {
		return codeSort;
	}

	public void setCodeSort(String codeSort) {
		this.codeSort = codeSort;
	}
	
	@Length(min=0, max=64, message="分类码1长度不能超过 64 个字符")
	public String getCategory1() {
		return category1;
	}

	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	
	@Length(min=0, max=64, message="分类码2长度不能超过 64 个字符")
	public String getCategory2() {
		return category2;
	}

	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	
	@Length(min=0, max=64, message="上次最大值长度不能超过 64 个字符")
	public String getLastMax() {
		return lastMax;
	}

	public void setLastMax(String lastMax) {
		this.lastMax = lastMax;
	}
	
	@Length(min=0, max=1, message="流水号补齐字符长度不能超过 1 个字符")
	public String getFlowComplement() {
		return flowComplement;
	}

	public void setFlowComplement(String flowComplement) {
		this.flowComplement = flowComplement;
	}
	
	@Length(min=0, max=1, message="流水号补齐方式长度不能超过 1 个字符")
	public String getFlowComplementMode() {
		return flowComplementMode;
	}

	public void setFlowComplementMode(String flowComplementMode) {
		this.flowComplementMode = flowComplementMode;
	}
	
	@NotBlank(message="编码主键不能为空")
	@Length(min=0, max=64, message="编码主键长度不能超过 64 个字符")
	public String getCodeId() {
		return codeId;
	}

	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	
}