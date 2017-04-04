package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.model.AbsmFile;

/**
 *  동영상 자료 화면
 */
public interface Page004Mapper {

    List<AbsmFile> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

}
