/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetdepre.entity;

import org.hibernate.validator.constraints.Length;
import cn.net.ecode.modules.sys.entity.Office;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import cn.net.ecode.modules.sys.entity.User;
import org.hibernate.validator.constraints.NotBlank;

import cn.net.ecode.common.persistence.DataEntity;

import javax.validation.constraints.NotNull;

/**
 * 计提折旧Entity
 * @author zhaohongbin
 * @version 2018-11-07
 */
public class AssetDepreDtl extends DataEntity<AssetDepreDtl> {
	
	private static final long serialVersionUID = 1L;
    private String depreCode;		// 关联键
	private String financeCode;		// 财务编码
	private String assetCode;		// 资产编码
	private String assetName;		// 资产名称
	private String topSortCode;		// 资产大分类编码
	private String topSortName;		// 资产大分类编码
	private String sortCode;		// 资产小分类编码
	private String sortName;		// 资产小分类名称
	private String brand;		// 品牌
	private String barCode;		// 条形码生成地址
	private String qrCode;		// 二维码生成地址
	private String version;		// 型号
	private Double unitPrice;		// 单价
	private String unit;		// 计量单位
	private String snCode;		// SN号
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 使用部门编码
	private String officeName;		// 使用部门
	private Date buyDate;		// 购入日期
	private Date useDate;		// 领用（配置）日期
	private User user;		// 使用人编码
	private String userName;		// 使用人名称
	private String regionCode;		// 区域编码
	private String regionName;		// 区域名称
	private String dutyCode;		// 责任人编码
	private String dutyName;		// 责任人名称
	private String dutyOfficeCode;		// 责任部门编码
	private String dutyOfficeName;		// 责任部门名称
	private Double residualValue;		// 净残值率
	private String storagePlaceCode;		// 存放地点编码
	private String storagePlace;		// 存放地点
	private String supplierCode;		// 供货商编码
	private String supplier;		// 供货商
	private String occupancy;		// 占用性质
	private String picturePath;		// 图片路径
	private Integer ageLimit;		// 使用期限
	private Double quantity;		// 数量
	private Date clearDate;		// 清理时间
    private Long currYear;		// 当前年
    private Long currMonth;		// 当前月
	private String assetStatus;		// 资产状态
	private String accountStatus;		// 折旧状态
	private String submitStatus;		// 提交状态  0未提交 1已提交
    private Integer accountQuantity;  //折旧月份
    private String accountComStatus; //折旧是否完成
    private Double accountThisMonth;  //本月折旧
    private Double addAccount; //累计折旧
    private Double netSalvage;  //净残值
    private Double netPrice;  //净值
	private String notes;		// 备注
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String extendS3;		// 扩展3
	
	public AssetDepreDtl() {
		super();
	}

	public AssetDepreDtl(String id){
		super();
		this.id = id;
	}

    public String getDepreCode() {
        return depreCode;
    }

    public void setDepreCode(String depreCode) {
        this.depreCode = depreCode;
    }

    @Length(min=0, max=64, message="财务编码长度不能超过 64 个字符")
	public String getFinanceCode() {
		return financeCode;
	}

	public void setFinanceCode(String financeCode) {
		this.financeCode = financeCode;
	}
	
	@Length(min=0, max=64, message="资产编码长度不能超过 64 个字符")
	public String getAssetCode() {
		return assetCode;
	}

	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	
	@Length(min=0, max=100, message="资产名称长度不能超过 100 个字符")
	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	
	@Length(min=0, max=64, message="资产大分类编码长度不能超过 64 个字符")
	public String getTopSortCode() {
		return topSortCode;
	}

	public void setTopSortCode(String topSortCode) {
		this.topSortCode = topSortCode;
	}
	
	@Length(min=0, max=100, message="资产大分类编码长度不能超过 100 个字符")
	public String getTopSortName() {
		return topSortName;
	}

	public void setTopSortName(String topSortName) {
		this.topSortName = topSortName;
	}
	
	@Length(min=0, max=64, message="资产小分类编码长度不能超过 64 个字符")
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
	
	@Length(min=0, max=100, message="资产小分类名称长度不能超过 100 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	
	@Length(min=0, max=100, message="品牌长度不能超过 100 个字符")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	@Length(min=0, max=225, message="条形码生成地址长度不能超过 225 个字符")
	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}
	
