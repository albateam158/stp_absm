<#escape x as x?html>
    <#if feedbacks?has_content>
        <#list feedbacks as feedback>
        <li>
            <div>
                <#if (feedback.user.profileImageUrl)?has_content>
                    <#assign pImg = (feedback.user.profileImageUrl)>
                <#else>
                    <#assign pImg = "/images/img-person.jpg">
                </#if>
                <p class="img profile_thum fl" style="background-image:url('${pImg}')"></p>
                <div class="comment_tx">
                    <p>
                        ${(feedback.user.name) !}
                        <#if feedback.user.userType == "investor">
                            <#if feedback.user.invSortCd == "01">
                                <i class="ic_investor1 sm">일반 투자자</i>
                                <#assign invSortType = '일반 투자자'>
                            <#elseif feedback.user.invSortCd == "02">
                                <i class="ic_investor2 sm">소득전문 투자자</i>
                                <#assign invSortType = '소득전문 투자자'>
                            <#else>
                                <i class="ic_investor3 sm">전문 투자자</i>
                            </#if>
                        </#if>
                        <span class="date">${(feedback.regDate?string("yyyy.MM.dd")) !}</span>
                    </p>
                    <div class="msg">
                        <#if (feedback.adminDeleteDate)?exists>
                            관리자에 의해 삭제된 글입니다.
                        <#else>
                            <#noescape>
                            ${(feedback.content)?replace('\n', '<br>')!}
                            </#noescape>
                        </#if>
                    </div>
                    <div class="fr">
                        <#if user?exists>
                            <#if project.user.userId == user.userId>
                                <#assign userType = 1>
                            <#else>
                                <#assign userType = 2>
                            </#if>
                            <#if !(feedback.adminDeleteDate)?exists && (feedback.user.userId == user.userId || project.user.userId == user.userId)>
                                <a class="btn_type02 delete" data-form="feedback" user-type ="${userType}" idx="${feedback.feedbackId}">삭제</a>
                            </#if>
                            <#if !(feedback.adminDeleteDate)?exists && (user.userId == project.user.userId) >
                                <a class="btn_type02 reply" data-form="feedback" feedbackId="${feedback.feedbackId}" idx="${feedback.feedbackId}">답글</a>
                            </#if>
                        </#if>
                    </div>
                </div>
                <ul class="reply">
                    <#if feedback.replies?has_content && !(feedback.adminDeleteDate)?exists>
                        <#list feedback.replies as reply>
                            <li>
                                <div class="mb15">
                                    <#if (reply.user.profileImageUrl)?has_content>
                                        <#assign r_pImg = (reply.user.profileImageUrl)>
                                    <#else>
                                        <#assign r_pImg = "/images/img-person.jpg">
                                    </#if>
                                    <p class="img profile_thum fl" style="background-image:url('${r_pImg}')"></p>
                                    <div class="comment_tx">
                                        <p>관리자 <span class="date">${(reply.regDate?string("yyyy.MM.dd")) !}</span></p>
                                        <div class="msg">
                                            <#noescape>
                                                 ${(reply.content)?replace('\n', '<br>')!}
                                            </#noescape>
                                        </div>
                                        <div class="fr">
                                            <#if user?exists && (project.user.userId == user.userId)>
                                                <a class="btn_type02 delete comment" data-form="feedback" idx="${reply.commentId}">삭제</a>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </#list>
                    </#if>
                </ul>
            </div>
        </li>
        </#list>
    </#if>
</#escape>