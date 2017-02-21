package com.stp.absm.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.stp.absm.model.XNotice;
import com.stp.absm.model.XNoticeComment;
import com.stp.absm.repository.support.Master;

/**
 * Created by bridge on 16. 1. 11..
 */
@Master
public interface KamsNoticeMapper {

    List<XNotice> selectNotices(Map<String, Object> params);

    Integer selectNoticesCount(Map<String, Object> params);

    List<XNoticeComment> selectNoticeComments(HashMap<String, Object> params);
}
