package cn.net.ecode.modules.ass.common.utils;


import cn.net.ecode.common.utils.SpringContextHolder;
import cn.net.ecode.common.utils.StringUtils;
import cn.net.ecode.modules.ass.common.service.MaxBillCodeService;

public class BillTypeUtils {

    private static MaxBillCodeService MaxBillCodeService = (MaxBillCodeService) SpringContextHolder.getBean(MaxBillCodeService.class);

    /**
     * 获取最大单号(需要在service中调用，需要使用事务)
     *
     * @param billType：单据类型(不能为空)
     * @param companyCode：公司编码
     * @return
     */
    public static String getMaxBillCode(String billType, String companyCode) {
        if (StringUtils.isBlank(billType)) {
            return null;
        }
        return MaxBillCodeService.getMaxCode(billType, companyCode);
    }

    public static String getBillTypeName(String billType) {
        String billTypeName = "";
        switch (billType) {
            case BillTypeUtils.BX:
                billTypeName = "报销单";
                break;
            case BillTypeUtils.CG:
                billTypeName = "采购订单";
                break;
            case BillTypeUtils.TH:
                billTypeName = "退货订单";
                break;
            case BillTypeUtils.CK:
                billTypeName = "出库单";
                break;
            case BillTypeUtils.CL:
                billTypeName = "差旅费报销单";
                break;
            case BillTypeUtils.CX:
                billTypeName = "个人借款冲销";
                break;
            case BillTypeUtils.DB:
                billTypeName = "调拨单";
                break;
            case BillTypeUtils.FK:
                billTypeName = "付款单";
                break;
            case BillTypeUtils.JK:
                billTypeName = "个人借款";
                break;
            case BillTypeUtils.ZCGH:
                billTypeName = "资产归还单";
                break;
            case BillTypeUtils.RK:
                billTypeName = "入库单";
                break;
            case BillTypeUtils.SK:
                billTypeName = "收款单";
                break;
            case BillTypeUtils.XS:
                billTypeName = "销售发票";
                break;
            case BillTypeUtils.YK:
                billTypeName = "移库单";
                break;
            case BillTypeUtils.ZF:
                billTypeName = "对公支付单";
                break;
            case BillTypeUtils.QR:
                billTypeName = "其它入库单";
                break;
            case BillTypeUtils.QC:
                billTypeName = "其它出库单";
                break;
            case BillTypeUtils.LZ:
                billTypeName = "离职申请";
                break;
            case BillTypeUtils.JB:
                billTypeName = "加班申请单";
                break;
            case BillTypeUtils.BXIU:
                billTypeName = "报修申请单";
                break;
            case BillTypeUtils.QS:
                billTypeName = "业务请示单";
                break;
            case BillTypeUtils.CC:
                billTypeName = "出差申请单";
                break;
            case BillTypeUtils.QJ:
                billTypeName = "请假申请单";
                break;
            case BillTypeUtils.YCSQ:
                billTypeName = "用车申请单";
                break;
            case BillTypeUtils.FL:
                billTypeName = "返利政策";
                break;
            case BillTypeUtils.JG:
                billTypeName = "价格调整";
                break;
            case BillTypeUtils.GC:
                billTypeName = "工程批文";
                break;
            case BillTypeUtils.TJ:
                billTypeName = "特价批文";
                break;
            case BillTypeUtils.MZ:
                billTypeName = "买赠单";
                break;
            case BillTypeUtils.KHZCNDFL:
                billTypeName = "客户政策返利";
                break;
            case BillTypeUtils.KHZCNDZK:
                billTypeName = "客户政策直扣";
                break;


            case BillTypeUtils.GCSHF:
                billTypeName = "工程返利-事后返";
                break;
            case BillTypeUtils.GCKDZK:
                billTypeName = "工程返利-开单直扣";
                break;
            case BillTypeUtils.MZYS:
                billTypeName = "买赠预算";
                break;
            case BillTypeUtils.TJYS:
                billTypeName = "特价预算";
                break;

            case BillTypeUtils.JTZJ:
                billTypeName = "计提折旧";
                break;

            case BillTypeUtils.ZCXZ:
                billTypeName = "资产新增";
                break;
            case BillTypeUtils.WC:
                billTypeName = "外出人员申请单";
                break;
            case BillTypeUtils.SJDD:
                billTypeName = "CRM商机任务打卡地点";
                break;
            case BillTypeUtils.TLZTX:
                billTypeName = "讨论组头像";
                break;
            case BillTypeUtils.BAOXIAN:
                billTypeName = "车辆保险图片";
                break;
            case BillTypeUtils.SYBAOXIAN:
                billTypeName = "车辆商业保险图片";
                break;
            case BillTypeUtils.CARINFO:
                billTypeName = "车辆信息图片";
                break;
            case BillTypeUtils.NSZHENGSHU:
                billTypeName = "车辆年审证书";
                break;
            case BillTypeUtils.CLWX:
                billTypeName = "车辆维修图片";
                break;
            case BillTypeUtils.ZC:
                billTypeName = "资产领用单";
                break;
            case BillTypeUtils.XMYQ:
                billTypeName = "项目延期申请单";
                break;
            case BillTypeUtils.XZ:
                billTypeName = "薪资调整单";
                break;
            case BillTypeUtils.JF:
                billTypeName = "奖罚单";
                break;
            case BillTypeUtils.TX:
                billTypeName = "转账单";
                break;
            case BillTypeUtils.ZK:
                billTypeName = "转款";
                break;
            case BillTypeUtils.CGFP:
                billTypeName = "采购发票";
                break;
            case BillTypeUtils.XSFP:
                billTypeName = "销售发票";
                break;
            case BillTypeUtils.XKZ:
                billTypeName = "许可证";
                break;
            case BillTypeUtils.KCQC:
                billTypeName = "库存期初";
                break;
            case BillTypeUtils.XSHT:
                billTypeName = "销售合同";
                break;
            case BillTypeUtils.CGHT:
                billTypeName = "采购合同";
                break;
            case BillTypeUtils.KHXY:
                billTypeName = "客户信用";
                break;
            case BillTypeUtils.KCPD:
                billTypeName = "库存盘点";
                break;
            case BillTypeUtils.YGDJ:
                billTypeName = "员工登记";
                break;
            case BillTypeUtils.KFSQ:
                billTypeName = "开发申请";
                break;
            case BillTypeUtils.YZHTSQ:
                billTypeName = "用章合同申请";
                break;
            case BillTypeUtils.ZCLY:
                billTypeName = "资产领用单";
                break;
            case BillTypeUtils.ZCJY:
                billTypeName = "资产借用单";
                break;
            case BillTypeUtils.ZCJYGH:
                billTypeName = "资产归还单";
                break;
            case BillTypeUtils.ZCTK:
                billTypeName = "资产借用单";
                break;
            case BillTypeUtils.ZCDB:
                billTypeName = "资产调拨单";
                break;
        }
        return billTypeName;
    }
    /**
     * 资产退库smallsapling
     */
    public static final String ZCTK = "ZCTK";
    /**
     * 资产退库smallsapling
     */
    public static final String ZCDB = "ZCDB";
    /**
     * 资产借用smallsapling
     */
    public static final String ZCJY = "ZCJY";
    /**
     * 资产归还smallsapling
     */
    public static final String ZCJYGH = "ZCJYGH";
    /**
     * 资产领用smallsapling
     */
    public static final String ZCLY = "ZCLY";
    /**
     * 车辆维修图片smallsapling
     */
    public static final String YGDJ = "YGDJ";
    /**
     * 车辆维修图片 wangfangwen
     */
    public static final String CLWX = "CLWX";

