package cn.net.ecode.modules.ass.report.dao;

import java.util.List;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturn;
import cn.net.ecode.modules.ass.report.entity.SendReceive;

/**
 * 收发存明细报表信息dao
 * @author tiange
 * @version 2018-10-16
 */
@MyBatisDao
public interface SendReceiveDao extends CrudDao<SendReceive> {
	/**
	 * 查询出库相关数据
	 * @param sendReceive
	 * @return
	 */
	public List<SendReceive> findOutList(SendReceive sendReceive);
	
	List<SendReceive> findDetail(SendReceive SendReceive);
}
