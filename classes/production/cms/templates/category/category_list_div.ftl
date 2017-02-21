<table id="category_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort sorting_desc" sort="name">카테고리명</th>
        <th class="sort sorting_desc" sort="type" style="width:20%">타입</th>
        <th class="sort sorting" sort="project_count" style="width:15%">모집공고 수</th>
        <th class="sort sorting" sort="reg_date" style="width:20%">등록일</th>
        <th style="width:10%"></th>
    </tr>
    </thead>
    <tbody>
    <#if categories?has_content>
        <#list categories as category>
        <tr category_id="${category.categoryId !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${category_index+1}" class="unit">
                    <label for="checkbox${category_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <a href="#">${category.name !}</a>
            </td>
            <td class="v-align-middle text-center">
                <a href="#"><#if category.type == "project">모집<#else>커뮤니티</#if></a>
            </td>
            <#--<td class="v-align-middle text-center">-->
                <#--<#if category.project?exists>-->
                    <#--<img src="${(category.project.mainImageUrl) !}" class="b-a b-grey" style="max-width: 100px;" />-->
                    <#--<p class="m-t-5">${category.project.name}</p class="m-t-5">-->
                <#--</#if>-->
            <#--</td>-->
            <td class="v-align-middle text-center">
            ${category.projectCount !}
            </td>
            <td class="v-align-middle text-center">
            ${category.regDate?datetime !}
            </td>
            <td class="v-align-middle text-center">
                <button class="btn btn-success btn-cons pull-left modify" style="min-width:100px;">
                    <i class="fa fa-wrench"></i> <span>Modify</span>
                </button>
            </td>
        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="5" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>