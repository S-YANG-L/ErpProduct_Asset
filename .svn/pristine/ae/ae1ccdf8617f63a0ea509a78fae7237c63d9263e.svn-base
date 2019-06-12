/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.borrow.entity;

import cn.net.ecode.modules.eflow.entity.FlowLog;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import cn.net.ecode.common.persistence.DataEntity;


/**
 * 资产借用归还Entity
 * @author sunhuijun
 * @version 2018-09-20
 */
public class AssetBorrowInfo extends DataEntity<AssetBorrowInfo> {

	private static final long serialVersionUID = 1L;
	private String borrowCode;		// 借用编码
	private String borrowerCode;		// 借用人编码
	private String borrowerName;		// 借用人
	private Date borrowDate;			// 借用日期
	private Date expectedReturnDate;// 预计归还日期
	private String restituerCode;		// 归还人编码
	private String restituerName;		// 归还人
	private String approveStatus;		// 审核状态
	private String approvalStatus;// 审核状态
	private String approval;		// 审批人
	private String approvalName;		// 审批人姓名
	private String approvalMemo;		// 审批意见
	private Date approvalDate;		// 审批日期
	private String assetClassCode;   //资产类别编码
	private String assetClass;   //资产类别
	private int numberRecipients;   //借用资产数量
	List<AssetBorrowDtl> assetBorrowDtls;
	private String sysId;
	private Date factReturnDate;		// 实际归还日期
	private String notes;		// 说明
	private String extendS1;		// 扩展1
	private String extendS2;		// 扩展2
	private String extendS3;		// 扩展3
	private String return1;//判断借用归还 0归还
	private String isWrite;
	public String getReturn1() {
		return return1;
	}

	public void setReturn1(String return1) {
		this.return1 = return1;
	}

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
	private String  companyCode ;
	private String   officeCode;
	private String   office;
	private String assetStatus;
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

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getOfficeCode() {
		return officeCode;
	}

	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	public List<AssetBorrowDtl> getAssetBorrowDtls() {
		return assetBorrowDtls;
	}

	public void setAssetBorrowDtls(List<AssetBorrowDtl> assetBorrowDtls) {
		this.assetBorrowDtls = assetBorrowDtls;
	}

	public AssetBorrowInfo() {
		super();
	}

	public AssetBorrowInfo(String id){
		super();
		this.id = id;
	}

	@Length(min=0, max=64, message="借用编码长度不能超过 64 个字符")
	public String getBorrowCode() {
		return borrowCode;
	}

	public void setBorrowCode(String borrowCode) {
		this.borrowCode = borrowCode;
	}

	@Length(min=0, max=64, message="借用人编码长度不能超过 64 个字符")
	public String getBorrowerCode() {
		return borrowerCode;
	}

	public void setBorrowerCode(String borrowerCode) {
		this.borrowerCode = borrowerCode;
	}

	@NotBlank(message="借用人不能为空")
	@Length(min=0, max=100, message="借用人长度不能超过 100 个字符")
	public String getBorrowerName() {
		return borrowerName;
	}

	public void setBorrowerName(String borrowerName) {
		this.borrowerName = borrowerName;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="借用日期不能为空")
	public Date getBorrowDate() {
		return borrowDate;
	}

	public void setBorrowDate(Date borrowDate) {
		this.borrowDate = borrowDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getExpectedReturnDate() {
		return expectedReturnDate;
	}

	public void setExpectedReturnDate(Date expectedReturnDate) {
		this.expectedReturnDate = expectedReturnDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFactReturnDate() {
		return factReturnDate;
	}

	public void setFactReturnDate(Date factReturnDate) {
		this.factReturnDate = factReturnDate;
	}

	@Length(min=0, max=64, message="归还人编码长度不能超过 64 个字符")
	public String getRestituerCode() {
		return restituerCode;
	}

	public void setRestituerCode(String restituerCode) {
		this.restituerCode = restituerCode;
	}

	@Length(min=0, max=100, message="归还人长度不能超过 100 个字符")
	public String getRestituerName() {
		return restituerName;
	}

	public void setRestituerName(String restituerName) {
		this.restituerName = restituerName;
	}

	@Length(min=0, max=1, message="审核状态长度不能超过 1 个字符")
	public String getApproveStatus() {
		return approveStatus;
	}

	public void setApproveStatus(String approveStatus) {
		this.approveStatus = approveStatus;
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

	public String getAssetStatus() {
		return assetStatus;
	}
	public String getSysId() {
		return sysId;
	}

	public void setSysId(String sysId) {
		this.sysId = sysId;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public void setAssetStatus(String assetStatus) {
		this.assetStatus = assetStatus;
	}

	public String getIsWrite() {
		return isWrite;
	}

	public void setIsWrite(String isWrite) {
		this.isWrite = isWrite;
	}
}