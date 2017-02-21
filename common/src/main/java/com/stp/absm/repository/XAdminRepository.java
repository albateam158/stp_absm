package com.stp.absm.repository;

import com.stp.absm.model.XAdmin;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 15. 12. 22..
 */
@Master
public interface XAdminRepository extends JpaRepository<XAdmin, Integer> {
    XAdmin findByEmpNo(String username);
}
