/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.approval.entity;

import org.hibernate.validator.constraints.Length;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 审批流程记录Entity
 * @author zhaohongbin
 * @version 2018-10-14
 */
public class FlowHelp extends DataEntity<FlowHelp> {
	
	private static final long serialVersionUID = 1L;
	private String flowId;		// 工作流ID
	private String step;		// 步骤
	private String applicantCode;		// 操作人编码
	private String applicantName;		// 操作人名称
	
	public FlowHelp() {
		super();
	}

	public FlowHelp(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="工作流ID长度不能超过 64 个字符")
	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}
	
	@Length(min=0, max=1, message="步骤长度不能超过 1 个字符")
	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}
	
	@Length(min=0, max=64, message="操作人编码长度不能超过 64 个字符")
	public String getApplicantCode() {
		return applicantCode;
	}

	public void setApplicantCode(String applicantCode) {
		this.applicantCode = applicantCode;
	}
	
	@Length(min=0, max=100, message="操作人名称长度不能超过 100 个字符")
	public String getApplicantName() {
		return applicantName;
	}

	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}
	
}