/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.orderbill.entity;

import cn.net.ecode.common.persistence.annotation.Id;
import cn.net.ecode.modules.eflow.entity.FlowLog;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import cn.net.ecode.modules.sys.entity.Office;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import cn.net.ecode.common.persistence.DataEntity;

/**
 * 物资采购Entity
 * @author zhaohongbin
 * @version 2018-10-15
 */
public class OrderBill extends DataEntity<OrderBill> {
	
	private static final long serialVersionUID = 1L;
	private String sysCode;		// 主键(系统编码)
	private String billCode;		// 流水单号
	private String cgCode;		// 采购编码
	private String buyerCode;		// 采购人编码
	private String buyerName;		// 采购人姓名
	private String inoutStatus;		// 入库状态0：未入库1：已入库
	private String companyCode;		// 公司编码
	private String companyName;		// 公司名称
	private Office office;		// 部门编码
	private String officeName;		// 部门名称
	private Date orderDate;		// 采购日期
	private String billsortCode;		// 单据类型
	private String billsortName;		// 单据类型名称
	private String inoutFlag;		// 出入库标志 1：入库；0：出库
	private String btypeCode;		// 往来单位编码
	private String btypeName;		// 往来单位名称
	private String whCode;		// 仓库编码
	private String whName;		// 仓库名称
	private Date deliveryDate;		// 交货日期
	private String addr;		// 送货信息
	private String tel;		// 电话
	private String linkMan;		// 联系人
	private Double printNum;		// 采购数据总金额
	private String approvalStatus;		// 审批状态(0:撤回,1:审批中,2:审批完成,3:已驳回)
	private Date approvalDate;		// 审批日期
	private String approval;		// 审批人
	private String approvalName;		// 审批人名称
	private String projectCode;		// 产品编码
	private String projectName;		// 产品名称
	private List<OrderBills> orderBillsList = Lists.newArrayList();		// 子表列表
	private String[] sysCodes;		//采购关联编码数组  入库时领用表格中已有的数据
	private String remarks;			//备注

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
	public OrderBill() {
		super();
	}

	public OrderBill(String sysCode){
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
	
	@Length(min=0, max=20, message="流水单号长度不能超过 20 个字符")
	public String getBillCode() {
		return billCode;
	}

	public void setBillCode(String billCode) {
		this.billCode = billCode;
	}
	
	@Length(min=0, max=64, message="采购编码长度不能超过 64 个字符")
	public String getCgCode() {
		return cgCode;
	}

	public void setCgCode(String cgCode) {
		this.cgCode = cgCode;
	}
	
	@NotBlank(message="采购人编码不能为空")
	@Length(min=0, max=64, message="采购人编码长度不能超过 64 个字符")
	public String getBuyerCode() {
		return buyerCode;
	}

	public void setBuyerCode(String buyerCode) {
		this.buyerCode = buyerCode;
	}
	
	@NotBlank(message="采购人姓名不能为空")
	@Length(min=0, max=61, message="采购人姓名长度不能超过 61 个字符")
	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
	
	@Length(min=0, max=1, message="入库状态0：未入库1：已入库长度不能超过 1 个字符")
	public String getInoutStatus() {
		return inoutStatus;
	}

	public void setInoutStatus(String inoutStatus) {
		this.inoutStatus = inoutStatus;
	}
	@Length(min=0, max=20, message="公司编码长度不能超过 20 个字符")
	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	@Length(min=0, max=50, message="公司名称长度不能超过 50 个字符")
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
	
	@Length(min=0, max=50, message="部门名称长度不能超过 50 个字符")
	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	
	@Length(min=0, max=20, message="单据类型长度不能超过 20 个字符")
	public String getBillsortCode() {
		return billsortCode;
	}

	public void setBillsortCode(String billsortCode) {
		this.billsortCode = billsortCode;
	}
	
	@Length(min=0, max=20, message="单据类型名称长度不能超过 20 个字符")
	public String getBillsortName() {
		return billsortName;
	}

	public void setBillsortName(String billsortName) {
		this.billsortName = billsortName;
	}
	
	@Length(min=0, max=1, message="出入库标志 1：入库；0：出库长度不能超过 1 个字符")
	public String getInoutFlag() {
		return inoutFlag;
	}

	public void setInoutFlag(String inoutFlag) {
		this.inoutFlag = inoutFlag;
	}
	
	@Length(min=0, max=64, message="往来单位编码长度不能超过 64 个字符")
	public String getBtypeCode() {
		return btypeCode;
	}

	public void setBtypeCode(String btypeCode) {
		this.btypeCode = btypeCode;
	}
	
	@Length(min=0, max=50, message="往来单位名称长度不能超过 50 个字符")
	public String getBtypeName() {
		return btypeName;
	}

	public void setBtypeName(String btypeName) {
		this.btypeName = btypeName;
	}
	
	@Length(min=0, max=64, message="仓库编码长度不能超过 64 个字符")
	public String getWhCode() {
		return whCode;
	}

	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	
	@Length(min=0, max=50, message="仓库名称长度不能超过 50 个字符")
	public String getWhName() {
		return whName;
	}

	public void setWhName(String whName) {
		this.whName = whName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	
	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	@Length(min=0, max=20, message="电话长度不能超过 20 个字符")
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Length(min=0, max=20, message="联系人长度不能超过 20 个字符")
	public String getLinkMan() {
		return linkMan;
	}

	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	
	public Double getPrintNum() {
		return printNum;
	}

	public void setPrintNum(Double printNum) {
		this.printNum = printNum;
	}

	@Length(min=0, max=1, message="审批状态(0:撤回,1:审批中,2:审批完成,3:已驳回)长度不能超过 1 个字符")
	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}
	
	@Length(min=0, max=64, message="审批人长度不能超过 64 个字符")
	public String getApproval() {
		return approval;
	}

	public void setApproval(String approval) {
		this.approval = approval;
	}
	
	@Length(min=0, max=20, message="审批人名称长度不能超过 20 个字符")
	public String getApprovalName() {
		return approvalName;
	}

	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}
	
	@Length(min=0, max=64, message="产品编码长度不能超过 64 个字符")
	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	
	@Length(min=0, max=64, message="产品名称长度不能超过 64 个字符")
	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	
	public List<OrderBills> getOrderBillsList() {
		return orderBillsList;
	}

	public void setOrderBillsList(List<OrderBills> orderBillsList) {
		this.orderBillsList = orderBillsList;
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

	public String[] getSysCodes() {
		return sysCodes;
	}

	public void setSysCodes(String[] sysCodes) {
		this.sysCodes = sysCodes;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
    
}