$(window).ready(function(){

    $('.all_wrap').addClass('sub');

    $('.content_box .step_box h2').click(function(){
        $(this).toggleClass('active');
        $(this).next().toggle();
    });

    $('.faq_box h3').click(function(){
        $(this).next().toggle();
    });
});