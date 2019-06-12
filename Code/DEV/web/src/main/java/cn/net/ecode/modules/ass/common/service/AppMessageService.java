/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.service;


import java.text.SimpleDateFormat;
import java.util.*;


import cn.net.ecode.modules.eflow.dao.FlowBusinessDao;
import cn.net.ecode.modules.eflow.dao.FlowLogDao;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.msg.entity.PushResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foxinmy.weixin4j.mp.message.TemplateMessage;
import cn.net.ecode.modules.msg.service.PushMessageService;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.common.dao.AppMessageDao;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.PeoPleSearch;
import cn.net.ecode.modules.msg.entity.PushMessage;
import cn.net.ecode.modules.sys.entity.Company;
import cn.net.ecode.modules.sys.entity.Employee;
import cn.net.ecode.modules.sys.entity.Menu;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.service.OfficeService;
import cn.net.ecode.modules.sys.service.UserService;
import cn.net.ecode.modules.sys.utils.UserUtils;
import cn.net.ecode.modules.weixin.utils.WeixinMsgPushUtils;

/**
 * 移动端获取后台日志Service
 * @author Mc
 * @version 2016-06-20
 */
@Service
@Transactional(readOnly = true)
public class AppMessageService extends CrudService<AppMessageDao, AppMessage> {
	@Autowired
	PushMessageService pushMessageService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private UserService userService;
	/**
	 * 获取单条数据
	 * @param appMessage
	 * @return
	 */
	public AppMessage get(AppMessage appMessage) {
		return super.get(appMessage);
	}
	/**
	 * 查询列表数据
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> findList(AppMessage appMessage) {
		return super.findList(appMessage);
	}
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param appMessage
	 * @return
	 */
	public Page<AppMessage> findPage(Page<AppMessage> page, AppMessage appMessage) {
		return super.findPage(page, appMessage);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param appMessage
	 */
	@Transactional(readOnly = false)
	public void save(AppMessage appMessage) {
		super.save(appMessage);
	}
	
	/**
	 * 删除数据
	 * @param appMessage
	 */
	@Transactional(readOnly = false)
	public void delete(AppMessage appMessage) {
		super.delete(appMessage);
	}

	/**
	 * 
	 * @Title: findMessageNew 
	 * @createBy：Mc
	 * @date: 2016年10月12日 下午4:35:09 
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> findMessageNew(AppMessage appMessage){
		return dao.findMessageNew(appMessage);
	}
	/**
	 * 
	 * @Title: findMessageTwo 
	 * @Description: TODO
	 * @author: wuchunyan
	 * @date: 2017年11月7日 下午3:36:23 
	 * @return
	 */
	public List<AppMessage> findMessageTwo(AppMessage appMessage){
		return dao.findMessageTwo(appMessage);
	}
	public List<Menu> getRoleMenuByUser(Menu menu) {
		return dao.getRoleMenuByUser(menu);
	}
	/**
	 * 获取代办消息表列表数据
	 * @Title: MessageList 
	 * @createBy：Mc
	 * @date: 2016年10月24日 下午2:02:33 
	 * @param appMessage
	 * @return
	 */
	public List<AppMessage> messageList(AppMessage appMessage){
		return dao.messageList(appMessage);
	}

	public Map<String,Object> getOfficePerson(String companyCode) {
		Office office = new Office();
		office.setParentCode("0");
		office.setCorpCode(UserUtils.getUser().getCorpCode());
		office.setCompany(new Company(companyCode));
		List<Office> list;
		list = this.officeService.findList(office);
		Map<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> list1;
//		List<Map<String,Object>> list1 = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < list.size(); i++) {
			Office o = list.get(i);
			Map<String,String> info = new HashMap<String,String>();
			info.put("OfficeCode", o.getOfficeCode());
			info.put("OfficeName", o.getOfficeName());
			map.put("currentInfo", info);
			list1 = recursionOffice(o,map,companyCode);
			map.put("next", list1);
		}
		return map;
	}
	
