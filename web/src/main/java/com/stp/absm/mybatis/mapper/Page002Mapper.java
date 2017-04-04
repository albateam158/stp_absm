package com.stp.absm.mybatis.mapper;

import com.stp.absm.model.AbsmFilter;
import com.stp.absm.model.AbsmModel;
import com.stp.absm.model.AbsmOrg;

import java.util.List;
import java.util.Map;
/**
 * 실험대상자 측정자료입력 화면
 */
public interface Page002Mapper {

    List<AbsmOrg> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

    Integer createFilterValCd2(AbsmFilter absmFilter);

    Integer createFilterValCd3(AbsmFilter absmFilter);

    Integer createModel(AbsmModel absmModel);

    List<AbsmModel> selectModelResult(Map<String, Object> params);


    Integer deletePrivate(Map<String, Object> params);

    Integer deleteMeasure(Map<String, Object> params);

    Integer deleteSurvey(Map<String, Object> params);

    Integer deleteSurveyAvg(Map<String, Object> params);

    Integer deleteFile(Map<String, Object> params);

    Integer deleteOrg(Map<String, Object> params);

    Integer deleteEvent(Map<String, Object> params);

    Integer deleteFilter(Map<String, Object> params);

    Integer deleteModel(Map<String, Object> params);

    List<AbsmFilter> selectFilterPrId(Map<String, Object> params);
}