    /**
     * 项目延期申请单 wangfangwen
     */
    public static final String XMYQ = "XMYQ";

    /**
     * 车辆信息图片 wangfangwen
     */
    public static final String CARINFO = "CARINFO";
    /**
     * 车辆保险图片 wangfangwen
     */
    public static final String BAOXIAN = "BAOXIAN";
    /**
     * 车辆商业保险图片 wangfangwen
     */
    public static final String SYBAOXIAN = "SYBAOXIAN";
    /**
     * 车辆商业保险图片 wangfangwen
     */
    public static final String NSZHENGSHU = "NSZHENGSHU";
    /**
     * 讨论组头像 wangfangwen
     */
    public static final String TLZTX = "TLZTX";
    /**
     * 用车申请单 wangfangwen
     */
    public static final String YCSQ = "YCSQ";
    /**
     * CRM商机任务打卡地点 wangfangwen
     */
    public static final String SJDD = "SJDD";
    /**
     * /**
     * 外出人员申请单 chenyuan
     */
    public static final String WC = "WC";
    /**
     * 报销单
     */
    public static final String BX = "BX";
    /**
     * 个人借款
     */
    public static final String JK = "JK";
    /**
     * 对公支付单
     */
    public static final String ZF = "ZF";
    /**
     * 差旅费报销单
     */
    public static final String CL = "CL";
    /**
     * 收款收据
     */
    public static final String SK = "SK";
    /**
     * 付款单
     */
    public static final String FK = "FK";
    /**
     * 出库单
     */
    public static final String CK = "CK";
    /**
     * 入库单
     */
    public static final String RK = "RK";
    /**
     * 销售单
     */
    public static final String XS = "XS";
    /**
     * 采购单
     */
    public static final String CG = "CG";
    /**
     * 退货订单
     */
    public static final String TH = "TH";
    /**
     * 调拨单
     */
    public static final String DB = "DB";
    /**
     * 移库单
     */
    public static final String YK = "YK";
    /**
     * 个人借款冲销
     */
    public static final String CX = "CX";
    /**
     * 其它入库单
     */
    public static final String QR = "QR";
    /**
     * 其它出库单
     */
    public static final String QC = "QC";
    /**
     * 离职申请
     */
    public static final String LZ = "LZ";

