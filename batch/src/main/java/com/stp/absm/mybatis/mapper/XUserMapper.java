package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.XUser;

/**
 * Created by bridge on 15. 12. 29..
 */
@Master
public interface XUserMapper {

    List<XUser> selectUsers(Map<String, Object> params);

    int selectUsersCount(Map<String, Object> params);

    List<XUser> selectOutUsers(Map<String, Object> params);

    int selectOutUsersCount(Map<String, Object> params);

}
