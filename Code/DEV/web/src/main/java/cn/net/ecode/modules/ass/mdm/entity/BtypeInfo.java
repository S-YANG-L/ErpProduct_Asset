/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.mdm.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.persistence.annotation.Id;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.Date;
import java.util.List;

/**
 * 
 * @Package: cn.net.ecode.mdm.entity 
 * @ClassName: BtypeInfo
 * @Description: TODO
 * @author: 于明珠
 * @date: 2015年9月21日 上午10:19:52 
 * @Version: V1.0
 */
public class BtypeInfo extends DataEntity<BtypeInfo> {

	private static final long serialVersionUID = 1L;
	private String companyCode;
	private String companyName;
	private String isNewRecord2;//app判断是否为新数据
	private String btypeCode; // 单位机构编码
	private String btypeName; // 单位机构全称
	private String shortName; // 单位简称
	private String regCode; // 税务登记号
	private String orgCode; // 组织机构代码
	private String btypeSortCode; // 单位分类名称
	private String btypeSortName; // 单位机构分类名称
	private Date registerDate; // 注册时间
	private String adminBtypeCode; // 主管部门编码/上级部门编码
	private String adminBtypeName; // 主管部门名称/上级部门名称
	private String lagerPersonName; // 法人名称
	private String lagerPersonIdNo; // 法人身份证号码
	private String lagerPersonTel; // 法人移动电话
	private String lagerOfficeTel; // 法人办公电话
	private String lagerPersonEmail; // 法人邮箱
	private String linkman; // 联系人
	private String linkmanTel; // 联系人电话
	private String linkmanMobile; // 联系人手机号
	private String linkmanEmail; // 联系人邮箱
	private String postCode; // 邮编
	private String fax; // 传真
	private String registerAddr; // 单位注册地
	private String workAddress; // 办公地址
	private String contactAddress; // 通信联系地址
	private String bank; // 开户银行
	private String bankAccount; // 银行账号
	private String approveStatus; // 审核状态
	private BtypeExt btypeExt; //引用Ext表
	private List<BtypeAttr> btypeAttrList;//关联Attr表
	private List<String> btypeSortsList;//单位分类
	private String propertyCode; // 性质编码
	private String propertyName; // 单位性质(科研机构、高等院校、事业单位、国有企业、合资企业、民营企业、政府部门)
	private String countryCode; // 国别编码
	private String countryName; // 国别名称
	private String tradeSortCode; // 所属行业编码
	private String tradeSortName; // 行业类别/卖方归属
	private String gardenCode; // 所属园区编码
	private String gardenName; // 所属园区名称
	private String areaCode;//全地址编码
	private String areaName;//全地址名称
	private String btypeSorts;//单位分类查询
	private String marketSortCode;//上市类型编码
	private String marketSortName;//上市类型名称
	private String isAdmin;//是否主管单位 1:是0：否
	private String attributeValue;//单位属性
	private String projectCode;//项目编号
	//liuchangmei 2016.06.06 添加
	private String loginCode;//登录人Code
	private String khStatus;  //客户类型状态（意向、正式）
	private String JsonStr;	//app传输联系人json串
	//客户业务员表
	private String managerCode;		// 客户业务员码
	private String managerName;		// 客户业务员名
	private String checkName;	// 校验是否重名
	
	public BtypeInfo() {
		super();
	}

	public BtypeInfo(String btypeCode) {
		super();
		this.btypeCode = btypeCode;
	}


	@Id
	public String getBtypeCode() {
		return btypeCode;
	}

	public void setBtypeCode(String btypeCode) {
		this.btypeCode = btypeCode;
	}

	@Length(min = 1, max = 100, message = "单位机构全称长度必须介于 1 和 100 之间")
	public String getBtypeName() {
		return btypeName;
	}

	public void setBtypeName(String btypeName) {
		this.btypeName = btypeName;
	}

	@Length(min = 0, max = 50, message = "单位简称长度不能大于 50 个字符")
	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	@Length(min = 0, max = 64, message = "税务登记号长度不能大于 64 个字符")
	public String getRegCode() {
		return regCode;
	}

