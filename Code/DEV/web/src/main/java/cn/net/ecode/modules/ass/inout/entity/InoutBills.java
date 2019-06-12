/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.inout.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;
import cn.net.ecode.common.utils.excel.annotation.ExcelField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 入库子表Entity
 * @version 2015-11-24
 */
public class InoutBills extends DataEntity<InoutBills> {
	private static final long serialVersionUID = 1L;
	private String sysId;		// 系统编号
	private String sysCode;		// 主表编码
	private Integer serialNo;		// 序号
	private String invCode;		// 存货编码
	private String invName;		// 存货名称
	private String batchNo;		// 批号
	private String invColor;		// 颜色
	private String invSize;		// 尺寸
	private Date produceDate;		// 生产日期
	private Date validDate;		// 截止有效期
	private Double qty;		// 数量
	private Double price;		// 含税开票价
	private String unit;		//单位
	private Double sumMoney;		// 合计金额
	private Double normPrice;		// 标准售价
	private Double costPrice;		// 成本单价
	private Double discountRate;		// 折扣率
	private Double discount;		// 折扣额
	private Double taxRate;		// 税率
	private Double taxMoney;		// tax_money
	private String grantNo;		// 1为采购入库2为办公用品入库
	private String memo;		// 备注
	private String relaSyscode;		// 采购订单号
	private String relaSerialno;		// 采购行序号
	private String isBilling;		// 结算开票标志，0：无结算，1：采购发票，2：销售发票
	private String sortCode;		// 类别编码
	private String sortName;		// 类别名称
	private String articlesName;	//名称
	private String articleCode;		//办公物品编码
	private String brand;			//品牌名称
	private String version;			//规格型号
	
	private Double inInitialQty;	//入库初始数量
	private Double inInitialPrice;	//入库初始单价
	private Double inInitialMoney;	//入库初始金额

    public InoutBills() {
        super();
    }

    public InoutBills(String sysId){
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

    @Length(min=1, max=64, message="主表编码长度必须介于 1 和 64 之间")
    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

	public String getArticleCode() {
		return articleCode;
	}

	public void setArticleCode(String articleCode) {
		this.articleCode = articleCode;
	}
	
	public String getArticlesName() {
		return articlesName;
	}

	public void setArticlesName(String articlesName) {
		this.articlesName = articlesName;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public Integer getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(Integer serialNo) {
		this.serialNo = serialNo;
	}
	
	@ExcelField(title = "商品编码",  sort = 7)
	@Length(min=1, max=20, message="存货编码长度必须介于 1 和 20 之间")
	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}
	
	@ExcelField(title = "商品名称",  sort = 8)
	@Length(min=1, max=50, message="存货名称长度必须介于 1 和 50 之间")
	public String getInvName() {
		return invName;
	}

	public void setInvName(String invName) {
		this.invName = invName;
	}
	
	@Length(min=0, max=50, message="批号长度不能大于 50 个字符")
	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}
	
	@Length(min=0, max=10, message="颜色长度不能大于 10 个字符")
	public String getInvColor() {
		return invColor;
	}

	public void setInvColor(String invColor) {
		this.invColor = invColor;
	}
	
	@Length(min=0, max=20, message="尺寸长度不能大于 20 个字符")
	public String getInvSize() {
		return invSize;
	}

	public void setInvSize(String invSize) {
		this.invSize = invSize;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getProduceDate() {
		return produceDate;
	}

	public void setProduceDate(Date produceDate) {
		this.produceDate = produceDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getValidDate() {
		return validDate;
	}

	public void setValidDate(Date validDate) {
		this.validDate = validDate;
	}
	@NotNull(message="数量不能为空")
	public Double getQty() {
		return qty;
	}

	public void setQty(Double qty) {
		this.qty = qty;
	}
	
	@ExcelField(title = "单价",  sort = 11)
	@NotNull(message="含税开票价不能为空")
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	@ExcelField(title = "金额",  sort = 12)
	@NotNull(message="价税合计不能为空")
	public Double getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(Double sumMoney) {
		this.sumMoney = sumMoney;
	}
	
	@NotNull(message="标准售价不能为空")
	public Double getNormPrice() {
		return normPrice;
	}

	public void setNormPrice(Double normPrice) {
		this.normPrice = normPrice;
	}
	
	@NotNull(message="成本单价不能为空")
	public Double getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(Double costPrice) {
		this.costPrice = costPrice;
	}
	
	@NotNull(message="折扣率不能为空")
	public Double getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(Double discountRate) {
		this.discountRate = discountRate;
	}
	
	@NotNull(message="折扣额不能为空")
	public Double getDiscount() {
		return discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}
	
	@NotNull(message="税率不能为空")
	public Double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(Double taxRate) {
		this.taxRate = taxRate;
	}
	
	@NotNull(message="tax_money不能为空")
	public Double getTaxMoney() {
		return taxMoney;
	}

	public void setTaxMoney(Double taxMoney) {
		this.taxMoney = taxMoney;
	}
	
	@Length(min=0, max=50, message="价格版本号长度不能大于 50 个字符")
	public String getGrantNo() {
		return grantNo;
	}

	public void setGrantNo(String grantNo) {
		this.grantNo = grantNo;
	}
	
	@ExcelField(title = "摘要",  sort = 21)
	@Length(min=0, max=500, message="备注长度不能大于 500 个字符")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	@Length(min=0, max=64, message="采购订单号长度不能大于 64 个字符")
	public String getRelaSyscode() {
		return relaSyscode;
	}

	public void setRelaSyscode(String relaSyscode) {
		this.relaSyscode = relaSyscode;
	}
	
	@Length(min=0, max=64, message="采购行序号长度不能大于 64 个字符")
	public String getRelaSerialno() {
		return relaSerialno;
	}

	public void setRelaSerialno(String relaSerialno) {
		this.relaSerialno = relaSerialno;
	}
	
	@Length(min=0, max=10, message="结算开票标志，0：无结算，1：采购发票，2：销售发票长度不能大于 10 个字符")
	public String getIsBilling() {
		return isBilling;
	}

	public void setIsBilling(String isBilling) {
		this.isBilling = isBilling;
	}

	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}

	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Double getInInitialQty() {
		return inInitialQty;
	}

	public void setInInitialQty(Double inInitialQty) {
		this.inInitialQty = inInitialQty;
	}

	public Double getInInitialPrice() {
		return inInitialPrice;
	}

	public void setInInitialPrice(Double inInitialPrice) {
		this.inInitialPrice = inInitialPrice;
	}

	public Double getInInitialMoney() {
		return inInitialMoney;
	}

	public void setInInitialMoney(Double inInitialMoney) {
		this.inInitialMoney = inInitialMoney;
	}
	

}