/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.orderbill.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.orderbill.entity.OrderBill;

import java.util.List;

/**
 * 物资采购DAO接口
 * @author zhaohongbin
 * @version 2018-10-15
 */
@MyBatisDao
public interface OrderBillDao extends CrudDao<OrderBill> {
	//查询办公用品采购数据列表
    List<OrderBill> selectListData(OrderBill orderBill);
    //更改采购是否入库状态
    void updateOrderStatus(String sysCode);
}