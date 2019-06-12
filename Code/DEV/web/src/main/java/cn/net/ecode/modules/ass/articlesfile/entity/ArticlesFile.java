/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.articlesfile.entity;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 办公用品档案管理Entity
 * @author yangjianjun
 * @version 2018-09-29
 */
public class ArticlesFile extends DataEntity<ArticlesFile> {
	
	private static final long serialVersionUID = 1L;
	private String articlesCode;		// 办公用品编码
	private String[] articlesCodes;		// 办公用品编码数组 领用表格中已有的数据
	private String[] articleCodes;		//办公用品编码数组  入库时领用表格中已有的数据
	private String articlesName;		// 办公用品名称
	private String sortCode;		// 类别编码
	private String sortName;		// 类别名称
	private String barCode;		// 商品条码
	private String brand;		// 品牌名称
	private String version;		// 规格型号
	private String unit;		// 单位
	private String unitPrice;		// 单价
	private String upperLimit;		// 安全上限
	private String lowerLimit;		// 安全下限
	private String picture;		// 照片
	
	public ArticlesFile() {
		super();
	}

	public ArticlesFile(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="办公用品编码长度不能超过 64 个字符")
	public String getArticlesCode() {
		return articlesCode;
	}

	public void setArticlesCode(String articlesCode) {
		this.articlesCode = articlesCode;
	}
	
	@Length(min=0, max=64, message="办公用品名称长度不能超过 64 个字符")
	public String getArticlesName() {
		return articlesName;
	}

	public void setArticlesName(String articlesName) {
		this.articlesName = articlesName;
	}
	
	@Length(min=0, max=64, message="类别编码长度不能超过 64 个字符")
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
	
	@Length(min=0, max=64, message="类别名称长度不能超过 64 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	
	@Length(min=0, max=64, message="商品条码长度不能超过 64 个字符")
	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}
	
	@Length(min=0, max=255, message="品牌名称长度不能超过 255 个字符")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	@Length(min=0, max=64, message="规格型号长度不能超过 64 个字符")
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	@Length(min=0, max=64, message="单位长度不能超过 64 个字符")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=64, message="单价长度不能超过 64 个字符")
	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	@Length(min=0, max=64, message="安全上限长度不能超过 64 个字符")
	public String getUpperLimit() {
		return upperLimit;
	}

	public void setUpperLimit(String upperLimit) {
		this.upperLimit = upperLimit;
	}
	
	@Length(min=0, max=64, message="安全下限长度不能超过 64 个字符")
	public String getLowerLimit() {
		return lowerLimit;
	}

	public void setLowerLimit(String lowerLimit) {
		this.lowerLimit = lowerLimit;
	}
	
	@Length(min=0, max=255, message="照片长度不能超过 255 个字符")
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String[] getArticlesCodes() {
		return articlesCodes;
	}

	public void setArticlesCodes(String[] articlesCodes) {
		this.articlesCodes = articlesCodes;
	}

	public String[] getArticleCodes() {
		return articleCodes;
	}

	public void setArticleCodes(String[] articleCodes) {
		this.articleCodes = articleCodes;
	}
	
}