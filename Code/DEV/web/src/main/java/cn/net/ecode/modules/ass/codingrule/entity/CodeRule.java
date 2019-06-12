/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.codingrule.entity;

import cn.net.ecode.common.persistence.annotation.Id;
import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

import java.util.List;

/**
 * 编码规则Entity
 * @author zhaohongbin
 * @version 2018-09-10
 */
public class CodeRule extends DataEntity<CodeRule> {
	
	private static final long serialVersionUID = 1L;
	private String codeId;		// 编码主键
	private String codeObjectId;		// 编码对象ID
	private String codeObject;		// 编码对象
	private String codeName;		// 编码名称
    private String codeOriginal;		// 修改前编码规则
    private String codeNow;		// 修改后编码规则
	private String codeRemarks;		// 编码备注
	private String maxCode;		// 最大编码
	private String saveLast;		// 保存上一次的流水号
	private String category2;		// 分类码2
    private List<CodeRules> codeRulesList;
	
	public CodeRule() {
		super();
	}

	public CodeRule(String codeId){
		super();
		this.codeId = codeId;
	}

    public List<CodeRules> getCodeRulesList() {
        return codeRulesList;
    }

    public void setCodeRulesList(List<CodeRules> codeRulesList) {
        this.codeRulesList = codeRulesList;
    }

    @Id
	public String getCodeId() {
		return codeId;
	}

	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	
	@Length(min=0, max=64, message="编码对象ID长度不能超过 64 个字符")
	public String getCodeObjectId() {
		return codeObjectId;
	}

	public void setCodeObjectId(String codeObjectId) {
		this.codeObjectId = codeObjectId;
	}
	
	@Length(min=0, max=64, message="编码对象长度不能超过 64 个字符")
	public String getCodeObject() {
		return codeObject;
	}

	public void setCodeObject(String codeObject) {
		this.codeObject = codeObject;
	}
	
	@Length(min=0, max=64, message="编码名称长度不能超过 64 个字符")
	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	
	@Length(min=0, max=252, message="编码备注长度不能超过 252 个字符")
	public String getCodeRemarks() {
		return codeRemarks;
	}

	public void setCodeRemarks(String codeRemarks) {
		this.codeRemarks = codeRemarks;
	}
	
	@Length(min=0, max=64, message="最大编码长度不能超过 64 个字符")
	public String getMaxCode() {
		return maxCode;
	}

	public void setMaxCode(String maxCode) {
		this.maxCode = maxCode;
	}
    @Length(min=0, max=64, message="保存上一次的流水号长度不能超过 64 个字符")
    public String getSaveLast() {
        return saveLast;
    }

    public void setSaveLast(String saveLast) {
        this.saveLast = saveLast;
    }

	@Length(min=0, max=64, message="分类码2长度不能超过 64 个字符")
	public String getCategory2() {
		return category2;
	}

	public void setCategory2(String category2) {
		this.category2 = category2;
	}

    public String getCodeOriginal() {
        return codeOriginal;
    }

    public void setCodeOriginal(String codeOriginal) {
        this.codeOriginal = codeOriginal;
    }

    public String getCodeNow() {
        return codeNow;
    }

    public void setCodeNow(String codeNow) {
        this.codeNow = codeNow;
    }
}