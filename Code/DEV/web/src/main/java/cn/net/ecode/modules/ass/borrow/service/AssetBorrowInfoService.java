/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrow.service;

import java.text.SimpleDateFormat;
import java.util.*;

import cn.net.ecode.common.mapper.JsonMapper;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.assetsput.entity.AssetInfo;
import cn.net.ecode.modules.ass.assetsput.service.AssetInfoService;
import cn.net.ecode.modules.ass.borrow.dao.AssetBorrowDtlDao;
import cn.net.ecode.modules.ass.common.entity.AppMessage;
import cn.net.ecode.modules.ass.common.entity.Push;
import cn.net.ecode.modules.ass.common.service.AppMessageService;
import cn.net.ecode.modules.ass.common.service.PushModelService;
import cn.net.ecode.modules.ass.common.service.PushService;
import cn.net.ecode.modules.ass.common.utils.BillTypeUtils;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedDtl;
import cn.net.ecode.modules.ass.usedinfo.entity.AssetUsedInfo;
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

import cn.net.ecode.common.persistence.Page;
import cn.net.ecode.common.service.CrudService;
import cn.net.ecode.common.utils.IdGen;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowDtl;
import cn.net.ecode.modules.ass.borrow.entity.AssetBorrowInfo;
import cn.net.ecode.modules.ass.borrow.dao.AssetBorrowInfoDao;

/**
 * 资产借用Service
 */
