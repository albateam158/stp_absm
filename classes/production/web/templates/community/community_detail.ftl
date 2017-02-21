<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">
    <#escape x as x?html>
        <div class="contents_wrap">
            <div class="content_box">
                <div class="form_box detail community">
                    <h2>
                        ${(community.title) !}
                        <#if user?exists && (user.userId == community.user.userId)>
                            <div class="hidden_menu">
                                <p></p>
                                <ul class="none">
                                    <li><a href="/community/form?communityId=${community.communityId}">수정</a></li>
                                    <li><a class="delete" community_id="${community.communityId}">삭제</a></li>
                                </ul>
                            </div>
                        </#if>
                    </h2>
                    <div class="top">
                        <div class="mypage">
                            <div class="board_view top">
                                <div class="overflow-h">
                                    <p class="fl">${(community.categoryName) !}</p>
                                    <p class="fr">
                                        <#if community.user.invSortCd == "01">
                                            <span class="invSortType type1">일반</span>
                                        <#elseif community.user.invSortCd == "02">
                                            <span class="invSortType type2">소득</span>
                                        <#else>
                                            <span class="invSortType type3">전문</span>
                                        </#if>
                                        ${(community.user.name) !} &nbsp; ${(community.regDate?string("yyyy.MM.dd")) !}
                                    </p>
                                </div>
                            </div>
                            <div class="board_view editor_view">
                                <#noescape>
                                    ${(community.content)?replace('\n', '<br>')!}
                                </#noescape>
                            </div>
                        </div>
                    </div>
                    <div class="comments">
                        <#if user?? && user.userType = "investor">
                            <div class="comment_input">
                                <div class="input_wrap">
                                    <textarea cols="75" rows="4" placeholder="댓글을 남겨주세요."></textarea>
                                    <p class="fr t-c">
                                        <input class="btn_type02 btn_submit" type="submit" value="확인">
                                    </p>
                                </div>
                            </div>
                        </#if>

                        <div class="comment_list t-l">
                            <#assign comment_total=community.comments?size>
                            <h4 class="pl15">총 <span>${comment_total}</span>건의 댓글이 있습니다.</h4>
                            <#if (comment_total > 5) >
                                <button class="comment_more" page="0">이전 댓글 보기...</button>
                            </#if>
                            <ul>
                                <#if community.comments?has_content>
                                    <#assign view_idx = comment_total - 5 >
                                    <#list community.comments as comment>
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
                                                                <#if !(comment.adminDeleteDate)?exists && (comment.user.userId == user.userId)>
                                                                    <a class="btn_type02 delete" idx="${comment.commentId}">삭제</a>
                                                                </#if>
                                                                <#if !(comment.adminDeleteDate)?exists && user.userType = "investor">
                                                                    <a class="btn_type02 reply" communityId="${community.communityId}" idx="${comment.commentId}">답글</a>
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
                                                                            <div class="fr">
                                                                                <#if user?exists && (reply.user.userId == user.userId)>
                                                                                    <a class="btn_type02 delete comment" idx="${reply.commentId}">삭제</a>
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
                    <div class="bottom">
                        <a href="/community" class="btn_type03">목록</a>
                    </div>
                </div>
            </div>
        </div>
    </#escape>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var communityId = '${community.communityId}';
    </script>
    <script type="text/javascript" src="/js/community/detail.js"></script>

    </@layout.put>

</@layout.extends>