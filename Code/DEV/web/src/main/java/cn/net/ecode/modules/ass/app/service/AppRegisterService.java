/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.app.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.app.dao.AppRegisterDao;
import cn.net.ecode.modules.ass.app.entity.AppRegister;
import cn.net.ecode.modules.sys.entity.Company;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.service.CompanyService;
import cn.net.ecode.modules.sys.service.UserService;

/**
 * 
 * @Package: cn.net.ecode.app.service 
 * @ClassName: AppRegisterService
 * @Description: 用户注册Service
 * @author: 司楠楠
 * @date: 2016年12月27日 上午10:33:44 
 * @Version: V1.0
 */
 
@Service
@Transactional(readOnly = true)
public class AppRegisterService extends CrudService<AppRegisterDao, AppRegister> {
	@Autowired
	private CompanyService companyService;
	@Autowired
	private UserService userService;
	/**
	 * @Title:getMaxCorp
	 * @Description:获取最大集团码
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 上午10:40:41 
	 * @param appRegister
	 * @return 
	 */
	public AppRegister getMaxCorp(AppRegister appRegister) {
		return dao.getMaxCorp(appRegister);
	}
	@Transactional(readOnly = false)
	public void save(AppRegister appRegister) {
		Company company=new Company();
		company.setCompanyCode(IdGen.nextId());
		company.setParentCode("0");
		company.setCompanyName(appRegister.getCompanyName());
		company.setCompanyNameSimple(appRegister.getCompanyName());
		AppRegister corp=dao.getMaxCorp(appRegister);//获取最大集团码
		String a = corp.getCorpCode();
		for(int i=0;i<(6-corp.getCorpCode().length());i++){
			a='0'+a;
		}
		company.setCorpCode(a);
		company.setCorpName(appRegister.getCompanyName());
		company.setViewCode(appRegister.getViewCode());
		company.preInsert();
		User user1=new User();
		Office office=new Office();
		office.setOfficeCode(null);
		office.setOfficeName("ERP");
		user1.setUserCode("system");
		company.setCreateBy(user1);
		company.setUpdateBy(user1);
		company.setOffice(office);
		companyService.insert(company);
		appRegister.setQyNum(a);
		appRegister.setCorpCode(a);
		appRegister.setCorpName(appRegister.getCompanyName());
//		MessageUtils.sendSms(null, "您好，您的企业码是："+a+"（请勿透露给其他人）感谢您的使用。", Message.RECEIVER_TYPE_NONE, appRegister.getMobile(), appRegister.getUserName());//将企业集团6位码发送短信到注册人手机上
	}
	@SuppressWarnings("static-access")
	@Transactional(readOnly = false)
	public void saveUser(AppRegister appRegister) {
		User user=new User();
		user.setLoginCode(appRegister.getMobile());
		if(appRegister.getIsPerson()==null){
			user.setMgrType("1");
			user.setUserType("0");
//			user.setPassword(userService.encryptPassword("123456"));
//			user.setPwdSecurityLevel(Integer.valueOf(User.PWD_SECURITY_LEVEL_INITPWD));
//			user.setPwdUpdateDate(new Date());
		}
		else{
			user.setExtendS5("1");
			user.setPassword(userService.encryptPassword(appRegister.getPassword()));
			user.setPwdSecurityLevel(Integer.valueOf(User.PWD_SECURITY_LEVEL_INITPWD));
			user.setPwdUpdateDate(new Date());
		}
		user.setMobile(appRegister.getMobile());
		user.setEmail(appRegister.getEmail());
		user.setIsNewRecord(true);
		user.setUserCode(IdGen.nextId());
		User user1=new User();
		user1.setUserCode("system");
		user.setCreateBy(user1);
		user.setUpdateBy(user1);
		user.setRefCode(IdGen.nextId());
		user.setCorpCode(appRegister.getCorpCode());
		user.setCorpName(appRegister.getCompanyName());
		user.setUserName(appRegister.getUserName());
		userService.save(user);
		appRegister.setUserCode(user.getUserCode());
//		dao.update(appRegister);
	}
	/**
	 * @Title:updateExtendS5
	 * @Description:更新ExtendS5等于1的user信息
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午2:30:17 
	 * @param appRegister
	 */
	@Transactional(readOnly = false)
	public void updateExtendS5(AppRegister appRegister) {
		dao.updateExtendS5(appRegister);
		
	}

	/**
	 * @Title:findUserList
	 * @Description:查找待确认用户
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午3:31:34 
	 * @param appRegister
	 * @return
	 */
	public List<AppRegister> findUserList(AppRegister appRegister) {
		return dao.findUserList(appRegister);
		
	}

	/**
	 * @Title:findLoginCode
	 * @Description:查找手机号是否存在
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午3:33:19 
	 * @param appRegister
	 * @return
	 */
	public List<AppRegister> findLoginCode(AppRegister appRegister) {
		return dao.findLoginCode(appRegister);
		
	}
	/**
	 * @Title:findCorpUserList
	 * @Description:查询集团
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月29日 上午10:37:50 
	 * @param appRegister
	 * @return
	 */
	public List<AppRegister> findCorpUserList(AppRegister appRegister) {
		
		return dao.findCorpUserList(appRegister);
	}

	public List<AppRegister> findList(AppRegister appRegister) {
		return dao.findList(appRegister);
		
	}
	/**
	 * @Title:findCorpCode
	 * @Description:查找企业码是否存在
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2017年1月3日 下午1:59:41 
	 * @param appRegister
	 * @return
	 */
	public List<AppRegister> findCorpCode(AppRegister appRegister) {
		
		return dao.findCorpCode(appRegister);
	}
	
	/** 
	 * @Title: loadPostTable 
	 * @Description: 初始化岗位表
	 * @param appRegister
	 */
	@Transactional(readOnly = false)
	private void loadPostTable(AppRegister appRegister) {
		dao.loadPostTable(appRegister);
		
	}
	/** 
	 * @Title: loadOfficeTable 
	 * @Description: 初始化部门表
	 * @param appRegister
	 */
	@Transactional(readOnly = false)
	private void loadOfficeTable(AppRegister appRegister) {
		dao.loadOfficeTable(appRegister);
		
	}
	
	/** 
	 * @Title: findRoleCode 
	 * @Description: 查找默认角色编码
	 * @param appRegister
	 */
	public List<AppRegister> findRoleCode(AppRegister appRegister) {
		return dao.findRoleCode(appRegister);
		
	}
}