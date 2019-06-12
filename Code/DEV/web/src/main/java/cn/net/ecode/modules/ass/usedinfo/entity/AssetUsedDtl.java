/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.entity;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 资产领用子表Entity
 * @author zhaohongbin
 * @version 2018-09-20
 */
public class AssetUsedDtl extends DataEntity<AssetUsedDtl> {
	
	private static final long serialVersionUID = 1L;
	private String usedCode;		// 领用编码
	private String assetCode;		// 资产编码
    private String assetCodes[]; //资产编码数组
	private String assetName;		// 资产名称
	private String sortCode;		// 资产分类编码
	private String sortName;		// 资产分类名称
	private String brand;		// 品牌
	private String version;		// 型号
	private String storagePlace;		// 存放地点
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 使用部门编码
	private String officeName;		// 使用部门
	private User user;		// 使用人编码
	private String userName;		// 使用人名称
	private String returnStatus;		// 退库状态
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String extendS3;		// 扩展3
	
	public AssetUsedDtl() {
		super();
	}

	public AssetUsedDtl(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="领用编码长度不能超过 64 个字符")
	public String getUsedCode() {
		return usedCode;
	}

	public void setUsedCode(String usedCode) {
		this.usedCode = usedCode;
	}
	
	@NotBlank(message="资产编码不能为空")
	@Length(min=0, max=64, message="资产编码长度不能超过 64 个字符")
	public String getAssetCode() {
		return assetCode;
	}

	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	
	@NotBlank(message="资产名称不能为空")
	@Length(min=0, max=100, message="资产名称长度不能超过 100 个字符")
	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	
	@NotBlank(message="资产分类编码不能为空")
	@Length(min=0, max=64, message="资产分类编码长度不能超过 64 个字符")
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
	
	@NotBlank(message="资产分类名称不能为空")
	@Length(min=0, max=100, message="资产分类名称长度不能超过 100 个字符")
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
	
	@Length(min=0, max=100, message="型号长度不能超过 100 个字符")
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	@Length(min=0, max=100, message="存放地点长度不能超过 100 个字符")
	public String getStoragePlace() {
		return storagePlace;
	}

	public void setStoragePlace(String storagePlace) {
		this.storagePlace = storagePlace;
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
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=100, message="使用人名称长度不能超过 100 个字符")
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

    @Length(min=0, max=1, message="退库状态长度不能超过 1 个字符")
    public String getReturnStatus() {
        return returnStatus;
    }

    public void setReturnStatus(String returnStatus) {
        this.returnStatus = returnStatus;
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
}