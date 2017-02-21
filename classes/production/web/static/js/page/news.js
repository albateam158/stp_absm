/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {

    $('.all_wrap').addClass('sub');

    $('.content_box .step_box h2').click(function(){
        $(this).toggleClass('active');
        $(this).next().toggle();
    });

    var paging = new Paging('#newsListDiv', '#newsList', '/news/list_div', 'reg_date', 'desc', '', function(){});
    paging.initPaging();


});