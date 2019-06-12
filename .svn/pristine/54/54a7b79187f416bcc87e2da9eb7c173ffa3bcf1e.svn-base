/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.wareitems.entity;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.utils.excel.annotation.ExcelField;

/**
 * 仓库物品信息Entity
 * @author tiange
 * @version 2018-10-13
 */

public class WarehouseItems extends DataEntity<WarehouseItems> {
	
	private static final long serialVersionUID = 1L;
	private String articlesCode;		// 办公物品编码
	private String[] articlesCodes;		//获取仓库中已有的物品编码
	private String[] ids;		//获取仓库中已有的主键
	private String articlesName;		// 办公用品名称
	private String whCode;		// 仓库编码
	private String whName;		// 仓库名称
	private String sortCode;		// 类别编码
	private String sortName;		// 类别名称
	private String brand;		// 品牌名称
	private String version;		// 规格型号
	private String unit;		// 单位
	private Double price;		// 单价
	private Double qty;		// 数量
	private Double checkQty;		// 数量
	private Double sumMoney;		// 合计金额
	private String upperLimit;		//安全上限
	private String lowerLimit;		//安全下限
	
	public WarehouseItems() {
		super();
	}

	public WarehouseItems(String id){
		super();
		this.id = id;
	}
	   @ExcelField(
	            title = "物品编码",
	            align = 1,
	            sort = 2
	    )
	@Length(min=0, max=64, message="办公物品编码长度不能超过 64 个字符")
	public String getArticlesCode() {
		return articlesCode;
	}
	
	public void setArticlesCode(String articlesCode) {
		this.articlesCode = articlesCode;
	}
	@ExcelField(
            title = "物品名称",
            align = 1,
            sort = 3
    )
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
	@ExcelField(
            title = "仓库",
            align = 1,
            sort = 6
    )
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
	
	   @ExcelField(
	            title = "类别名称",
	            align = 1,
	            sort = 1
	    )
	@Length(min=0, max=64, message="类别名称长度不能超过 64 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	@ExcelField(
            title = "品牌名称",
            align = 1,
            sort = 4
    )
	@Length(min=0, max=100, message="品牌名称长度不能超过 100 个字符")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
	@ExcelField(
            title = "规格型号",
            align = 1,
            sort = 5
    )
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
	@ExcelField(
            title = "数量",
            align = 1,
            sort = 7
    )
	@Length(min=0, max=100, message="数量长度不能超过 100 个字符")
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
	public String getUpperLimit() {
		return upperLimit;
	}

	public void setUpperLimit(String upperLimit) {
		this.upperLimit = upperLimit;
	}
	public String getLowerLimit() {
		return lowerLimit;
	}

	public void setLowerLimit(String lowerLimit) {
		this.lowerLimit = lowerLimit;
	}

	public String[] getIds() {
		return ids;
	}

	public void setIds(String[] ids) {
		this.ids = ids;
	}

	public String[] getArticlesCodes() {
		return articlesCodes;
	}

	public void setArticlesCodes(String[] articlesCodes) {
		this.articlesCodes = articlesCodes;
	}

	public Double getCheckQty() {
		return checkQty;
	}

	public void setCheckQty(Double checkQty) {
		this.checkQty = checkQty;
	}
}