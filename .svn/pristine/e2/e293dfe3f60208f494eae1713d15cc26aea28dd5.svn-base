/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.usedinfo.entity;

import cn.net.ecode.modules.eflow.entity.FlowLog;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 资产领用Entity
 * @author zhaohongbin
 * @version 2018-09-20
 */
public class AssetUsedInfo extends DataEntity<AssetUsedInfo> {
	
	private static final long serialVersionUID = 1L;
	private String usedCode;		// 领用编码
	private String receiverCode;		// 领用人编码
	private String receiverName;		// 领用人
	private Date receiverDate;		// 领用日期
	private String usedCompanyCode;		// 使用人公司编码
	private String usedCompanyName;		// 使用人公司名称
	private String usedOfficeCode;		// 使用人部门编码
	private String usedOfficeName;		// 使用人部门名称
	private String usedRegionCode;		// 使用人区域编码
	private String usedRegionName;		// 使用人区域名称
	private String usedStoragePlace;		// 使用人存放地点
	private String approvalStatus;		// 审核状态
	private String notes;		//说明
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String extendS3;		// 扩展3
	private List<AssetUsedDtl> assetUsedDtls;//子表
    private String assetUsedDtlsString;		// 审批人
    private String approval;		// 审批人
    private String approvalName;		// 审批人姓名
    private String approvalMemo;		// 审批意见
    private Date approvalDate;		// 审批日期
    private String assetClassCode;   //资产类别编码
    private String assetClass;   //资产类别
    private int numberRecipients;   //领用资产数量
    private String topSortCode;		// 资产大类编码
    private String topSortName;		// 资产大类
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


    public String getAssetClassCode() {
        return assetClassCode;
    }

    public void setAssetClassCode(String assetClassCode) {
        this.assetClassCode = assetClassCode;
    }

    public String getAssetClass() {
        return assetClass;
    }

    public void setAssetClass(String assetClass) {
        this.assetClass = assetClass;
    }

    public int getNumberRecipients() {
        return numberRecipients;
    }

    public void setNumberRecipients(int numberRecipients) {
        this.numberRecipients = numberRecipients;
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


    public AssetUsedInfo() {
		super();
	}

    public List<AssetUsedDtl> getAssetUsedDtls() {
        return assetUsedDtls;
    }

    public void setAssetUsedDtls(List<AssetUsedDtl> assetUsedDtls) {
        this.assetUsedDtls = assetUsedDtls;
    }

    public AssetUsedInfo(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="领用编码长度不能超过 64 个字符")
	public String getUsedCode() {
		return usedCode;
	}

	public void setUsedCode(String usedCode) {
		this.usedCode = usedCode;
	}
	
	@Length(min=0, max=64, message="领用人编码长度不能超过 64 个字符")
	public String getReceiverCode() {
		return receiverCode;
	}

	public void setReceiverCode(String receiverCode) {
		this.receiverCode = receiverCode;
	}
	
	@NotBlank(message="领用人不能为空")
	@Length(min=0, max=100, message="领用人长度不能超过 100 个字符")
	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="领用日期不能为空")
	public Date getReceiverDate() {
		return receiverDate;
	}

	public void setReceiverDate(Date receiverDate) {
		this.receiverDate = receiverDate;
	}
	
	@Length(min=0, max=64, message="使用人公司编码长度不能超过 64 个字符")
	public String getUsedCompanyCode() {
		return usedCompanyCode;
	}

	public void setUsedCompanyCode(String usedCompanyCode) {
		this.usedCompanyCode = usedCompanyCode;
	}

	@Length(min=0, max=100, message="使用人公司名称长度不能超过 100 个字符")
	public String getUsedCompanyName() {
		return usedCompanyName;
	}

	public void setUsedCompanyName(String usedCompanyName) {
		this.usedCompanyName = usedCompanyName;
	}
	
	@Length(min=0, max=64, message="使用人部门编码长度不能超过 64 个字符")
	public String getUsedOfficeCode() {
		return usedOfficeCode;
	}

	public void setUsedOfficeCode(String usedOfficeCode) {
		this.usedOfficeCode = usedOfficeCode;
	}
	
	@Length(min=0, max=100, message="使用人部门名称长度不能超过 100 个字符")
	public String getUsedOfficeName() {
		return usedOfficeName;
	}

	public void setUsedOfficeName(String usedOfficeName) {
		this.usedOfficeName = usedOfficeName;
	}
	
	@Length(min=0, max=64, message="使用人区域编码长度不能超过 64 个字符")
	public String getUsedRegionCode() {
		return usedRegionCode;
	}

	public void setUsedRegionCode(String usedRegionCode) {
		this.usedRegionCode = usedRegionCode;
	}
	
	@Length(min=0, max=100, message="使用人区域名称长度不能超过 100 个字符")
	public String getUsedRegionName() {
		return usedRegionName;
	}

	public void setUsedRegionName(String usedRegionName) {
		this.usedRegionName = usedRegionName;
	}
	
	@Length(min=0, max=100, message="使用人存放地点长度不能超过 100 个字符")
	public String getUsedStoragePlace() {
		return usedStoragePlace;
	}

	public void setUsedStoragePlace(String usedStoragePlace) {
		this.usedStoragePlace = usedStoragePlace;
	}
    @Length(min=0, max=1, message="审核状态长度不能超过 1 个字符")
    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
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

    public String getTopSortCode() {
        return topSortCode;
    }

    public void setTopSortCode(String topSortCode) {
        this.topSortCode = topSortCode;
    }

    public String getTopSortName() {
        return topSortName;
    }

    public void setTopSortName(String topSortName) {
        this.topSortName = topSortName;
    }

    public String getAssetUsedDtlsString() {
        return assetUsedDtlsString;
    }

    public void setAssetUsedDtlsString(String assetUsedDtlsString) {
        this.assetUsedDtlsString = assetUsedDtlsString;
    }
}