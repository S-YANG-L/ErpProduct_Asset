/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.entity;

import cn.net.ecode.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 单位属性表Entity
 * @author 车磊岩
 * @version 2015-09-30
 */
public class BtypeAttr extends DataEntity<BtypeAttr> {
	
	private static final long serialVersionUID = 1L;
	private String btypeCode;		// 单位机构编码
	private String btypeName;		// 单位机构名称
	private String attributeSort;		// 属性分类
	private String attributeCode;		// 属性编码
	private String attributeValue;		// 属性值
	
	public BtypeAttr() {
		super();
	}

	public BtypeAttr(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="单位机构编码长度不能大于 64 个字符")
	public String getBtypeCode() {
		return btypeCode;
	}

	public void setBtypeCode(String btypeCode) {
		this.btypeCode = btypeCode;
	}
	
	@Length(min=0, max=128, message="单位机构名称长度不能大于 128 个字符")
	public String getBtypeName() {
		return btypeName;
	}

	public void setBtypeName(String btypeName) {
		this.btypeName = btypeName;
	}
	
	@Length(min=0, max=64, message="属性分类长度不能大于 64 个字符")
	public String getAttributeSort() {
		return attributeSort;
	}

	public void setAttributeSort(String attributeSort) {
		this.attributeSort = attributeSort;
	}
	
	@Length(min=0, max=32, message="属性编码长度不能大于 32 个字符")
	public String getAttributeCode() {
		return attributeCode;
	}

	public void setAttributeCode(String attributeCode) {
		this.attributeCode = attributeCode;
	}
	
	@Length(min=0, max=64, message="属性值长度不能大于 64 个字符")
	public String getAttributeValue() {
		return attributeValue;
	}

	public void setAttributeValue(String attributeValue) {
		this.attributeValue = attributeValue;
	}
	
}