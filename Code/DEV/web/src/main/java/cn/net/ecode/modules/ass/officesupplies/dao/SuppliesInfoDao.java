/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.officesupplies.dao;

import java.util.List;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.officesupplies.entity.SuppliesInfo;

/**
 * 办公用品DAO接口
 * @author sun
 * @version 2018-09-10
 */
@MyBatisDao
public interface SuppliesInfoDao extends CrudDao<SuppliesInfo> {

	List<SuppliesInfo> getprosuppliesCode(SuppliesInfo suppliesInfo);//查询编码是否存在，声明一个无方法体的方法
	
	void deleteDtl(SuppliesInfo suppliesInfo);//物理删除声明的方法
	
}