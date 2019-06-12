/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.supplier.entity;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 供货商Entity
 * @author zhaohongbin
 * @version 2018-11-03
 */
public class SupplierInfo extends DataEntity<SupplierInfo> {
	
	private static final long serialVersionUID = 1L;
	private String supplierCode;		// 供货商编码
	private String supplierName;		// 供货商名称
	private String extendS1;		// extend_s1
	private String extendS2;		// extend_s2
	
	public SupplierInfo() {
		super();
	}

	public SupplierInfo(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="供货商编码长度不能超过 64 个字符")
	public String getSupplierCode() {
		return supplierCode;
	}

	public void setSupplierCode(String supplierCode) {
		this.supplierCode = supplierCode;
	}
	
	@Length(min=0, max=64, message="供货商名称长度不能超过 64 个字符")
	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	
	@Length(min=0, max=64, message="extend_s1长度不能超过 64 个字符")
	public String getExtendS1() {
		return extendS1;
	}

	public void setExtendS1(String extendS1) {
		this.extendS1 = extendS1;
	}
	
	@Length(min=0, max=64, message="extend_s2长度不能超过 64 个字符")
	public String getExtendS2() {
		return extendS2;
	}

	public void setExtendS2(String extendS2) {
		this.extendS2 = extendS2;
	}
	
}