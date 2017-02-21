/**
 * Created by sj on 16. 1. 13..
 */
function XUpload() {

}

XUpload.prototype.upload = function(formData, callback) {
    $.ajax({
        crossDomain:true,
        type:'post',
        url: 'http://kams.kasset.co.kr/upload',
        //url: 'http://182.162.100.214/upload',
        data: formData,
        processData: false,
        contentType: false,
        error: function(data) {
            console.log(data);
            NoticeCommon.Dialog.alert('업로드가 실패했습니다.');
        },
        success: function(data) {
            var data = JSON.parse(data);
            if(data.url) {
                callback(data);
            }
            else {
                NoticeCommon.Dialog.alert('업로드가 실패했습니다.');
            }
        }
    });
}


XUpload.prototype.crossUpload = function(formData, callback) {
    var xhr = createCORSRequest('POST', 'http://kams.kasset.co.kr/upload');
    //var xhr = createCORSRequest('POST', '//182.162.100.214/upload');
    xhr.onreadystatechange = function (data) {
        if(xhr.readyState == 4) {
            if(xhr.status == 200) {
                temp = xhr.responseText;
                var data = JSON.parse(temp);

                if(data.url) {
                    callback(data);
                }
            }
            else {
                NoticeCommon.Dialog.alert("파일 업로드가 실패 했습니다.<br/>다시 한번 시도해주시기 바랍니다.");
            }
        }
    };
    if (!xhr) {
        throw new Error('CORS not supported');
    }
    else {
        var result = xhr.send(formData);
        console.log(result);
    }
}