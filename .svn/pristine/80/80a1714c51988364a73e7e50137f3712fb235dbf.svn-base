/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.allotinfo.entity;

import cn.net.ecode.modules.eflow.entity.FlowLog;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;
import cn.net.ecode.modules.sys.entity.Office;
import java.util.List;
import java.util.Date;
import com.google.common.collect.Lists;
import cn.net.ecode.common.persistence.DataEntity;
import javax.validation.constraints.NotNull;

/**
 * 资产调拨管理Entity
 * @author zhaohongbin
 * @version 2018-10-10
 */
public class AssetAllotInfo extends DataEntity<AssetAllotInfo> {
	
	private static final long serialVersionUID = 1L;
    private String allotCode;       // 资产调拨编码
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 使用部门编码
	private String officeName;		// 使用部门
    private String operatorCode;		// 操作人编码
    private String operatorName;		// 操作人名称
    private Date allotDate;		// 调拨时间
	private String regionCode;		// 区域编码
	private String regionName;		// 区域名称
    private String assetCodes[];        //调拨资产数组
    private String allotUserCode;		// 调拨后使用人编码
    private String allotUserName;        //
    private String allotTypeCode;		// 调拨类型编码
    private String allotTypeName;		// 调拨类型名称
    private String allotCompanyCode;		// 调拨后使用公司编码
    private String allotCompanyName;		// 调拨后使用公司名称
    private String allotOfficeCode;		// 调拨后使用部门编码
    private String allotOfficeName;		// 调拨后使用部门名称
	private String storagePlace;		// 存放地点
	private String storagePlaceCode;		// 存放地点编码
	private Integer ageLimit;		// 使用期限
	private List<AssetAllotDtl> assetAllotDtlList = Lists.newArrayList();		// 子表列表
    private  String assetAllotDtl;
    private String approvalStatus;
    public String getAssetAllotDtl() {
        return assetAllotDtl;
    }

    public void setAssetAllotDtl(String assetAllotDtl) {
        this.assetAllotDtl = assetAllotDtl;
    }

    private String approvalName;
    private String approvalMemo;
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
    
    private Date beginDate;		//开始时间
    private Date endDate;		//结束时间

	public AssetAllotInfo() {
		super();
	}

	public AssetAllotInfo(String id){
		super();
		this.id = id;
	}
    @Length(min=0, max=64, message="资产调拨编码长度不能超过 64 个字符")
    public String getAllotCode() {
        return allotCode;
    }

    public void setAllotCode(String allotCode) {
        this.allotCode = allotCode;
    }
	@Length(min=0, max=64, message="公司编码长度不能超过 64 个字符")
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
	
	@Length(min=0, max=100, message="使用部门长度不能超过 100 个字符")
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	

	
	@Length(min=0, max=64, message="区域编码长度不能超过 64 个字符")
	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	
	@Length(min=0, max=100, message="区域名称长度不能超过 100 个字符")
	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

    @Length(min=0, max=64, message="调拨后使用部门编码长度不能超过 64 个字符")
    public String getAllotOfficeCode() {
        return allotOfficeCode;
    }

    public void setAllotOfficeCode(String allotOfficeCode) {
        this.allotOfficeCode = allotOfficeCode;
    }
    @Length(min=0, max=100, message="调拨后使用部门名称长度不能超过 100 个字符")
    public String getAllotOfficeName() {
        return allotOfficeName;
    }

    public void setAllotOfficeName(String allotOfficeName) {
        this.allotOfficeName = allotOfficeName;
    }
	@Length(min=0, max=100, message="存放地点长度不能超过 100 个字符")
	public String getStoragePlace() {
		return storagePlace;
	}

	public void setStoragePlace(String storagePlace) {
		this.storagePlace = storagePlace;
	}
	
	@Length(min=0, max=64, message="存放地点编码长度不能超过 64 个字符")
	public String getStoragePlaceCode() {
		return storagePlaceCode;
	}

	public void setStoragePlaceCode(String storagePlaceCode) {
		this.storagePlaceCode = storagePlaceCode;
	}
	
	public Integer getAgeLimit() {
		return ageLimit;
	}

	public void setAgeLimit(Integer ageLimit) {
		this.ageLimit = ageLimit;
	}
	
	public List<AssetAllotDtl> getAssetAllotDtlList() {
		return assetAllotDtlList;
	}

	public void setAssetAllotDtlList(List<AssetAllotDtl> assetAllotDtlList) {
		this.assetAllotDtlList = assetAllotDtlList;
	}

    @Length(min=0, max=64, message="操作人编码长度不能超过 64 个字符")
    public String getOperatorCode() {
        return operatorCode;
    }

    public void setOperatorCode(String operatorCode) {
        this.operatorCode = operatorCode;
    }
    @Length(min=0, max=64, message="操作人名称长度不能超过 100 个字符")
    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @NotNull(message="调拨日期不能为空")
    public Date getAllotDate() {
        return allotDate;
    }

    public void setAllotDate(Date allotDate) {
        this.allotDate = allotDate;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
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

    public String getAllotTypeCode() {
        return allotTypeCode;
    }

    public void setAllotTypeCode(String allotTypeCode) {
        this.allotTypeCode = allotTypeCode;
    }

    public String getAllotTypeName() {
        return allotTypeName;
    }

    public void setAllotTypeName(String allotTypeName) {
        this.allotTypeName = allotTypeName;
    }

    public String getAllotCompanyCode() {
        return allotCompanyCode;
    }

    public void setAllotCompanyCode(String allotCompanyCode) {
        this.allotCompanyCode = allotCompanyCode;
    }

    public String getAllotCompanyName() {
        return allotCompanyName;
    }

    public void setAllotCompanyName(String allotCompanyName) {
        this.allotCompanyName = allotCompanyName;
    }

	public Date getBeginDate() {
		return beginDate;
	}
	@JsonFormat(pattern="yyyy-MM-dd")
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	@JsonFormat(pattern="yyyy-MM-dd")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

    public String getAllotUserCode() {
        return allotUserCode;
    }

    public void setAllotUserCode(String allotUserCode) {
        this.allotUserCode = allotUserCode;
    }

    public String getAllotUserName() {
        return allotUserName;
    }

    public void setAllotUserName(String allotUserName) {
        this.allotUserName = allotUserName;
    }

    public String[] getAssetCodes() {
        return assetCodes;
    }

    public void setAssetCodes(String[] assetCodes) {
        this.assetCodes = assetCodes;
    }
}