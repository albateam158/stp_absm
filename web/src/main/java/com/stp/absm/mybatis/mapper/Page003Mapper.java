package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmEvent;
import com.stp.absm.model.AbsmMeasure;
import com.stp.absm.repository.support.Master;

/**
 * 이벤트자료입력 화면
 */
@Master
public interface Page003Mapper {

    List<AbsmEvent> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

}
