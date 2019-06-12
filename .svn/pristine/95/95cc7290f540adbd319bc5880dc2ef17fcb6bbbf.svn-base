/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetdepre.entity;

import cn.net.ecode.common.persistence.annotation.Id;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 计提折旧Entity
 * @author zhaohongbin
 * @version 2018-11-07
 */
public class AssetDepre extends DataEntity<AssetDepre> {
	
	private static final long serialVersionUID = 1L;
	private String sysId;		// 系统编号
	private String topSortCode;		// 资产大类编码
	private String topSortName;		// 资产大类
	private String sortCode;		// 资产小类编码
	private String sortName;		// 资产小类
	private String companyCode;		// 公司ID
	private String companyName;		// 公司名称
	private String deptCode;		// 部门核算编码
	private String deptName;		// 部门核算名称
	private Long currYear;		// 当前年
	private Long currMonth;		// 当前月
	private String assetCode;		// 系统编号
	private String assetName;		// 资产名称
	private Integer accrueMonth;		// 已计提月份
	private Double originalValue;		// 原值
	private Double netsalvageRate;		// 净残率
	private Double netsalvageValue;		// 净残值
	private Double depreTotal;		// 累计折旧额
	private Double mdepreRate;		// 月折旧率
	private Double mdepreValue;		// 月折旧额
	private Double netValue;		// 净值
	private Double workAmount;		// 工作总量
	private Double workTotal;		// 累计工作量
	private String workUnit;		// 工作量单位
	private Date beginDate;		// 开始使用时间
	private String sysCode;		// 单号
	private String assetType;		// 计提类型(0未提计，1已提计)
	private List<AssetDepreDtl> assetDepreDtlList = Lists.newArrayList();		// 子表列表
	
	public AssetDepre() {
		super();
	}

	public AssetDepre(String sysId){
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
	
	@Length(min=0, max=64, message="资产大类编码长度不能超过 64 个字符")
	public String getTopSortCode() {
		return topSortCode;
	}

	public void setTopSortCode(String topSortCode) {
		this.topSortCode = topSortCode;
	}
	
	@Length(min=0, max=100, message="资产大类长度不能超过 100 个字符")
	public String getTopSortName() {
		return topSortName;
	}

	public void setTopSortName(String topSortName) {
		this.topSortName = topSortName;
	}
	
	@Length(min=0, max=64, message="资产小类编码长度不能超过 64 个字符")
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
	
	@Length(min=0, max=100, message="资产小类长度不能超过 100 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	
	@NotBlank(message="公司ID不能为空")
	@Length(min=0, max=20, message="公司ID长度不能超过 20 个字符")
	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	
	@NotBlank(message="公司名称不能为空")
	@Length(min=0, max=50, message="公司名称长度不能超过 50 个字符")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	@Length(min=0, max=20, message="部门核算编码长度不能超过 20 个字符")
	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	
	@Length(min=0, max=50, message="部门核算名称长度不能超过 50 个字符")
	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	@NotNull(message="当前年不能为空")
	public Long getCurrYear() {
		return currYear;
	}

	public void setCurrYear(Long currYear) {
		this.currYear = currYear;
	}
	
	@NotNull(message="当前月不能为空")
	public Long getCurrMonth() {
		return currMonth;
	}

	public void setCurrMonth(Long currMonth) {
		this.currMonth = currMonth;
	}
	
	@NotBlank(message="系统编号不能为空")
	@Length(min=0, max=64, message="系统编号长度不能超过 64 个字符")
	public String getAssetCode() {
		return assetCode;
	}

	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	
	@NotBlank(message="资产名称不能为空")
	@Length(min=0, max=20, message="资产名称长度不能超过 20 个字符")
	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	
	@NotNull(message="已计提月份不能为空")
	public Integer getAccrueMonth() {
		return accrueMonth;
	}

	public void setAccrueMonth(Integer accrueMonth) {
		this.accrueMonth = accrueMonth;
	}
	
	@NotNull(message="原值不能为空")
	public Double getOriginalValue() {
		return originalValue;
	}

	public void setOriginalValue(Double originalValue) {
		this.originalValue = originalValue;
	}
	
	@NotNull(message="净残率不能为空")
	public Double getNetsalvageRate() {
		return netsalvageRate;
	}

	public void setNetsalvageRate(Double netsalvageRate) {
		this.netsalvageRate = netsalvageRate;
	}
	
	@NotNull(message="净残值不能为空")
	public Double getNetsalvageValue() {
		return netsalvageValue;
	}

	public void setNetsalvageValue(Double netsalvageValue) {
		this.netsalvageValue = netsalvageValue;
	}
	
	@NotNull(message="累计折旧额不能为空")
	public Double getDepreTotal() {
		return depreTotal;
	}

	public void setDepreTotal(Double depreTotal) {
		this.depreTotal = depreTotal;
	}
	
	@NotNull(message="月折旧率不能为空")
	public Double getMdepreRate() {
		return mdepreRate;
	}

	public void setMdepreRate(Double mdepreRate) {
		this.mdepreRate = mdepreRate;
	}
	
	@NotNull(message="月折旧额不能为空")
	public Double getMdepreValue() {
		return mdepreValue;
	}

	public void setMdepreValue(Double mdepreValue) {
		this.mdepreValue = mdepreValue;
	}
	
	@NotNull(message="净值不能为空")
	public Double getNetValue() {
		return netValue;
	}

	public void setNetValue(Double netValue) {
		this.netValue = netValue;
	}
	
	public Double getWorkAmount() {
		return workAmount;
	}

	public void setWorkAmount(Double workAmount) {
		this.workAmount = workAmount;
	}
	
	public Double getWorkTotal() {
		return workTotal;
	}

	public void setWorkTotal(Double workTotal) {
		this.workTotal = workTotal;
	}
	
	@Length(min=0, max=50, message="工作量单位长度不能超过 50 个字符")
	public String getWorkUnit() {
		return workUnit;
	}

	public void setWorkUnit(String workUnit) {
		this.workUnit = workUnit;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	
	@Length(min=0, max=20, message="单号长度不能超过 20 个字符")
	public String getSysCode() {
		return sysCode;
	}

	public void setSysCode(String sysCode) {
		this.sysCode = sysCode;
	}
	
	@NotBlank(message="计提类型(1为资产，2为摊销)不能为空")
	@Length(min=0, max=1, message="计提类型(1为资产，2为摊销)长度不能超过 1 个字符")
	public String getAssetType() {
		return assetType;
	}

	public void setAssetType(String assetType) {
		this.assetType = assetType;
	}
	
	public List<AssetDepreDtl> getAssetDepreDtlList() {
		return assetDepreDtlList;
	}

	public void setAssetDepreDtlList(List<AssetDepreDtl> assetDepreDtlList) {
		this.assetDepreDtlList = assetDepreDtlList;
	}
}