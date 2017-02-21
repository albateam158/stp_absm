<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="form_box">
                <form>
                    <h2>통계보기</h2>
                    <div class="top">
                        <div class="info_box">
                            <#if stats??>
                                <p><img src="${(stats.url) !}" /></p>
                            <#else>
                                <p class="no_data">등록된 데이터가 없습니다.</p>
                            </#if>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">

    <script type="text/javascript" src="/js/stats/stats.js"></script>

    </@layout.put>

</@layout.extends>