    /**
     * 加班申请
     */
    public static final String JB = "JB";
    /**
     * 报修申请
     */
    public static final String BXIU = "BXIU";
    /**
     * 业务请示单
     */
    public static final String QS = "QS";
    /**
     * 出差申请单
     */
    public static final String CC = "CC";
    /**
     * 返利政策
     */
    public static final String FL = "FL";
    /**
     * 价格调整
     */
    public static final String JG = "JG";
    /**
     * 买赠单
     */
    public static final String MZ = "MZ";

    /**
     * 工程批文
     */
    public static final String GC = "GC";

    /**
     * 特价批文
     */
    public static final String TJ = "TJ";

    /**
     * 计提折旧
     */
    public static final String JTZJ = "JTZJ";

    /**
     * 资产新增
     */
    public static final String ZCXZ = "ZCXZ";
    /**
     * 薪资调整单
     */
    public static final String XZ = "XZ";

    /**
     * 奖罚单
     */
    public static final String JF = "JF";
    /**
     * 转账单
     */
    public static final String TX = "TX";
    /**
     * 申请管理单
     */
    public static final String KFSQ = "KFSQ";

    /**
     * 客户政策工程返利
     */
    public static final String KHZCNDFL = "120101";
    public static final String KHZCNDZK = "120102";

    public static final String GCSHF = "220401";    //工程返利-事后返
    public static final String GCKDZK = "220402";    //工程返利-开单直扣
    public static final String MZYS = "220501";        // 买赠预算
    public static final String TJYS = "220601";    //特价预算
    /**
     * 临时项目的viewCode
     */
    public static final String TEMPORARY_PROJECT = "Y2016-03";

    /**
     * msgType 类型
     */
    public static final String DJ = "0";    //单据
    public static final String HT = "1";    //合同
    public static final String DJTH = "2";    //单据退回
    /**
     * 请假申请
     */
    public static final String QJ = "QJ";
    /**
     * 资产领用申请单 chenyuan
     */
    public static final String ZC = "ZC";
    /**
     * 用章合同申请单 cjt
     */
    public static final String YZHTSQ = "YZHTSQ";
    /**
     * 资产归还 wfw
     */
    public static final String ZCGH = "ZCGH";


    /**
     * 转款
     */
    public static final String ZK = "ZK";

    public static final String CGFP = "61";
    public static final String XSFP = "62";

    /**
     * 许可证 license申请
     */
    public static final String XKZ = "XKZ";

    /**
     * 库存期初 Mc add 20180116
     */
    public static final String KCQC = "KCQC";
    /**
     * 销售合同
     */
    public static final String XSHT = "XSHT";
    /**
     * 采购合同
     */
    public static final String CGHT = "CGHT";
    /**
     * 物资采购 Mc add 20180123
     */
    public static final String WZCG = "WZCG";
    /**
     * 客户信用额度
     */
    public static final String KHXY = "KHXY";
    /**
     * 物资采购 Mc add 20180205
     */
    public static final String KCPD = "KCPD";
}
