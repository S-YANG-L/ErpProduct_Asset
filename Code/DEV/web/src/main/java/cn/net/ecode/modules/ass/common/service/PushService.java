/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.service;


import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.common.dao.PushDao;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.Push;
import cn.net.ecode.modules.msg.dao.MessageDao;
import cn.net.ecode.modules.msg.entity.Message;
import cn.net.ecode.modules.msg.entity.PushMessage;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;
import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 推送中间表Service
 * @author Mc
 * @version 2017-03-03
 */
@Service
@Transactional(readOnly = true)
public class PushService extends CrudService<PushDao, Push> {
	
	@Autowired
	private PushModelService pushModelService;
	@Autowired
	private MessageDao messageDao;
	@Autowired
	private AppMessageService appMessageService;
	/**
	 * 获取单条数据
	 * @param push
	 * @return
	 */
	public Push get(Push push) {
		return super.get(push);
	}
	
	/**
	 * 查询列表数据
	 * @param push
	 * @return
	 */
	public List<Push> findList(Push push) {
		return super.findList(push);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param push
	 * @return
	 */
	public Page<Push> findPage(Page<Push> page, Push push) {
		return super.findPage(page, push);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param push
	 */
	@Transactional(readOnly = false)
	public void save(Push push) {
		//非空默认值
		if(StringUtils.isBlank(push.getIsPush())){
			push.setIsPush("0");
		}
		if(StringUtils.isBlank(push.getPushCycle())){
			push.setPushCycle("0");
		}
		super.save(push);
	}
	
	/**
	 * 删除数据
	 * @param push
	 */
	@Transactional(readOnly = false)
	public void delete(Push push) {
		super.delete(push);
	}	

	/**
	 * 删除数据
	 * @param push
	 */
	@Transactional(readOnly = false)
	public void deleteByBizkey(Push push) {
		dao.deleteByBizkey(push);
	}	
	
	
	/**
	 * 定时推送任务调用方法
	 * @Title: pushMessage 
	 * @createBy：Mc
	 * @date: 2017年3月7日 下午4:49:31 
	 * @param list
	 */
	@Transactional(readOnly = false)
	public void pushMessage(List<Push> list){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		//非空判断
		if(list!=null && !list.isEmpty()){
			for(Push p : list){
				@SuppressWarnings("unchecked")
				Map<String,String> param =  (Map<String, String>) JSON.parse(p.getPushParam());
				String[] codes = StringUtils.split(p.getReceiverCode(), ",");
				//获取需要推送的所有user
				List<User> userList = Lists.newArrayList();
				Message message = new Message(codes);
				User user = message.getCurrentUser();
				if (user.getUserCode() == null) {
					//获取消息接受的第一个人的user信息
					user = UserUtils.get(p.getReceiverCode().split(",")[0]);
					//获取system的user信息
					//user = UserUtils.get(User.SUPER_ADMIN_CODE.split(",")[0]);
				}
				message.setCorpCode(user.getCorpCode());
				switch (p.getReceiverType()) {
				case "1": 
				  userList = messageDao.findUserByUserCodes(message);
				  break;
				case "2": 
				  userList = messageDao.findUserByOfficeCodes(message);
				  break;
				case "3": 
				  userList = messageDao.findUserByRoleCodes(message);
				  break;
				case "4": 
				  userList = messageDao.findUserByPostCodes(message);
				  break;
				case "5": 
				  userList = messageDao.findAllUserList(message);
				  break;
				default: 
					break;
				}
		      	for(User u : userList){
		      		//获取接受消息人的接受方式
		      		Map<String, Boolean> map =pushModelService.pushType(u.getUserCode());	
		      		if(!map.isEmpty()){
		      			try {	
		      				//定义返回值
		      				String resultAurora = "200";
		      				String resultWeChat = "200";
			      			if(map.get("pushAurora")){
								//极光推送
			      				resultAurora = appMessageService.pushMessage(u.getUserCode(),p.getReceiverContent(),p.getBizKey(),
										PushMessage.REVICERTYPE_USER_LIST,p.getBizType(),p.getOriginateCode());//调用极光推送接口
							}
							if(map.get("pushWeChat")){
								//微信推送
								AppMessage appMessage = new AppMessage();
								//非空判断
								if(StringUtils.isNotBlank(param.get("applicantName"))){
									appMessage.setApplicantName(param.get("applicantName"));
								}
								if(StringUtils.isNotBlank(param.get("applyDate"))){
									appMessage.setApplyDate(sdf.parse(param.get("applyDate")));
								}
								if(StringUtils.isNotBlank(param.get("applyMoney"))){
									appMessage.setApplyMoney(Double.valueOf(param.get("applyMoney")));
								}
								if(StringUtils.isNotBlank(param.get("templageHead"))){
									appMessage.setTemplageHead(param.get("templageHead"));
								}
								if(StringUtils.isNotBlank(param.get("keyword1"))){
									appMessage.setKeyword1(param.get("keyword1"));
								}
								if(StringUtils.isNotBlank(param.get("keyword2"))){
									appMessage.setKeyword2(param.get("keyword2"));
								}
								if(StringUtils.isNotBlank(param.get("keyword3"))){
									appMessage.setKeyword3(param.get("keyword3"));
								}
								if(StringUtils.isNotBlank(param.get("keyword4"))){
									appMessage.setKeyword4(param.get("keyword4"));
								}
								appMessage.setBizKey(p.getBizKey());
								appMessage.setBizType(p.getBizType());
								appMessage.setBizName(p.getBizName());
								appMessage.setReceiverType(Message.RECEIVER_TYPE_USER);
								appMessage.setReceiverCodes(u.getUserCode());
								appMessage.setReceiverNames(u.getUserName());
								appMessage.setContentTitle(p.getReceiverContent());
								resultWeChat = appMessageService.pushWeChatMessage(appMessage);
							}
							//执行成功更改是否推送字段
							if("200".equals(resultAurora) || "200".equals(resultWeChat)){
								p.setIsPush("1");
								this.update(p);
							}else{
								logger.debug("-----------推送失败-----------");
							}
		      			} catch (Exception e) {
		      				e.printStackTrace();
		      				break;
							// TODO: handle exception
						}
		      		}
		      	}   		
			}
		}	
	}
	
	
	/**
	 * 定时推送任务10分钟一次
	 * @Title: pushMinuteJob 
	 * @createBy：Mc
	 * @date: 2017年3月3日 下午5:20:37 
	 */
	@Transactional(readOnly = false)
	public void pushMinuteJob() {
		//查询需要推送的消息
		Push push = new Push();
		push.setIsPush("0");
		push.setPushCycle("0");
		push.setReceiverDate(new Date());
		Calendar date = Calendar.getInstance();
		date.setTime(push.getReceiverDate());
		date.add(Calendar.MINUTE, -10);
		push.setReceiverBeforeDate(date.getTime());
		List<Push> list =  this.findList(push);
		this.pushMessage(list);
	}
	
	 
	/**
	 * 定时推送任务每天十点推送一次 
	 * @Title: pushDayJob 
	 * @createBy：Mc
	 * @date: 2017年3月7日 下午5:20:25
	 */
	@Transactional(readOnly = false)
	public void pushDayJob() {
		//查询需要推送的消息
		Push push = new Push();
		push.setIsPush("0");
		push.setPushCycle("1");
		push.setReceiverDate(new Date());
		Calendar date = Calendar.getInstance();
		date.setTime(push.getReceiverDate());
		date.add(Calendar.DATE, -1);
		push.setReceiverBeforeDate(date.getTime());
		List<Push> list =  this.findList(push);
		this.pushMessage(list);
	}
}