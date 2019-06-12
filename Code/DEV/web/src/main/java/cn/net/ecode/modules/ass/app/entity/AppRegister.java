package cn.net.ecode.modules.ass.app.entity;

import cn.net.ecode.common.persistence.DataEntity;
/**
 * 
 * @Package: cn.net.ecode.app.entity 
 * @ClassName: AppRegister
 * @Description: 用户注册实体类
 * @author: 司楠楠
 * @date: 2016年12月27日 上午10:11:09 
 * @Version: V1.0
 */
 
public class AppRegister extends DataEntity<AppRegister> {
	private static final long serialVersionUID = 1L;
	private String userCode;          //用户编码
	private String userName;          //用户名称
	private String password;   //密码
	private String mobile;   //当前操作人手机号
	private String phone;   //联系电话
	private String idCard;   //身份证号
	private String companyCode;//企业编码
	private String companyName;//企业名称
	private String viewCode;//企业组织代码
	private String homeAddress;//家庭住址
	private String email;//邮箱
	private String loginCode;//登陆账号
	private String addr;//公司地址
	private String isPerson;//是否个人注册
	private String jtCode;//集团编码
	private String jtName;//集团名称
	private String corpNum;//集团数量
	private String qyNum;//企业码
	private String verificationCode;//验证码
	private String extendS5;//确认标记
	private String moduleCode;//模块编码
	private String moduleName;//模块名称
	private String roleCode;//角色编码
	private String roleName;//角色名称
	public AppRegister() {
		super();
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getCompanyCode() {
		return companyCode;
	}
	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	public String getViewCode() {
		return viewCode;
	}
	public void setViewCode(String viewCode) {
		this.viewCode = viewCode;
	}
	public String getHomeAddress() {
		return homeAddress;
	}
	public void setHomeAddress(String homeAddress) {
		this.homeAddress = homeAddress;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLoginCode() {
		return loginCode;
	}
	public void setLoginCode(String loginCode) {
		this.loginCode = loginCode;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getIsPerson() {
		return isPerson;
	}
	public void setIsPerson(String isPerson) {
		this.isPerson = isPerson;
	}
	public String getJtCode() {
		return jtCode;
	}
	public void setJtCode(String jtCode) {
		this.jtCode = jtCode;
	}
	public String getJtName() {
		return jtName;
	}
	public void setJtName(String jtName) {
		this.jtName = jtName;
	}
	public String getCorpNum() {
		return corpNum;
	}
	public void setCorpNum(String corpNum) {
		this.corpNum = corpNum;
	}
	public String getQyNum() {
		return qyNum;
	}
	public void setQyNum(String qyNum) {
		this.qyNum = qyNum;
	}
	public String getVerificationCode() {
		return verificationCode;
	}
	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}
	public String getExtendS5() {
		return extendS5;
	}
	public void setExtendS5(String extendS5) {
		this.extendS5 = extendS5;
	}
	public String getModuleCode() {
		return moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	

	
}
