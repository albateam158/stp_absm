package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmEvent;
import com.stp.absm.model.AbsmFile;
import com.stp.absm.repository.support.Master;

/**
 *  동영상 자료 화면
 */
@Master
public interface Page004Mapper {

    List<AbsmFile> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

}
