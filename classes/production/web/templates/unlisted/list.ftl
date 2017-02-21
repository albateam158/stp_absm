<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="thum_wrap unlisted">
                <div class="title_div">
                    <h3>비상장 주식 100선</h3>
                    <div class="search_box">
                        <div>
                            <div class="search_keys fl">
                                <ul>
                                    <li>
                                        <h2 id="search_section">분류<i class="icon ic_arrow"></i></h2>
                                        <ul class="sub none">
                                            <#if unlistedBusinessTypeCodes?has_content>
                                                <#list unlistedBusinessTypeCodes as unlistedBusinessTypeCode>
                                                    <li>
                                                        <input type="checkbox" name="chk_1[]" id="chk${unlistedBusinessTypeCode_index + 1}" value="${unlistedBusinessTypeCode.code}" class="data checkbox" />
                                                        <label for="chk${unlistedBusinessTypeCode_index + 1}">${unlistedBusinessTypeCode.codeName}</label>
                                                    </li>
                                                </#list>
                                            </#if>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="fr">
                                <dl>
                                    <dt>기업검색</dt>
                                    <dd><input type="text" name="s_firm" value="${(keyword)!}" required="true" /></dd>
                                    <dd><input type="button" class="btn_type04" value="검색" /></dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" class="currentPage" name="currentPage" value="" />
                <table cellpadding="0" cellspacing="0" class="list">
                    <thead class="web">
                        <tr>
                            <th style="width:12%;">분류</th>
                            <th style="width:25%;">종목명</th>
                            <th style="width:12%;">자본금(백만)</th>
                            <th style="width:12%;">자산총계(백만)</th>
                            <th style="width:12%;">부채총계(백만)</th>
                            <th style="width:12%;">매출액(백만)</th>
                            <th style="width:12%;">영업이익(백만)</th>
                        </tr>
                    </thead>
                    <tbody class="unlistedList"></tbody>
                </table>
                <p class="more_btn mt40"><a class="plus more" page="1" totalPage="1"><i></i></a></p>
            </div>
        </div>
    </div>

    </@layout.put>

    <@layout.put block="script">
    <script type="text/javascript" src="/js/unlisted/list.js"></script>
    </@layout.put>

</@layout.extends>