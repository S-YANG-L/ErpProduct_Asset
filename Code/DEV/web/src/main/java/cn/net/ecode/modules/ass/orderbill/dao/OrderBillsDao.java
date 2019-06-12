/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.orderbill.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBill;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBills;

import java.util.List;

/**
 * 物资采购DAO接口
 * @author zhaohongbin
 * @version 2018-10-15
 */
@MyBatisDao
public interface OrderBillsDao extends CrudDao<OrderBills> {
	//查询子表数据
    List<OrderBill> findUsedCode(OrderBills orderBills);
}