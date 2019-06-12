/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsclean.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetClean;
import cn.net.ecode.modules.ass.assetsclean.entity.AssetCleanDtl;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;

import java.util.List;

/**
 * 资产清理DAO接口
 * @author sww
 * @version 2018-10-11
 */
@MyBatisDao
public interface AssetCleanDao extends CrudDao<AssetClean> {
    String getCompanyCode(AssetClean assetClean);
    void deleteassetBorrowDtl(AssetCleanDtl assetCleanDtl);
    void saveassetBorrowDtl(AssetCleanDtl assetCleanDtl);
    List<AssetCleanDtl> findListDtl(AssetCleanDtl assetCleanDtl);
    AssetCleanDtl findListjilu(String assetCode);
    void reduction(AssetCleanDtl assetCleanDtl);
    List<AssetClean> summaryData(AssetClean assetClean);

    List<AssetCleanDtl> assetCleanJilu(AssetCleanDtl assetCleanDtl);
}