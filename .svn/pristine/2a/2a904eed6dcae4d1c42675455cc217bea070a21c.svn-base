/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.outbound.entity;

import cn.net.ecode.common.persistence.annotation.Id;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import cn.net.ecode.modules.eflow.entity.FlowLog;
import cn.net.ecode.modules.sys.entity.Office;
import java.util.List;
import com.google.common.collect.Lists;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 物资出库Entity
 * @author tiange
 * @version 2018-10-11
 */
public class OutboundBill extends DataEntity<OutboundBill> {
	
	private static final long serialVersionUID = 1L;
	private String sysCode;		// 主键
	private String billCode;		// 流水号
	private String outboundCode;	//出库编码
	private String outbounderCode;		// 出库人编码
	private String outbounderName;		// 出库人姓名
	private Date outboundDate;		// 出库日期
    private String whCode;		// 仓库编码
    private String whName;		// 仓库名称
	private String operatorCode;		// 操作人编码
	private String operatorName;		// 操作人名称
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 部门编码
	private String officeName;		// 部门名称
	private String officeCode;		//部门编码
	private String applyNo;		// 申请单号
	private Date applyDate;		// 申请日期
	private String approvalStatus;		// 审核状态0撤回1审批中2终审3拒绝
	private Date approvalDate;		// 审批日期
	private String approval;		// 审批人
	private String approvalName;		// 审批人姓名
	private String memo;		// 说明
	private List<OutboundBillDtl> outboundBillDtlList = Lists.newArrayList();		// 子表列表
    private String outboundBillDtlListString;
    private String sortCode;		// 办公类别编码
    private String sortName;		// 办公类别名称
    private int outboundNumber;		// 出库数量
    private Date createDate;		//创建时间
    private Date beginDate;		//开始时间
    private Date endDate;		//结束时间
    //调用JUDP3.0工作流所需属性
    private String flowId;//流程模板ID
    private String bizKey;//业务编码
    private String flowBusinessId;//工作流ID
    private String approvalMemo;//审批意见
    private String nextApprovalCode;//下一步审批人
    private String nextApprovalName;//下一步审批人姓名
    private List<FlowLog> flList;
    private String approvalCode;//审批人
    private String pageFlag;  //页面标识，判断我的待办1、我的已办2、我的申请0
    private String stepId; //当期工作流步骤id
    private String step;//当前步骤
    private Integer isEnd;  //工作流程是否结束
	public OutboundBill() {
		super();
	}

	public OutboundBill(String sysCode){
		super();
		this.sysCode = sysCode;
	}

	@Id
	public String getSysCode() {
		return sysCode;
	}

	public void setSysCode(String sysCode) {
		this.sysCode = sysCode;
	}


	public String getBillCode() {
		return billCode;
	}

	public void setBillCode(String billCode) {
		this.billCode = billCode;
	}
	

	public String getOutbounderCode() {
		return outbounderCode;
	}

	public void setOutbounderCode(String outbounderCode) {
		this.outbounderCode = outbounderCode;
	}
	
	@Length(min=0, max=100, message="出库人姓名长度不能超过 100 个字符")
	public String getOutbounderName() {
		return outbounderName;
	}

	public void setOutbounderName(String outbounderName) {
		this.outbounderName = outbounderName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getOutboundDate() {
		return outboundDate;
	}

	public void setOutboundDate(Date outboundDate) {
		this.outboundDate = outboundDate;
	}
	

	public String getOperatorCode() {
		return operatorCode;
	}

	public void setOperatorCode(String operatorCode) {
		this.operatorCode = operatorCode;
	}
	
	@Length(min=0, max=100, message="操作人名称长度不能超过 100 个字符")
	public String getOperatorName() {
		return operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	
	@Length(min=0, max=100, message="公司名称长度不能超过 100 个字符")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=0, max=100, message="部门名称长度不能超过 100 个字符")
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	public String getOfficeCode() {
		return officeCode;
	}

	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	

	public String getApplyNo() {
		return applyNo;
	}

	public void setApplyNo(String applyNo) {
		this.applyNo = applyNo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	
	@Length(min=0, max=1, message="审核状态0撤回1审批中2终审3拒绝长度不能超过 1 个字符")
	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}
	
	@Length(min=0, max=100, message="审批人长度不能超过 100 个字符")
	public String getApproval() {
		return approval;
	}

	public void setApproval(String approval) {
		this.approval = approval;
	}
	
	@Length(min=0, max=100, message="审批人姓名长度不能超过 100 个字符")
	public String getApprovalName() {
		return approvalName;
	}

	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}