	@Length(min=0, max=225, message="二维码生成地址长度不能超过 225 个字符")
	public String getQrCode() {
		return qrCode;
	}

	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}
	
	@Length(min=0, max=64, message="型号长度不能超过 64 个字符")
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	@Length(min=0, max=64, message="计量单位长度不能超过 64 个字符")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=64, message="SN号长度不能超过 64 个字符")
	public String getSnCode() {
		return snCode;
	}

	public void setSnCode(String snCode) {
		this.snCode = snCode;
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
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUseDate() {
		return useDate;
	}

	public void setUseDate(Date useDate) {
		this.useDate = useDate;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=64, message="使用人名称长度不能超过 64 个字符")
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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
	
	@Length(min=0, max=64, message="责任人名称长度不能超过 64 个字符")
	public String getDutyName() {
		return dutyName;
	}

	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}
	
	@Length(min=0, max=64, message="责任部门编码长度不能超过 64 个字符")
	public String getDutyOfficeCode() {
		return dutyOfficeCode;
	}

	public void setDutyOfficeCode(String dutyOfficeCode) {
		this.dutyOfficeCode = dutyOfficeCode;
	}
	
	@Length(min=0, max=100, message="责任部门名称长度不能超过 100 个字符")
	public String getDutyOfficeName() {
		return dutyOfficeName;
	}

	public void setDutyOfficeName(String dutyOfficeName) {
		this.dutyOfficeName = dutyOfficeName;
	}
	
	public Double getResidualValue() {
		return residualValue;
	}

	public void setResidualValue(Double residualValue) {
		this.residualValue = residualValue;
	}
	
	@Length(min=0, max=64, message="存放地点编码长度不能超过 64 个字符")
	public String getStoragePlaceCode() {
		return storagePlaceCode;
	}

	public void setStoragePlaceCode(String storagePlaceCode) {
		this.storagePlaceCode = storagePlaceCode;
	}
	
	@Length(min=0, max=100, message="存放地点长度不能超过 100 个字符")
	public String getStoragePlace() {
		return storagePlace;
	}

	public void setStoragePlace(String storagePlace) {
		this.storagePlace = storagePlace;
	}
	
	@Length(min=0, max=64, message="供货商编码长度不能超过 64 个字符")
	public String getSupplierCode() {
		return supplierCode;
	}

	public void setSupplierCode(String supplierCode) {
		this.supplierCode = supplierCode;
	}
	
	@Length(min=0, max=100, message="供货商长度不能超过 100 个字符")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=0, max=100, message="占用性质长度不能超过 100 个字符")
	public String getOccupancy() {
		return occupancy;
	}

	public void setOccupancy(String occupancy) {
		this.occupancy = occupancy;
	}
	
	@Length(min=0, max=100, message="图片路径长度不能超过 100 个字符")
	public String getPicturePath() {
		return picturePath;
	}

	public void setPicturePath(String picturePath) {
		this.picturePath = picturePath;
	}
	
	public Integer getAgeLimit() {
		return ageLimit;
	}

	public void setAgeLimit(Integer ageLimit) {
		this.ageLimit = ageLimit;
	}
	
	public Double getQuantity() {
		return quantity;
	}

	public void setQuantity(Double quantity) {
		this.quantity = quantity;
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
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getClearDate() {
		return clearDate;
	}

	public void setClearDate(Date clearDate) {
		this.clearDate = clearDate;
	}
	
	@NotBlank(message="资产状态不能为空")
	@Length(min=0, max=1, message="资产状态长度不能超过 1 个字符")
	public String getAssetStatus() {
		return assetStatus;
	}

	public void setAssetStatus(String assetStatus) {
		this.assetStatus = assetStatus;
	}
	
	@Length(min=0, max=1, message="折旧状态长度不能超过 1 个字符")
	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}
	
	@Length(min=0, max=1, message="提交状态  0未提交 1已提交长度不能超过 1 个字符")
	public String getSubmitStatus() {
		return submitStatus;
	}

	public void setSubmitStatus(String submitStatus) {
		this.submitStatus = submitStatus;
	}
	
	@Length(min=0, max=100, message="备注长度不能超过 100 个字符")
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}
	
	@Length(min=0, max=100, message="扩展1长度不能超过 100 个字符")
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
	
	@Length(min=0, max=100, message="扩展3长度不能超过 100 个字符")
	public String getExtendS3() {
		return extendS3;
	}

	public void setExtendS3(String extendS3) {
		this.extendS3 = extendS3;
	}

    public Integer getAccountQuantity() {
        return accountQuantity;
    }

    public void setAccountQuantity(Integer accountQuantity) {
        this.accountQuantity = accountQuantity;
    }

    public String getAccountComStatus() {
        return accountComStatus;
    }

    public void setAccountComStatus(String accountComStatus) {
        this.accountComStatus = accountComStatus;
    }

    public Double getNetPrice() {
        return netPrice;
    }

    public void setNetPrice(Double netPrice) {
        this.netPrice = netPrice;
    }

    public Double getAccountThisMonth() {
        return accountThisMonth;
    }

    public void setAccountThisMonth(Double accountThisMonth) {
        this.accountThisMonth = accountThisMonth;
    }

    public Double getAddAccount() {
        return addAccount;
    }

    public void setAddAccount(Double addAccount) {
        this.addAccount = addAccount;
    }

    public Double getNetSalvage() {
        return netSalvage;
    }

    public void setNetSalvage(Double netSalvage) {
        this.netSalvage = netSalvage;
    }
}