/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetcheck.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import cn.net.ecode.modules.sys.entity.Office;
import java.util.List;
import com.google.common.collect.Lists;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 资产盘点Entity
 * @author zhaohongbin
 * @version 2018-10-20
 */
public class AssetCheck extends DataEntity<AssetCheck> {
	
	private static final long serialVersionUID = 1L;
	private String chackCode;		// 盘点编码
	private String chackName;		// 盘点单名称
	private String handleName;		// 发起人
	private String handleCode;		// 发起人编码
	private Date handleTime;		// 发起时间
	private Office office;		// 使用部门编码
	private String officeName;		// 使用部门名称
	private String sortCode;		// 资产分类编码
	private String sortName;		// 资产分类名称
	private String regionCode;		// 区域编码
	private String regionName;		// 区域名称
    private String submitStatus;        // 提交状态   0未提交  1已提交
	private List<AssetCheckDtl> assetCheckDtlList = Lists.newArrayList();		// 子表列表
    private Date beginDate;			//开始日期
    private Date endDate;			//结束日期
	public AssetCheck() {
		super();
	}

	public AssetCheck(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="盘点编码长度不能超过 64 个字符")
	public String getChackCode() {
		return chackCode;
	}

	public void setChackCode(String chackCode) {
		this.chackCode = chackCode;
	}
	
	@Length(min=0, max=255, message="盘点单名称长度不能超过 255 个字符")
	public String getChackName() {
		return chackName;
	}

	public void setChackName(String chackName) {
		this.chackName = chackName;
	}
	
	@Length(min=0, max=64, message="发起人长度不能超过 64 个字符")
	public String getHandleName() {
		return handleName;
	}

	public void setHandleName(String handleName) {
		this.handleName = handleName;
	}
	
	@Length(min=0, max=64, message="发起人编码长度不能超过 64 个字符")
	public String getHandleCode() {
		return handleCode;
	}

	public void setHandleCode(String handleCode) {
		this.handleCode = handleCode;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	public Date getHandleTime() {
		return handleTime;
	}

	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=0, max=255, message="使用部门名称长度不能超过 255 个字符")
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	@Length(min=0, max=64, message="资产分类编码长度不能超过 64 个字符")
	public String getSortCode() {
		return sortCode;
	}

	public void setSortCode(String sortCode) {
		this.sortCode = sortCode;
	}
	
	@Length(min=0, max=100, message="资产分类名称长度不能超过 100 个字符")
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
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
	
	public List<AssetCheckDtl> getAssetCheckDtlList() {
		return assetCheckDtlList;
	}

	public void setAssetCheckDtlList(List<AssetCheckDtl> assetCheckDtlList) {
		this.assetCheckDtlList = assetCheckDtlList;
	}

    public String getSubmitStatus() {
        return submitStatus;
    }

    public void setSubmitStatus(String submitStatus) {
        this.submitStatus = submitStatus;
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