/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;
import org.hibernate.validator.constraints.Length;

/**
 * 收发类别表Entity
 * @author 肖敦山
 * @version 2015-11-19
 */
public class Rdstyle extends DataEntity<Rdstyle> {
	
	private static final long serialVersionUID = 1L;
	private String rdCode;		// 系统流水编码
	private String rdName;		// 收发名称
	private String billsortCode;		// 单据类型编码
	private String billsortName;		// 单据类型名称
	private String isIn;		// 是否入库
	private String isOut;		// 是否出库
	private String isConsign;		// 是否代销
	private Long orderCode;		// 排序码
	private String memo;		// 备注
	private String flag;
	
	public Rdstyle() {
		super();
	}

	public Rdstyle(String rdCode){
		super();
		this.rdCode = rdCode;
	}

	@Id
	public String getRdCode() {
		return rdCode;
	}

	public void setRdCode(String rdCode) {
		this.rdCode = rdCode;
	}
	
	@Length(min=1, max=50, message="收发名称长度必须介于 1 和 50 之间")
	public String getRdName() {
		return rdName;
	}

	public void setRdName(String rdName) {
		this.rdName = rdName;
	}
	
	@Length(min=1, max=64, message="单据类型编码长度必须介于 1 和 64 之间")
	public String getBillsortCode() {
		return billsortCode;
	}

	public void setBillsortCode(String billsortCode) {
		this.billsortCode = billsortCode;
	}
	
	@Length(min=1, max=50, message="单据类型名称长度必须介于 1 和 50 之间")
	public String getBillsortName() {
		return billsortName;
	}

	public void setBillsortName(String billsortName) {
		this.billsortName = billsortName;
	}
	
	@Length(min=1, max=1, message="是否入库长度必须是 1个字符")
	public String getIsIn() {
		return isIn;
	}

	public void setIsIn(String isIn) {
		this.isIn = isIn;
	}
	
	@Length(min=1, max=1, message="是否出库长度必须是 1个字符")
	public String getIsOut() {
		return isOut;
	}

	public void setIsOut(String isOut) {
		this.isOut = isOut;
	}
	
	@Length(min=1, max=1, message="是否代销长度必须是 1个字符")
	public String getIsConsign() {
		return isConsign;
	}

	public void setIsConsign(String isConsign) {
		this.isConsign = isConsign;
	}
	
	public Long getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(Long orderCode) {
		this.orderCode = orderCode;
	}
	
	@Length(min=0, max=500, message="备注长度不能大于 500 个字符")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	
}