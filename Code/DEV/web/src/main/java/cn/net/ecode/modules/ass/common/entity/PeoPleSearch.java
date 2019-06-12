/**
 * Copyright (c) 2013-Now 山东易科德软件有限公司 All rights reserved.
 */
package cn.net.ecode.modules.ass.common.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.modules.sys.entity.Office;

/**
 * 
 * @author yhl
 * @version 2018年11月1日
 */
public class PeoPleSearch extends DataEntity<PeoPleSearch>{

	private static final long serialVersionUID = 1L;
	
	private String empCode;  // 员工编码
	private String empName;  // 员工名称
	private String officeCode;  // 部门编码
	private String officeName;  // 部门名称
	private Office office;  // 部门
	private String company; // 公司
	private String companyCode; // 公司
	private String companyName; // 公司
	private String userCode; // 用户编码
	private String userName;  // 用户名称
	private Integer pageSize1;  // 手机端分页
	private Integer pageNo1;    //手机端分页
	private Integer pageStart; //手机端开始条数
	private String extendS1;  // 扩展字段
	private String extendS2;	// 扩展字段
	
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getOfficeCode() {
		return officeCode;
	}
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	public Office getOffice() {
		return office;
	}
	public void setOffice(Office office) {
		this.office = office;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
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
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getPageSize1() {
		return pageSize1;
	}
	public void setPageSize1(Integer pageSize1) {
		this.pageSize1 = pageSize1;
	}
	public Integer getPageNo1() {
		return pageNo1;
	}
	public void setPageNo1(Integer pageNo1) {
		this.pageNo1 = pageNo1;
	}
	public Integer getPageStart() {
		return pageStart;
	}
	public void setPageStart(Integer pageStart) {
		this.pageStart = pageStart;
	}
	public String getExtendS1() {
		return extendS1;
	}
	public void setExtendS1(String extendS1) {
		this.extendS1 = extendS1;
	}
	public String getExtendS2() {
		return extendS2;
	}
	public void setExtendS2(String extendS2) {
		this.extendS2 = extendS2;
	}
	
}
