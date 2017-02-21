/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {
    $('.all_wrap').addClass('sub');

    // 상단 메뉴 on
    $('.icon.mn4, .menu li:nth-child(4) a').addClass('on');

    var paging = new Paging('#listDiv', '#communityList', '/community/list_div', 'reg_date', 'desc', '', function(){});
    paging.initPaging();

    $('.search_keys h2').click(function(){
        if($(this).find('i').hasClass('up')) {
            $(this).find('i').removeClass('up').removeClass('ic_arrow_w').addClass('ic_arrow');
            $(this).removeClass('active');
            $(this).next().addClass('none');
        } else {
            $(this).find('i').addClass('up').removeClass('ic_arrow').addClass('ic_arrow_w');
            $(this).addClass('active');
            $(this).next().removeClass('none');
        }
    });

    //$('.search_keys .sub').mouseleave(function(){
    //    $('.search_keys h2').removeClass('active');
    //    $('.search_keys h2 i').removeClass('up').removeClass('ic_arrow_w').addClass('ic_arrow');
    //    $('.search_keys .sub').addClass('none');
    //});

    $(document).on('click', '#chkAll', function(){
        if($(this).is(':checked')) {
            $('.search_keys .data.checkbox').prop('checked', true);
        }
        else {
            $('.search_keys .data.checkbox').prop('checked', false);
        }

        searchResult();
    });

    $('.search_keys .data.checkbox').click(function(){
        searchResult();
    });


    $('.category-collect').click(function () {
        paging = new Paging('#listDiv', '#communityList', '/community/list_div?categories='+$(this).attr('categoryId'), 'reg_date', 'desc', '', function(){});
        paging.initPaging();
    });


});

function searchResult() {
    var category_ids = "";
    var category_count = 0;

    $(".search_keys .data.checkbox").each(function() {
        if($(this).is(':checked'))
        {
            if(category_count == 0) {
                category_ids = $(this).val();
            } else {
                category_ids += ',' + $(this).val();
            }
            category_count++;
        }
    });

    paging = new Paging('#listDiv', '#communityList', '/community/list_div?categories='+category_ids, 'reg_date', 'desc', '', function(){});
    paging.initPaging();
}