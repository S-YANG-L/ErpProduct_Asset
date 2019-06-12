/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.outbound.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBill;
import cn.net.ecode.modules.ass.outbound.entity.OutboundBillDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;

import java.util.List;

/**
 * 物资出库DAO接口
 * @author tiange
 * @version 2018-10-11
 */
@MyBatisDao
public interface OutboundBillDao extends CrudDao<OutboundBill> {
	/**
	 * 获取部门信息
	 * @param outboundBill
	 * @return
	 */
	OutboundBill getOffice(OutboundBill outboundBill);
	
	String getCompanyCode(OutboundBill outboundBill);
	
	void saveDtl(OutboundBillDtl outboundBillDtl);

    void deleteFlowLog(OutboundBill outboundBill);
}