/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.dao;


import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.CodeAssetSort;
import cn.net.ecode.modules.ass.common.entity.Common;
import cn.net.ecode.modules.sys.entity.Menu;

import java.util.List;

/**
 * 移动端获取后台日志DAO接口
 * @author Mc
 * @version 2016-06-20
 */
@MyBatisDao
public interface CommonDao extends CrudDao<Common> {

    Common getOfficeCompany(String usercode);
    CodeAssetSort getMaxbillcode(CodeAssetSort codeAssetSort);
    void insertBillcode(CodeAssetSort codeAssetSort);
    void updateBillcode(CodeAssetSort codeAssetSort);
}