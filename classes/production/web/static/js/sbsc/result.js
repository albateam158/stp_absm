/**
 * Created by sj on 16. 3. 7..
 */
$( document ).ready(function() {

    $('.btn_retry').click(function () {
        document.location.href = '/sbsc/'+projectId+'/form';
    });

    $('.btn_submit').click(function () {
        document.location.href = '/main';
    });

});

