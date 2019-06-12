/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.common.entity;

import cn.net.ecode.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 推送方式表Entity
 * @author Mc
 * @version 2017-02-24
 */
public class PushModel extends DataEntity<PushModel> {
	
	private static final long serialVersionUID = 1L;
	private String receiverCode;		// 接受者编码
	private String receiverName;		// 接受者名称
	private String deviceModel;			// 设备型号 Android/ios
	private String pushSettings;		// 推送设置 1：微信推送 2：极光推送  3：微信推送+极光推送
	private String billNotice;			// 单据类通知  1：实时推送 2：延时半小时推送
	private String messageNotice;		// 消息类通知  1：实时推送 2：延时半小时推送
	
	public PushModel() {
		super();
	}

	public PushModel(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=200, message="接受者编码长度不能超过 200 个字符")
	public String getReceiverCode() {
		return receiverCode;
	}

	public void setReceiverCode(String receiverCode) {
		this.receiverCode = receiverCode;
	}
	
	@Length(min=0, max=100, message="接受者名称长度不能超过 100 个字符")
	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	
	@Length(min=0, max=100, message="设备型号 Android/ios长度不能超过 100 个字符")
	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}
	
	@Length(min=0, max=1, message="推送设置 1：微信推送 2：极光推送  3：微信推送+极光推送长度不能超过 1 个字符")
	public String getPushSettings() {
		return pushSettings;
	}

	public void setPushSettings(String pushSettings) {
		this.pushSettings = pushSettings;
	}
	
	@Length(min=0, max=1, message="单据类通知  1：实时推送 2：延时半小时推送长度不能超过 1 个字符")
	public String getBillNotice() {
		return billNotice;
	}

	public void setBillNotice(String billNotice) {
		this.billNotice = billNotice;
	}
	
	@Length(min=0, max=1, message="消息类通知  1：实时推送 2：延时半小时推送长度不能超过 1 个字符")
	public String getMessageNotice() {
		return messageNotice;
	}

	public void setMessageNotice(String messageNotice) {
		this.messageNotice = messageNotice;
	}
	
}