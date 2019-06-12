/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;
import org.hibernate.validator.constraints.Length;

/**
 * 仓库表Entity
 * @author 肖敦山
 * @version 2015-11-19
 */
public class Warehouse extends DataEntity<Warehouse> {
	
	private static final long serialVersionUID = 1L;
	private String whCode;		// 仓库编码
	private String whName;		// 仓库名称
	private String whCodeFrom;		// 仓库编码
	private String whNameFrom;		// 仓库名称
	private String companyCode;		// 公司ID
	private String companyName;		// 公司名称
	private String deptCode;		// 部门核算编码
	private String deptName;		// 部门核算名称
	private String addr;		// 地址
	private String tel;		// 电话
	private String fax;		// 传真
	private String director;		// 负责人
	private Long orderCode;		// 排序
	private String searchCode;		// 检索码
	private String flag;
	
	
	public Warehouse() {
		super();
	}

	public Warehouse(String whCode){
		super();
		this.whCode = whCode;
	}

	@Id
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
	
	@Length(min=0, max=20, message="公司ID长度不能大于 20 个字符")
	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	
	@Length(min=0, max=50, message="公司名称长度不能大于 50 个字符")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	@Length(min=0, max=20, message="部门核算编码长度不能大于 20 个字符")
	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	
	@Length(min=0, max=50, message="部门核算名称长度不能大于 50 个字符")
	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	@Length(min=0, max=500, message="地址长度不能大于 500 个字符")
	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	@Length(min=0, max=20, message="电话长度不能大于 20 个字符")
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Length(min=0, max=20, message="传真长度不能大于 20 个字符")
	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}
	
	@Length(min=0, max=20, message="负责人长度不能大于 20 个字符")
	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}
	
	public Long getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(Long orderCode) {
		this.orderCode = orderCode;
	}
	
	@Length(min=0, max=50, message="检索码长度不能大于 50 个字符")
	public String getSearchCode() {
		return searchCode;
	}

	public void setSearchCode(String searchCode) {
		this.searchCode = searchCode;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getWhCodeFrom() {
		return whCodeFrom;
	}

	public void setWhCodeFrom(String whCodeFrom) {
		this.whCodeFrom = whCodeFrom;
	}

	public String getWhNameFrom() {
		return whNameFrom;
	}

	public void setWhNameFrom(String whNameFrom) {
		this.whNameFrom = whNameFrom;
	}
	
}