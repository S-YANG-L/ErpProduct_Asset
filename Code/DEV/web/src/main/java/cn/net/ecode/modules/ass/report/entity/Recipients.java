package cn.net.ecode.modules.ass.report.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.utils.excel.annotation.ExcelField;

/**
 * 耗材领用信息实体类
 * @author tiange
 * @version 2018-10-17
 */
public class Recipients extends DataEntity<Recipients> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String sortName;		//耗材分类
	private String articlesName;	//耗材名称
	private String sysId;			//领用单号
	private String officeName;		//部门
	private String officeCode;		//部门编码
	private Date createDate;		//领用日期
	private String createDateString;	//领用日期
	private String sumNumber;		//领用量
	private String sumMoney;		//金额
	private Date monthDate;			//转化成月的日期
	private String outboundCode;	//出库编码
	private String outbounderName;	//领用人名称
	private String price;			//领用单价
	private Date beginDate;			//开始日期
	private Date endDate;			//结束日期
	
	 @ExcelField(
	            title = "办公用品分类",
	            align = 1,
	            sort = 2
	    )
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	 @ExcelField(
	            title = "办公用品名称",
	            align = 1,
	            sort = 3
	    )
	public String getArticlesName() {
		return articlesName;
	}
	public void setArticlesName(String articlesName) {
		this.articlesName = articlesName;
	} 
	public String getSysId() {
		return sysId;
	}
	public void setSysId(String sysId) {
		this.sysId = sysId;
	}
	
	@JsonFormat(pattern="yyyy-MM-dd") 
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	 @ExcelField(
	            title = "领用数量",
	            align = 1,
	            sort = 6
	    )
	public String getSumNumber() {
		return sumNumber;
	}
	public void setSumNumber(String sumNumber) {
		this.sumNumber = sumNumber;
	}
	 @ExcelField(
	            title = "金额",
	            align = 1,
	            sort = 8
	    )
	public String getSumMoney() {
		return sumMoney;
	}
	public void setSumMoney(String sumMoney) {
		this.sumMoney = sumMoney;
	}
	@JsonFormat(pattern="yyyy-MM-dd") 
	public Date getBeginDate() {
		return beginDate;
	}
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
	@JsonFormat(pattern="yyyy-MM-dd")
	public Date getMonthDate() {
		return monthDate;
	}
	public void setMonthDate(Date monthDate) {
		this.monthDate = monthDate;
	}
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	public String getOfficeCode() {
		return officeCode;
	}
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	@ExcelField(
            title = "办公用品领用单号",
            align = 1,
            sort = 1
    )
	public String getOutboundCode() {
		return outboundCode;
	}
	public void setOutboundCode(String outboundCode) {
		this.outboundCode = outboundCode;
	}
	@ExcelField(
            title = "领用人",
            align = 1,
            sort = 5
    )
	public String getOutbounderName() {
		return outbounderName;
	}
	public void setOutbounderName(String outbounderName) {
		this.outbounderName = outbounderName;
	}
	 @ExcelField(
	            title = "办公用品领用日期",
	            align = 1,
	            sort = 4
	    )
	public String getCreateDateString() {
		return createDateString;
	}
	public void setCreateDateString(String createDateString) {
		this.createDateString = createDateString;
	}
	 @ExcelField(
	            title = "领用单价",
	            align = 1,
	            sort = 7
	    )
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
}
