<input type="hidden" class="currentPage" name="currentPage" value="${(page + 1) !}" />
<input type="hidden" class="totalPage" name="totalPage" value="${(totalPage) !}" />
<ul class="card_list">
<#if mainNewses?has_content>
    <#list mainNewses as news>
        <li>
            <a href="${(news.link) !}" target="_blank">
                <div class="title">
                    <h4>${(news.title) !}</h4>
                    <p class="date">${news.pubDate?date?string('yyyy. MM. dd')}</p>
                </div>
                <div class="thum">
                    <p class="image" style="background-image:url(<#if news.imageUrl?exists >${news.imageUrl}<#else>'images/sample.jpg'</#if>);"></p>
                </div>
                <p class="desc">
                    ${(news.description) !}
                </p>
            </a>
        </li>
    </#list>
</#if>
<script type="text/javascript">
$( document ).ready(function() {
    $('.thum_wrap.post a.plus.more').attr('totalPage', ${totalPage?default(1) !});

    var page = parseInt($('.thum_wrap.post a.plus.more').attr('page'));
    var totalPage = parseInt($('.thum_wrap.post a.plus.more').attr('totalPage'));

    if(page == totalPage) {
        $('.thum_wrap.post a.plus.more').parent().remove();
    }
});
</script>

