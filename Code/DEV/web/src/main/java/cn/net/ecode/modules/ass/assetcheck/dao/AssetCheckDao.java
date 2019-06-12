/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetcheck.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheck;

/**
 * 资产盘点DAO接口
 * @author zhaohongbin
 * @version 2018-10-20
 */
@MyBatisDao
public interface AssetCheckDao extends CrudDao<AssetCheck> {
	
}