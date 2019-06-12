/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.service;


import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.common.dao.PushModelDao;
import cn.net.ecode.modules.ass.common.entity.PushModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 推送方式表Service
 * @author Mc
 * @version 2017-02-24
 */
@Service
@Transactional(readOnly = true)
public class PushModelService extends CrudService<PushModelDao, PushModel> {
	
	/**
	 * 获取单条数据
	 * @param pushModel
	 * @return
	 */
	public PushModel get(PushModel pushModel) {
		return super.get(pushModel);
	}
	
	/**
	 * 查询列表数据
	 * @param pushModel
	 * @return
	 */
	public List<PushModel> findList(PushModel pushModel) {
		return super.findList(pushModel);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param pushModel
	 * @return
	 */
	public Page<PushModel> findPage(Page<PushModel> page, PushModel pushModel) {
		return super.findPage(page, pushModel);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param pushModel
	 */
	@Transactional(readOnly = false)
	public void save(PushModel pushModel) {
		if(StringUtils.isNotBlank(pushModel.getReceiverCode())){
			PushModel p = new PushModel();
			p.setReceiverCode(pushModel.getReceiverCode());
			List<PushModel> list = this.findList(p);
			if(list.size()!=0){
				pushModel.setIsNewRecord(false);
				pushModel.setId(list.get(0).getId());
			}
		}
		super.save(pushModel);
	}
	
	/**
	 * 删除数据
	 * @param pushModel
	 */
	@Transactional(readOnly = false)
	public void delete(PushModel pushModel) {
		super.delete(pushModel);
	}
	
	/**
	 * 获取推送方式
	 * @Title: pushType 
	 * @createBy：Mc
	 * @date: 2017年2月28日 上午10:01:36 
	 * @param receiverCode  消息接受人
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Boolean> pushType(String receiverCode){		
		Map<String, Boolean> map = new HashMap<>();
		//获取推送方式
		String pushSettings = null;					// 推送设置 1：微信推送 2：App推送  3：微信推送+极光推送
		boolean pushApp = false;					// App推送
		boolean pushWeChat = false;					// 微信推送
		boolean billNotice = true;					// 单据类通知  true：实时推送 false：延时半小时推送			
		boolean messageNotice = true;				// 消息类通知  true：实时推送 false：延时半小时推送
		if(StringUtils.isNotBlank(receiverCode)){
			PushModel pushModel = new PushModel();
			pushModel.setReceiverCode(receiverCode);
			List<PushModel> list = this.findList(pushModel);
			if(list.size() == 1){	
				pushSettings = list.get(0).getPushSettings();
				//微信推送
				if("1".equals(pushSettings)){
					pushWeChat = true;
				}
				//极光推送
				else if("2".equals(pushSettings)){
					pushApp = true;
				}
				//微信推送+极光推送
				else if("3".equals(pushSettings)){
					pushApp = true;
					pushWeChat = true;
				}	
				if("2".equals(list.get(0).getBillNotice())){
					billNotice = false;
				}
				if("2".equals(list.get(0).getMessageNotice())){
					messageNotice = false;
				}
			}else{
				//张萌定的需求，如果查不到推送方式默认微信推送
				pushWeChat = true;
			}
			map.put("pushApp", pushApp);
			map.put("pushWeChat", pushWeChat);
			map.put("billNotice", billNotice);
			map.put("messageNotice", messageNotice);
		}		
		return map;
	}
}