package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmFilter;
import com.stp.absm.model.AbsmMeasure;
import com.stp.absm.model.AbsmModel;
import com.stp.absm.model.AbsmSurvey;
import com.stp.absm.repository.support.Master;

/**
 * 결과보기 화면
 */
@Master
public interface Page006Mapper {

    List<AbsmFilter> selectFilters(Map<String, Object> params);

    Integer selectFiltersCount(Map<String, Object> params);

    List<AbsmModel> selectModels(Map<String, Object> params);

    Integer selectModelsCount(Map<String, Object> params);

    List<AbsmMeasure> selectMeasures(Map<String, Object> params);


}
