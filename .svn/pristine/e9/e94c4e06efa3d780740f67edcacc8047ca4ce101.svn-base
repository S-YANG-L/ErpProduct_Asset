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
 * 部门汇总
 */
public class AssetOffice extends DataEntity<AssetOffice> {

    private static final long serialVersionUID = 1L;

    private String sumAssetName;        // 资产数量
    private String Je;// 单价
    private String officeName;        // 使用部门
    private String officeCode;        // 使用部门

    @ExcelField(title = "资产数量", align = 1, sort = 2)
    public String getSumAssetName() {
        return sumAssetName;
    }

    public void setSumAssetName(String sumAssetName) {
        this.sumAssetName = sumAssetName;
    }

    @ExcelField(title = "金额", align = 1, sort = 3)
    public String getJe() {
        return Je;
    }

    public void setJe(String je) {
        Je = je;
    }

    @ExcelField(title = "部门", align = 1, sort = 1)
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
}