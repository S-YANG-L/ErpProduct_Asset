/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.price.dao;

import java.util.List;

import cn.net.ecode.modules.ass.price.entity.InvPriceAdjust;
import org.apache.ibatis.annotations.Param;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.sys.entity.Company;


/**
 * 面价管理DAO接口
 * @author 陈玉春
 * @version 2016-05-24
 */
@MyBatisDao
public interface InvPriceAdjustDao extends CrudDao<InvPriceAdjust> {

	//更新审批状态
	void updateApproStatus(InvPriceAdjust invPriceAdjust);

	 void deleteDetil(InvPriceAdjust invPriceAdjust);

	List<Company> findCompanyListByDataScope(@Param(value = "userCode") String userCode);
	
	List<InvPriceAdjust > findDetailList(InvPriceAdjust invPriceAdjust);
	

}