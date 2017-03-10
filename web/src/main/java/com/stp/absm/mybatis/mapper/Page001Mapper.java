package com.stp.absm.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmPrivate;
import com.stp.absm.model.KamsBoardComments;
import com.stp.absm.model.KamsBoardContent;
import com.stp.absm.repository.support.Master;

/**
 * 개인특성자료입력 화면
 */
@Master
public interface Page001Mapper {

    List<AbsmPrivate> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

}
