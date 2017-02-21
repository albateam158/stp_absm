<#escape x as x?html>
    <#if comments?has_content>
        <#list comments?reverse as comment>
            <li>
            <div>
                <#if (comment.user.profileImageUrl)?has_content>
                    <#assign pImg = (comment.user.profileImageUrl)>
                <#else>
                    <#assign pImg = "/images/img-person.jpg">
                </#if>
                <p class="img profile_thum fl" style="background-image:url('${pImg}')"></p>
                <div class="comment_tx">
                    <p>${(comment.user.name) !} <span class="date">${(comment.regDate?string("yyyy.MM.dd")) !}</span></p>
                    <div class="msg">
                        <#if (comment.adminDeleteDate)?exists>
                            관리자에 의해 삭제된 글입니다.
                        <#else>
                            <#noescape>
                            ${(comment.content)?replace('\n', '<br>')!}
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
                            <#if !(comment.adminDeleteDate)?exists && (comment.user.userId == user.userId || project.user.userId == user.userId)>
                                <a class="btn_type02 delete" data-form="update" user-type ="${userType}" idx="${comment.commentId}">삭제</a>
                            </#if>
                            <#if !(comment.adminDeleteDate)?exists && (user.userId == project.user.userId)>
                                <a class="btn_type02 reply" data-form="update" updateId="${update.updateId}" idx="${comment.commentId}">답글</a>
                            </#if>
                        </#if>
                    </div>
                </div>
                <ul class="reply">
                    <#if comment.replies?has_content && !(comment.adminDeleteDate)?exists>
                        <#list comment.replies as reply>
                            <li>
                                <div>
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
                                                <a class="btn_type02 delete comment" data-form="update" idx="${reply.commentId}">삭제</a>
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