/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {
    $('.all_wrap').addClass('sub');

    var paging_project = new morePaging('.thum_wrap.unlisted', '.unlistedList', '/unlisted/list_div?keyword='+encodeURIComponent($('input[name=s_firm]').val()), 'orderno', 'asc', 0, 20, true, function(){});
    paging_project.initPaging();

    $(document).on('click', '.unlistedList tr',function(){
        location.href = '/unlisted/' + $(this).attr('unlistedId');
    });

    $('.btn_type04').click(function (e) {

        var section_ids = "";
        var section_count = 0;

        $(".data.checkbox").each(function() {
            if($(this).is(':checked'))
            {
                if(section_count == 0) {
                    section_ids = $(this).val();
                } else {
                    section_ids += ',' + $(this).val();
                }
                section_count++;
            }
        });


        paging_project.params = $(this).serialize();
        paging_project.url = '/unlisted/list_div?keyword='+ encodeURIComponent($('input[name=s_firm]').val()) + '&sectionIds=' + section_ids;
        paging_project.offset = 0;
        paging_project.limit = 4;
        paging_project.isAppend = false;
        paging_project.loadDiv();

        var page = parseInt($('a.plus.more').attr('page'));
        var totalPage = parseInt($('a.plus.more').attr('totalPage'));

        if(page == totalPage) {
            $('a.plus.more').parent().hide();
        }
        else {
            $('a.plus.more').parent().show();
        }
    });

    $('input').keyup(function (e) {
        if (e.which == 13) {
            $('.btn_type04').click();
        }
    });

    $('input[type=checkbox]').click(function () {
        if($(this).is(':checked')) {
            $('#search_section').html($(this).next().text() + '<i class="icon up ic_arrow_w"></i>');
        }
        else {
            $('#search_section').html('분류<i class="icon up ic_arrow_w"></i>');
        }

        $('.btn_type04').click();
    });

    $('.search_keys h2').click(function(){
        if($(this).find('i').hasClass('up')) {
            $(this).find('i').removeClass('up').removeClass('ic_arrow_w').addClass('ic_arrow');
            $(this).removeClass('active');
            $(this).next().addClass('none');
        } else {
            $('.search_keys h2').removeClass('active');
            $('.search_keys h2 i').removeClass('up').removeClass('ic_arrow_w').addClass('ic_arrow');
            $('.search_keys .sub').addClass('none');

            $(this).find('i').addClass('up').removeClass('ic_arrow').addClass('ic_arrow_w');
            $(this).addClass('active');
            $(this).next().removeClass('none');
        }
    });



    $('.search_box .search_keys .sub').mouseleave(function(){
        $('.search_keys h2').find('i').removeClass('up').removeClass('ic_arrow_w').addClass('ic_arrow');
        $('.search_keys h2').removeClass('active');
        $(this).addClass('none');
    });
});