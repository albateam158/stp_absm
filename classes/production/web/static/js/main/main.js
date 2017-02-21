/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {

    var paging_project = new morePaging('.thum_wrap.project', '#main_project_list', '/main/project_div', 'orderno', 'asc', 0, 4, true, function(){});

    paging_project.initPaging();

    var paging_news = new morePaging('.thum_wrap.post', '#main_news_list', '/main/news_div', 'pubDate', 'desc', 0, 8, true, function(){
    });

    paging_news.initPaging();

    $('.all_wrap').addClass('main');

    $('a.plus.more').click(function(){
        var page = parseInt($(this).attr('page'));
        var totalPage = parseInt($(this).attr('totalPage'));

        if(page == totalPage) {
            $(this).parent().remove();
        }
    });

    var unlistedScroll = $('#unlistedScrollTxt').newsTicker({
        row_height: 24,
        max_rows: 1,
        duration: 4000
    });
});