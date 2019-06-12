/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclassify.entity;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;

import cn.net.ecode.common.persistence.TreeEntity;

/**
 * assetsortEntity
 * @author tiantongwang
 * @version 2018-09-11
 */
public class AssetSort extends TreeEntity<AssetSort> {
	
	private static final long serialVersionUID = 1L;
	private String sortCode;		// 分类编码
	private String sortName;		// 分类名称
	private Integer sortGrade;		// 分类级别
	private Integer ageLimit;		// 使用年限
	private Double netsalvageRate;		// 净残值率
	private String assetUnit;		// 计量单位
	private String memo;		// 备注


	public AssetSort() {
		super();
	}

	public AssetSort(String id){
		super();
		this.id = id;
	}

	public AssetSort(AssetSort parent){
		this.parent = parent;
	}
		


	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
		
	@NotBlank(message="分类名称不能为空")
	@Length(min=0, max=100, message="分类名称长度不能超过 100 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
		
	@JsonBackReference
	@NotNull(message="上级编码不能为空")
	public AssetSort getParent() {
		return parent;
	}
	public void setParent(AssetSort parent) {
		this.parent = parent;
	}

	public Integer getSortGrade() {
		return sortGrade;
	}
	public void setSortGrade(Integer sortGrade) {
		this.sortGrade = sortGrade;
	}
		

		

	public Integer getAgeLimit() {
		return ageLimit;
	}

	public void setAgeLimit(Integer ageLimit) {
		this.ageLimit = ageLimit;
	}
		

	public Double getNetsalvageRate() {
		return netsalvageRate;
	}

	public void setNetsalvageRate(Double netsalvageRate) {
		this.netsalvageRate = netsalvageRate;
	}

	@Length(min=0, max=20, message="计量单位长度不能超过 20 个字符")
	public String getAssetUnit() {
		return assetUnit;
	}
	public void setAssetUnit(String assetUnit) {
		this.assetUnit = assetUnit;
	}

	@Length(min=0, max=1024, message="备注长度不能超过 1024 个字符")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String toString() {
		return id;
	}
}