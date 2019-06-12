/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.warehouse.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.warehouse.entity.WarehouseInfo;

/**
 * 仓库管理DAO接口
 * @author sun
 * @version 2018-09-18
 */
@MyBatisDao
public interface WarehouseInfoDao extends CrudDao<WarehouseInfo> {

	void deleteDtl(WarehouseInfo oaWarehouseInfo);
	
	/**
	 * 停用
	 * @param oaWarehouseInfo
	 */
	void disable(WarehouseInfo oaWarehouseInfo);
	/**
	 * 启用
	 * @param oaWarehouseInfo
	 */
	void normal(WarehouseInfo oaWarehouseInfo);
	
}