	public List<Map<String,Object>> recursionOffice(Office office, Map<String,Object> map, String companyCode){
		List<Map<String,Object>> list1 = new ArrayList<Map<String,Object>>();
		if("1".equals(office.getHasnext())){
			Office office1 = new Office();
			office1.setParentCode(office.getOfficeCode());
			office1.setCorpCode(UserUtils.getUser().getCorpCode());
			office1.setCompany(office.getCompany());
			List<Office> list;
			list = officeService.findList(office1);
			for(int i = 0; i < list.size(); i++){
				Map<String,Object> map1 = new HashMap<String,Object>();
				Office o = list.get(i);
				Map<String,String> info = new HashMap<String,String>();
				info.put("OfficeCode", o.getOfficeCode());
				info.put("OfficeName", o.getOfficeName());
				map1.put("currentInfo", info);
				List<Map<String,Object>> result = recursionOffice(o,map1,companyCode);
				map1.put("next", result);
				list1.add(map1);
			}
		}else{
			User user = new User();
			Employee employee = new Employee();
			employee.setOfficeCode(office.getOfficeCode());
			employee.getOffice().setIsQueryChildren(Boolean.valueOf(false));
			employee.setCompanyCode(companyCode);
			employee.getCompany().setIsQueryChildren(Boolean.valueOf(false));
			employee.setPostCode(null);
			user.setEmployee(employee);
			user.setRoleCode(null);
			user.setStatus("0");
			user.setUserType("1");
			user.setMgrType("0");
			List<User> userList = userService.findAllList(user);
			for(User u:userList){
				Map<String,Object> map2 = new HashMap<String,Object>();
				map2.put("userCode", u.getUserCode());
				map2.put("userName", u.getUserName());
				list1.add(map2);
			}
		}
		return list1;
	}

	
	/**
	 * 极光推送
	 * @Title: pushMessage 
	 * @createBy：Mc
	 * @date: 2017年2月14日 上午11:00:14 
	 * @param userCodes 	接收人
	 * @param context		标题
	 * @param bizKey		单据号
	 * @param revicerType	接收类型
	 * @param billType  	单据类型
	 * @return
	 */
	@Transactional(readOnly = false)
	public String pushMessage(String userCodes,String context,String bizKey,Integer revicerType,String billType,String poster) {	
		//param
		Map<String, String> map = new HashMap<String,String>();		
		map.put("bizKey", bizKey);		// 单据号
		//map.put("msgType", msgType);	// 0：单据  1：合同  2：单据退回
		map.put("billType", billType);	// 单据类型		
		//message
		PushMessage message=new PushMessage();
		User u = UserUtils.getUser();
		if(StringUtils.isBlank(poster)){
			if("".equals(u)){
				poster = "system";
			}else{
				poster = u.getUserCode();
			}			
		}
		message.setPoster(poster);								// 发送人
	    message.setContext(context);							// 单据信息
	    message.setRevicerType(revicerType);					// 接收类型  1：全员  2：指定人员
	    message.setType(PushMessage.TYPE_TEXT_MESSAGE);			// 1：普通文本消息 2：超链接消息
	    message.setPushType(PushMessage.PUSHTYPE_REAL_TIME);	// 1：实时推送 2：定时推送 3：汇总推送
	    if(billType.equals("GG")){//如果是公告则保存类型为1
	    	message.setContentType("1");
	    }
	    else if(billType.equals("XW")){//如果是新闻则保存类型为2
	    	message.setContentType("2");
	    }
	    else if(billType.equals("HY")){//如果是会议则保存类型为3
	    	message.setContentType("3");
	    }
	    else{
	    	message.setContentType("4");//如果是其他则保存类型为3
	    }
	    message.setContentLevel("1");
	    //userList
	    List<String> userList=new ArrayList<String>();	
	    if(StringUtils.isNotBlank(userCodes)){
		    String userCode[] = userCodes.split(",");	   
		    Collections.addAll(userList, userCode);	
	    }
	//   PushResponse result = pushMessageService.sendMessage(message, userList, map);
//	    if(result.isSuccess()){
//	    	return "200";
//	    }else{
//	    	return "201";
//	    }
        return "200";
	}
	
	
	/**
	 * 微信推送(下面是必填入参)
	 * @Title: pushWeChatMessage 
	 * @createBy：Mc
	 * @date: 2017年2月22日 下午2:14:35
	 */
	@Transactional(readOnly = false)
	public String pushWeChatMessage(AppMessage appMessage) {		
		String applyDate = null;
		if(appMessage.getApplyDate() != null){
			//初始化日期
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");	
			applyDate = sdf.format(appMessage.getApplyDate());
		}
		String title = null;	// 消息内容
		String url = null;		// 微信点击消息跳转地址	
		String sendAfterStatus = "1";	// 已读未读状态 1:未读 2：已读
		if(StringUtils.isBlank(appMessage.getContentTitle())){
			if (appMessage.isAgree()) {			
				//url = Global.getConfig("wechat.site") + "/wx/messageSsolLogin?contentType=" + appMessage.getContentType() + "&userCode=" + appMessage.getReceiverCodes();
				if (appMessage.getApplyMoney() != null) {
					title = "您有一笔" + appMessage.getApplicantName() + "的" + appMessage.getBizName() + ",金额" + appMessage.getApplyMoney() + "元";
				} else {
					title = "您有一笔" + appMessage.getApplicantName() + "的" + appMessage.getBizName();
				}
			}else{
				title = "您的" + appMessage.getBizName() + "审核未通过";
				sendAfterStatus = "2";//发送消息的时候直接改为已读
			}
		}else{
			title = appMessage.getContentTitle();
		}	
		//定义微信模板ID
		String templage = null;
		if(StringUtils.isBlank(appMessage.getTemplageMessage())){
			//测试
			//templage= "jqm6_5vlYUsNG7vLFjEEdeSHcP6xVfc2aLwvaOTUeOw";
			//正式
			templage= "ZjYK__o6Rv7Fg5mNj1KQB3StXnXdzG66qk20-1KBo8A";
		}else{
			templage = appMessage.getTemplageMessage();
		}
		
		//微信发送模板消息
	    TemplateMessage templageMessage = new TemplateMessage(templage,url)
		   .pushHead(appMessage.getTemplageHead() == null ?appMessage.getApplicantName()+"的"+appMessage.getBizName():appMessage.getTemplageHead())
		   .pushItem("keyword1", title)
		   .pushItem("keyword2", appMessage.getKeyword2() == null ?appMessage.getApplicantName() : appMessage.getKeyword2())
		   .pushItem("keyword3", appMessage.getKeyword3() == null ?appMessage.getBizName() : appMessage.getKeyword3())
		   .pushItem("keyword4", appMessage.getKeyword4() == null ?applyDate : appMessage.getKeyword4());
	    if(appMessage.getBizType()=="KP"){
	    	 templageMessage = new TemplateMessage(templage,url)
			   .pushHead(appMessage.getTemplageHead() == null ?appMessage.getApplicantName()+"的"+appMessage.getBizName():appMessage.getTemplageHead())
			   .pushItem("keyword1", appMessage.getApplicantName())
			   .pushItem("keyword2", appMessage.getKeyword2() == null ?String.valueOf(appMessage.getApplyMoney()): appMessage.getKeyword2())
			   .pushItem("keyword3", appMessage.getKeyword3() == null ?applyDate : appMessage.getKeyword3())
			   .pushItem("keyword4", appMessage.getKeyword4() == null ?appMessage.getContent() : appMessage.getKeyword4());
	    }
	    if(appMessage.getBizType()=="SK"){
	    	templageMessage = new TemplateMessage(
		    		templage,
					url)
			   .pushHead(appMessage.getTemplageHead() == null ?appMessage.getApplicantName()+"的"+appMessage.getBizName()
					   :appMessage.getTemplageHead())
			   .pushItem("keyword1", appMessage.getApplicantName())
			   .pushItem("keyword2", appMessage.getKeyword2() == null ?String.valueOf(appMessage.getApplyMoney())+'('+appMessage.getNumSumMoney()+')': appMessage.getKeyword2())
			   .pushItem("keyword3", appMessage.getKeyword3() == null ?appMessage.getContentText() : appMessage.getKeyword3())
			   .pushItem("keyword4", appMessage.getKeyword4() == null ?applyDate : appMessage.getKeyword4())
		       .pushItem("keyword5", appMessage.getKeyword4() == null ?appMessage.getContentTitle() : appMessage.getKeyword4());
	    }
		   //.pushTail("#0000FF","请尽快办理，谢谢！");
	    //测试
	    //String appidXCX="wx28542a95718c4d01";
	    //正式
	    String appidXCX="wxf6fbc29ec0cc9e23";
	    if(appMessage.getBizType()=="QJ"){
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/leaveDetails/leaveDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="WC"){
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/outDetails/outDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="BX"){
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/feeDetails/feeDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="CC"){ //2018/4/16  于慧亮add  出差
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/businessTripDetails/businessTripDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="QS"){ //2018/4/16  于慧亮add  业务请示
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/applyDetails/applyDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="LZ"){ //2018/4/16  于慧亮add  离职申请
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/resignationDetails/resignationDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="JK"){ //2018/4/16  于慧亮add  借款申请
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/borrowDoneDetails/borrowDoneDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="ZF"){ //2018/4/16  于慧亮add  对公支付
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/payPublic/payPublic?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="BXI"){ //2018/4/16  于慧亮add  报修
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/repairDetails/repairDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="XKZ"){ //2018/4/16  于慧亮add  许可证
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/licenseDetails/licenseDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="JF"){ //2018/4/16  于慧亮add  奖罚
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/rewardPunishmentDetails/rewardPunishmentDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="JB"){ //2018/4/16  于慧亮add  加班
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/overTimeDetails/overTimeDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="YCSQ"){ //2018/4/16  于慧亮add  用车申请
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/carApplyDetails/carApplyDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }
	    else if(appMessage.getBizType()=="YGDJ"){ //2018/4/16  于慧亮add 员工登记
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/employee/employee?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }
	    else if(appMessage.getBizType() == "ZC"){ //2018/6/1  李则良add 资产申请
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/assetsApplyDetail/assetsApplyDetail?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType() == "ZCGH"){ //2018/6/1  李则良add 资产归还
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/assetsReturnDetail/assetsReturnDetail?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }
	    else if(appMessage.getBizType() == "YZHTSQ"){ //2018/6/20 于慧亮add 用章
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/oaContractChapterDetail/oaContractChapterDetail?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }
	    else if(appMessage.getBizType()=="KP"){
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/salesInvoiceDetail/salesInvoiceDetail?sysCode=" + appMessage.getBizKey()+"&totalSumAll="+appMessage.getApplyMoney());
	    	templageMessage.pushTail("#0000FF", "点击可查看详情");
	    }else if(appMessage.getBizType()=="SK"){//只提醒
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/receivableDetail/receivableDetail?sysCode=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "点击可查看详情");
	    }
	    else if(appMessage.getBizType()=="XZ"){
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/salaryStandardDetail/salaryStandardDetail?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="RK1"){//2018/8/9 徐兰add 入库单
	    	templageMessage.setMiniprogram(appidXCX, "pages/scm/inoutDetail/inoutDetail?id=" + appMessage.getBizKey()+"&page=approval");
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else if(appMessage.getBizType()=="CK1"){//2018/8/13 徐兰add 出库单
	    	templageMessage.setMiniprogram(appidXCX, "pages/scm/inoutDetail/inoutDetail?id=" + appMessage.getBizKey()+"&page=approval");
	    	templageMessage.pushTail("#0000FF", "请尽快办理,谢谢（单击可进入小程序）");
	    }else{
	    	templageMessage.pushTail("请尽快办理,谢谢");
	    }
	    
	  //  String contentType = StringUtils.isBlank(appMessage.getContentType()) ? Message.TYPE_WEIXIN : appMessage.getContentType();
		try {
			 //如果微信接受者不为空则执行推送微信消息
			 //if (StringUtils.isNotBlank(appMessage.getReceiverCodes()) && StringUtils.isNotBlank(appMessage.getReceiverNames())) {
			/*WeixinUtils.sendMessage(templageMessage, appMessage.getReceiverType(), appMessage.getReceiverCodes(), 
						appMessage.getReceiverNames(), appMessage.getBizKey(), appMessage.getBizType(), title, 
						contentType, sendAfterStatus);		*/	
			WeixinMsgPushUtils.push(templageMessage, appMessage.getBizKey(), appMessage.getBizType(), appMessage.getReceiverCodes());
			return "200";
		} catch (Exception e) {
			return "201";
			// TODO: handle exception
		}	   
	}

