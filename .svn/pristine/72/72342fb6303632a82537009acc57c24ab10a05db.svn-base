package cn.net.ecode.modules.ass.report.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.utils.excel.annotation.ExcelField;
import freemarker.cache.StrongCacheStorage;

/**
 * 收发存明细报表信息entity
 * @author tiange
 * @version 2018-10-16
 */
public class SendReceive extends DataEntity<SendReceive>  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Double inInitialQty;				//入库初始数量
	private String inInitialPrice;			//入库初始单价
	private String inInitialMoney;		//入库初始金额
	private Double outInitialQty;				//出库初始数量
	private String outInitialPrice;			//出库初始单价
	private String outInitialMoney;		//出库初始金额
	
	
	private Double inoutQty;		//入库数量
	private String inoutOrder;			//入库单号
	private String inoutBy;			//入库经办人
	private Date inoutDate;			//入库时间
	private String inoutDateString;	//入库时间字符串
	private String inoutPrice;			//入库单价
	private String inoutMoney;		//入库金额
	private String costPrice;			//入库中出库
	private String taxMoney;			//入库中出库
	private String discount;		//入库中出库
	private String inoutStatus;		//入库状态
	
	
	private Double outboundNumber;		//出库数量
	private String outOrder;			//出库单号
	private String outBy;			//出库经办人
	private Date outDate;				//出库经办时间
	private String outboundPrice;			//出库单价
	private String outboundMoney;		//出库金额
	private String psnCode;				//出库中入库
	private String billCode;			//出库出中入库
	private String psnName;		//出库中入库
	private String outStatus;		//出库状态
	
	private Double balanceQty;		//入库结存数量
	private String balancePrice;			//入库结存单价
	private String balanceSumMoney;		//入库结存金额
	private Double balancesQty;		//出库结存数量
	private String balancesPrice;			//出库结存单价
	private String balancesSumMoney;		//出库结存金额
	
	private String whCode;				//仓库编码
	private String whName;				//仓库名称
	private String articlesCode;		//物品编码
	private String articlesName;		//物品名称
	private String status;				//状态
	
	private String warehouseWhCode;			//获取的仓库编码
	private String warehouseWhName;		//获取的仓库值
	private Date beginDate;			//开始日期
	private Date endDate;				//结束日期
	private String warehouseArticlesName;	//传的传的物品名称
	private String warehouseArticlesCode;	//传的编码值
	private String warehouseWhCodes;			//传的仓库编码
	
	@ExcelField(
            title = "初始数量",
            align = 1,
            sort = 6
    )
	public Double getinInitialQty() {
		return inInitialQty;
	}
	public void setinInitialQty(Double inInitialQty) {
		this.inInitialQty = inInitialQty;
	}
	@ExcelField(
            title = "初始单价",
            align = 1,
            sort = 7
    )
	public String getinInitialPrice() {
		return inInitialPrice;
	}
	public void setinInitialPrice(String inInitialPrice) {
		this.inInitialPrice = inInitialPrice;
	}
	@ExcelField(
            title = "初始金额",
            align = 1,
            sort = 8
    )
	public String getinInitialMoney() {
		return inInitialMoney;
	}
	public void setinInitialMoney(String inInitialMoney) {
		this.inInitialMoney = inInitialMoney;
	}
	@ExcelField(
            title = "单据号",
            align = 1,
            sort = 1
    )
	public String getInoutOrder() {
		return inoutOrder;
	}
	public void setInoutOrder(String inoutOrder) {
		this.inoutOrder = inoutOrder;
	}
	
	@JsonFormat(pattern="yyyy-MM-dd") 
	public Date getInoutDate() {
		return inoutDate;
	}
	public void setInoutDate(Date inoutDate) {
		this.inoutDate = inoutDate;
	}
	@ExcelField(
            title = "入库单价",
            align = 1,
            sort = 10
    )
	public String getInoutPrice() {
		return inoutPrice;
	}
	public void setInoutPrice(String inoutPrice) {
		this.inoutPrice = inoutPrice;
	}
	public Double getOutboundNumber() {
		return outboundNumber;
	}
	public void setOutboundNumber(Double outboundNumber) {
		this.outboundNumber = outboundNumber;
	}
	public String getOutOrder() {
		return outOrder;
	}
	public void setOutOrder(String outOrder) {
		this.outOrder = outOrder;
	}
	@JsonFormat(pattern="yyyy-MM-dd") 
	public Date getOutDate() {
		return outDate;
	}
	public void setOutDate(Date outDate) {
		this.outDate = outDate;
	}
	public String getOutboundPrice() {
		return outboundPrice;
	}
	public void setOutboundPrice(String outboundPrice) {
		this.outboundPrice = outboundPrice;
	}
	@ExcelField(
            title = "结存数量",
            align = 1,
            sort = 15
    )
	public Double getBalanceQty() {
		return balanceQty;
	}
	public void setBalanceQty(Double balanceQty) {
		this.balanceQty = balanceQty;
	}
	@ExcelField(
            title = "结存单价",
            align = 1,
            sort = 16
    )
	public String getBalancePrice() {
		return balancePrice;
	}
	public void setBalancePrice(String balancePrice) {
		this.balancePrice = balancePrice;
	}
	@ExcelField(
            title = "结存金额",
            align = 1,
            sort = 17
    )
	public String getBalanceSumMoney() {
		return balanceSumMoney;
	}
	public void setBalanceSumMoney(String balanceSumMoney) {
		this.balanceSumMoney = balanceSumMoney;
	}
	@ExcelField(
            title = "入库数量",
            align = 1,
            sort = 9
    )
	public Double getInoutQty() {
		return inoutQty;
	}
	public void setInoutQty(Double inoutQty) {
		this.inoutQty = inoutQty;
	}
	@ExcelField(
            title = "经办人",
            align = 1,
            sort = 2
    )
	public String getInoutBy() {
		return inoutBy;
	}
	public void setInoutBy(String inoutBy) {
		this.inoutBy = inoutBy;
	}
	@ExcelField(
            title = "入库金额",
            align = 1,
            sort = 11
    )
	public String getInoutMoney() {
		return inoutMoney;
	}
	public void setInoutMoney(String inoutMoney) {
		this.inoutMoney = inoutMoney;
	}
	public String getOutBy() {
		return outBy;
	}
	public void setOutBy(String outBy) {
		this.outBy = outBy;
	}
	public String getOutboundMoney() {
		return outboundMoney;
	}
	public void setOutboundMoney(String outboundMoney) {
		this.outboundMoney = outboundMoney;
	}
	public String getWhCode() {
		return whCode;
	}
	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}
	@ExcelField(
            title = "仓库",
            align = 1,
            sort = 4
    )
	public String getWhName() {
		return whName;
	}
	public void setWhName(String whName) {
		this.whName = whName;
	}
	public String getArticlesCode() {
		return articlesCode;
	}
	public void setArticlesCode(String articlesCode) {
		this.articlesCode = articlesCode;
	}
	@ExcelField(
            title = "物品",
            align = 1,
            sort = 5
    )
	public String getArticlesName() {
		return articlesName;
	}
	public void setArticlesName(String articlesName) {
		this.articlesName = articlesName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@ExcelField(
            title = "出库数量",
            align = 1,
            sort = 12
    )
	public String getCostPrice() {
		return costPrice;
	}
	public void setCostPrice(String costPrice) {
		this.costPrice = costPrice;
	}
	@ExcelField(
            title = "出库单价",
            align = 1,
            sort = 13
    )
	public String getTaxMoney() {
		return taxMoney;
	}
	public void setTaxMoney(String taxMoney) {
		this.taxMoney = taxMoney;
	}
	@ExcelField(
            title = "出库金额",
            align = 1,
            sort = 14
    )
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	
	public String getPsnCode() {
		return psnCode;
	}
	public void setPsnCode(String psnCode) {
		this.psnCode = psnCode;
	}
	public String getBillCode() {
		return billCode;
	}
	public void setBillCode(String billCode) {
		this.billCode = billCode;
	}
	public String getPsnName() {
		return psnName;
	}
	public void setPsnName(String psnName) {
		this.psnName = psnName;
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
	public Double getOutInitialQty() {
		return outInitialQty;
	}
	public void setOutInitialQty(Double outInitialQty) {
		this.outInitialQty = outInitialQty;
	}
	public String getOutInitialPrice() {
		return outInitialPrice;
	}
	public void setOutInitialPrice(String outInitialPrice) {
		this.outInitialPrice = outInitialPrice;
	}
	public String getOutInitialMoney() {
		return outInitialMoney;
	}
	public void setOutInitialMoney(String outInitialMoney) {
		this.outInitialMoney = outInitialMoney;
	}
	@ExcelField(
            title = "经办日期",
            align = 1,
            sort = 3
    )
	public String getInoutDateString() {
		return inoutDateString;
	}
	public void setInoutDateString(String inoutDateString) {
		this.inoutDateString = inoutDateString;
	}
	public String getInoutStatus() {
		return inoutStatus;
	}
	public void setInoutStatus(String inoutStatus) {
		this.inoutStatus = inoutStatus;
	}
	public String getOutStatus() {
		return outStatus;
	}
	public void setOutStatus(String outStatus) {
		this.outStatus = outStatus;
	}
	public Double getBalancesQty() {
		return balancesQty;
	}
	public void setBalancesQty(Double balancesQty) {
		this.balancesQty = balancesQty;
	}
	public String getBalancesPrice() {
		return balancesPrice;
	}
	public void setBalancesPrice(String balancesPrice) {
		this.balancesPrice = balancesPrice;
	}
	public String getBalancesSumMoney() {
		return balancesSumMoney;
	}
	public void setBalancesSumMoney(String balancesSumMoney) {
		this.balancesSumMoney = balancesSumMoney;
	}
	public String getWarehouseArticlesCode() {
		return warehouseArticlesCode;
	}
	public void setWarehouseArticlesCode(String warehouseArticlesCode) {
		this.warehouseArticlesCode = warehouseArticlesCode;
	}
	public String getWarehouseWhCodes() {
		return warehouseWhCodes;
	}
	public void setWarehouseWhCodes(String warehouseWhCodes) {
		this.warehouseWhCodes = warehouseWhCodes;
	}
	public String getWarehouseArticlesName() {
		return warehouseArticlesName;
	}
	public void setWarehouseArticlesName(String warehouseArticlesName) {
		this.warehouseArticlesName = warehouseArticlesName;
	}
	public String getWarehouseWhName() {
		return warehouseWhName;
	}
	public void setWarehouseWhName(String warehouseWhName) {
		this.warehouseWhName = warehouseWhName;
	}
	public String getWarehouseWhCode() {
		return warehouseWhCode;
	}
	public void setWarehouseWhCode(String warehouseWhCode) {
		this.warehouseWhCode = warehouseWhCode;
	}
	
}
