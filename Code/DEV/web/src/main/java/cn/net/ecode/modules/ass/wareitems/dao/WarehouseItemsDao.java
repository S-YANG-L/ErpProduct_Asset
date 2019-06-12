/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.wareitems.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.wareitems.entity.WarehouseItems;

import java.util.List;

/**
 * 仓库物品信息DAO接口
 * @author tiange
 * @version 2018-10-13
 */
@MyBatisDao
public interface WarehouseItemsDao extends CrudDao<WarehouseItems> {
    WarehouseItems getQty(WarehouseItems warehouseItems);
    List<WarehouseItems> getWhcode(WarehouseItems warehouseItems);
}