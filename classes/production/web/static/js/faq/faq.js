$(window).ready(function(){

    $('.all_wrap').addClass('sub');

    $('.content_box .step_box h2').click(function(){
        $(this).toggleClass('active');
        $(this).next().toggle();
    });

    var paging = new Paging('#faqListDiv', '#faqList', '/faq/list_div?faqType='+faqType, 'reg_date', 'asc', '', function(){});
    paging.initPaging();

    $(document).on('click', '.faq_box h3', function(){
        $(this).next().toggle();
    });
});