    @Length(min=0, max=200, message="审批意见长度不能超过 200 个字符")
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }



	
	public List<OutboundBillDtl> getOutboundBillDtlList() {
		return outboundBillDtlList;
	}

	public void setOutboundBillDtlList(List<OutboundBillDtl> outboundBillDtlList) {
		this.outboundBillDtlList = outboundBillDtlList;
	}

    public String getWhCode() {
        return whCode;
    }

    public void setWhCode(String whCode) {
        this.whCode = whCode;
    }

    public String getWhName() {
        return whName;
    }

    public void setWhName(String whName) {
        this.whName = whName;
    }

    public String getSortCode() {
        return sortCode;
    }

    public void setSortCode(String sortCode) {
        this.sortCode = sortCode;
    }

    public String getSortName() {
        return sortName;
    }

    public void setSortName(String sortName) {
        this.sortName = sortName;
    }

    public int getOutboundNumber() {
        return outboundNumber;
    }

    public void setOutboundNumber(int outboundNumber) {
        this.outboundNumber = outboundNumber;
    }
    public String getOutboundCode() {
        return outboundCode;
    }

    public void setOutboundCode(String outboundCode) {
        this.outboundCode = outboundCode;
    }

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    public String getBizKey() {
        return bizKey;
    }

    public void setBizKey(String bizKey) {
        this.bizKey = bizKey;
    }

    public String getFlowBusinessId() {
        return flowBusinessId;
    }

    public void setFlowBusinessId(String flowBusinessId) {
        this.flowBusinessId = flowBusinessId;
    }

    public String getApprovalMemo() {
        return approvalMemo;
    }

    public void setApprovalMemo(String approvalMemo) {
        this.approvalMemo = approvalMemo;
    }

    public String getNextApprovalCode() {
        return nextApprovalCode;
    }

    public void setNextApprovalCode(String nextApprovalCode) {
        this.nextApprovalCode = nextApprovalCode;
    }

    public String getNextApprovalName() {
        return nextApprovalName;
    }

    public void setNextApprovalName(String nextApprovalName) {
        this.nextApprovalName = nextApprovalName;
    }

    public List<FlowLog> getFlList() {
        return flList;
    }

    public void setFlList(List<FlowLog> flList) {
        this.flList = flList;
    }

    public String getApprovalCode() {
        return approvalCode;
    }

    public void setApprovalCode(String approvalCode) {
        this.approvalCode = approvalCode;
    }

    public String getPageFlag() {
        return pageFlag;
    }

    public void setPageFlag(String pageFlag) {
        this.pageFlag = pageFlag;
    }

    public String getStepId() {
        return stepId;
    }

    public void setStepId(String stepId) {
        this.stepId = stepId;
    }

    public String getStep() {
        return step;
    }

    public void setStep(String step) {
        this.step = step;
    }

    public Integer getIsEnd() {
        return isEnd;
    }

    public void setIsEnd(Integer isEnd) {
        this.isEnd = isEnd;
    }

    @JsonFormat(pattern="yyyy-MM-dd")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

    public String getOutboundBillDtlListString() {
        return outboundBillDtlListString;
    }

    public void setOutboundBillDtlListString(String outboundBillDtlListString) {
        this.outboundBillDtlListString = outboundBillDtlListString;
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
}