/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrowreturn.dao;


import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowInfo;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturn;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturnDtl;

import java.util.List;

/**
 * 资产归还DAO接口
 * @author shiwangwang
 * @version 2018-10-09
 */
@MyBatisDao
public interface AssetBorrowReturnDao extends CrudDao<AssetBorrowReturn> {
    void deleteassetBorrowDtl(AssetBorrowReturnDtl assetBorrowReturnDtl);
    AssetBorrowReturn getOffice(AssetBorrowReturn assetBorrowReturn);
    List<AssetBorrowReturnDtl> findListDtl(AssetBorrowReturnDtl assetBorrowReturnDtl);
    String getCompanyCode(AssetBorrowReturn assetBorrowReturn);
    void saveassetBorrowDtl(AssetBorrowReturnDtl assetBorrowReturnDtl);
    void updateuserName(AssetInfo assetInfo);
    List<AssetInfo> findAsset(AssetInfo assetInfo);

}