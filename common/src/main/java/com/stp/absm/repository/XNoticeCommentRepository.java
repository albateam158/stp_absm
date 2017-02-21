package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.XNoticeComment;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface XNoticeCommentRepository extends JpaRepository<XNoticeComment, Integer> {
    List<XNoticeComment> findByUserId(String userId);
    Integer countByNoticeIdAndDeleteDateIsNull(Integer communityId);

    List<XNoticeComment> findByNoticeIdAndDeleteDateIsNull(Integer communityId, Pageable pageable);
}
