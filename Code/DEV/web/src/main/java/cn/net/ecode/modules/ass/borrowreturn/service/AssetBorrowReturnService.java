/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrowreturn.service;

import cn.net.ecode.common.mapper.JsonMapper;
import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.service.AssetBorrowDtlService;
import cn.net.ecode.modules.ass.borrowreturn.dao.AssetBorrowReturnDao;
import cn.net.ecode.modules.ass.borrowreturn.dao.AssetBorrowReturnDtlDao;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturn;
import cn.net.ecode.modules.ass.borrowreturn.entity.AssetBorrowReturnDtl;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.Push;
import cn.net.ecode.modules.ass.common.service.AppMessageService;
import cn.net.ecode.modules.ass.common.service.PushModelService;
import cn.net.ecode.modules.ass.common.service.PushService;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.eflow.entity.FlowBusiness;
import cn.net.ecode.modules.eflow.service.FlowBusinessService;
import cn.net.ecode.modules.eflow.service.FlowLogService;
import cn.net.ecode.modules.msg.entity.Message;
import cn.net.ecode.modules.msg.entity.PushMessage;
import cn.net.ecode.modules.sys.entity.User;
import cn.net.ecode.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 资产归还Service
 * @author shiwangwang
 * @version 2018-10-09
 */
@Service
@Transactional(readOnly = true)
public class AssetBorrowReturnService extends CrudService<AssetBorrowReturnDao, AssetBorrowReturn> {
	@Autowired
	private AssetBorrowDtlService assetBorrowDtlService;
	@Autowired
	private AssetBorrowReturnDtlDao assetBorrowReturnDtlDao;
	@Autowired
	private AssetInfoService assetInfoService;
	@Autowired
	private PushModelService pushModelService;
	@Autowired
	private AppMessageService appMessageService;
	@Autowired
	private FlowBusinessService flowBusinessService;
	@Autowired
	private FlowLogService flowLogService;
	@Autowired
	private PushService pushService;
	/**
	 * 获取单条数据
	 * @param assetBorrowReturn
	 * @return
	 */
	public AssetBorrowReturn get(AssetBorrowReturn assetBorrowReturn) {
		return super.get(assetBorrowReturn);
	}
	
