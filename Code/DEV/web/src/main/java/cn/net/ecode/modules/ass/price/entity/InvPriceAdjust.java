/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.price.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;
import cn.net.ecode.common.utils.excel.annotation.ExcelField;
import cn.net.ecode.modules.sys.entity.Company;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 面价管理Entity
 * @author 陈玉春
 * @version 2016-05-24
 */
public class InvPriceAdjust extends DataEntity<InvPriceAdjust> {
	
	private static final long serialVersionUID = 1L;
	private String sysCode;		// 系统版本号
	private String grantBillNo;		// 价格版本号
	private String companyCode;		// 公司，分支机构
	private String companyName;		// 公司名称
	private String priceType;		// 价格类型：1：统一标准价，2：地区价，3：渠道价，4：客户价
	private String flag;		// 属性标志，1：采购，2：销售，3：内部交易
	private String grade;		// 优先级
	private String regionCode;		// 地区
	private String channelCode;		// 渠道分类
	private String btypeCode;		// 往来单位编码
	private String btypeName;		// 往来单位名称
	private String priceTypeMemo;		// 价格类型说明
	private Date beginDate;		// 开始日期
	private Date endDate;		// 结束日期
	private String approvalStatus;		// 审批状态，0：待审批，2：通过，3：拒绝
	private Date approvalDate;		// 审批日期
	private String approval;		// 审批人编码
	private String approvalName;		// 审批人姓名
	private String approvalMemo;		// 审批意见
	private String memo;		// 备注，摘要
	private Date sysDate;		// 系统时间
	private Date orderDate;		// 申请日期
	private String invCode;		// 产品编码
	private String invName;		// 产品名称
	private Double price;		// 标准价（面价）
	private Double lastPrice;		// 上一次面价
	private Company company;        //公司
	/*private List<InvPrice> invPriceList;   //子表信息
*/	private Double lowPrice;		// 盈亏平衡价
	private Double lastLowPrice;		// 上一次盈亏平衡价
	
	
	public InvPriceAdjust() {
		super();
	}

	public InvPriceAdjust(String sysCode){
		super();
		this.sysCode = sysCode;
	}

	@Id
	public String getSysCode() {
		return sysCode;
	}

	public void setSysCode(String sysCode) {
		this.sysCode = sysCode;
	}
	
	@Length(min=0, max=20, message="价格版本号长度不能超过 20 个字符")
	public String getGrantBillNo() {
		return grantBillNo;
	}

	public void setGrantBillNo(String grantBillNo) {
		this.grantBillNo = grantBillNo;
	}
	
	@ExcelField(title = "公司编码",  sort = 10)
	@Length(min=0, max=20, message="公司，分支机构长度不能超过 20 个字符")
	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	
	@ExcelField(title = "公司名称",  sort = 20)
	@Length(min=0, max=50, message="公司名称长度不能超过 50 个字符")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	@Length(min=0, max=2, message="价格类型：1：统一标准价，2：地区价，3：渠道价，4：客户价长度不能超过 2 个字符")
	public String getPriceType() {
		return priceType;
	}

	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}
	
	@Length(min=0, max=3, message="属性标志，1：采购，2：销售，3：内部交易长度不能超过 3 个字符")
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	@Length(min=0, max=3, message="优先级长度不能超过 3 个字符")
	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	@Length(min=0, max=20, message="地区长度不能超过 20 个字符")
	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	
	@Length(min=0, max=20, message="渠道分类长度不能超过 20 个字符")
	public String getChannelCode() {
		return channelCode;
	}

	public void setChannelCode(String channelCode) {
		this.channelCode = channelCode;
	}
	
	@Length(min=0, max=20, message="往来单位编码长度不能超过 20 个字符")
	public String getBtypeCode() {
		return btypeCode;
	}

	public void setBtypeCode(String btypeCode) {
		this.btypeCode = btypeCode;
	}
	
	@Length(min=0, max=200, message="价格类型说明长度不能超过 200 个字符")
	public String getPriceTypeMemo() {
		return priceTypeMemo;
	}

	public void setPriceTypeMemo(String priceTypeMemo) {
		this.priceTypeMemo = priceTypeMemo;
	}
	@ExcelField(title = "开始日期",  sort = 30)
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	
	@ExcelField(title = "结束日期",  sort = 40)
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Length(min=0, max=1, message="审批状态，0：待审批，2：通过，3：拒绝长度不能超过 1 个字符")
	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}
	
	@Length(min=0, max=20, message="审批人编码长度不能超过 20 个字符")
	public String getApproval() {
		return approval;
	}

	public void setApproval(String approval) {
		this.approval = approval;
	}
	
	@Length(min=0, max=50, message="审批人姓名长度不能超过 50 个字符")
	public String getApprovalName() {
		return approvalName;
	}

	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}
	
	@Length(min=0, max=20, message="审批意见长度不能超过 20 个字符")
	public String getApprovalMemo() {
		return approvalMemo;
	}

	public void setApprovalMemo(String approvalMemo) {
		this.approvalMemo = approvalMemo;
	}
	
	@Length(min=0, max=50, message="备注，摘要长度不能超过 50 个字符")
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSysDate() {
		return sysDate;
	}

	public void setSysDate(Date sysDate) {
		this.sysDate = sysDate;
	}
	
	//@ExcelField(title = "申请日期",  sort = 50)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	@ExcelField(title = "商品编码",  sort = 60)
	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	@ExcelField(title = "商品名称",  sort = 70)
	public String getInvName() {
		return invName;
	}

	public void setInvName(String invName) {
		this.invName = invName;
	}
	@ExcelField(title = "本次调整价",  sort = 90)
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	@ExcelField(title = "原面价",  sort = 80)
	public Double getLastPrice() {
		return lastPrice;
	}

	public void setLastPrice(Double lastPrice) {
		this.lastPrice = lastPrice;
	}

	public String getBtypeName() {
		return btypeName;
	}

	public void setBtypeName(String btypeName) {
		this.btypeName = btypeName;
	}

	/*public List<InvPrice> getInvPriceList() {
		return invPriceList;
	}

	public void setInvPriceList(List<InvPrice> invPriceList) {
		this.invPriceList = invPriceList;
	}*/

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}
	@ExcelField(title = "本次盈亏平衡价",  sort = 110)
	public Double getLowPrice() {
		return lowPrice;
	}

	public void setLowPrice(Double lowPrice) {
		this.lowPrice = lowPrice;
	}
	@ExcelField(title = "原盈亏平衡价",  sort = 100)
	public Double getLastLowPrice() {
		return lastLowPrice;
	}

	public void setLastLowPrice(Double lastLowPrice) {
		this.lastLowPrice = lastLowPrice;
	}
	
}