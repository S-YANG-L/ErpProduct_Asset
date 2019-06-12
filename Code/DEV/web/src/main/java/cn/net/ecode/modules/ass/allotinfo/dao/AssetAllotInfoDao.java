/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.allotinfo.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.allotinfo.entity.AssetAllotInfo;

import java.util.List;

/**
 * 资产调拨管理DAO接口
 * @author zhaohongbin
 * @version 2018-10-10
 */
@MyBatisDao
public interface AssetAllotInfoDao extends CrudDao<AssetAllotInfo> {

    List<AssetAllotInfo> getAll(AssetAllotInfo assetAllotInfo);

    void deleteFlowLog(AssetAllotInfo assetAllotInfo);
}