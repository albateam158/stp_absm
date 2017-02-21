package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.KAccCode;
import com.stp.absm.model.KPlList;
import com.stp.absm.model.KProdCode;
import com.stp.absm.model.dz.DzDept;
import com.stp.absm.model.dz.TbDzDept;
import com.stp.absm.repository.support.Master;

/**
 * Created by bridge on 15. 12. 29..
 */
@Master
public interface KamsRecordMapper {
    //부서코드
    List<DzDept> selectTbDepts(Map<String, Object> params);

    List<DzDept> selectTbDeptsGrpByDeptCd(Map<String, Object> params);

    List<TbDzDept> selectTbDeptsRecord();

    //계정코드
    List<KAccCode> selectAccCdList(Map<String, Object> params);

    //상품코드
    List<KProdCode> selectProdCdList(Map<String, Object> params);

    //실적폼내역
    List<KPlList> selectPlList(Map<String, Object> params);

    KPlList selectPlOne(Map<String, Object> params);

    int selectPlListCount(Map<String, Object> params);


    //실적내역ALL
    List<KPlList> selectPlListAll(Map<String, Object> params);

    int selectPlListCountAll(Map<String, Object> params);

    //실적보고ALL
    List<KPlList> selectPlLisReport(Map<String, Object> params);

    int selectPlLisReportCount(Map<String, Object> params);

    //전화번호부

    String selectJsonTreeData();


    //실적원장
//    List<KPlBal> selectPlBal(Map<String, Object> params);
//
//    KPlList selectPlBalOne(Map<String, Object> params);
//
//    int selectPlBalCount(Map<String, Object> params);


}