	public void setRegCode(String regCode) {
		this.regCode = regCode;
	}

	@Length(min = 0, max = 64, message = "组织机构代码长度不能大于 64 个字符")
	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	@Length(min = 0, max = 64, message = "单位分类名称长度不能大于 64 个字符")
	public String getBtypeSortCode() {
		return btypeSortCode;
	}

	public void setBtypeSortCode(String btypeSortCode) {
		this.btypeSortCode = btypeSortCode;
	}

	@Length(min = 0, max = 20, message = "单位机构分类名称长度不能大于 20 个字符")
	public String getBtypeSortName() {
		return btypeSortName;
	}

	public void setBtypeSortName(String btypeSortName) {
		this.btypeSortName = btypeSortName;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	@Length(min = 0, max = 64, message = "主管部门编码/上级部门编码长度不能大于 64 个字符")
	public String getAdminBtypeCode() {
		return adminBtypeCode;
	}

	public void setAdminBtypeCode(String adminBtypeCode) {
		this.adminBtypeCode = adminBtypeCode;
	}

	@Length(min = 0, max = 20, message = "主管部门名称/上级部门名称长度不能大于 20 个字符")
	public String getAdminBtypeName() {
		return adminBtypeName;
	}

	public void setAdminBtypeName(String adminBtypeName) {
		this.adminBtypeName = adminBtypeName;
	}

	@Length(min = 0, max = 50, message = "法人名称长度不能大于 50 个字符")
	public String getLagerPersonName() {
		return lagerPersonName;
	}

	public void setLagerPersonName(String lagerPersonName) {
		this.lagerPersonName = lagerPersonName;
	}

	@Length(min = 0, max = 64, message = "法人身份证号码长度不能大于 64 个字符")
	public String getLagerPersonIdNo() {
		return lagerPersonIdNo;
	}

	public void setLagerPersonIdNo(String lagerPersonIdNo) {
		this.lagerPersonIdNo = lagerPersonIdNo;
	}

	@Length(min = 0, max = 64, message = "法人移动电话长度不能大于 64 个字符")
	public String getLagerPersonTel() {
		return lagerPersonTel;
	}

	public void setLagerPersonTel(String lagerPersonTel) {
		this.lagerPersonTel = lagerPersonTel;
	}

	@Length(min = 0, max = 64, message = "法人办公电话长度不能大于 64 个字符")
	public String getLagerOfficeTel() {
		return lagerOfficeTel;
	}

	public void setLagerOfficeTel(String lagerOfficeTel) {
		this.lagerOfficeTel = lagerOfficeTel;
	}

	@Length(min = 0, max = 64, message = "法人邮箱长度不能大于 64 个字符")
	public String getLagerPersonEmail() {
		return lagerPersonEmail;
	}

	public void setLagerPersonEmail(String lagerPersonEmail) {
		this.lagerPersonEmail = lagerPersonEmail;
	}

	@Length(min = 0, max = 20, message = "联系人长度不能大于 20 个字符")
	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	@Length(min = 0, max = 64, message = "联系人电话长度不能大于 64 个字符")
	public String getLinkmanTel() {
		return linkmanTel;
	}

	public void setLinkmanTel(String linkmanTel) {
		this.linkmanTel = linkmanTel;
	}

	@Length(min = 0, max = 64, message = "联系人手机号长度不能大于 64 个字符")
	public String getLinkmanMobile() {
		return linkmanMobile;
	}

	public void setLinkmanMobile(String linkmanMobile) {
		this.linkmanMobile = linkmanMobile;
	}

	@Length(min = 0, max = 100, message = "联系人邮箱长度不能大于 100 个字符")
	public String getLinkmanEmail() {
		return linkmanEmail;
	}

	public void setLinkmanEmail(String linkmanEmail) {
		this.linkmanEmail = linkmanEmail;
	}

	@Length(min = 0, max = 64, message = "邮编长度不能大于 64 个字符")
	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	@Length(min = 0, max = 64, message = "传真长度不能大于 64 个字符")
	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	@Length(min = 0, max = 200, message = "单位注册地长度不能大于 200 个字符")
	public String getRegisterAddr() {
		return registerAddr;
	}

	public void setRegisterAddr(String registerAddr) {
		this.registerAddr = registerAddr;
	}

	@Length(min = 0, max = 200, message = "办公地址长度不能大于 200 个字符")
	public String getWorkAddress() {
		return workAddress;
	}

	public void setWorkAddress(String workAddress) {
		this.workAddress = workAddress;
	}

	@Length(min = 0, max = 200, message = "通信联系地址长度不能大于 200 个字符")
	public String getContactAddress() {
		return contactAddress;
	}

	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}

