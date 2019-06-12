/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.basic.entity.Rdstyle;


/**
 * 收发类别表DAO接口
 * @author 肖敦山
 * @version 2015-11-19
 */
@MyBatisDao
public interface RdstyleDao extends CrudDao<Rdstyle> {
	
}