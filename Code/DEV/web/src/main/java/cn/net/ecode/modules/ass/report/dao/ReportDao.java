package cn.net.ecode.modules.ass.report.dao;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.report.entity.Report;

/**
 * 仓库物品信息DAO接口
 * @author tiange
 * @version 2018-10-15
 */
@MyBatisDao
public interface ReportDao extends CrudDao<Report> {

}
