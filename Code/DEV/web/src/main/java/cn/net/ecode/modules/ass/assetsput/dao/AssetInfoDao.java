/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsput.dao;

import java.util.List;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.assetcheck.entity.AssetCheckDtl;
import cn.net.ecode.modules.ass.assetdepre.entity.AssetDepre;
import cn.net.ecode.modules.ass.assetdepre.entity.AssetDepreDtl;
import cn.net.ecode.modules.ass.assetsput.entity.*;

/**
 * 资产入库DAO接口
 * @author zhaohongbin
 * @version 2018-09-11
 */
@MyBatisDao
public interface AssetInfoDao extends CrudDao<AssetInfo> {
    //得到数据
    AssetInfo getAssetCodesql(AssetInfo assetInfo);
    List<AssetInfo> findListdtl(AssetInfo assetInfo);
    List<AssetOffice> findOffice(AssetOffice assetOffice);
    List<AssetSum> findSumList(AssetSum assetSum);
    List<AssetListing> findAssetListing(AssetListing assetListing);
    List<AssetOverTime> findOverData(AssetOverTime assetOverTime);
    List<AssetPersonal> findPersonalData(AssetPersonal assetPersonal);
    void updatauserStatus(AssetInfo assetInfo);
    void updataChange(AssetInfo assetInfo);
	List<AssetInfo> findAssetList(AssetInfo assetInfo);
    List<AssetListing> findAllData1(AssetListing assetListing);
    List<AssetListing> findAllData2(AssetListing assetListing);
    List<AssetListing> findAllData3(AssetListing assetListing);
    List<AssetListing> findAllData4(AssetListing assetListing);
    List<AssetZheJiu> findZheJiuData(AssetZheJiu assetZheJiu);
    AssetZheJiu findZheJiuSumData(AssetZheJiu assetZheJiu);


    List<AssetCheckDtl> findListCheck(AssetInfo assetInfo);

    List<AssetInfo> findListPrint(AssetInfo assetInfo);

    List<AssetDepreDtl> findListDepre(AssetDepre asset);

    List<AssetInfo> findListPrintlist(AssetInfo assetInfo);
}