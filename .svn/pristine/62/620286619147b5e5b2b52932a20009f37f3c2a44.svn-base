/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclean.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetClean;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;

import java.util.List;

/**
 * 资产清理DAO接口
 * @author sww
 * @version 2018-10-11
 */
@MyBatisDao
public interface AssetCleanDtlDao extends CrudDao<AssetCleanDtl> {
    List<AssetCleanDtl> findUsedCode(AssetCleanDtl assetCleanDtl);
    List<AssetCleanDtl> findCleanData(AssetCleanDtl assetCleanDtl);
    List<AssetClean> assetCleanJilu(AssetClean assetClean);
void updateDtl(AssetCleanDtl assetCleanDtl);
}