@Service
@Transactional(readOnly = true)
public class AssetBorrowInfoService extends CrudService<AssetBorrowInfoDao, AssetBorrowInfo> {
	@Autowired
	private AssetBorrowDtlDao assetBorrowDtlDao;
	@Autowired
	private AssetBorrowDtlService assetBorrowDtlService;
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
	@Autowired
	private AssetInfoService assetInfoService;
	/**
	 * 获取单条数据
	 * @param assetBorrowInfo
	 * @return
	 */
	public AssetBorrowInfo get(AssetBorrowInfo assetBorrowInfo) {
		return super.get(assetBorrowInfo);
	}
	/**
	 * 查询列表数据
	 * @param assetBorrowInfo
	 * @return
	 */
	public List<AssetBorrowInfo> findList(AssetBorrowInfo assetBorrowInfo) {
		return super.findList(assetBorrowInfo);
	}

	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param assetBorrowInfo
	 * @return
	 */
	public Page<AssetBorrowInfo> findPage(Page<AssetBorrowInfo> page, AssetBorrowInfo assetBorrowInfo) {
		return super.findPage(page, assetBorrowInfo);
	}
	/**
	 * 保存数据（插入或更新）
	 * @param assetBorrowInfo
	 */
	@Transactional(readOnly = false)
	public void save(AssetBorrowInfo assetBorrowInfo) {

		if (assetBorrowInfo.getIsNewRecord()) {
			super.save(assetBorrowInfo);
			submitForApproval(assetBorrowInfo);
		} else {
			if (assetBorrowInfo.getApprovalStatus().equals("0")||assetBorrowInfo.getApprovalStatus().equals("3")) {
				super.save(assetBorrowInfo);
				submitForApproval(assetBorrowInfo);
			}
			if (assetBorrowInfo.getStep().equals("2")) {
				for (AssetBorrowDtl assetBorrowDtl : assetBorrowInfo.getAssetBorrowDtls()) {
					assetBorrowDtl.setBorrowCode(assetBorrowInfo.getId());
					User user=new User();
					user.setUserCode(assetBorrowInfo.getBorrowerCode());
					assetBorrowDtl.setUser(user);
					assetBorrowDtl.setReturnStatus("0");
					assetBorrowDtl.setUserName(assetBorrowInfo.getBorrowerName());
					assetBorrowDtl.preInsert();
					dao.saveassetBorrowDtl(assetBorrowDtl);
					AssetInfo assetInfo = new AssetInfo();/**改变使用人跟状态*/
					assetInfo.setAssetCode(assetBorrowDtl.getAssetCode());
					if (assetBorrowDtl.getAssetStatus().equals("0")){
						assetInfo.setAssetStatus("2");
					}else if(assetBorrowDtl.getAssetStatus().equals("1")){
						assetInfo.setAssetStatus("1");
					}
					user.setUserCode(assetBorrowInfo.getBorrowerCode());
					assetInfo.setUser(user);
					assetInfo.setUserName(assetBorrowInfo.getBorrowerName());
					assetInfo.setUseDate(assetBorrowInfo.getBorrowDate());
					dao.updatauserStatus(assetInfo);
				}
			}
		}
	}
	/**
	 * 提交审批
	 */
	public void submitForApproval(AssetBorrowInfo assetBorrowInfo) {

		User currUser = UserUtils.getUser();
		//调用JUDP3.0工作流----start ydy
		AssetBorrowInfo assetBorrowInfo1 = new AssetBorrowInfo();
		assetBorrowInfo1.setBorrowerCode(currUser.getRefCode());
		AssetBorrowInfo ot = getOffice(assetBorrowInfo1);
		FlowBusiness flowBusiness = new FlowBusiness();
		if (assetBorrowInfo.getApproval() != null) {
			flowBusiness.setApprovalCode(assetBorrowInfo.getApproval());    // 必填-审核人编码
		} else if (assetBorrowInfo.getApprovalCode() != null) {
			flowBusiness.setApprovalCode(assetBorrowInfo.getApprovalCode());    // 必填-审核人编码
		}
		flowBusiness.setLinkUrlPc("/borrow/assetBorrowInfo/form?id=" + assetBorrowInfo.getId());// 必填-单据详情页链接地址
		flowBusiness.setBizKey(assetBorrowInfo.getId()); // 必填-业务单号/id
		flowBusiness.setBilltypeCode("ZCJY"); // 必填-单据类型
		flowBusiness.setCompanyCode(ot.getCompanyCode());// 必填-公司编码
		flowBusiness.setOfficeCode(ot.getOfficeCode());//  必填-部门编码
		flowBusiness.setFlowId(assetBorrowInfo.getFlowId()); // 必填-工作流模板ID
		flowBusiness.setBillDate(new Date()); // 必填-单据日期
		flowBusiness.setApplicantCode(currUser.getUserCode());    // 必填-申请人编码
		//  flowBusiness.setLinkUrlApp("../billDetail/AssetUsedInfoBill.w?id="+AssetUsedInfo.getId()); // 选填-APP单据详情页链接地址
		flowBusiness.setBillAmt(null);    // 选填-单据金额
		flowBusiness.setContent(currUser.getUserName() + "提交的资产借用申请");    // 选填-业务描述
		flowBusinessService.submit(flowBusiness);
		AssetBorrowInfo hl = get(assetBorrowInfo);
		hl.setApprovalStatus("1");
		dao.update(hl);
		//调用JUDP3.0工作流----end
		Map<String, Boolean> map = pushModelService.pushType(assetBorrowInfo.getApprovalCode());
		if (!map.isEmpty()) {
			//判断单据类通知推送方式
			if (map.get("billNotice")) {
				if (map.get("pushAurora")) {
					//极光推送
					appMessageService.pushMessage(assetBorrowInfo.getApprovalCode(), currUser.getUserName() + "的资产领用申请",
							assetBorrowInfo.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.ZCJY, null);//调用极光推送接口
				}
				if (map.get("pushWeChat")) {
					//微信推送
					AppMessage message = new AppMessage();
					message.setApplicantName(assetBorrowInfo.getBorrowerName());
					message.setApplyDate(assetBorrowInfo.getBorrowDate());
					message.setApplyMoney(null);
					message.setBizKey(assetBorrowInfo.getId());
					message.setBizType(BillTypeUtils.ZCJY);
					message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
					message.setReceiverType(Message.RECEIVER_TYPE_USER);
					message.setReceiverCodes(assetBorrowInfo.getApprovalCode());
					message.setReceiverNames(assetBorrowInfo.getApprovalName());
					message.setAgree(true);
					appMessageService.pushWeChatMessage(message);
				}
			} else {
				//保存延时推送中间表数据
				Push push = new Push();
				User curr = UserUtils.getUser();
				push.setOriginateCode(curr.getUserCode());
				push.setOriginateName(curr.getUserName());
				push.setReceiverCode(assetBorrowInfo.getApprovalCode());
				push.setReceiverName(assetBorrowInfo.getApprovalName());
				//当前时间加上半小时
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(new Date());
				calendar.add(Calendar.MINUTE, 30);
				push.setReceiverDate(calendar.getTime());
				push.setReceiverContent(assetBorrowInfo.getBorrowerName() + "的" + BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
				push.setBizKey(assetBorrowInfo.getId());
				push.setBizType(BillTypeUtils.ZCJY);
				push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
				push.setReceiverType(Message.RECEIVER_TYPE_USER);
				//业务单据参数
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Map<String, String> param = new HashMap<String, String>();
				param.put("applicantName", assetBorrowInfo.getBorrowerName());
				param.put("applyDate", sdf.format(assetBorrowInfo.getBorrowDate()));
				String pushParam = JsonMapper.toJsonString(param);
				push.setPushParam(pushParam);
				push.preInsert();
				push.setIsNewRecord(true);//插入表数据
				pushService.save(push);
			}
		}
	}
	/**
	 * 删除数据
	 * @param assetBorrowInfo
	 */
	@Transactional(readOnly = false)
	public void delete(AssetBorrowInfo assetBorrowInfo) {
		super.delete(assetBorrowInfo);
	}
	/**
	 * 查询字表数据
	 * @param assetBorrowDtl
	 * @return
	 */
	@Transactional(readOnly = false)
	public List<AssetBorrowDtl> findListDtl(AssetBorrowDtl assetBorrowDtl) {
		return   dao.findListDtl(assetBorrowDtl);
	}
	@Transactional(readOnly = false)
	public void agree(AssetBorrowInfo AssetBorrowInfo) {
		// 调用JUDP3.0 同意方法
		String isEnd = flowBusinessService.auditPass(AssetBorrowInfo.getFlowBusinessId(), AssetBorrowInfo.getApprovalMemo1(), AssetBorrowInfo.getNextApprovalCode());
		//更改业务表数据 TO-DO
		if ("1".equals(isEnd)) {//已经终审
			AssetBorrowInfo hl = get(AssetBorrowInfo);
			hl.setApprovalStatus("2");
			dao.update(hl);
		} else {
			AssetBorrowInfo hl = get(AssetBorrowInfo);
			hl.setApprovalStatus("1");
			dao.update(hl);
		}
		//如果下一步审批人为空，证明该流程已经结束
		if (cn.net.ecode.common.utils.StringUtils.isNotEmpty(AssetBorrowInfo.getNextApprovalCode())) {
			//推送----Mc add 20170228
			Map<String, Boolean> map = pushModelService.pushType(AssetBorrowInfo.getNextApprovalCode());
			if (!map.isEmpty()) {
				//判断单据类通知推送方式
				if (map.get("billNotice")) {
					if (map.get("pushAurora")) {
						//极光推送
						appMessageService.pushMessage(AssetBorrowInfo.getNextApprovalCode(), AssetBorrowInfo.getBorrowerName() + "的资产领用申请", AssetBorrowInfo.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.ZCJY, null);//调用极光推送接口
					}
					if (map.get("pushWeChat")) {
						//微信推送
						AppMessage message = new AppMessage();
						message.setApplicantName(AssetBorrowInfo.getBorrowerName());
						message.setApplyDate(AssetBorrowInfo.getBorrowDate());
						message.setApplyMoney(null);
						message.setBizKey(AssetBorrowInfo.getId());
						message.setBizType(BillTypeUtils.ZCJY);
						message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
						message.setReceiverType(Message.RECEIVER_TYPE_USER);
						message.setReceiverCodes(AssetBorrowInfo.getNextApprovalCode());
						message.setReceiverNames(AssetBorrowInfo.getNextApprovalName());
						message.setAgree(true);
						appMessageService.pushWeChatMessage(message);
					}
				} else {
					//保存延时推送中间表数据
					Push push = new Push();
					User curr = UserUtils.getUser();
					push.setOriginateCode(curr.getUserCode());
					push.setOriginateName(curr.getUserName());
					push.setReceiverCode(AssetBorrowInfo.getNextApprovalCode());
					push.setReceiverName(AssetBorrowInfo.getNextApprovalName());
					//当前时间加上半小时
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(new Date());
					calendar.add(Calendar.MINUTE, 30);
					push.setReceiverDate(calendar.getTime());
					push.setReceiverContent(AssetBorrowInfo.getBorrowerName() + "的资产借用申请");
					push.setBizKey(AssetBorrowInfo.getId());
					push.setBizType(BillTypeUtils.ZCJY);
					push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
					push.setReceiverType(Message.RECEIVER_TYPE_USER);
					//业务单据参数
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Map<String, String> param = new HashMap<String, String>();
					param.put("applicantName", AssetBorrowInfo.getBorrowerName());
					param.put("applyDate", sdf.format(AssetBorrowInfo.getBorrowDate()));
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
	public void disagree(AssetBorrowInfo AssetBorrowInfo) {
		//极光推送
		if (AssetBorrowInfo.getBorrowerCode() != null) {
			Map<String, Boolean> map = pushModelService.pushType(AssetBorrowInfo.getBorrowerCode());
			if (!map.isEmpty()) {
				//判断单据类通知推送方式
				if (map.get("billNotice")) {
					if (map.get("pushAurora")) {
						//极光推送
						appMessageService.pushMessage(AssetBorrowInfo.getBorrowerCode(), UserUtils.getUser().getUserName() + "不同意您提交的借用申请",
								AssetBorrowInfo.getId(), PushMessage.REVICERTYPE_USER_LIST, BillTypeUtils.ZCJY, null);//调用极光推送接口
					}
					if (map.get("pushWeChat")) {
						//微信推送
						AppMessage message = new AppMessage();
						message.setApplicantName(AssetBorrowInfo.getBorrowerCode());
						message.setApplyDate(AssetBorrowInfo.getBorrowDate());
						message.setApplyMoney(null);
						message.setBizKey(AssetBorrowInfo.getId());
						message.setBizType(BillTypeUtils.ZCJY);
						message.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
						message.setReceiverType(Message.RECEIVER_TYPE_USER);
						message.setReceiverCodes(AssetBorrowInfo.getBorrowerCode());
						message.setReceiverNames(AssetBorrowInfo.getBorrowerName());
						message.setAgree(false);
						appMessageService.pushWeChatMessage(message);
					}
				} else {
					//保存延时推送中间表数据
					Push push = new Push();
					User curr = UserUtils.getUser();
					push.setOriginateCode(curr.getUserCode());
					push.setOriginateName(curr.getUserName());
					push.setReceiverCode(AssetBorrowInfo.getBorrowerCode());
					push.setReceiverName(AssetBorrowInfo.getBorrowerName());
					//当前时间加上半小时
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(new Date());
					calendar.add(Calendar.MINUTE, 30);
					push.setReceiverDate(calendar.getTime());
					push.setReceiverContent(AssetBorrowInfo.getBorrowerName() + "的" + BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
					push.setBizKey(AssetBorrowInfo.getId());
					push.setBizType(BillTypeUtils.ZCJY);
					push.setBizName(BillTypeUtils.getBillTypeName(BillTypeUtils.ZCJY));
					push.setReceiverType(Message.RECEIVER_TYPE_USER);
					//业务单据参数
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Map<String, String> param = new HashMap<String, String>();
					param.put("applicantName", AssetBorrowInfo.getBorrowerName());
					param.put("applyDate", sdf.format(AssetBorrowInfo.getBorrowDate()));
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
		flowBusinessService.auditUnpass(AssetBorrowInfo.getFlowBusinessId(), AssetBorrowInfo.getApprovalMemo1());
		//更改业务表数据 TO-DO
		AssetBorrowInfo hl = get(AssetBorrowInfo);
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
			AssetBorrowInfo hl1 = new AssetBorrowInfo();
			hl1.setId(flowBusiness.getBizKey());
			AssetBorrowInfo hl = get(hl1);
			hl.setApprovalStatus("1");
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
				AssetBorrowInfo o = new AssetBorrowInfo();
				o.setId(flowBusiness.getBizKey());
				AssetBorrowInfo o1 = get(o);
				o1.setApprovalStatus("0");
				dao.update(o1);
			}
		}
		return msg;
	}
	/**
	 * @Title: getCompanyCode
	 * @Description: 根据userCode查询公司编码
	 * @return
	 */
	public String getCompanyCode(AssetBorrowInfo assetBorrowInfo){
		return dao.getCompanyCode(assetBorrowInfo);
	}
	/**
	 * @Title:getOffice
	 * @Description:获取部门信息
	 * @return
	 */
	public AssetBorrowInfo getOffice(AssetBorrowInfo assetBorrowInfo ) {
		return dao.getOffice(assetBorrowInfo);
	}
	@Transactional(readOnly = false)
	public void deleteassetBorrowDtl(AssetBorrowDtl assetBorrowDtl) {
		dao.deleteassetBorrowDtl(assetBorrowDtl);
	}
	/**
	 * 查询闲置数据
	 * @param assetInfo
	 * @return
	 */
	public List<AssetInfo> findAssetInfo(AssetInfo assetInfo) {
		return dao.findAssetInfo(assetInfo);
	}
}