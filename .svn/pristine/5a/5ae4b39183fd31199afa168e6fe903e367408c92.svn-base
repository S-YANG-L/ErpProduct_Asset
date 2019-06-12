/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.entity;

import cn.net.ecode.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 推送中间表Entity
 * @author Mc
 * @version 2017-03-03
 */
public class Push extends DataEntity<Push> {
	
	private static final long serialVersionUID = 1L;
	private String originateCode;		// 发起人编码
	private String originateName;		// 发起人名称
	private String receiverCode;		// 接受人编码
	private String receiverName;		// 接受人名称
	private Date receiverDate;			// 推送时间
	private String receiverContent;		// 推送内容
	private String isPush;		// 是否推送(0：未推送1：已推送)
	private String bizKey;		// 业务主键
	private String bizType;		// 单据类型编码
	private String bizName;		// 单据类型名称
	private String msgType;		// 推送类型
	private String receiverType;	// 接受者类型（1用户 2部门 3角色 4岗位 5所有人）
	private String pushParam;		// 推送业务参数
	private String pushCycle;		// 推送周期(0：按分钟推送1：按天推送)
	private Date receiverBeforeDate;	//用于筛选推送时间
	public Push() {
		super();
	}

	public Push(String id){
		super();
		this.id = id;
	}

	@NotBlank(message="发起人编码不能为空")
	@Length(min=0, max=64, message="发起人编码长度不能超过 64 个字符")
	public String getOriginateCode() {
		return originateCode;
	}

	public void setOriginateCode(String originateCode) {
		this.originateCode = originateCode;
	}
	
	@NotBlank(message="发起人名称不能为空")
	@Length(min=0, max=255, message="发起人名称长度不能超过 255 个字符")
	public String getOriginateName() {
		return originateName;
	}

	public void setOriginateName(String originateName) {
		this.originateName = originateName;
	}
	
	@NotBlank(message="接受人编码不能为空")
	@Length(min=0, max=2000, message="接受人编码长度不能超过 2000 个字符")
	public String getReceiverCode() {
		return receiverCode;
	}

	public void setReceiverCode(String receiverCode) {
		this.receiverCode = receiverCode;
	}
	
	@NotBlank(message="接受人名称不能为空")
	@Length(min=0, max=2000, message="接受人名称长度不能超过 2000 个字符")
	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="推送时间不能为空")
	public Date getReceiverDate() {
		return receiverDate;
	}

	public void setReceiverDate(Date receiverDate) {
		this.receiverDate = receiverDate;
	}
	
	@NotBlank(message="推送内容不能为空")
	@Length(min=0, max=2000, message="推送内容长度不能超过 2000 个字符")
	public String getReceiverContent() {
		return receiverContent;
	}

	public void setReceiverContent(String receiverContent) {
		this.receiverContent = receiverContent;
	}
	
	@NotBlank(message="是否推送(0：未推送1：已推送)不能为空")
	@Length(min=0, max=1, message="是否推送(0：未推送1：已推送)长度不能超过 1 个字符")
	public String getIsPush() {
		return isPush;
	}

	public void setIsPush(String isPush) {
		this.isPush = isPush;
	}
	
	@NotBlank(message="业务主键不能为空")
	@Length(min=0, max=64, message="业务主键长度不能超过 64 个字符")
	public String getBizKey() {
		return bizKey;
	}

	public void setBizKey(String bizKey) {
		this.bizKey = bizKey;
	}
	
	@Length(min=0, max=64, message="单据类型编码长度不能超过 64 个字符")
	public String getBizType() {
		return bizType;
	}

	public void setBizType(String bizType) {
		this.bizType = bizType;
	}
	
	@Length(min=0, max=64, message="单据类型名称长度不能超过 64 个字符")
	public String getBizName() {
		return bizName;
	}

	public void setBizName(String bizName) {
		this.bizName = bizName;
	}
	
	@Length(min=0, max=1, message="推送类型长度不能超过 1 个字符")
	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	
	@NotNull(message="接受者类型（1用户 2部门 3角色 4岗位 5所有人）不能为空")
	public String getReceiverType() {
		return receiverType;
	}

	public void setReceiverType(String receiverType) {
		this.receiverType = receiverType;
	}
	
	public String getPushParam() {
		return pushParam;
	}

	public void setPushParam(String pushParam) {
		this.pushParam = pushParam;
	}

	public String getPushCycle() {
		return pushCycle;
	}

	public void setPushCycle(String pushCycle) {
		this.pushCycle = pushCycle;
	}

	public Date getReceiverBeforeDate() {
		return receiverBeforeDate;
	}

	public void setReceiverBeforeDate(Date receiverBeforeDate) {
		this.receiverBeforeDate = receiverBeforeDate;
	}
	
}