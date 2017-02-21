<#escape x as x?html>
    <#if updates?has_content>
        <#list updates as update>
            <div class="post_box">
                <div class="top">
                    <span class="num">#${num}</span>
                    <strong>${(update.title) !}</strong>
                    <span class="date">${(update.regDate?string("yyyy.MM.dd")) !}</span>
                    <span>공개</span>
                    <#if user?exists && (user.userId == project.user.userId)>
                        <div class="hidden_menu">
                            <p></p>
                            <ul class="none">
                                <li><a href="/project/${projectId}/update_form?updateId=${update.updateId}">수정</a></li>
                                <li><a class="delete" update_id="${update.updateId}">삭제</a></li>
                            </ul>
                        </div>
                    </#if>
                </div>
                <div class="text editor_view">
                    <#noescape>
                            ${(update.content)?replace('\n', '<br>')!}
                    </#noescape>
                </div>
                <div class="comments">
                    <#if user??>
                        <div class="comment_input">
                            <div class="input_wrap">
                                <textarea cols="75" rows="4" placeholder="댓글을 남겨주세요."></textarea>
                                <p class="fr t-c">
                                    <input class="btn_type02 btn_submit" data-form="update" updateId="${update.updateId}" type="submit" value="확인">
                                </p>
                            </div>
                        </div>
                    </#if>

                    <div class="comment_list">
                        <#assign comment_total=update.comments?size>
                        <h4 class="fc-lightgrey">총 <span class="fc-grey">${comment_total}</span>건의 댓글이 있습니다</h4>
                        <#if (comment_total > 5) >
                            <button class="comment_more" updateId="${update.updateId}" page="0">이전 댓글 보기...</button>
                        </#if>
                        <ul>
                            <#if update.comments?has_content>
                                <#assign view_idx = comment_total - 5 >
                                <#list update.comments as comment>
                                    <#if (comment_index >= view_idx)>
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
                                    </#if>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </div>
            </div>
            <#assign num = num-1>
        </#list>
    </#if>
</#escape>