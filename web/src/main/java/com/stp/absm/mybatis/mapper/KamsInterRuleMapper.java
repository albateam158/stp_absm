package com.stp.absm.mybatis.mapper;

import java.util.List;
import java.util.Map;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KInRule;

/**
 * Created by bridge on 15. 12. 29..
 */
@Master
public interface KamsInterRuleMapper {

    List<KInRule> selectKinRules(Map<String, Object> params);

    KInRule selectKinRule(Map<String, Object> params);

    int selectKinRuleCount(Map<String, Object> params);

    KInRule selectKinRuleDocSeq(Map<String, Object> params);



}