	/**
	 * 
	 * @Title: findBillList 
	 * @Description: app端单据列 chenyuan
	 * @param appMessage
	 * @return
	 */	
	public Page<AppMessage> findBillList(Page<AppMessage> page, AppMessage appMessage) {
		try {
			entityClass.getMethod("setPage", Page.class).invoke(appMessage, page);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		page.setList(dao.findBillList(appMessage));
		return page;
	}
	/**
	 * 
	 * @Title: findBillFeeList 
	 * @Description: app端单据列 chenyuan
	 * @param page
	 * @param appMessage
	 * @return
	 */
	public Page<AppMessage> findBillFeeList(Page<AppMessage> page, AppMessage appMessage) {
		try {
			entityClass.getMethod("setPage", Page.class).invoke(appMessage, page);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		page.setList(dao.findBillFeeList(appMessage));
		return page;
	}


	/**
	 * 获取二级权限
	 * @Title: getRoleMenuByParentCode 
	 * @Description: TODO
	 * @author: Mc
	 * @date: 2017年5月10日 上午11:21:16 
	 * @return
	 */
	public List<Menu> getRoleMenuByParentCode(Menu menu) {
		return dao.getRoleMenuByParentCode(menu);
	}
	
	/** 
	 * @Title: pushReceiptWeChatMessage 
	 * @Description: TODO
	 * @param appMessage
	 * @return
	 */
	@Transactional(readOnly = false)
	public String pushReceiptWeChatMessage(AppMessage appMessage) {		
		String applyDate = null;
		if(appMessage.getApplyDate() != null){
			//初始化日期
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");	
			applyDate = sdf.format(appMessage.getApplyDate());
		}
		String title = null;	// 消息内容
		String url = null;		// 微信点击消息跳转地址	
		String sendAfterStatus = "1";	// 已读未读状态 1:未读 2：已读
		if(StringUtils.isBlank(appMessage.getContentTitle())){
			if (appMessage.isAgree()) {			
					title = "您有一笔" + appMessage.getApplicantName() + "的" + appMessage.getBizName();
				}
			
		}else{
			title = appMessage.getContentTitle();
		}	
		//定义微信模板ID
		String templage = null;
		if(StringUtils.isBlank(appMessage.getTemplageMessage())){
			templage= "g0jd_yMnQPvH1iRG7uKKYMR8LVkENVYwgMVgpZs-GI8";
		}else{
			templage = appMessage.getTemplageMessage();
		}
		//微信发送模板消息
	    TemplateMessage templageMessage = new TemplateMessage(
	    		templage,
				url)
		   .pushHead(appMessage.getTemplageHead() == null ?appMessage.getApplicantName()+"的"+appMessage.getBizName()
				   :appMessage.getTemplageHead())
		   .pushItem("keyword1", appMessage.getApplicantName())
		   .pushItem("keyword2", appMessage.getKeyword2() == null ?String.valueOf(appMessage.getApplyMoney()): appMessage.getKeyword2())
		   .pushItem("keyword3", appMessage.getKeyword3() == null ?appMessage.getContentText() : appMessage.getKeyword3())
		   .pushItem("keyword4", appMessage.getKeyword4() == null ?applyDate : appMessage.getKeyword4())
	       .pushItem("keyword5", appMessage.getKeyword4() == null ?appMessage.getContentTitle() : appMessage.getKeyword4());
		   //.pushTail("#0000FF","请尽快办理，谢谢！");
	    String appidXCX="wxf6fbc29ec0cc9e23";
	    if(appMessage.getBizType()=="SK"){
	    	templageMessage.setMiniprogram(appidXCX, "pages/business/feeDetails/feeDetails?id=" + appMessage.getBizKey());
	    	templageMessage.pushTail("#0000FF", "感谢您的使用（单击可进入小程序）");
	    }
	    else{
	    	templageMessage.pushTail("感谢您的使用");
	    }
	    
	   // String contentType = StringUtils.isBlank(appMessage.getContentType()) ? Message.TYPE_WEIXIN : appMessage.getContentType();
		try {
			 //如果微信接受者不为空则执行推送微信消息
		/*	WeixinUtils.sendMessage(templageMessage, appMessage.getReceiverType(), appMessage.getReceiverCodes(), 
						appMessage.getReceiverNames(), appMessage.getBizKey(), appMessage.getBizType(), title, 
						contentType, sendAfterStatus);*/
			// 即时推送消息
		     WeixinMsgPushUtils.push(templageMessage, appMessage.getBizKey(), appMessage.getBizType(), appMessage.getReceiverCodes());
			return "200";
		} catch (Exception e) {
			return "201";
		}	   
	}
	public Page<FlowLog> fingFinishPage(Page<FlowLog> page, FlowLog flowLog) {
		flowLog.setPage(page);
		flowLog.setBilltypeCode("CG");
		List<FlowLog> finishList = dao.findFinishList(flowLog);
//		if (org.apache.commons.lang3.StringUtils.isNotBlank(flowLog.getSearchFlag())) {
//			User currentUser = UserUtils.getUser();
//			flowLog.setApplicantCode(currentUser.getUserCode());
//			List<FlowLog> logList = dao.findapplicationList(flowLog);
//			Iterator var6 = logList.iterator();
//
//			while(var6.hasNext()) {
//				FlowLog fl = (FlowLog)var6.next();
//				fl.setDataType("sq");
//				finishList.add(fl);
//			}
//		}

		page.setList(finishList);
		return page;
	}
	public Page<FlowBusiness> findProcessList(Page<FlowBusiness> page, FlowBusiness flowBusiness) {
		flowBusiness.setPage(page);
		flowBusiness.setBilltypeCode("CG");
		User currentUser = UserUtils.getUser();
		flowBusiness.setApprovalCode(currentUser.getUserCode());
		page.setList(dao.findProcessList(flowBusiness));
		return page;
	}
	public Page<FlowLog> findapplicationList(Page<FlowLog> page, FlowLog flowLog) {
		try {
			this.entityClass.getMethod("setPage", Page.class).invoke(flowLog, page);
		} catch (Exception var4) {
			var4.printStackTrace();
		}
		flowLog.setBilltypeCode("CG");
		User currentUser = UserUtils.getUser();
		flowLog.setApplicantCode(currentUser.getUserCode());
		page.setList(dao.findapplicationList(flowLog));
		return page;
	}

	/**
	 * 查询人员编码并关联公司部门（按照通讯录排序）
	 * @param people
	 * @return
	 * @author yhl
	 */
	public List<PeoPleSearch> findPersonnelInfo(PeoPleSearch people) {
		return dao.findPersonnelInfo(people);
	}



}