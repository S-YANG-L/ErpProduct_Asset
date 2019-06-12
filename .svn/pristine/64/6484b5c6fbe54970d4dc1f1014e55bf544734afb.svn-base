/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.inout.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fr.third.v2.com.microsoft.schemas.office.office.PreferrelativeAttribute;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

/**
 * 出入库主表Entity
 * @version 2015-11-24
 */
public class InoutBill extends DataEntity<InoutBill> {
	
	private static final long serialVersionUID = 1L;
	private String sysCode;		// 系统编码
	private String billCode;		// 入库单号
	private String companyCode;		// 公司ID
	private String companyName;		// 公司名称
	private String deptCode;		// 部门核算编码
	private String deptName;		// 部门核算名称
	private Date orderDate;		// 入库日期
	private String inoutFlag;		// 出入库标志 1：入库；0：出库
	private String whCode;		// 仓库编码
	private String whName;		// 仓库名称
	private String tel;		// 电话
	private String linkMan;		// 联系人
	private String memo;		// 备注
	private String psnCode;		// 业务人编码
	private String psnName;		// 业务人名称
	private Date createDate;	//创建时间
	private List<InoutBills> inoutBillsListOrderbill;
    private List<InoutBills> inoutBillsListArticles;
	private String inoutBillsList; //办公用品
	private String inoutOrderbillsList; //采购单
    private Date beginDate;		//开始日期
	public String getInoutBillsList() {
		return inoutBillsList;
	}

	public void setInoutBillsList(String inoutBillsList) {
		this.inoutBillsList = inoutBillsList;
	}
	public InoutBill() {
		super();
	}

	public InoutBill(String sysCode){
		super();
		this.sysCode = sysCode;
	}

	@Id
	public String getSysCode() {
		return sysCode;
	}

	public void setSysCode(String sysCode) {
		this.sysCode = sysCode;
	}
	
	public String getBillCode() {
		return billCode;
	}

	public String getInoutOrderbillsList() {
		return inoutOrderbillsList;
	}

	public void setInoutOrderbillsList(String inoutOrderbillsList) {
		this.inoutOrderbillsList = inoutOrderbillsList;
	}

	public void setBillCode(String billCode) {
		this.billCode = billCode;
	}
	
	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	
	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="订单日期不能为空")
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	
	@Length(min=1, max=1, message="出入库标志 1：入库；0：出库长度必须是 1个字符")
	public String getInoutFlag() {
		return inoutFlag;
	}

	public void setInoutFlag(String inoutFlag) {
		this.inoutFlag = inoutFlag;
	}

	
	@Length(min=0, max=64, message="仓库编码长度不能大于 64 个字符")
	public String getWhCode() {
		return whCode;
	}

	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	
	@Length(min=0, max=50, message="仓库名称长度不能大于 50 个字符")
	public String getWhName() {
		return whName;
	}

	public void setWhName(String whName) {
		this.whName = whName;
	}

	
	@Length(min=0, max=20, message="电话长度不能大于 20 个字符")
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getLinkMan() {
		return linkMan;
	}

	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	
	public String getPsnCode() {
		return psnCode;
	}

	public void setPsnCode(String psnCode) {
		this.psnCode = psnCode;
	}
	
	public String getPsnName() {
		return psnName;
	}

	public void setPsnName(String psnName) {
		this.psnName = psnName;
	}


    public List<InoutBills> getInoutBillsListOrderbill() {
        return inoutBillsListOrderbill;
    }

    public void setInoutBillsListOrderbill(List<InoutBills> inoutBillsListOrderbill) {
        this.inoutBillsListOrderbill = inoutBillsListOrderbill;
    }

    public List<InoutBills> getInoutBillsListArticles() {
        return inoutBillsListArticles;
    }

    public void setInoutBillsListArticles(List<InoutBills> inoutBillsListArticles) {
        this.inoutBillsListArticles = inoutBillsListArticles;
    }
    @JsonFormat(pattern="yyyy-MM-dd") 
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
    
}