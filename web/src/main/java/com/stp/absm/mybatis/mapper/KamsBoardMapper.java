package com.stp.absm.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stp.absm.model.KamsBoardComments;
import com.stp.absm.model.KamsBoardContent;
import com.stp.absm.repository.support.Master;

/**
 * Created by bridge on 16. 1. 11..
 */
@Master
public interface KamsBoardMapper {

    List<KamsBoardContent> selectBoards(Map<String, Object> params);

    Integer selectBoardsCount(Map<String, Object> params);

    List<KamsBoardComments> selectBoardComments(HashMap<String, Object> params);
}
