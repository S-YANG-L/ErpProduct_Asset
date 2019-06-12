/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.changeinfo.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;
import cn.net.ecode.modules.sys.entity.Office;
import java.util.Date;
import java.util.List;
import com.google.common.collect.Lists;
import cn.net.ecode.common.persistence.DataEntity;
import javax.validation.constraints.NotNull;


/**
 * 实物信息变更Entity
 * @author zhao
 * @version 2018-10-09
 */
public class AssetChangeInfo extends DataEntity<AssetChangeInfo> {
	
	private static final long serialVersionUID = 1L;
    private String changeCode;		// 实物信息变更编码
	private String topSortCode;        // 资产大类编码
	private String topSortName;        // 资产大类
	private String sortCode;        // 资产小类编码
	private String sortName;        // 资产大类
	private String assetName;        // 资产大类
	private String brand;        // 品牌
	private String version;        // 型号
	private String unit;        // 计量单位
	private String supplierCode;  //供货商编码
	private String supplier;        // 供货商
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 使用部门编码
	private String officeName;		// 使用部门
	private String moneyCode;       // 财务编码
    private String operatorCode;		// 操作人编码
    private String operatorName;		// 操作人名称
    private Date changeDate;		// 操作时间
	private String regionCode;		// 区域编码
	private String regionName;		// 区域名称
	private String dutyCode;		// 责任人编码
	private String dutyName;		// 责任人名称
	private String storagePlace;		// 存放地点
	private String storagePlaceCode;		// 存放地点编码
	private Integer ageLimit;		// 使用期限
	private String picturePath;		// 存放地点编码
	private List<AssetChangeDtl> assetChangeDtlList = Lists.newArrayList();		// 子表列表
	
	private Date beginDate;			//开始日期
	private Date endDate;			//结束日期
	
	public AssetChangeInfo() {
		super();
	}

	public AssetChangeInfo(String id){
		super();
		this.id = id;
	}
    @Length(min=0, max=64, message="实物信息变更编码长度不能超过 64 个字符")
    public String getChangeCode() {
        return changeCode;
    }

    public void setChangeCode(String changeCode) {
        this.changeCode = changeCode;
    }

    @Length(min=0, max=64, message="公司编码长度不能超过 64 个字符")
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
	
	@Length(min=0, max=100, message="使用部门长度不能超过 100 个字符")
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	
	

	public String getMoneyCode() {
		return moneyCode;
	}

	public void setMoneyCode(String moneyCode) {
		this.moneyCode = moneyCode;
	}

	@Length(min=0, max=64, message="区域编码长度不能超过 64 个字符")
	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	
	@Length(min=0, max=100, message="区域名称长度不能超过 100 个字符")
	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	
	@Length(min=0, max=64, message="责任人编码长度不能超过 64 个字符")
	public String getDutyCode() {
		return dutyCode;
	}

	public void setDutyCode(String dutyCode) {
		this.dutyCode = dutyCode;
	}
	
	@Length(min=0, max=100, message="责任人名称长度不能超过 100 个字符")
	public String getDutyName() {
		return dutyName;
	}

	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}
	
	@Length(min=0, max=100, message="存放地点长度不能超过 100 个字符")
	public String getStoragePlace() {
		return storagePlace;
	}

	public void setStoragePlace(String storagePlace) {
		this.storagePlace = storagePlace;
	}
	
	@Length(min=0, max=64, message="存放地点编码长度不能超过 64 个字符")
	public String getStoragePlaceCode() {
		return storagePlaceCode;
	}

	public void setStoragePlaceCode(String storagePlaceCode) {
		this.storagePlaceCode = storagePlaceCode;
	}
	
	public Integer getAgeLimit() {
		return ageLimit;
	}

	public void setAgeLimit(Integer ageLimit) {
		this.ageLimit = ageLimit;
	}
	
	public List<AssetChangeDtl> getAssetChangeDtlList() {
		return assetChangeDtlList;
	}

	public void setAssetChangeDtlList(List<AssetChangeDtl> assetChangeDtlList) {
		this.assetChangeDtlList = assetChangeDtlList;
	}
    @Length(min=0, max=64, message="操作人编码长度不能超过 64 个字符")
    public String getOperatorCode() {
        return operatorCode;
    }

    public void setOperatorCode(String operatorCode) {
        this.operatorCode = operatorCode;
    }
    @Length(min=0, max=64, message="操作人名称长度不能超过 100 个字符")
    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @NotNull(message="变更日期不能为空")
    public Date getChangeDate() {
        return changeDate;
    }

    public void setChangeDate(Date changeDate) {
        this.changeDate = changeDate;
    }

	public Date getBeginDate() {
		return beginDate;
	}
	@JsonFormat(pattern="yyyy-MM-dd") 
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	@JsonFormat(pattern="yyyy-MM-dd") 
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getPicturePath() {
		return picturePath;
	}

	public void setPicturePath(String picturePath) {
		this.picturePath = picturePath;
	}

	public String getTopSortCode() {
		return topSortCode;
	}

	public void setTopSortCode(String topSortCode) {
		this.topSortCode = topSortCode;
	}

	public String getTopSortName() {
		return topSortName;
	}

	public void setTopSortName(String topSortName) {
		this.topSortName = topSortName;
	}

	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}

	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getSupplierCode() {
		return supplierCode;
	}

	public void setSupplierCode(String supplierCode) {
		this.supplierCode = supplierCode;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
}