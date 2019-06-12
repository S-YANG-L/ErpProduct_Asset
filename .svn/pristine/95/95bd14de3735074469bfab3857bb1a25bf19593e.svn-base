/**
 * Copyright &copy; 2013-2016 山东易科德软件有限公司   All rights reserved.
 */
package cn.net.ecode.modules.ass.assetsput.entity;

import cn.net.ecode.common.persistence.DataEntity;
import cn.net.ecode.common.utils.excel.annotation.ExcelField;
import cn.net.ecode.modules.sys.entity.Office;
import cn.net.ecode.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 资产折旧
 */
public class AssetZheJiu extends DataEntity<AssetZheJiu> {

    private static final long serialVersionUID = 1L;
    private String assetCode;        // 资产编码
    private String assetName;        // 资产名称
    private String unitPrice;//资产单价
    private String bqzJ;//本期折旧
    private String ljzJ;//累计折旧
    private String qZ;//净值
    private String qcZ;//净残值
    private String ageLimit;//使用期限
    private String syyF;//已使用月份
    private String syqX;//剩余期限
    private String zczE;//资产总计
    private String zclJ;//资产累计总计
    private String sortCode;//资产分类编码
    private String sortName;//资产分类名称
    private String topSortCode;		// 资产大类编码
    private String topSortName;		// 资产大类
    @ExcelField(title = "资产编码",align = 1,sort = 1 )
    public String getAssetCode() {
        return assetCode;
    }

    public void setAssetCode(String assetCode) {
        this.assetCode = assetCode;
    }
    @ExcelField(title = "资产名称",align = 1,sort = 2 )
    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }
    @ExcelField(title = "原值",align = 1,sort = 3 )
    public String getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }
    @ExcelField(title = "本期折旧",align = 1,sort = 4 )
    public String getBqzJ() {
        return bqzJ;
    }

    public void setBqzJ(String bqzJ) {
        this.bqzJ = bqzJ;
    }
    @ExcelField(title = "累计折旧",align = 1,sort = 5 )
    public String getLjzJ() {
        return ljzJ;
    }

    public void setLjzJ(String ljzJ) {
        this.ljzJ = ljzJ;
    }
    @ExcelField(title = "净值",align = 1,sort = 6 )
    public String getqZ() {
        return qZ;
    }

    public void setqZ(String qZ) {
        this.qZ = qZ;
    }
    @ExcelField(title = "使用期限",align = 1,sort = 8 )
    public String getAgeLimit() {
        return ageLimit;
    }

    public void setAgeLimit(String ageLimit) {
        this.ageLimit = ageLimit;
    }
    @ExcelField(title = "已使用月份",align = 1,sort = 9 )
    public String getSyyF() {
        return syyF;
    }

    public void setSyyF(String syyF) {
        this.syyF = syyF;
    }
    @ExcelField(title = "剩余期限",align = 1,sort = 10 )
    public String getSyqX() {
        return syqX;
    }

    public void setSyqX(String syqX) {
        this.syqX = syqX;
    }
    @ExcelField(title = "净残值",align = 1,sort = 7 )
    public String getQcZ() {
        return qcZ;
    }

    public void setQcZ(String qcZ) {
        this.qcZ = qcZ;
    }

    public String getZczE() {
        return zczE;
    }

    public void setZczE(String zczE) {
        this.zczE = zczE;
    }

    public String getZclJ() {
        return zclJ;
    }

    public void setZclJ(String zclJ) {
        this.zclJ = zclJ;
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
}