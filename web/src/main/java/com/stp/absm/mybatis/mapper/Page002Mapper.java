package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmFilter;
import com.stp.absm.model.AbsmMeasure;
import com.stp.absm.model.AbsmModel;
/**
 * 실험대상자 측정자료입력 화면
 */
public interface Page002Mapper {

    List<AbsmMeasure> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

    Integer createFilterValCd2(AbsmFilter absmFilter);

    Integer createFilterValCd3(AbsmFilter absmFilter);

    Integer createModel(AbsmModel absmModel);

    List<AbsmModel> selectModelResult(Map<String, Object> params);


    Integer deletePrivate(Map<String, Object> params);

    Integer deleteMeasure(Map<String, Object> params);

    Integer deleteSurvey(Map<String, Object> params);

    Integer deleteSurveyAvg(Map<String, Object> params);


    Integer deleteOrg(Map<String, Object> params);

    Integer deleteEvent(Map<String, Object> params);

    Integer deleteFilter(Map<String, Object> params);

    Integer deleteModel(Map<String, Object> params);
}
