/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.ascheck.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 办公用品盘点Entity
 * @author zhaohongbin
 * @version 2018-10-17
 */
public class AsCheck extends DataEntity<AsCheck> {
	
	private static final long serialVersionUID = 1L;
	private String checkCode;		// 盘点编码
	private String checkName;		// 盘点名称
	private String operatorName;		// 操作人编码
	private String operatorCode;		// 操作人
	private String whCode;		// 仓库编码
	private String whName;		// 仓库名称
	private Date checkDate;		// 盘点时间
	private List<AsCheckDtl> asCheckDtlList = Lists.newArrayList();		// 子表列表
	
	public AsCheck() {
		super();
	}

	public AsCheck(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="盘点编码长度不能超过 64 个字符")
	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	
	@Length(min=0, max=100, message="盘点名称长度不能超过 100 个字符")
	public String getCheckName() {
		return checkName;
	}

	public void setCheckName(String checkName) {
		this.checkName = checkName;
	}
	
	@Length(min=0, max=64, message="操作人编码长度不能超过 64 个字符")
	public String getOperatorName() {
		return operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	
	@Length(min=0, max=64, message="操作人长度不能超过 64 个字符")
	public String getOperatorCode() {
		return operatorCode;
	}

	public void setOperatorCode(String operatorCode) {
		this.operatorCode = operatorCode;
	}
	
	@Length(min=0, max=64, message="仓库编码长度不能超过 64 个字符")
	public String getWhCode() {
		return whCode;
	}

	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	
	@Length(min=0, max=100, message="仓库名称长度不能超过 100 个字符")
	public String getWhName() {
		return whName;
	}

	public void setWhName(String whName) {
		this.whName = whName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}
	
	public List<AsCheckDtl> getAsCheckDtlList() {
		return asCheckDtlList;
	}

	public void setAsCheckDtlList(List<AsCheckDtl> asCheckDtlList) {
		this.asCheckDtlList = asCheckDtlList;
	}
}