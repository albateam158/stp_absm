package com.stp.absm.mybatis.mapper;

import com.stp.absm.model.AbsmEvent;
import com.stp.absm.model.AbsmPrivate;

import java.util.List;
import java.util.Map;

/**
 * 이벤트자료입력 화면
 */
public interface Page003Mapper {

    List<AbsmEvent> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

    List<AbsmPrivate> selectPrivates(Map<String, Object> params);

}
