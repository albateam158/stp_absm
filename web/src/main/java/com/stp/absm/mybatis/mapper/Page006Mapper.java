package com.stp.absm.mybatis.mapper;

import com.stp.absm.model.*;

import java.util.List;
import java.util.Map;

/**
 * 결과보기 화면
 */
public interface Page006Mapper {

    List<AbsmFilter> selectFilters(Map<String, Object> params);

    Integer selectFiltersCount(Map<String, Object> params);

    List<AbsmModel> selectModels(Map<String, Object> params);

    Integer selectModelsCount(Map<String, Object> params);

    List<AbsmMeasure> selectMeasures(Map<String, Object> params);

    List<AbsmFilter> selectResultData(Map<String, Object> params);

    AbsmFile selectVideoUrl(Map<String, Object> params);

    List<AbsmEvent> selectEvents(Map<String, Object> params);

    List<AbsmPrivate> selectPrivates(Map<String, Object> params);

    AbsmPrivate selectPrivate(Map<String, Object> params);

    List<AbsmOrg> selectGraph(Map<String, Object> params);

    List<AbsmMeasure> selectGraph2(Map<String, Object> params);

    List<AbsmOrg> selectReportData(Map<String, Object> params);

}
