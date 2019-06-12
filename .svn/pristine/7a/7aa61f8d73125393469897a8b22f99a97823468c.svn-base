/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetcheck.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtl;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtlSM;

import java.util.List;

/**
 * 资产盘点DAO接口
 * @author zhaohongbin
 * @version 2018-10-20
 */
@MyBatisDao
public interface AssetCheckDtlDao extends CrudDao<AssetCheckDtl> {

    List<AssetCheckDtl> findCheckCode(AssetCheckDtl assetCheckDtl);

    List<AssetCheckDtl>  getAssetCodesql(String assetCode);

    void updateCheckStatus(AssetCheckDtl assetCheckDtl);

    void updateSubmitStatus(String id);

    List<AssetCheckDtl> undeterminedAssetCheck(String userCode);

    List<AssetCheckDtl> undeterminedAssetCheckFen(AssetCheckDtl assetCheckDtl);


    List<AssetCheckDtl> findAppAssetCheckDtls(AssetCheckDtl assetCheckDtl);

	void updateAppAssetCheckDtls(AssetCheckDtl assetCheckDtl);

    void updateAssetCheckDtLosses(AssetCheckDtl assetCheckDtl);


    List<AssetCheckDtlSM> findCheckCodeSM(AssetCheckDtlSM assetCheckDtlSM);

    void updateCheckCodeSM(AssetCheckDtlSM assetCheckDtlSM);
}