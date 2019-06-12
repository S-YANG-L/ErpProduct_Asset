/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsput.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.utils.excel.annotation.ExcelField;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 资产入库Entity
 * @author zhaohongbin
 * @version 2018-09-11
 */
public class AssetSum extends DataEntity<AssetSum> {

	private static final long serialVersionUID = 1L;
	private String assetCode;		// 资产编码
	private String assetName;		// 资产名称
	private String sortCode;		// 资产分类编码
	private String sortName;		// 资产分类名称
	private String brand;		// 品牌
	private String version;		// 型号
	private Double unitPrice;		// 单价
	private String unit;		// 计量单位
	private String snCode;		// SN号
    private String barCode;		// 条形码生成地址
    private String qrCode;		// 二维码生成地址
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 使用部门编码
	private String officeName;		// 使用部门
	private Date buyDate;		// 购入日期
    private String buyDateString;		// 购入日期
	private Date useDate;		// 领用（配置）日期
	private User user;		// 使用人编码
	private String userName;		// 使用人名称
	private String regionCode;		// 区域编码
	private String regionName;		// 区域名称
	private String dutyCode;		// 责任人编码
	private String dutyName;		// 责任人名称
	private String storagePlace;		// 存放地点
    private String storagePlaceCode;  //存放地点编码
	private String supplier;		// 供货商
	private String occupancy;		// 占用性质
	private String picturePath;		// 图片路径
	private Integer ageLimit;		// 使用期限
	private Date clearDate;		// 清理时间
	private String assetStatus;		// 资产状态
	private String accountStatus;		// 折旧状态
	private String notes;		// 备注
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String extendS3;		// 扩展3
    private String[] assetCodes;		// 借用，领用表格中已有的数据
	private Date beginDate;//开始日期
	private Date endDate;//结束日期
	public AssetSum() {
		super();
}

	public AssetSum(String id){
		super();
		this.id = id;
	}
    public String getStoragePlaceCode() {
        return storagePlaceCode;
    }

    public void setStoragePlaceCode(String storagePlaceCode) {
        this.storagePlaceCode = storagePlaceCode;
    }
    @ExcelField(
            title = "资产名称编码",
            align = 1,
            sort = 1
    )
    @Length(min=0, max=64, message="资产名称编码长度不能超过 64 个字符")
	public String getAssetCode() {
		return assetCode;
	}

	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}

    @ExcelField(
            title = "资产名称",
            align = 1,
            sort = 2
    )
	@NotBlank(message="资产名称不能为空")
	@Length(min=0, max=100, message="资产名称长度不能超过 100 个字符")
	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	@Length(min=0, max=64, message="资产分类编码长度不能超过 64 个字符")
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}

    @ExcelField(
            title = "资产小类",
            align = 1,
            sort = 3
    )
	@NotBlank(message="资产分类名称不能为空")
	@Length(min=0, max=100, message="资产分类名称长度不能超过 100 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

    @ExcelField(
            title = "品牌",
            align = 1,
            sort = 4
    )
	@Length(min=0, max=100, message="品牌长度不能超过 100 个字符")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
    @ExcelField(
            title = "型号",
            align = 1,
            sort = 5
    )
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

    @ExcelField(
            title = "SN号",
            align = 1,
            sort = 6
    )
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
	@NotBlank(message="公司名称不能为空")
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


	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="购入日期不能为空")
	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}
    public String getBuyDateString() {
        return buyDateString;
    }

    public void setBuyDateString(String buyDateString) {
        this.buyDateString = buyDateString;
    }

	@JsonFormat(pattern = "yyyy-MM-dd")
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

    @ExcelField(
            title = "区域名称",
            align = 1,
            sort = 7
    )
	@NotBlank(message="区域名称不能为空")
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
	
	@Length(min=0, max=64, message="存放地点长度不能超过 64 个字符")
	public String getStoragePlace() {
		return storagePlace;
	}

	public void setStoragePlace(String storagePlace) {
		this.storagePlace = storagePlace;
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
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getClearDate() {
		return clearDate;
	}

	public void setClearDate(Date clearDate) {
		this.clearDate = clearDate;
	}
	
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

    public String[] getAssetCodes() {
        return assetCodes;
    }

    public void setAssetCodes(String[] assetCodes) {
        this.assetCodes = assetCodes;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
    }

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
}