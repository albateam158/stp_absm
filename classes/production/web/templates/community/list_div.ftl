<table cellpadding="0" cellspacing="0" id="communityList" class="communityList web">
    <thead>
    <tr>
        <th width="2%">No.</th>
        <th width="46%">제목</th>
        <th width="16%">카테고리</th>
        <th width="14%">작성자</th>
        <th width="14%">작성일</th>
        <th width="8%">조회수</th>
    </tr>
    </thead>
    <tbody>
        <#if communities?has_content>
            <#list communities as community>
                <tr>
                    <td>${community_index + 1}</td>
                    <td class="t-l"><a href="/community/${(community.communityId) !}">${(community.title) !}</a></td>
                    <td>${(community.categoryName) !}</td>
                    <td class="t-l">
                        <#if community.user.invSortCd == "01">
                            <span class="invSortType type1">일반</span>
                        <#elseif community.user.invSortCd == "02">
                            <span class="invSortType type2">소득</span>
                        <#else>
                            <span class="invSortType type3">전문</span>
                        </#if>
                        ${(community.user.name) !}
                    </td>
                    <td>${(community.regDate?string("yyyy.MM.dd")) !}</td>
                    <td>${(community.viewCount)?default(0) !}</td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="6">
                    <p class="no_data">등록된 커뮤티니 글이 없습니다.</p>
                </td>
            </tr>
        </#if>
    </tbody>
</table>


<div id="communityList" class="communityList mobile">
    <#if communities?has_content>
        <#list communities as community>
            <div>
                <p class="category">[${(community.categoryName) !}]</p>
                <h3><a href="/community/${(community.communityId) !}">${(community.title) !}</a></h3>
                <p class="opt"><span class="invSortType type3">전문</span> ${(community.user.name) !} &nbsp;|&nbsp; ${(community.viewCount)?default(0) !} &nbsp;|&nbsp; ${(community.regDate?string("yyyy.MM.dd")) !}</p>
            </div>
        </#list>
    <#else>
        <div>
            <p class="no_data">등록된 커뮤티니 글이 없습니다.</p>
        </div>
    </#if>
</div>
<#if (totalPage > 1)>
    ${paging !}
</#if>
<#if user?? && user.userType = "investor">
<p class="btn_community t-r"><a href="/community/form" class="btn_type03">글쓰기</a></p>
</#if>