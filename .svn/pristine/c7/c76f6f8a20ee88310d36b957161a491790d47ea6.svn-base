/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.officesupplies.entity;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 办公用品Entity
 * @author sun
 * @version 2018-09-10
 */
public class SuppliesInfo extends DataEntity<SuppliesInfo> {
	
	private static final long serialVersionUID = 1L;
	private String suppliesCode;		// 办公用品编码
	private String suppliesName;		// 办公用品名称
	private String sortCode;		// 分类编码
	private String sortName;		// 分类名称
	private String brand;		// 品牌
	private String model;		// 型号
	private String unit;		// 单位
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String remarks;
	
	
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public SuppliesInfo() {
		super();
	}

	public SuppliesInfo(String id){
		super();
		this.id = id;
	}

	@NotBlank(message="办公用品编码不能为空")
	@Length(min=0, max=64, message="办公用品编码长度不能超过 64 个字符")
	public String getSuppliesCode() {
		return suppliesCode;
	}

	public void setSuppliesCode(String suppliesCode) {
		this.suppliesCode = suppliesCode;
	}
	
	@NotBlank(message="办公用品名称不能为空")
	@Length(min=0, max=200, message="办公用品名称长度不能超过 200 个字符")
	public String getSuppliesName() {
		return suppliesName;
	}

	public void setSuppliesName(String suppliesName) {
		this.suppliesName = suppliesName;
	}
	
	@Length(min=0, max=64, message="分类编码长度不能超过 64 个字符")
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
	
	@Length(min=0, max=100, message="分类名称长度不能超过 100 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	
	@Length(min=0, max=200, message="品牌长度不能超过 200 个字符")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	@Length(min=0, max=100, message="型号长度不能超过 100 个字符")
	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}
	
	@Length(min=0, max=100, message="单位长度不能超过 100 个字符")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=200, message="扩展1长度不能超过 200 个字符")
	public String getExtendS1() {
		return extendS1;
	}

	public void setExtendS1(String extendS1) {
		this.extendS1 = extendS1;
	}
	
	@Length(min=0, max=100, message="扩展2长度不能超过 100 个字符")
	public String getExtendS2() {
		return extendS2;
	}

	public void setExtendS2(String extendS2) {
		this.extendS2 = extendS2;
	}
	
}