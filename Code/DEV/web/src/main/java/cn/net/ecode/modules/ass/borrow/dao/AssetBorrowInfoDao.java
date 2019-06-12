/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrow.dao;

import java.util.List;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowInfo;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;

/**
 * 资产借用归还DAO接口
 */
@MyBatisDao
public interface AssetBorrowInfoDao extends CrudDao<AssetBorrowInfo> {
	List<AssetInfo> findAssetInfo(AssetInfo assetInfo);
	void deleteassetBorrowDtl(AssetBorrowDtl assetBorrowDtl);
	AssetBorrowInfo getOffice(AssetBorrowInfo assetBorrowInfo);
	List<AssetBorrowDtl> findListDtl(AssetBorrowDtl assetBorrowDtl);
	String getCompanyCode(AssetBorrowInfo assetBorrowInfo);
	void saveassetBorrowDtl(AssetBorrowDtl assetBorrowDtl);
	void updatauserStatus(AssetInfo assetInfo);
	List<AssetInfo> findListjilu(AssetInfo assetInfo);

	
}