	/**
	 * 查询列表数据
	 * @param assetBorrowReturn
	 * @return
	 */
	public List<AssetBorrowReturn> findList(AssetBorrowReturn assetBorrowReturn) {
		return super.findList(assetBorrowReturn);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assetBorrowReturn
	 * @return
	 */
	public Page<AssetBorrowReturn> findPage(Page<AssetBorrowReturn> page, AssetBorrowReturn assetBorrowReturn) {
		return super.findPage(page, assetBorrowReturn);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param assetBorrowReturn
	 */
	@Transactional(readOnly = false)
	public void save(AssetBorrowReturn assetBorrowReturn) {
		if(assetBorrowReturn.getIsNewRecord()){
			super.save(assetBorrowReturn);
			saveDtl(assetBorrowReturn);
			submitForApproval(assetBorrowReturn);
		}else{
			if (assetBorrowReturn.getApprovalStatus().equals("0")||assetBorrowReturn.getApprovalStatus().equals("3")) {
				super.save(assetBorrowReturn);
				submitForApproval(assetBorrowReturn);
			}
			if (assetBorrowReturn.getStep().equals("2")) {
				for (AssetBorrowReturnDtl assetBorrowReturnDtl : assetBorrowReturn.getAssetBorrowReturnDtl()) {
					AssetBorrowReturnDtl assetBorrowReturnDtl1 = new AssetBorrowReturnDtl();
					assetBorrowReturnDtl.setBorrowCode(assetBorrowReturn.getId());
					assetBorrowReturnDtlDao.deleteDtl(assetBorrowReturnDtl);
					saveDtl(assetBorrowReturn);
				}
			}
		}

	}
/**
 * 保存字表数据
 */
public  void saveDtl(AssetBorrowReturn assetBorrowReturn){
	for (AssetBorrowReturnDtl assetBorrowReturnDtl : assetBorrowReturn.getAssetBorrowReturnDtl()) {
		assetBorrowReturnDtl.setBorrowCode(assetBorrowReturn.getId());
		User user=new User();
		user.setUserCode(assetBorrowReturn.getBorrowerCode());
		assetBorrowReturnDtl.setUser(user);
		assetBorrowReturnDtl.setUserName(assetBorrowReturn.getBorrowerName());
		assetBorrowReturnDtl.preInsert();
		dao.saveassetBorrowDtl(assetBorrowReturnDtl);
	}
}
	@Transactional(readOnly = false)
	public List<AssetInfo> findAsset(AssetInfo assetInfo) {
		return   dao.findAsset(assetInfo);
	}
	/**
	 * 提交审批
	 */
	public void submitForApproval(AssetBorrowReturn assetBorrowReturn) {


		User currUser = UserUtils.getUser();
		//调用JUDP3.0工作流----start ydy
		AssetBorrowReturn assetBorrowReturn1 = new AssetBorrowReturn();
		assetBorrowReturn1.setBorrowerCode(currUser.getRefCode());
		AssetBorrowReturn ot = getOffice(assetBorrowReturn1);
		FlowBusiness flowBusiness = new FlowBusiness();
		if (assetBorrowReturn.getApproval() != null) {
			flowBusiness.setApprovalCode(assetBorrowReturn.getApproval());    // 必填-审核人编码
		} else if (assetBorrowReturn.getApprovalCode() != null) {
			flowBusiness.setApprovalCode(assetBorrowReturn.getApprovalCode());    // 必填-审核人编码
		}
		flowBusiness.setLinkUrlPc("/return/assetBorrowReturn/form?id=" + assetBorrowReturn.getId());// 必填-单据详情页链接地址
		flowBusiness.setBizKey(assetBorrowReturn.getId()); // 必填-业务单号/id
		flowBusiness.setBilltypeCode("ZCJYGH"); // 必填-单据类型
		flowBusiness.setCompanyCode(ot.getCompanyCode());// 必填-公司编码
		flowBusiness.setOfficeCode(ot.getOfficeCode());//  必填-部门编码
		flowBusiness.setFlowId(assetBorrowReturn.getFlowId()); // 必填-工作流模板ID
		flowBusiness.setBillDate(new Date()); // 必填-单据日期
		flowBusiness.setApplicantCode(currUser.getUserCode());    // 必填-申请人编码
		//  flowBusiness.setLinkUrlApp("../billDetail/AssetUsedInfoBill.w?id="+AssetUsedInfo.getId()); // 选填-APP单据详情页链接地址
		flowBusiness.setBillAmt(null);    // 选填-单据金额
		flowBusiness.setContent(currUser.getUserName() + "提交的资产归还申请");    // 选填-业务描述
		flowBusinessService.submit(flowBusiness);
		AssetBorrowReturn hl = get(assetBorrowReturn);
		hl.setApprovalStatus("1");
		dao.update(hl);
		//调用JUDP3.0工作流----end
		Map<String, Boolean> map = pushModelService.pushType(assetBorrowReturn.getApprovalCode());
		if (!map.isEmpty()) {
			//判断单据类通知推送方式
			if (map.get("billNotice")) {
				if (map.get("pushAurora")) {
					//极光推送
					appMessageService.pushMessage(assetBorrowReturn.getApprovalCode(), currUser.getUserName() + "的资产归还申请",
							assetBorrowReturn.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.ZCJYGH, null);//调用极光推送接口
				}
				if (map.get("pushWeChat")) {
					//微信推送
					AppMessage message = new AppMessage();
					message.setApplicantName(assetBorrowReturn.getBorrowerName());
					message.setApplyDate(assetBorrowReturn.getBorrowDate());
					message.setApplyMoney(null);
					message.setBizKey(assetBorrowReturn.getId());
					message.setBizType(BillTypeUtils.ZCJYGH);
					message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
					message.setReceiverType(Message.RECEIVER_TYPE_USER);
					message.setReceiverCodes(assetBorrowReturn.getApprovalCode());
					message.setReceiverNames(assetBorrowReturn.getApprovalName());
					message.setAgree(true);
					appMessageService.pushWeChatMessage(message);
				}
			} else {
				//保存延时推送中间表数据
				Push push = new Push();
				User curr = UserUtils.getUser();
				push.setOriginateCode(curr.getUserCode());
				push.setOriginateName(curr.getUserName());
				push.setReceiverCode(assetBorrowReturn.getApprovalCode());
				push.setReceiverName(assetBorrowReturn.getApprovalName());
				//当前时间加上半小时
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(new Date());
				calendar.add(Calendar.MINUTE, 30);
				push.setReceiverDate(calendar.getTime());
				push.setReceiverContent(assetBorrowReturn.getBorrowerName() + "的" + BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
				push.setBizKey(assetBorrowReturn.getId());
				push.setBizType(BillTypeUtils.ZCJYGH);
				push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
				push.setReceiverType(Message.RECEIVER_TYPE_USER);
				//业务单据参数
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Map<String, String> param = new HashMap<String, String>();
				param.put("applicantName", assetBorrowReturn.getBorrowerName());
				param.put("applyDate", sdf.format(assetBorrowReturn.getBorrowDate()));
				String pushParam = JsonMapper.toJsonString(param);
				push.setPushParam(pushParam);
				push.preInsert();
				push.setIsNewRecord(true);//插入表数据
				pushService.save(push);
			}
		}


	}
	@Transactional(readOnly = false)
	public List<AssetBorrowReturnDtl> findListDtl(AssetBorrowReturnDtl assetBorrowReturnDtl) {
		return   dao.findListDtl(assetBorrowReturnDtl);
	}
	@Transactional(readOnly = false)
	public void agree(AssetBorrowReturn assetBorrowReturn) {
		// 调用JUDP3.0 同意方法
		String isEnd = flowBusinessService.auditPass(assetBorrowReturn.getFlowBusinessId(), assetBorrowReturn.getApprovalMemo1(), assetBorrowReturn.getNextApprovalCode());
		//更改业务表数据 TO-DO
		if ("1".equals(isEnd)) {//已经终审
			AssetBorrowReturn hl = get(assetBorrowReturn);
			hl.setApprovalStatus("2");
			dao.update(hl);
			AssetBorrowReturnDtl assetBorrowReturnDtl=new AssetBorrowReturnDtl();
			assetBorrowReturnDtl.setBorrowCode(assetBorrowReturn.getId());
			List<AssetBorrowReturnDtl> assetBorrowReturnDtls = findReturnDtl(assetBorrowReturnDtl);
			for(AssetBorrowReturnDtl e :assetBorrowReturnDtls){
				AssetBorrowDtl assetBorrowDtl = new AssetBorrowDtl();
				assetBorrowDtl.setAssetCode(e.getAssetCode());
				assetBorrowDtl.setReturnStatus("1");
/**改变使用人跟状态*/
				AssetInfo assetInfo = new AssetInfo();
				assetInfo.setAssetCode(e.getAssetCode());
				assetInfo.setUserName(e.getYuanuserName());
				if (e.getAssetStatus().equals("0")){
					assetInfo.setAssetStatus("0");
				}else if(e.getAssetStatus().equals("1")){
					assetInfo.setAssetStatus("1");
				}

				dao.updateuserName(assetInfo);
				assetBorrowDtlService.updatauserStatus2(assetBorrowDtl);
			}
		} else {
			AssetBorrowReturn hl = get(assetBorrowReturn);
			hl.setApprovalStatus("1");
			dao.update(hl);
		}
		//如果下一步审批人为空，证明该流程已经结束
		if (cn.net.ecode.common.utils.StringUtils.isNotEmpty(assetBorrowReturn.getNextApprovalCode())) {
			//推送----Mc add 20170228
			Map<String, Boolean> map = pushModelService.pushType(assetBorrowReturn.getNextApprovalCode());
			if (!map.isEmpty()) {
				//判断单据类通知推送方式
				if (map.get("billNotice")) {
					if (map.get("pushAurora")) {
						//极光推送
						appMessageService.pushMessage(assetBorrowReturn.getNextApprovalCode(), assetBorrowReturn.getBorrowerName() + "的资产领用申请", assetBorrowReturn.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.ZCJYGH, null);//调用极光推送接口
					}
					if (map.get("pushWeChat")) {
						//微信推送
						AppMessage message = new AppMessage();
						message.setApplicantName(assetBorrowReturn.getBorrowerName());
						message.setApplyDate(assetBorrowReturn.getBorrowDate());
						message.setApplyMoney(null);
						message.setBizKey(assetBorrowReturn.getId());
						message.setBizType(BillTypeUtils.ZCJYGH);
						message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
						message.setReceiverType(Message.RECEIVER_TYPE_USER);
						message.setReceiverCodes(assetBorrowReturn.getNextApprovalCode());
						message.setReceiverNames(assetBorrowReturn.getNextApprovalName());
						message.setAgree(true);
						appMessageService.pushWeChatMessage(message);
					}
				} else {
					//保存延时推送中间表数据
					Push push = new Push();
					User curr = UserUtils.getUser();
					push.setOriginateCode(curr.getUserCode());
					push.setOriginateName(curr.getUserName());
					push.setReceiverCode(assetBorrowReturn.getNextApprovalCode());
					push.setReceiverName(assetBorrowReturn.getNextApprovalName());
					//当前时间加上半小时
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(new Date());
					calendar.add(Calendar.MINUTE, 30);
					push.setReceiverDate(calendar.getTime());
					push.setReceiverContent(assetBorrowReturn.getBorrowerName() + "的资产归还申请");
					push.setBizKey(assetBorrowReturn.getId());
					push.setBizType(BillTypeUtils.ZCJYGH);
					push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
					push.setReceiverType(Message.RECEIVER_TYPE_USER);
					//业务单据参数
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Map<String, String> param = new HashMap<String, String>();
					param.put("applicantName", assetBorrowReturn.getBorrowerName());
					param.put("applyDate", sdf.format(assetBorrowReturn.getBorrowDate()));
					String pushParam = JsonMapper.toJsonString(param);
					push.setPushParam(pushParam);
					push.preInsert();
					push.setIsNewRecord(true);//插入表数据
					pushService.save(push);
				}
			}
			//end
		}

	}

	@Transactional(readOnly = false)
	public void disagree(AssetBorrowReturn assetBorrowReturn) {
		//极光推送 20161102 Mc add
		if (assetBorrowReturn.getBorrowerCode() != null) {
			Map<String, Boolean> map = pushModelService.pushType(assetBorrowReturn.getBorrowerCode());
			if (!map.isEmpty()) {
				//判断单据类通知推送方式
				if (map.get("billNotice")) {
					if (map.get("pushAurora")) {
						//极光推送
						appMessageService.pushMessage(assetBorrowReturn.getBorrowerCode(), UserUtils.getUser().getUserName() + "不同意您提交的借用申请",
								assetBorrowReturn.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.ZCJYGH, null);//调用极光推送接口
					}
					if (map.get("pushWeChat")) {
						//微信推送
						AppMessage message = new AppMessage();
						message.setApplicantName(assetBorrowReturn.getBorrowerCode());
						message.setApplyDate(assetBorrowReturn.getBorrowDate());
						message.setApplyMoney(null);
						message.setBizKey(assetBorrowReturn.getId());
						message.setBizType(BillTypeUtils.ZCJYGH);
						message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
						message.setReceiverType(Message.RECEIVER_TYPE_USER);
						message.setReceiverCodes(assetBorrowReturn.getBorrowerCode());
						message.setReceiverNames(assetBorrowReturn.getBorrowerName());
						message.setAgree(false);
						appMessageService.pushWeChatMessage(message);
					}
				} else {
					//保存延时推送中间表数据
					Push push = new Push();
					User curr = UserUtils.getUser();
					push.setOriginateCode(curr.getUserCode());
					push.setOriginateName(curr.getUserName());
					push.setReceiverCode(assetBorrowReturn.getBorrowerCode());
					push.setReceiverName(assetBorrowReturn.getBorrowerName());
					//当前时间加上半小时
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(new Date());
					calendar.add(Calendar.MINUTE, 30);
					push.setReceiverDate(calendar.getTime());
					push.setReceiverContent(assetBorrowReturn.getBorrowerName() + "的" + BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
					push.setBizKey(assetBorrowReturn.getId());
					push.setBizType(BillTypeUtils.ZCJYGH);
					push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJYGH));
					push.setReceiverType(Message.RECEIVER_TYPE_USER);
					//业务单据参数
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Map<String, String> param = new HashMap<String, String>();
					param.put("applicantName", assetBorrowReturn.getBorrowerName());
					param.put("applyDate", sdf.format(assetBorrowReturn.getBorrowDate()));
					String pushParam = JsonMapper.toJsonString(param);
					push.setPushParam(pushParam);
					push.preInsert();
					push.setIsNewRecord(true);//插入表数据
					pushService.save(push);
				}
			}
		}
		//end
		// 调用JUDP3.0 不同意方法
		flowBusinessService.auditUnpass(assetBorrowReturn.getFlowBusinessId(), assetBorrowReturn.getApprovalMemo1());

		//更改业务表数据 TO-DO
		AssetBorrowReturn hl = get(assetBorrowReturn);
		hl.setApprovalStatus("3");
		dao.update(hl);
	}

	/**
	 * @return
	 * @Title: unDo
	 * @Description: 撤回审批
	 */
	@Transactional(readOnly = false)
	public String unDo(FlowBusiness flowBusiness) {
		String msg = null;
		if (cn.jpush.api.utils.StringUtils.isNotEmpty(flowBusiness.getBizKey())) {

			// 调用JUDP3.0 撤回方法
			msg = flowBusinessService.unDo(flowBusiness.getBizKey());

			//更改业务表数据 TO-DO
			AssetBorrowReturn hl1 = new AssetBorrowReturn();
			hl1.setId(flowBusiness.getBizKey());
			AssetBorrowReturn hl = get(hl1);
			hl.setApprovalStatus("0");
			dao.update(hl);
		}
		return msg;
	}


	@Transactional(readOnly = false)
	public String unSubmit(FlowBusiness flowBusiness) {
		String msg = null;
		if (cn.jpush.api.utils.StringUtils.isNotEmpty(flowBusiness.getBizKey())) {
			// 调用JUDP3.0 撤回方法
			msg = flowBusinessService.unSubmit(flowBusiness.getBizKey());
			if (cn.jpush.api.utils.StringUtils.isEmpty(msg)) {
				//更改业务表数据 TO-DO
				AssetBorrowReturn o = new AssetBorrowReturn();
				o.setId(flowBusiness.getBizKey());
				AssetBorrowReturn o1 = get(o);
				o1.setApprovalStatus("0");
				dao.update(o1);
			}
		}
		return msg;
	}

	/**
	 * 得到子表数据的sql
	 * @return
	 */
	public List<AssetBorrowReturnDtl> findUsedCode(AssetBorrowReturnDtl assetBorrowReturnDtl) {
		return assetBorrowReturnDtlDao.findUsedCode(assetBorrowReturnDtl);
	}
	public List<AssetBorrowReturnDtl> findReturnDtl(AssetBorrowReturnDtl assetBorrowReturnDtl) {
		return assetBorrowReturnDtlDao.findReturnDtl(assetBorrowReturnDtl);
	}
	/**
	 * 删除数据
	 * @param assetBorrowReturn
	 */
	@Transactional(readOnly = false)
	public void delete(AssetBorrowReturn assetBorrowReturn) {
		super.delete(assetBorrowReturn);
		AssetBorrowReturnDtl assetBorrowReturnDtl = new AssetBorrowReturnDtl();
//		assetBorrowReturnDtl.setAssetBorrowReturn(assetBorrowReturn);
		assetBorrowReturnDtl.preUpdate();
		assetBorrowReturnDtlDao.delete(assetBorrowReturnDtl);
	}
	/**
	 * @return
	 * @Title:getOffice
	 * @Description:获取部门信息
	 */
	public AssetBorrowReturn getOffice(AssetBorrowReturn assetBorrowReturn) {
		return dao.getOffice(assetBorrowReturn);
	}
	/**
	 * @Title: getCompanyCode
	 * @Description: 根据userCode查询公司编码
	 * @return
	 */

	public String getCompanyCode(AssetBorrowReturn assetBorrowReturn){
		return dao.getCompanyCode(assetBorrowReturn);
	}
}