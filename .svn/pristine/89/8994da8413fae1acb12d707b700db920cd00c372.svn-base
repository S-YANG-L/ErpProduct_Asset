/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import java.util.List;

/**
 * 资产领用子表DAO接口
 *
 * @author zhaohongbin
 * @version 2018-09-20
 */
@MyBatisDao
public interface AssetUsedDtlDao extends CrudDao<AssetUsedDtl> {
    List<AssetUsedDtl> findUsedCode(AssetUsedDtl assetUsedDtl);
    List<AssetUsedDtl> findUsedCodeReturn(AssetUsedDtl assetUsedDtl);
    void updateReturn(String assetCode);
    void updateUserinfo(AssetUsedDtl assetUsedDtl);
}