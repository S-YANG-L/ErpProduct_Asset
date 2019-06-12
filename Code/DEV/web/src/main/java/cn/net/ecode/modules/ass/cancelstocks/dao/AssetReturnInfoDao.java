/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.cancelstocks.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnInfo;

import java.util.List;

/**
 * 资产退库DAO接口
 * @author zhaohongbin
 * @version 2018-10-08
 */
@MyBatisDao
public interface AssetReturnInfoDao extends CrudDao<AssetReturnInfo> {

    AssetReturnInfo getOffice(AssetReturnInfo assetReturnInfo);

    List<AssetReturnInfo> getAll(AssetReturnInfo assetReturnInfo);

    void deleteFlowLog(AssetReturnInfo assetReturnInfo);
}