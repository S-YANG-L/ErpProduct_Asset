/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.ascheck.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.ascheck.entity.AsCheckDtl;

import java.util.List;

/**
 * 办公用品盘点DAO接口
 * @author zhaohongbin
 * @version 2018-10-17
 */
@MyBatisDao
public interface AsCheckDtlDao extends CrudDao<AsCheckDtl> {

    List<AsCheckDtl> findCheckCode(AsCheckDtl asCheckDtl);

	void insertDtl(AsCheckDtl asCheckDtl);
}