/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrow.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;

import java.util.List;

/**
 * 资产借用归还子表DAO接口
 */
@MyBatisDao
public interface AssetBorrowDtlDao extends CrudDao<AssetBorrowDtl> {
    List<AssetBorrowDtl> findUsedCode(AssetBorrowDtl assetBorrowDtl);
    List<AssetBorrowDtl> findListdtl(AssetBorrowDtl assetBorrowDtl);
    void updatauserStatus(AssetBorrowDtl assetBorrowDtl);
    void updatauserStatus2(AssetBorrowDtl assetBorrowDtl);
    void updateStatus(AssetInfo assetInfo);
    List<AssetBorrowDtl> findListjilu(AssetBorrowDtl assetBorrowDtl);
}