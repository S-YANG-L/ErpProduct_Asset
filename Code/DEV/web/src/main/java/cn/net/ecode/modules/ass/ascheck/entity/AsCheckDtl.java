/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.ascheck.entity;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 办公用品盘点Entity
 * @author zhaohongbin
 * @version 2018-10-17
 */
public class AsCheckDtl extends DataEntity<AsCheckDtl> {
	
	private static final long serialVersionUID = 1L;
	private String checkCode;		// 关联键 父类
	private String articlesCode;		// 办公物品编码
	private String articlesName;		// 办公用品名称
	private String whCode;		// 仓库编码
	private String whName;		// 仓库名称
	private String sortCode;		// 类别编码
	private String sortName;		// 类别名称
	private String brand;		// 品牌名称
	private String version;		// 规格型号
	private String unit;		// 单位
	private Double price;		// 单价
	private Double qty;		// 应盘数量
	private Double sumMoney;		// 合计金额
	private Double checkQty;		// 实盘数量
	
	private String initialQty;		//初始数量
	private String initialPrice;	//初始单价
	private	String initialMoney;	//初始金额
	
	public AsCheckDtl() {
		super();
	}

	public AsCheckDtl(String id){
		super();
		this.id = id;
	}


	@Length(min=0, max=64, message="关联键长度不能超过 64 个字符")
	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	
	@Length(min=0, max=64, message="办公物品编码长度不能超过 64 个字符")
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
	
	@Length(min=0, max=64, message="仓库编码长度不能超过 64 个字符")
	public String getWhCode() {
		return whCode;
	}

	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	
	@Length(min=0, max=64, message="仓库名称长度不能超过 64 个字符")
	public String getWhName() {
		return whName;
	}

	public void setWhName(String whName) {
		this.whName = whName;
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
	
	@Length(min=0, max=100, message="品牌名称长度不能超过 100 个字符")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	@Length(min=0, max=100, message="规格型号长度不能超过 100 个字符")
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	@Length(min=0, max=100, message="单位长度不能超过 100 个字符")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=100, message="单价长度不能超过 100 个字符")
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	public Double getQty() {
		return qty;
	}

	public void setQty(Double qty) {
		this.qty = qty;
	}
	
	@Length(min=0, max=100, message="合计金额长度不能超过 100 个字符")
	public Double getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(Double sumMoney) {
		this.sumMoney = sumMoney;
	}
	
	public Double getCheckQty() {
		return checkQty;
	}

	public void setCheckQty(Double checkQty) {
		this.checkQty = checkQty;
	}

	public String getInitialQty() {
		return initialQty;
	}

	public void setInitialQty(String initialQty) {
		this.initialQty = initialQty;
	}

	public String getInitialPrice() {
		return initialPrice;
	}

	public void setInitialPrice(String initialPrice) {
		this.initialPrice = initialPrice;
	}

	public String getInitialMoney() {
		return initialMoney;
	}

	public void setInitialMoney(String initialMoney) {
		this.initialMoney = initialMoney;
	}
	
}