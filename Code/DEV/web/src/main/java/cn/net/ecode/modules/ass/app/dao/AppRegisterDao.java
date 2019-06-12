/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.app.dao;

import java.util.List;

import cn.net.ecode.modules.ass.app.entity.AppRegister;
import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;

/**
 * 
 * @Package: cn.net.ecode.app.dao 
 * @ClassName: AppRegisterDao
 * @Description: 用户注册Dao接口
 * @author: 司楠楠
 * @date: 2016年12月27日 上午10:34:14 
 * @Version: V1.0
 */
 
@MyBatisDao
public interface AppRegisterDao extends CrudDao<AppRegister> {
	/**
	 * @Title:getMaxCorp
	 * @Description:获取最大集团码
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 上午10:40:41 
	 * @param appRegister
	 */
	AppRegister getMaxCorp(AppRegister appRegister);
	/**
	 * @Title:updateExtendS5
	 * @Description:更新ExtendS5等于1的user信息
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午2:30:17 
	 * @param appRegister
	 */
	void updateExtendS5(AppRegister appRegister);
	/**
	 * @Title:findUserList
	 * @Description:查找待确认用户
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午3:31:34 
	 * @param appRegister
	 * @return
	 */
	List<AppRegister> findUserList(AppRegister appRegister);
	/**
	 * @Title:findLoginCode
	 * @Description:查找手机号是否存在
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月27日 下午3:33:19 
	 * @param appRegister
	 * @return
	 */
	List<AppRegister> findLoginCode(AppRegister appRegister);
	/**
	 * @Title:findCorpUserList
	 * @Description:查询集团
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2016年12月29日 上午10:37:50 
	 * @param appRegister
	 * @return
	 */
	List<AppRegister> findCorpUserList(AppRegister appRegister);
	public List<AppRegister> findList(AppRegister appRegister);
	/**
	 * @Title:findCorpCode
	 * @Description:查找企业码是否存在
	 * @createBy: 司楠楠
	 * @updateBy：司楠楠
	 * @date: 2017年1月3日 下午1:59:41 
	 * @param appRegister
	 * @return
	 */
	List<AppRegister> findCorpCode(AppRegister appRegister);

	/** 
	 * @Title: loadOfficeTable
	 * @Description: 初始化部门表sys_office
	 * @param appRegister
	 */
	void loadOfficeTable(AppRegister appRegister);
	/** 
	 * @Title: loadPostTable 
	 * @Description: 初始化岗位表sys_post
	 * @param appRegister
	 */
	void loadPostTable(AppRegister appRegister);
	/** 
	 * @Title: findRoleCode 
	 * @Description: 查找默认角色编码
	 * @param appRegister
	 */
	List<AppRegister> findRoleCode(AppRegister appRegister);
}