/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.warehouse.entity;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 仓库管理Entity
 * @author sun
 * @version 2018-09-18
 */
public class WarehouseInfo extends DataEntity<WarehouseInfo> {
	
	private static final long serialVersionUID = 1L;
	private String warehouseCode;		// 仓库编码
	private String warehouseName;		// 仓库名称
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public WarehouseInfo() {
		super();
	}

	public WarehouseInfo(String id){
		super();
		this.id = id;
	}

	
	@NotBlank(message="仓库编码不能为空")
	@Length(min=0, max=64, message="仓库编码长度不能超过 64 个字符")
	public String getWarehouseCode() {
		return warehouseCode;
	}

	public void setWarehouseCode(String warehouseCode) {
		this.warehouseCode = warehouseCode;
	}
	
	
	@NotBlank(message="仓库名称不能为空")
	@Length(min=0, max=200, message="仓库名称长度不能超过 200 个字符")
	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}
	
	
	@Length(min=0, max=200, message="扩展1长度不能超过 200 个字符")
	public String getExtendS1() {
		return extendS1;
	}

	public void setExtendS1(String extendS1) {
		this.extendS1 = extendS1;
	}
	
	@Length(min=0, max=100, message="扩展2长度不能超过 100 个字符")
	public String getExtendS2() {
		return extendS2;
	}

	public void setExtendS2(String extendS2) {
		this.extendS2 = extendS2;
	}
	
}