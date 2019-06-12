/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.cancelstocks.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnDtl;

import java.util.List;

/**
 * 资产退库DAO接口
 * @author zhaohongbin
 * @version 2018-10-08
 */
@MyBatisDao
public interface AssetReturnDtlDao extends CrudDao<AssetReturnDtl> {


    List<AssetReturnDtl> findUsedCode(AssetReturnDtl assetReturnDtl);
}