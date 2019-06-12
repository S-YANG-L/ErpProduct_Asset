/**
 * Copyright &copy; 2014 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.basic.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.basic.entity.Warehouse;


import java.util.List;

/**
 * 仓库表DAO接口
 * @author 肖敦山
 * @version 2015-11-19
 */
@MyBatisDao
public interface WarehouseDao extends CrudDao<Warehouse> {
	/**
	 * 删除数据时判断仓库编码是否已经使用
	 * @Title: findWhcode 
	 * @updateBy：Mc
	 * @date: 2016年6月16日 下午4:17:51 
	 * @param warehouse
	 * @return
	 */
	public List<Warehouse> findWhcode(Warehouse warehouse);
	
}