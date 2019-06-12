/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclean.entity;

import cn.net.ecode.common.utils.excel.annotation.ExcelField;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 资产清理Entity
 * @author sww
 * @version 2018-10-11
 */
public class AssetClean extends DataEntity<AssetClean> {
	
	private static final long serialVersionUID = 1L;
	private String cleanCode;		// 清理编码
	private String cleanerCode;		// 清理人编码
	private String cleanerName;		// 清理人
	private Date cleanDate;		// 清理日期
	private Date beginDate;//开始日期
	private Date endDate;//结束日期
	private String cleanStatus;		// 状态0报废1闲置
	private String notes;		// 说明
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String extendS3;		// 扩展3
	private List<AssetCleanDtl> assetCleanDtlList = Lists.newArrayList();		// 子表列表
	private String  companyCode ;//公司编码
	private String   officeCode;//公司名称
	private String   officeName;//部门名称
	private String   sortName;//类别名称
	private String   countxz;//资产闲置
	private String   countly;//资产领用
	private String   countjy;//资产借用
	private String   countbf;//资产报废
	private String   hj;//合计
	private String   je;//金额
	private String topSortCode;//资产大类编码
	private String topSortName;//资产大类名称
	private String countdb;//资产调拨
	private String countjx;//资产捐献
	private String countdw;//调拨到新单位

	public AssetClean() {
		super();
	}

	public AssetClean(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="清理编码长度不能超过 64 个字符")
	public String getCleanCode() {
		return cleanCode;
	}

	public void setCleanCode(String cleanCode) {
		this.cleanCode = cleanCode;
	}
	
	@Length(min=0, max=64, message="清理人编码长度不能超过 64 个字符")
	public String getCleanerCode() {
		return cleanerCode;
	}

	public void setCleanerCode(String cleanerCode) {
		this.cleanerCode = cleanerCode;
	}
	@Length(min=0, max=100, message="清理人长度不能超过 100 个字符")
	public String getCleanerName() {
		return cleanerName;
	}

	public void setCleanerName(String cleanerName) {
		this.cleanerName = cleanerName;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getCleanDate() {
		return cleanDate;
	}

	public void setCleanDate(Date cleanDate) {
		this.cleanDate = cleanDate;
	}
	
	@Length(min=0, max=1, message="状态0报废1闲置长度不能超过 1 个字符")
	public String getCleanStatus() {
		return cleanStatus;
	}

	public void setCleanStatus(String cleanStatus) {
		this.cleanStatus = cleanStatus;
	}
	
	@Length(min=0, max=100, message="说明长度不能超过 100 个字符")
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
	
	public List<AssetCleanDtl> getAssetCleanDtlList() {
		return assetCleanDtlList;
	}

	public void setAssetCleanDtlList(List<AssetCleanDtl> assetCleanDtlList) {
		this.assetCleanDtlList = assetCleanDtlList;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getOfficeCode() {
		return officeCode;
	}

	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	@ExcelField(title = "资产闲置数量",align = 1,sort = 3)
	public String getCountxz() {
		return countxz;
	}

	public void setCountxz(String countxz) {
		this.countxz = countxz;
	}
	@ExcelField(title = "资产领用数量",align = 1,sort = 4)
	public String getCountly() {
		return countly;
	}

	public void setCountly(String countly) {
		this.countly = countly;
	}
	public String getCountjy() {
		return countjy;
	}

	public void setCountjy(String countjy) {
		this.countjy = countjy;
	}
	@ExcelField(title = "资产报废数量",align = 1,sort = 6)
	public String getCountbf() {
		return countbf;
	}

	public void setCountbf(String countbf) {
		this.countbf = countbf;
	}
	@ExcelField(title = "资产数量合计",align = 1,sort = 9)
	public String getHj() {
		return hj;
	}

	public void setHj(String hj) {
		this.hj = hj;
	}
	@ExcelField(title = "资产金额合计",align = 1,sort = 10)
	public String getJe() {
		return je;
	}

	public void setJe(String je) {
		this.je = je;
	}

	public String getTopSortCode() {
		return topSortCode;
	}

	public void setTopSortCode(String topSortCode) {
		this.topSortCode = topSortCode;
	}
	@ExcelField(title = "资产大类名称",align = 1,sort = 2)
	public String getTopSortName() {
		return topSortName;
	}

	public void setTopSortName(String topSortName) {
		this.topSortName = topSortName;
	}
	@ExcelField(title = "资产调拨中",align = 1,sort = 5)
	public String getCountdb() {
		return countdb;
	}

	public void setCountdb(String countdb) {
		this.countdb = countdb;
	}
	@ExcelField(title = "资产捐献数量",align = 1,sort = 7)
	public String getCountjx() {
		return countjx;
	}

	public void setCountjx(String countjx) {
		this.countjx = countjx;
	}
	@ExcelField(title = "调拨到新单位数量",align = 1,sort = 8)
	public String getCountdw() {
		return countdw;
	}

	public void setCountdw(String countdw) {
		this.countdw = countdw;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
}