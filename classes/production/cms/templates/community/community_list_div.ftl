<table id="community_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th style="width:10%">#</th>
        <th style="width:20%">카테고리</th>
        <th class="sort" sort="title" style="width:29%">제목</th>
        <th style="width:10%">댓글 수</th>
        <th style="width:10%">조회 수</th>
        <th class="sort" sort="reg_date" style="width:15%">등록일</th>
    </tr>
    </thead>
    <tbody>
        <#if communitys?has_content>
            <#list communitys as community>
                <tr community_id="${(community.communityId) !}">
                    <td class="v-align-middle">
                        <div class="checkbox">
                            <input type="checkbox" id="checkbox${community_index+1}" class="unit">
                            <label for="checkbox${community_index+1}"></label>
                        </div>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${community.communityId}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${community.category}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/community/${(community.communityId) !}">${community.title}</a></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${community.commentCount}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${community.viewCount}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${community.regDate?datetime}</p>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="7" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
            </tr>
        </#if>
    </tbody>
</table>
${paging !}