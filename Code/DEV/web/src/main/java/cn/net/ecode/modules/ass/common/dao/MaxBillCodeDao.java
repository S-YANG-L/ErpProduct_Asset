/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.dao;



import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.common.entity.MaxBillCode;

/**
 * 单表生成DAO接口
 * @author 肖敦山
 * @version 2015-10-27
 */
@MyBatisDao
public interface MaxBillCodeDao extends CrudDao<MaxBillCode> {
	
   public int update(MaxBillCode maxBillCode);
	
}