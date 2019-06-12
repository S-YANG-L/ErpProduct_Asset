/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.cancelstocks.entity;

import cn.net.ecode.modules.eflow.entity.FlowLog;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import java.util.List;
import com.google.common.collect.Lists;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 资产退库Entity
 * @author zhaohongbin
 * @version 2018-10-08
 */
public class AssetReturnInfo extends DataEntity<AssetReturnInfo> {
	
	private static final long serialVersionUID = 1L;
	private String returnCode;		// 退库编码
	private String retireCode;		// 退库人编码
	private String retireName;		// 退库人
	private Date receiverDate;		// 退库日期
	private String returnCompanyCode;		// 退库后公司编码
	private String returnCompanyName;		// 退库后公司名称
	private String returnOfficeCode;		// 退库后部门编码
	private String returnOfficeName;		// 退库后部门名称
	private String returnRegionCode;		// 退库后区域编码
	private String returnRegionName;		// 退库后区域名称
	private String returnStoragePlace;		// 退库后存放地点
    private String approvalStatus;		// 审核状态
	private String notes;		// 说明
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String extendS3;		// 扩展3
    private String approval;		// 审批人
    private String approvalName;		// 审批人姓名
    private String approvalMemo;		// 审批意见
    private Date approvalDate;		// 审批日期


    //调用JUDP3.0工作流所需属性
    private String flowId;//流程模板ID
    private String bizKey;//业务编码
    private String flowBusinessId;//工作流ID
    private String approvalMemo1;//审批意见
    private String nextApprovalCode;//下一步审批人
    private String nextApprovalName;//下一步审批人姓名
    private List<FlowLog> flList;
    private String approvalCode;//审批人
    private String pageFlag;  //页面标识，判断我的待办1、我的已办2、我的申请0
    private String stepId; //当期工作流步骤id
    private String step;//当前步骤
    private Integer isEnd;  //工作流程是否结束

	private List<AssetReturnDtl> assetReturnDtlList = Lists.newArrayList();		// 子表列表
	private String assetReturnDtl;
	public AssetReturnInfo() {
		super();
	}

	public String getAssetReturnDtl() {
		return assetReturnDtl;
	}

	public void setAssetReturnDtl(String assetReturnDtl) {
		this.assetReturnDtl = assetReturnDtl;
	}

	public AssetReturnInfo(String id){
		super();
		this.id = id;
	}

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getApproval() {
        return approval;
    }

    public void setApproval(String approval) {
        this.approval = approval;
    }

    public String getApprovalName() {
        return approvalName;
    }

    public void setApprovalName(String approvalName) {
        this.approvalName = approvalName;
    }

    public String getApprovalMemo() {
        return approvalMemo;
    }

    public void setApprovalMemo(String approvalMemo) {
        this.approvalMemo = approvalMemo;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
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

    public String getApprovalMemo1() {
        return approvalMemo1;
    }

    public void setApprovalMemo1(String approvalMemo1) {
        this.approvalMemo1 = approvalMemo1;
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

    @Length(min=0, max=64, message="退库编码长度不能超过 64 个字符")
	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}
	
	@NotBlank(message="退库人编码不能为空")
	@Length(min=0, max=64, message="退库人编码长度不能超过 64 个字符")
	public String getRetireCode() {
		return retireCode;
	}

	public void setRetireCode(String retireCode) {
		this.retireCode = retireCode;
	}
	
	@NotBlank(message="退库人不能为空")
	@Length(min=0, max=100, message="退库人长度不能超过 100 个字符")
	public String getRetireName() {
		return retireName;
	}

	public void setRetireName(String retireName) {
		this.retireName = retireName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	@NotNull(message="退库日期不能为空")
	public Date getReceiverDate() {
		return receiverDate;
	}

	public void setReceiverDate(Date receiverDate) {
		this.receiverDate = receiverDate;
	}
	

	@Length(min=0, max=64, message="退库后公司编码长度不能超过 64 个字符")
	public String getReturnCompanyCode() {
		return returnCompanyCode;
	}

	public void setReturnCompanyCode(String returnCompanyCode) {
		this.returnCompanyCode = returnCompanyCode;
	}
	

	@Length(min=0, max=100, message="退库后公司名称长度不能超过 100 个字符")
	public String getReturnCompanyName() {
		return returnCompanyName;
	}

	public void setReturnCompanyName(String returnCompanyName) {
		this.returnCompanyName = returnCompanyName;
	}
	
	@Length(min=0, max=64, message="退库后部门编码长度不能超过 64 个字符")
	public String getReturnOfficeCode() {
		return returnOfficeCode;
	}

	public void setReturnOfficeCode(String returnOfficeCode) {
		this.returnOfficeCode = returnOfficeCode;
	}
	
	@Length(min=0, max=100, message="退库后部门名称长度不能超过 100 个字符")
	public String getReturnOfficeName() {
		return returnOfficeName;
	}

	public void setReturnOfficeName(String returnOfficeName) {
		this.returnOfficeName = returnOfficeName;
	}
	
	@Length(min=0, max=64, message="退库后区域编码长度不能超过 64 个字符")
	public String getReturnRegionCode() {
		return returnRegionCode;
	}

	public void setReturnRegionCode(String returnRegionCode) {
		this.returnRegionCode = returnRegionCode;
	}
	
	@Length(min=0, max=100, message="退库后区域名称长度不能超过 100 个字符")
	public String getReturnRegionName() {
		return returnRegionName;
	}

	public void setReturnRegionName(String returnRegionName) {
		this.returnRegionName = returnRegionName;
	}
	
	@Length(min=0, max=100, message="退库后存放地点长度不能超过 100 个字符")
	public String getReturnStoragePlace() {
		return returnStoragePlace;
	}

	public void setReturnStoragePlace(String returnStoragePlace) {
		this.returnStoragePlace = returnStoragePlace;
	}

	@Length(min=0, max=100, message="说明长度不能超过 100 个字符")
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}
	
	@Length(min=0, max=100, message="扩展1长度不能超过 100 个字符")
	public String getExtendS1() {
		return extendS1;
	}

	public void setExtendS1(String extendS1) {
		this.extendS1 = extendS1;
	}
	
	@Length(min=0, max=100, message="扩展2长度不能超过 100 个字符")
	public String getExtendS2() {
		return extendS2;
	}

	public void setExtendS2(String extendS2) {
		this.extendS2 = extendS2;
	}
	
	@Length(min=0, max=100, message="扩展3长度不能超过 100 个字符")
	public String getExtendS3() {
		return extendS3;
	}

	public void setExtendS3(String extendS3) {
		this.extendS3 = extendS3;
	}
	
	public List<AssetReturnDtl> getAssetReturnDtlList() {
		return assetReturnDtlList;
	}

	public void setAssetReturnDtlList(List<AssetReturnDtl> assetReturnDtlList) {
		this.assetReturnDtlList = assetReturnDtlList;
	}
}