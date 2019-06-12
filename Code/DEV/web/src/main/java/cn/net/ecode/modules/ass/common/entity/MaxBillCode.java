/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;

/**
 * 单表生成Entity
 * @author 肖敦山
 * @version 2015-10-27
 */
public class MaxBillCode extends DataEntity<MaxBillCode> {
	
	private static final long serialVersionUID = 1L;
	
	private String sysId;
	private String corpCode;
	private String corpName;
	private String companyCode;
	private String companyName;
	private String billsortCode;
	private String billsortName;
	private String accountYear;
	private Integer maxCode;

	public MaxBillCode() {
		super();
	}

	public MaxBillCode(String id){
		super();
		this.id = id;
	}

	@Id
	public String getSysId() {
		return sysId;
	}

	public void setSysId(String sysId) {
		this.sysId = sysId;
	}

	public String getCorpCode() {
		return corpCode;
	}

	public void setCorpCode(String corpCode) {
		this.corpCode = corpCode;
	}

	public String getCorpName() {
		return corpName;
	}

	public void setCorpName(String corpName) {
		this.corpName = corpName;
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

	public String getBillsortCode() {
		return billsortCode;
	}

	public void setBillsortCode(String billsortCode) {
		this.billsortCode = billsortCode;
	}

	public String getBillsortName() {
		return billsortName;
	}

	public void setBillsortName(String billsortName) {
		this.billsortName = billsortName;
	}

	public String getAccountYear() {
		return accountYear;
	}

	public void setAccountYear(String accountYear) {
		this.accountYear = accountYear;
	}

	public Integer getMaxCode() {
		return maxCode;
	}

	public void setMaxCode(Integer maxCode) {
		this.maxCode = maxCode;
	}
   

	
}