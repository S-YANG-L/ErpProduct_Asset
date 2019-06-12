/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.dao;


import java.util.List;

import cn.net.ecode.common.persistence.CrudDao;
import cn.net.ecode.common.persistence.annotation.MyBatisDao;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.PeoPleSearch;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.sys.entity.Menu;

/**
 * 移动端获取后台日志DAO接口
 * @author Mc
 * @version 2016-06-20
 */
@MyBatisDao
public interface AppMessageDao extends CrudDao<AppMessage> {
	/**
	 * 
	 * @Title: findMessage 移动端消息条数
	 * @updateBy：Mc
	 * @date: 2016年6月20日 下午3:21:38 
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> findMessage(AppMessage appMessage);
	/**
	 * @Title: getRecordId 根据业务表的sysCode获取消息记录表的id
	 * @updateBy：Mc
	 * @date: 2016年6月23日 下午5:23:26 
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> getRecordId(AppMessage appMessage);
	
	/**
	 * 
	 * @Title: findMessageNew 
	 * @createBy：Mc
	 * @date: 2016年10月12日 下午4:34:21 
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> findMessageNew(AppMessage appMessage);
	/**
	 * 
	 * @Title: findMessageTwo 
	 * @Description: TODO
	 * @author: wuchunyan
	 * @date: 2017年11月7日 下午3:35:40 
	 * @return
	 */
	public List<AppMessage> findMessageTwo(AppMessage appMessage);
	public List<Menu> getRoleMenuByUser(Menu menu);

	/**
	 * 获取代办消息表列表数据
	 * @Title: MessageList 
	 * @createBy：Mc
	 * @date: 2016年10月24日 下午2:01:39 
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> messageList(AppMessage appMessage);

	/**
	 * 
	 * @Title: findBillList 
	 * @Description: app端单据列 chenyuan
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> findBillFeeList(AppMessage appMessage);
	public List<AppMessage> findBillList(AppMessage appMessage);

	
	public List<Menu> getRoleMenuByParentCode(Menu menu);
	
	/**
	 * 查询人员编码并关联公司部门（按照通讯录排序）
	 * @param user
	 * @return
	 * @author yhl
	 */
	public List<PeoPleSearch> findPersonnelInfo(PeoPleSearch user);

	List<FlowLog> findFinishList(FlowLog flowLog);

	List<FlowBusiness> findProcessList(FlowBusiness flowBusiness);

	List<FlowLog> findapplicationList(FlowLog flowLog);
}