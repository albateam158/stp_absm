<table id="project_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th style="width:12%">이미지</th>
        <th style="width:8%">카테고리</th>
        <th class="sort" sort="name">종목명</th>
        <th style="width:8%">발행인</th>
        <th style="width:8%">청약 시작일</th>
        <th style="width:8%">청약 종료일</th>
        <th style="width:5%">상태</th>
        <th style="width:5%">모집 상태</th>
        <th class="sort" sort="reg_date" style="width:10%">등록일</th>
        <th style="width:5%"></th>
        <th style="width:5%"></th>
        <th style="width:5%"></th>
        <#--<th style="width:8%"></th>-->
    </tr>
    </thead>
    <tbody>
        <#if projects?has_content>
            <#list projects as project>
                <tr project_id="${(project.projectId) !}">
                    <td class="v-align-middle">
                        <div class="checkbox">
                            <input type="checkbox" id="checkbox${project_index+1}" class="unit">
                            <label for="checkbox${project_index+1}"></label>
                        </div>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                            <img src="${(project.mainImageUrl) !}" style="max-width: 120px;" />
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(project.category.name) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/project/form?projectId=${(project.projectId) !}" class="urlLink">${(project.sbscIssNm) !}</a></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(project.name) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(project.sbscStDt?date("yyyyMMdd")?string("yyyy-MM-dd")) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(project.sbscNdDt?date("yyyyMMdd")?string("yyyy-MM-dd")) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><#if project.status == "visible">보임<#else>안보임</#if></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <#function fnSuccessStateName successState>
                            <#switch successState>
                                <#case "ing">
                                    <#return "진행중">
                                    <#break>
                                <#case "finish">
                                    <#return "마감">
                                    <#break>
                                <#case "success">
                                    <#return "성공">
                                    <#break>
                                <#case "fail">
                                    <#return "실패">
                                    <#break>
                                <#default> <!--ready-->
                                    <#return "대기">
                            </#switch>
                        </#function>
                        <p>${fnSuccessStateName(project.successState)}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${project.regDate?datetime}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/project/${(project.projectId) !}/ir"><button class="btn btn-default btn-xs m-t-10">IR</button></a></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/project/${(project.projectId) !}/board"><button class="btn btn-default btn-xs m-t-10">Board</button></a></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/project/${(project.projectId) !}/update"><button class="btn btn-default btn-xs m-t-10">Update</button></a></p>
                    </td>
                    <#--<td class="v-align-middle text-center">-->
                        <#--<p><a href="/project/${(project.projectId) !}/feedback"><button class="btn btn-default btn-xs m-t-10">Feedback</button></a></p>-->
                    <#--</td>-->
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="13" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
            </tr>
        </#if>
    </tbody>
</table>
${paging !}