<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="thum_wrap unlisted community">
                <div class="title_div">
                    <h3>커뮤니티</h3>
                    <div class="search_box">
                        <div>
                            <div class="search_keys fr">
                                <ul>
                                    <li>
                                        <h2 id="search_section">카테고리<i class="icon ic_arrow"></i></h2>
                                        <ul class="sub none">
                                            <li>
                                                <input type="checkbox" id="chkAll" class="chkAll"/>
                                                <label for="chkAll">전체보기</label>
                                            </li>
                                            <#if categories?has_content>
                                                <#list categories as category>
                                                    <li>
                                                        <input type="checkbox" name="chk_1[]" id="chk${category_index + 1}" value="${(category.categoryId) !}" class="data checkbox" />
                                                        <label for="chk${category_index + 1}">${(category.name) !}</label>
                                                    </li>
                                                </#list>
                                            </#if>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form_box noline_bottom community">
                <h2>커뮤니티</h2>
            </div>

            <div class="form_box mypage community">
                <div class="top">
                    <div class="mypage community_div" id="listDiv"></div>
                </div>
            </div>

            <div class="funding_box mt50 pt10">
                <div class="funding_list">
                    <h3>카테고리 모아보기</h3>
                    <ul>
                        <#if categories?has_content>
                            <#list categories as category>
                                <#if category.isCollect == "Y">
                                    <li class="category-collect" categoryId="${(category.categoryId)}"><a href="#"><i style="background-image: url('${(category.imageUrl) !}')"></i><span>${(category.name) !}</span></a></li>
                                </#if>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    </@layout.put>


    <@layout.put block="script">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <script type="text/javascript" src="/js/community/list.js"></script>
    </@layout.put>

</@layout.extends>