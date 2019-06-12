/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrowreturn.dao;


import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturnDtl;
import cn.net.ecode.modules.ass.cancelstocks.entity.AssetReturnDtl;

import java.util.List;

/**
 * 资产归还DAO接口
 * @author shiwangwang
 * @version 2018-10-09
 */
@MyBatisDao
public interface AssetBorrowReturnDtlDao extends CrudDao<AssetBorrowReturnDtl> {
    List<AssetBorrowReturnDtl> findUsedCode(AssetBorrowReturnDtl assetBorrowReturnDtl);
    List<AssetBorrowReturnDtl> findReturnDtl(AssetBorrowReturnDtl assetBorrowReturnDtl);
    /**
     *
     * @Title: deleteDtl
     * @Description: 根据id删除字表
     * @return
     */
    void deleteDtl(AssetBorrowReturnDtl assetBorrowReturnDtl);
}