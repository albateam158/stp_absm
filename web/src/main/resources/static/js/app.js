/**
 * Created by thomas on 2017-03-15.
 */


/* 개인특성 정보 업로드 처리 */
function savePrivate() {
    console.log("save button click");

    var form = $('#PrivateForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/baseline_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;

            if (retCode == "S_PAGE1001") {
                // 조회 api 호출
                getPrivateInfo(caId);
            }
            else {
                alert(retMsg);
            }
        },
        error: function(request, status, error) {
            alert("개인정보 등록 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });
}

// 개인특성 등록 후 조회
function getPrivateInfo(caId) {

    $.ajax({
        type : "GET",
        url : "/input/baseline_div?caId="+caId,

        success: function(data) {

            var gridData = data.boards;

            console.log("grid 생성" + gridData.rows);

            $("#jsGrid").jsGrid({
                width: "100%",
                height: "400px",

                //inserting: true,
                // editing: true,
                sorting: true,
                paging: true,

                data: gridData.rows,

                fields: [
                    { name: "케이스명", type: "text", width: 100 , align: "center"},
                    { name: "참가번호", type: "number", width: 100 , align: "center"},
                    { name: "이름", type: "text",  width: 100 , align: "center"},
                    { name: "나이", type: "text",  width: 100 , align: "center"},
                    { name: "성별", type: "text",  width: 100 , align: "center"}
                ]
            });

        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

/* 측정 정보 업로드 처리 */
function saveBiosignal() {
    console.log("save button click");

    var form = $('#BioForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/biosignal_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;
            var prId    = data.prId;
            if (retCode == "S_PAGE2001") {
                // 조회 api 호출
                getBioInfo(caId, prId);
            }
            else {
                alert(retMsg);
            }
        },
        error: function(request, status, error) {
            alert("개인정보 등록 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });
}

// 측정 정보 등록 후 조회
function getBioInfo(caId, prId) {

    $.ajax({
        type : "GET",
        url : "/input/biosignal_div?caId="+caId+"&prId="+prId,

        success: function(data) {

            var gridData = data.boards;

            console.log("grid 생성" + gridData.rows);

            $("#jsGrid").jsGrid({
                width: "100%",
                height: "400px",

                //inserting: true,
                // editing: true,
                sorting: true,
                paging: true,

                data: gridData.rows,

                fields: [
                    { name: "케이스명", type: "text", width: 100 , align: "center"},
                    { name: "참가번호", type: "text", width: 100 , align: "center"},
                    { name: "ECG/GSR구분", type: "text",  width: 100 , align: "center"},
                    { name: "측정시간", type: "text",  width: 100 , align: "center"},
                    { name: "측정값", type: "text",  width: 100 , align: "center"}
                ]
            });

        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

/* 이벤트 정보 업로드 처리 */
function saveEvent() {
    console.log("save button click");

    var form = $('#EventForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/event_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;

            if (retCode == "S_PAGE3001") {
                // 조회 api 호출
                getEventInfo(caId);
            }
            else {
                alert(retMsg);
            }
        },
        error: function(request, status, error) {
            alert("개인정보 등록 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });
}

// 이벤트 등록 후 조회
function getEventInfo(caId) {

    $.ajax({
        type : "GET",
        url : "/input/event_div?caId="+caId,
        success: function(data) {

            var gridData = data.boards;
            console.log("data " + data);
            console.log("grid 생성" + gridData);
            console.log("grid rows 생성" + gridData.rows);

            $("#jsGrid").jsGrid({
                width: "100%",
                height: "400px",

                //inserting: true,
                // editing: true,
                sorting: true,
                paging: true,

                data: gridData.rows,

                fields: [
                    { name: "이름", type: "text", width: 100 , align: "center"},
                    { name: "이벤트1", type: "number", width: 100 , align: "center"},
                    { name: "이벤트2", type: "number",  width: 100 , align: "center"},
                    { name: "이벤트3", type: "number",  width: 100 , align: "center"},
                    { name: "이벤트4", type: "number",  width: 100 , align: "center"},
                    { name: "이벤트5", type: "number", width: 100 , align: "center"},
                    { name: "이벤트6", type: "number", width: 100 , align: "center"},
                    { name: "이벤트7", type: "number", width: 100 , align: "center"},
                    { name: "이벤트8", type: "number", width: 100 , align: "center"},
                    { name: "이벤트9", type: "number", width: 100 , align: "center"},
                    { name: "이벤트10", type: "number", width: 100 , align: "center"},
                ]
            });

        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

/* 동영상 정보 업로드 처리 */
function saveVideo() {
    console.log("save button click");

    var form = $('#VideoForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    $.ajax({
        type : "POST",
        url : "/input/video_form",
        data : formData,
        processData: false,
        contentType: false,
        cache: false,
        success: function(data) {

            var retCode = data.retCode;
            var retMsg  = data.retMsg;
            var caId    = data.caId;
            var prId    = data.prId;
            
            if (retCode == "S_PAGE4001") {
                // 조회 api 호출
                getVideoInfo(caId, prId);
            }
            else {
                alert(retMsg);
            }
        },
        error: function(request, status, error) {
            alert("동영상 등록 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });
}

// 이벤트 등록 후 조회
function getVideoInfo(caId, prId) {

    $.ajax({
        type : "GET",
        url : "/input/video_div?caId="+caId+"&prId="+prId+"&fileCd=VIDEO",
        success: function(data) {

            if (data.url != "") {
                var video = $('#video1')[0];
                video.src = data.url;
                video.load();
                video.play();
            }

        },
        error: function(request, status, error) {
            alert("동영상 파일 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

// 케이스 목록 조회
function getCaseList(formName) {


    $.ajax({
        type : "GET",
        url : "/input/caseList",
        success: function(data) {

            var cases = data.cases;
            var pris = data.pris;

            if (formName == "EventForm") {
                $.each(cases, function(index, item) {
                    $('#EventForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
            else if (formName == "BioForm") {
                $.each(cases, function(index, item) {
                    $('#BioForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });

                var pris = data.pris;
                $.each(pris, function(index, item) {
                    // TODO 케이스 조회시 리턴 오브젝트에 개인정보 이름 추가
                    $('#BioForm select#name').append("<option value='" + item.prId + "'>" + item.name + "</option> ");
                });
            }
            else if (formName == "VideoForm") {
                $.each(cases, function(index, item) {
                    $('#VideoForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });

                var pris = data.pris;
                $.each(pris, function(index, item) {
                    // TODO 케이스 조회시 리턴 오브젝트에 개인정보 이름 추가
                    $('#VideoForm select#name').append("<option value='" + item.prId + "'>" + item.name + "</option> ");
                });
            }


        },
        error: function(request, status, error) {
            alert("bioCaseList 케이스 목록 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}
