/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.orderbill.entity;

import cn.net.ecode.common.persistence.annotation.Id;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 物资采购Entity
 * @author zhaohongbin
 * @version 2018-10-15
 */
public class OrderBills extends DataEntity<OrderBills> {
	
	private static final long serialVersionUID = 1L;
	private String sysId;		// 主键
	private String sysCode;		// 关联键 父类
	private Double barCode;		// 商品条码
	private String articlesCode;		// 办公用品编码
	private String articlesName;		// 办公用品名称
	private String sortCode;		// 类别编码
	private String sortName;		// 类别名称
	private Double qty;		// 数量
	private Double price;		// 价格
    private Double sumMoney;		// 价格合计
	private String unit;		// 单位
	private String brand;		// 品牌名称
	private String version;		// 规格型号
	
	public OrderBills() {
		super();
	}

	public OrderBills(String sysId){
		super();
		this.sysId = sysId;
	}



	@Id
	public String getSysId() {
		return sysId;
	}

	public void setSysId(String sysId) {
		this.sysId = sysId;
	}
	
	@NotBlank(message="关联键不能为空")
	@Length(min=0, max=64, message="关联键长度不能超过 64 个字符")
	public String getSysCode() {
		return sysCode;
	}

	public void setSysCode(String sysCode) {
		this.sysCode = sysCode;
	}
	
	public Double getBarCode() {
		return barCode;
	}

	public void setBarCode(Double barCode) {
		this.barCode = barCode;
	}
	
	@Length(min=0, max=20, message="办公用品编码长度不能超过 20 个字符")
	public String getArticlesCode() {
		return articlesCode;
	}

	public void setArticlesCode(String articlesCode) {
		this.articlesCode = articlesCode;
	}
	
	@Length(min=0, max=50, message="办公用品名称长度不能超过 50 个字符")
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
	
	@NotNull(message="数量不能为空")
	public Double getQty() {
		return qty;
	}

	public void setQty(Double qty) {
		this.qty = qty;
	}
	
	@NotNull(message="价格不能为空")
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	@Length(min=0, max=100, message="单位长度不能超过 100 个字符")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
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

    public Double getSumMoney() {
        return sumMoney;
    }

    public void setSumMoney(Double sumMoney) {
        this.sumMoney = sumMoney;
    }
}