	@Length(min = 0, max = 64, message = "开户银行长度不能大于 64 个字符")
	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	@Length(min = 0, max = 64, message = "银行账号长度不能大于 64 个字符")
	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	@Length(min = 0, max = 1, message = "审核状态长度不能大于 1 个字符")
	public String getApproveStatus() {
		return approveStatus;
	}

	public void setApproveStatus(String approveStatus) {
		this.approveStatus = approveStatus;
	}

	public BtypeExt getBtypeExt() {
		return btypeExt;
	}

	public void setBtypeExt(BtypeExt btypeExt) {
		this.btypeExt = btypeExt;
	}

	public List<String> getBtypeSortsList() {
		return btypeSortsList;
	}

	public void setBtypeSortsList(List<String> btypeSortsList) {
		this.btypeSortsList = btypeSortsList;
	}

	public List<BtypeAttr> getBtypeAttrList() {
		return btypeAttrList;
	}

	public void setBtypeAttrList(List<BtypeAttr> btypeAttrList) {
		this.btypeAttrList = btypeAttrList;
	}

	public String getPropertyCode() {
		return propertyCode;
	}

	public void setPropertyCode(String propertyCode) {
		this.propertyCode = propertyCode;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

	public String getTradeSortCode() {
		return tradeSortCode;
	}

	public void setTradeSortCode(String tradeSortCode) {
		this.tradeSortCode = tradeSortCode;
	}

	public String getTradeSortName() {
		return tradeSortName;
	}

	public void setTradeSortName(String tradeSortName) {
		this.tradeSortName = tradeSortName;
	}

	public String getGardenCode() {
		return gardenCode;
	}

	public void setGardenCode(String gardenCode) {
		this.gardenCode = gardenCode;
	}

	public String getGardenName() {
		return gardenName;
	}

	public void setGardenName(String gardenName) {
		this.gardenName = gardenName;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getBtypeSorts() {
		return btypeSorts;
	}

	public void setBtypeSorts(String btypeSorts) {
		this.btypeSorts = btypeSorts;
	}

	public String getMarketSortCode() {
		return marketSortCode;
	}

	public void setMarketSortCode(String marketSortCode) {
		this.marketSortCode = marketSortCode;
	}

	public String getMarketSortName() {
		return marketSortName;
	}

	public void setMarketSortName(String marketSortName) {
		this.marketSortName = marketSortName;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getAttributeValue() {
		return attributeValue;
	}

	public void setAttributeValue(String attributeValue) {
		this.attributeValue = attributeValue;
	}

	public String getKhStatus() {
		return khStatus;
	}

	public void setKhStatus(String khStatus) {
		this.khStatus = khStatus;
	}




	public String getIsNewRecord2() {
		return isNewRecord2;
	}

	public void setIsNewRecord2(String isNewRecord2) {
		this.isNewRecord2 = isNewRecord2;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public String getJsonStr() {
		return JsonStr;
	}

	public void setJsonStr(String jsonStr) {
		JsonStr = jsonStr;
	}

	public String getLoginCode() {
		return loginCode;
	}

	public void setLoginCode(String loginCode) {
		this.loginCode = loginCode;
	}

	public String getManagerCode() {
		return managerCode;
	}

	public void setManagerCode(String managerCode) {
		this.managerCode = managerCode;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getCheckName() {
		return checkName;
	}

	public void setCheckName(String checkName) {
		this.checkName = checkName;
	}
	
}