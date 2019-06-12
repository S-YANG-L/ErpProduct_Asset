/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.entity;

import cn.net.ecode.common.persistence.TreeEntity;
import cn.net.ecode.common.persistence.annotation.Id;
import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;

/**
 * 产品分类Entity
 * @Package: cn.net.ecode.scm.basic.entity 
 * @ClassName: InvSort
 * @author: 车磊岩
 * @date: 2016年5月23日 上午11:53:00 
 * @Version: V1.0
 */
public class InvSort extends TreeEntity<InvSort> {

	private static final long serialVersionUID = 1L;
	private String sortCode; // 产品分类编码
	private String sortName; // 产品分类名称
	private String fullname; // 上级编码
	private Integer sortGrade; // 级次
	private String corpCode; // 集团号
	private String corpName; // 集团名称

	public String getCorpCode() {
		return corpCode;
	}

	public void setCorpCode(String corpCode) {
		this.corpCode = corpCode;
	}

	public String getCorpName() {
		return corpName;
	}

	public void setCorpName(String corpName) {
		this.corpName = corpName;
	}

	public InvSort() {
		super();
	}

	public InvSort(String sortCode) {
		super();
		this.sortCode = sortCode;
	}

	public InvSort(InvSort parent) {
		this.parent = parent;
	}

	@Id
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}

	@Length(min = 0, max = 50, message = "产品分类名称长度不能超过 50 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	@NotBlank(message = "上级编码不能为空")
	@Length(min = 0, max = 200, message = "上级编码长度不能超过 200 个字符")
	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	@JsonBackReference
	@NotNull(message = "上级编码不能为空")
	public InvSort getParent() {
		return parent;
	}

	public void setParent(InvSort parent) {
		this.parent = parent;
	}

	//@NotNull(message = "级次不能为空")
	public Integer getSortGrade() {
		return sortGrade;
	}

	public void setSortGrade(Integer sortGrade) {
		this.sortGrade = sortGrade;
	}

	public String toString() {
		return sortCode;
	}
}