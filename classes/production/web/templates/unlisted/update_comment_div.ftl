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
                    <#if user?exists && (user.userType == "investor")>
                        <div class="mt10">
                            <#if !(comment.adminDeleteDate)?exists && (comment.user.userId == user.userId)>
                                <a class="btn_type02 delete" updateId="${(updateId) !}" idx="${comment.commentId}">삭제</a>
                            </#if>
                            <#if !(comment.adminDeleteDate)?exists>
                                <a class="btn_type02 reply" updateId="${(updateId) !}" idx="${comment.commentId}">답글</a>
                            </#if>
                        </div>
                    </#if>
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
                                        <p>${(reply.user.name) !} <span class="date">${(reply.regDate?string("yyyy.MM.dd")) !}</span></p>
                                        <div class="msg">
                                            <#if (reply.adminDeleteDate)?exists>
                                                관리자에 의해 삭제된 글입니다.
                                            <#else>
                                                <#noescape>
                                                ${(reply.content)?replace('\n', '<br>')!}
                                                </#noescape>
                                            </#if>
                                        </div>
                                        <#if user?exists && (user.userType == "investor")>
                                            <#if !(reply.adminDeleteDate)?exists && (reply.user.userId == user.userId)>
                                                <div class="mt10">
                                                    <a class="btn_type02 delete comment" updateId="${(updateId) !}" idx="${reply.commentId}">삭제</a>
                                                </div>
                                            </#if>
                                        </#if>
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