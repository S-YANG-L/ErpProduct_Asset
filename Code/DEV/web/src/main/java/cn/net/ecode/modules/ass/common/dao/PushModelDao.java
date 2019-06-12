/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.dao;


import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.common.entity.PushModel;

/**
 * 推送方式表DAO接口
 * @author Mc
 * @version 2017-02-24
 */
@MyBatisDao
public interface PushModelDao extends CrudDao<PushModel> {
	
}