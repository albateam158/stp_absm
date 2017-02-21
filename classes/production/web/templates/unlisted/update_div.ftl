<#escape x as x?html>
    <#if updates?has_content>
        <#list updates as update>
            <div class="post_box update unlisted">
                <div class="update_list_box">
                    <div class="top">
                        <div class="firm">
                            <#if (update.user.profileImageUrl)?has_content>
                                <#assign u_pImg = (update.user.profileImageUrl)>
                            <#else>
                                <#assign u_pImg = "/images/img-person.jpg">
                            </#if>
                            <p class="img firm_logo fl" style="background-image:url('${u_pImg !}');"></p>
                        </div>
                        <strong>
                            ${(update.title) !}

                        </strong>
                        <#if update.user.invSortCd?has_content>
                            <#function fnInvSortName invSortCd>
                                <#switch invSortCd>
                                    <#case "02">
                                        <#return "소득요건">
                                        <#break>
                                    <#case "03">
                                        <#return "전문">
                                        <#break>
                                    <#case "04">
                                        <#return "연고자">
                                        <#break>
                                    <#default> <#--01-->
                                        <#return "일반">
                                </#switch>
                            </#function>
                        </#if>
                        <span class="investorType">${(fnInvSortName(update.user.invSortCd)) !}</span>
                        <span class="date">${(update.user.name) !} &nbsp; | &nbsp; ${(update.regDate?string("yyyy.MM.dd")) !}</span>
                        <#if user?exists && (user.userId == update.user.userId)>
                            <#if !(update.adminDeleteDate)?exists>
                            <div class="hidden_menu">
                                <p></p>
                                <ul class="none">
                                    <li><a href="/unlisted/${unlistedId}/update_form?updateId=${update.updateId}">수정</a></li>
                                    <li><a class="delete" update_id="${update.updateId}">삭제</a></li>
                                </ul>
                            </div>
                            </#if>
                        </#if>
                    </div>
                    <div class="text editor_view">
                        <#if (update.adminDeleteDate)?exists>
                            관리자에 의해 삭제된 글입니다.
                        <#else>
                            <#noescape>
                            ${(update.content)?replace('\n', '<br>')!}
                            </#noescape>
                        </#if>
                    </div>
                    <#if !(update.adminDeleteDate)?exists && user?? && (user.userType == "investor")>
                        <div class="comment_input">
                            <div class="input_wrap">
                                <textarea placeholder="댓글을 남겨주세요."></textarea>
                                <input class="btn_type02 t-c btn_submit" updateId="${update.updateId}" type="submit" value="게시">
                            </div>
                        </div>
                    </#if>
                </div>
                <div class="comments">
                    <div class="comment_list">
                        <#assign comment_total=update.comments?size>
                        <h4><strong>총 <span class="fc-red">${update.commentCount !}</span>건</strong>의 댓글이 있습니다</h4>
                        <#if (comment_total > 5) >
                            <p class="more_btn mt20 mb10"><a class="plus more" updateId="${update.updateId}" page="0" totalPage="${comment_total}"><i></i></a></p>
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
                                                    <#if user?exists && (user.userType == "investor")>
                                                        <div class="mt10">
                                                            <#if !(comment.adminDeleteDate)?exists && (comment.user.userId == user.userId)>
                                                                <a class="btn_type02 delete" updateId="${(update.updateId) !}" idx="${comment.commentId}">삭제</a>
                                                            </#if>
                                                            <#if !(comment.adminDeleteDate)?exists>
                                                                <a class="btn_type02 reply" updateId="${(update.updateId) !}" idx="${comment.commentId}">답글</a>
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
                                                                                    <a class="btn_type02 delete comment" updateId="${(update.updateId) !}" idx="${reply.commentId}">삭제</a>
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
                                    </#if>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </div>
            </div>
        </#list>
    </#if>
</#escape>