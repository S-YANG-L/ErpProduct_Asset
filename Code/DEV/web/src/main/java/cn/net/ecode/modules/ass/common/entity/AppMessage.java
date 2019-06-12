/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.entity;

import cn.net.ecode.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import java.util.Date;

/**
 * 移动端获取后台日志Entity
 * @author Mc
 * @version 2016-06-20
 */
public class AppMessage extends DataEntity<AppMessage> {
	
	private static final long serialVersionUID = 1L;
	private String type;			// 消息类型(1通知 2消息 3短信 4邮件)
	private String contentTitle;	// 内容标题
	private String contentLevel;	// 内容级别(1普通 2一般 3紧急)
	private String contentType;		// 内容类型(1公告 2新闻 3会议 4其它 5微信 6app推送)
	private String contentText;		// 消息内容
	private String receiverType;	// 接受者类型（1用户 2部门 3角色 4岗位  all_user所有人）
	private String receiverCodes;	// 接受者字符串
	private String receiverNames;	// 接受者名称字符串
	private String sender;		// 发送者
	private String senderName;	// 发送者姓名
	private Date sendDate;		// 发送时间
	private String bizKey;		// 业务主键(关联业务表)
	private String buttons;		// 按钮配置JSON
	private String bizType;		// 业务主键(关联业务表类型)
	private String emailCc;		// 邮件抄送地址
	private String emailBcc;	// 邮件密送地址
	private String sendResult;	// 发送结果信息
	private int messageNum;  	// 消息条数
	private String name;     	// 字典名
	private int value;			// 字典值
	private String sysCode;		// 业务单据号	
	private String nextPostCode;// 下一步审批人岗位编码
	private String seqId;		// 审批步骤(1、2、3)
	private String selectUserId;// 下一步审批人编码	
	//业务表单据字段
	private String applicantName;	// 申请人姓名
	private Date applyDate;			// 申请日期
	private Date beginDate;    // 开始申请日期
	private Date endDate;		// 结束申请日期
	private Double applyMoney;		// 申请人金额
	private Double beginMoney;		// 申请人开始金额
	private Double endMoney;		// 申请人结束金额
	private String bizName;			// 业务主键(关联业务表类型名称)	
	private boolean agree;			// 单据是否同意(拒绝：false 其他：true)
	//微信模板字段
	private String templageId;		// 微信模板ID
	private String templageHead;	// 模板标题
	private String keyword1;		
	private String keyword2;
	private String keyword3;
	private String keyword4;
	
	private String billtypeCode;   //单据类型
	private String content;   //内容
	private String companyCode; //公司编码
	private String companyName; //公司名称
	private String officeName; //部门
	private String billDate;  //单据申请日期
	private String typeName;  //请假类型
	private String leaveDays;  //请假天数
	private String reason;  //请假原因
	private String repeirTypeName;  //报修类型名称
	private String depiction; //故障描述
	private String travelDays;//出差天数
	private String destination;//出差地点
	private String vehicle;  //交通工具
	private String reasons;  //出差原因
	private String overtimeHours;  //加班时长
	private String reasonss; //加班原因
	private String useItem;  //用车项目
	private String useRoute; //用车路径
	private String remarkss;  //请示内容
	private String depictions; //资产领用描述
	private String sortName; //资产名称
	private String assetStd;// 类别型号
	private Double sumMoney;		// 金额
	private String numSumMoney;		// 大写金额
	
	private String templageMessage;//微信模板ID
	public AppMessage() {
		super();
	}

