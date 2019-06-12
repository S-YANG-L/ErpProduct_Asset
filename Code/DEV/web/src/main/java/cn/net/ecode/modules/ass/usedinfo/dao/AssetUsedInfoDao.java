/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;

import java.util.List;

/**
 * 资产领用DAO接口
 *
 * @author zhaohongbin
 * @version 2018-09-20
 */
@MyBatisDao
public interface AssetUsedInfoDao extends CrudDao<AssetUsedInfo> {
    String getCompanyCode(AssetUsedInfo assetUsedInfo);
    AssetUsedInfo getOffice(AssetUsedInfo assetUsedInfo);
    List<AssetUsedInfo> getAll(AssetUsedInfo assetUsedInfo);
//    删除流程日志数据
    void deleteFlowLog(AssetUsedInfo assetUsedInfo);
}