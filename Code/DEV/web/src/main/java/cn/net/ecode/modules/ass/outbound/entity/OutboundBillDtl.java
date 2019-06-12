/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.outbound.entity;

import cn.net.ecode.common.persistence.annotation.Id;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import cn.net.ecode.modules.sys.entity.Office;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 物资出库Entity
 * @author tiange
 * @version 2018-10-11
 */
public class OutboundBillDtl extends DataEntity<OutboundBillDtl> {
	
	private static final long serialVersionUID = 1L;
	private String sysId;		// 主键
	private String sysCode;		// 关联键 父类
	private String outboundCode;    //出库编码
	private String billCode;		// 流水号
	private String inoutOrder;		// 入库单号
	private Date orderDate;		// 入库日期
	private String psnCode;		// 入库经办人编码
	private Double outboundNumber;		// 出库数量
	private String psnName;		// 入库经办人名称
	private String articlesName;		// 办公用品名称
	private String articlesCode;		// 办公用品编码
	private String sortCode;		// 办公类别编码
	private String sortName;		// 办公类别名称
	private String brand;		// 品牌名称
	private String version;		// 规格型号
	private Double qty;		// 数量
	private Double price;		// 单价
	private Double sumMoney;		// 合计金额
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 部门编码
	private String officeName;		// 部门名称
    private String whCode;		// 仓库编码
    private String whName;		// 仓库名称
    
    private Double outInitialQty;	//出库初始数量
	private Double outInitialPrice;	//出库初始单价
	private Double outInitialMoney;	//出库初始金额
    
	public OutboundBillDtl() {
		super();
	}

	public OutboundBillDtl(String sysId){
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
	
	
	public String getSysCode() {
		return sysCode;
	}

	public void setSysCode(String sysCode) {
		this.sysCode = sysCode;
	}


	public String getBillCode() {
		return billCode;
	}

	public void setBillCode(String billCode) {
		this.billCode = billCode;
	}
	
	public String getOutboundCode() {
		return outboundCode;
	}

	public void setOutboundCode(String outboundCode) {
		this.outboundCode = outboundCode;
	}


	public String getInoutOrder() {
		return inoutOrder;
	}

	public void setInoutOrder(String inoutOrder) {
		this.inoutOrder = inoutOrder;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	

	public String getPsnCode() {
		return psnCode;
	}

	public void setPsnCode(String psnCode) {
		this.psnCode = psnCode;
	}
	
	public Double getOutboundNumber() {
		return outboundNumber;
	}

	public void setOutboundNumber(Double outboundNumber) {
		this.outboundNumber = outboundNumber;
	}
	
	@Length(min=0, max=100, message="入库经办人名称长度不能超过 100 个字符")
	public String getPsnName() {
		return psnName;
	}

	public void setPsnName(String psnName) {
		this.psnName = psnName;
	}
	
	@Length(min=0, max=100, message="办公用品名称长度不能超过 100 个字符")
	public String getArticlesName() {
		return articlesName;
	}

	public void setArticlesName(String articlesName) {
		this.articlesName = articlesName;
	}
	

	public String getArticlesCode() {
		return articlesCode;
	}

	public void setArticlesCode(String articlesCode) {
		this.articlesCode = articlesCode;
	}
	

	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
	
	@Length(min=0, max=100, message="办公类别名称长度不能超过 100 个字符")
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
	
	@Length(min=0, max=100, message="数量长度不能超过 100 个字符")
	public Double getQty() {
		return qty;
	}

	public void setQty(Double qty) {
		this.qty = qty;
	}
	
	@Length(min=0, max=100, message="单价长度不能超过 100 个字符")
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	@Length(min=0, max=100, message="合计金额长度不能超过 100 个字符")
	public Double getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(Double sumMoney) {
		this.sumMoney = sumMoney;
	}


	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	
	@Length(min=0, max=100, message="公司名称长度不能超过 100 个字符")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=0, max=100, message="部门名称长度不能超过 100 个字符")
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}

    public String getWhCode() {
        return whCode;
    }

    public void setWhCode(String whCode) {
        this.whCode = whCode;
    }

    public String getWhName() {
        return whName;
    }

    public void setWhName(String whName) {
        this.whName = whName;
    }

	public Double getOutInitialQty() {
		return outInitialQty;
	}

	public void setOutInitialQty(Double outInitialQty) {
		this.outInitialQty = outInitialQty;
	}

	public Double getOutInitialPrice() {
		return outInitialPrice;
	}

	public void setOutInitialPrice(Double outInitialPrice) {
		this.outInitialPrice = outInitialPrice;
	}

	public Double getOutInitialMoney() {
		return outInitialMoney;
	}

	public void setOutInitialMoney(Double outInitialMoney) {
		this.outInitialMoney = outInitialMoney;
	}
    
    
}