	public AppMessage(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=1, message="消息类型(1通知 2消息 3短信 4邮件)长度不能超过 1 个字符")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=200, message="内容标题长度不能超过 200 个字符")
	public String getContentTitle() {
		return contentTitle;
	}

	public void setContentTitle(String contentTitle) {
		this.contentTitle = contentTitle;
	}
	
	@Length(min=0, max=1, message="内容级别(1普通 2一般 3紧急)长度不能超过 1 个字符")
	public String getContentLevel() {
		return contentLevel;
	}

	public void setContentLevel(String contentLevel) {
		this.contentLevel = contentLevel;
	}
	
	@Length(min=0, max=1, message="内容类型(1公告 2新闻 3会议 4其它)长度不能超过 1 个字符")
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	@NotBlank(message="消息内容不能为空")
	@Length(min=0, max=2000, message="消息内容长度不能超过 2000 个字符")
	public String getContentText() {
		return contentText;
	}

	public void setContentText(String contentText) {
		this.contentText = contentText;
	}
	
	@NotBlank(message="接受者类型（1用户 2部门 3角色 4岗位）不能为空")
	@Length(min=0, max=1, message="接受者类型（1用户 2部门 3角色 4岗位）长度不能超过 1 个字符")
	public String getReceiverType() {
		return receiverType;
	}

	public void setReceiverType(String receiverType) {
		this.receiverType = receiverType;
	}
	
	@NotBlank(message="接受者字符串不能为空")
	@Length(min=0, max=3000, message="接受者字符串长度不能超过 3000 个字符")
	public String getReceiverCodes() {
		return receiverCodes;
	}

	public void setReceiverCodes(String receiverCodes) {
		this.receiverCodes = receiverCodes;
	}
	
	@NotBlank(message="接受者名称字符串不能为空")
	@Length(min=0, max=2000, message="接受者名称字符串长度不能超过 2000 个字符")
	public String getReceiverNames() {
		return receiverNames;
	}

	public void setReceiverNames(String receiverNames) {
		this.receiverNames = receiverNames;
	}
	
	@Length(min=0, max=64, message="发送者长度不能超过 64 个字符")
	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}
	
	@Length(min=0, max=100, message="发送者姓名长度不能超过 100 个字符")
	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	
	@Length(min=0, max=64, message="业务主键(关联业务表)长度不能超过 64 个字符")
	public String getBizKey() {
		return bizKey;
	}

	public void setBizKey(String bizKey) {
		this.bizKey = bizKey;
	}
	
	@Length(min=0, max=3000, message="按钮配置JSON长度不能超过 3000 个字符")
	public String getButtons() {
		return buttons;
	}

	public void setButtons(String buttons) {
		this.buttons = buttons;
	}
	
	@Length(min=0, max=64, message="业务主键(关联业务表类型)长度不能超过 64 个字符")
	public String getBizType() {
		return bizType;
	}

	public void setBizType(String bizType) {
		this.bizType = bizType;
	}
	
	@Length(min=0, max=3000, message="邮件抄送地址长度不能超过 3000 个字符")
	public String getEmailCc() {
		return emailCc;
	}

	public void setEmailCc(String emailCc) {
		this.emailCc = emailCc;
	}
	
	@Length(min=0, max=3000, message="邮件密送地址长度不能超过 3000 个字符")
	public String getEmailBcc() {
		return emailBcc;
	}

	public void setEmailBcc(String emailBcc) {
		this.emailBcc = emailBcc;
	}
	
	@Length(min=0, max=3000, message="发送结果信息长度不能超过 3000 个字符")
	public String getSendResult() {
		return sendResult;
	}

	public void setSendResult(String sendResult) {
		this.sendResult = sendResult;
	}

	public int getMessageNum() {
		return messageNum;
	}

	public void setMessageNum(int messageNum) {
		this.messageNum = messageNum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getSysCode() {
		return sysCode;
	}

	public void setSysCode(String sysCode) {
		this.sysCode = sysCode;
	}

	public String getNextPostCode() {
		return nextPostCode;
	}

	public void setNextPostCode(String nextPostCode) {
		this.nextPostCode = nextPostCode;
	}

	public String getSeqId() {
		return seqId;
	}

	public void setSeqId(String seqId) {
		this.seqId = seqId;
	}

	public String getSelectUserId() {
		return selectUserId;
	}

	public void setSelectUserId(String selectUserId) {
		this.selectUserId = selectUserId;
	}

	public String getApplicantName() {
		return applicantName;
	}

	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public Double getApplyMoney() {
		return applyMoney;
	}

	public void setApplyMoney(Double applyMoney) {
		this.applyMoney = applyMoney;
	}

	public String getBizName() {
		return bizName;
	}

	public void setBizName(String bizName) {
		this.bizName = bizName;
	}

	public boolean isAgree() {
		return agree;
	}

	public void setAgree(boolean agree) {
		this.agree = agree;
	}

	public String getTemplageId() {
		return templageId;
	}

	public void setTemplageId(String templageId) {
		this.templageId = templageId;
	}

	public String getTemplageHead() {
		return templageHead;
	}

	public void setTemplageHead(String templageHead) {
		this.templageHead = templageHead;
	}

	public String getKeyword1() {
		return keyword1;
	}

	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}

	public String getKeyword2() {
		return keyword2;
	}

	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}

	public String getKeyword3() {
		return keyword3;
	}

	public void setKeyword3(String keyword3) {
		this.keyword3 = keyword3;
	}

	public String getKeyword4() {
		return keyword4;
	}

	public void setKeyword4(String keyword4) {
		this.keyword4 = keyword4;
	}

	public String getBilltypeCode() {
		return billtypeCode;
	}

	public void setBilltypeCode(String billtypeCode) {
		this.billtypeCode = billtypeCode;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getLeaveDays() {
		return leaveDays;
	}

	public void setLeaveDays(String leaveDays) {
		this.leaveDays = leaveDays;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getRepeirTypeName() {
		return repeirTypeName;
	}

	public void setRepeirTypeName(String repeirTypeName) {
		this.repeirTypeName = repeirTypeName;
	}

	public String getDepiction() {
		return depiction;
	}

	public void setDepiction(String depiction) {
		this.depiction = depiction;
	}

	public String getTravelDays() {
		return travelDays;
	}

	public void setTravelDays(String travelDays) {
		this.travelDays = travelDays;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public String getReasons() {
		return reasons;
	}

	public void setReasons(String reasons) {
		this.reasons = reasons;
	}

	public String getOvertimeHours() {
		return overtimeHours;
	}

	public void setOvertimeHours(String overtimeHours) {
		this.overtimeHours = overtimeHours;
	}

	public String getReasonss() {
		return reasonss;
	}

	public void setReasonss(String reasonss) {
		this.reasonss = reasonss;
	}

	public String getUseItem() {
		return useItem;
	}

	public void setUseItem(String useItem) {
		this.useItem = useItem;
	}

	public String getUseRoute() {
		return useRoute;
	}

	public void setUseRoute(String useRoute) {
		this.useRoute = useRoute;
	}

	public String getRemarkss() {
		return remarkss;
	}

	public void setRemarkss(String remarkss) {
		this.remarkss = remarkss;
	}

	public String getDepictions() {
		return depictions;
	}

	public void setDepictions(String depictions) {
		this.depictions = depictions;
	}

	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public String getAssetStd() {
		return assetStd;
	}

	public void setAssetStd(String assetStd) {
		this.assetStd = assetStd;
	}

	public Double getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(Double sumMoney) {
		this.sumMoney = sumMoney;
	}

	public String getTemplageMessage() {
		return templageMessage;
	}

	public void setTemplageMessage(String templageMessage) {
		this.templageMessage = templageMessage;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Double getBeginMoney() {
		return beginMoney;
	}

	public void setBeginMoney(Double beginMoney) {
		this.beginMoney = beginMoney;
	}

	public Double getEndMoney() {
		return endMoney;
	}

	public void setEndMoney(Double endMoney) {
		this.endMoney = endMoney;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getNumSumMoney() {
		return numSumMoney;
	}

	public void setNumSumMoney(String numSumMoney) {
		this.numSumMoney = numSumMoney;
	}
	
}