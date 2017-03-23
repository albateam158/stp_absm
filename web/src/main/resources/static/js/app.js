/**
 * Created by thomas on 2017-03-15.
 */

var $window = $(window);
var isSearch = false;

/* 개인특성 정보 업로드 처리 */
function savePrivate() {
    console.log("save button click");

    var form = $('#PrivateForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    console.log("file path " + $('#file1')[0].files[0].name);

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
        url : "/input/baseline_div",
        data : {"caId" : caId},
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
        url : "/input/biosignal_div",
        data: {
            "caId": caId,
            "prId": prId
        },
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
        url : "/input/event_div",
        data: {
            "caId": caId
        },
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
        enctype: "multipart/form-data",
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
        url : "/input/video_div",
        data: {
            "caId": caId,
            "prId": prId,
            "fileCd": "VIDEO"
        },
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

// 자료 조회
function getAbsmInfo() {

    console.log("getAbsmInfo Start");

    var form = $('#SearchForm')[0];
    var formData = new FormData(form);
    console.log("formData " + formData);

    console.log("formData " + formData.get("caId"));
    console.log("formData " + formData.get("name"));
    console.log("formData " + formData.get("age"));
    console.log("formData " + formData.get("sex"));


    $.ajax({
        type : "GET",
        url : "/search/search_div",
        data: {
            "caId": formData.get("caId"),
            "name": formData.get("name"),
            "age": formData.get("age"),
            "sex": formData.get("sex")
        },

        success: function(data) {

            var gridData = data.boards;

            $("#jsGrid").jsGrid({
                width: "100%",
                height: "400px",

                //inserting: true,
                // editing: true,
                sorting: true,
                paging: true,

                data: gridData.rows,

                fields: [
                    { name: "caId", type: "text", width: 100 , visible: false},
                    { name: "참가번호", type: "text", width: 100 , align: "center"},
                    { name: "이름", type: "text", width: 100 , align: "center"},
                    { name: "나이", type: "text", width: 100 , align: "center"},
                    { name: "성별", type: "text",  width: 100 , align: "center"},
                    { name: "설문조사1", type: "number",  width: 100 , align: "center"},
                    { name: "설문조사2", type: "number",  width: 100 , align: "center"},
                    { name: "설문조사3", type: "number", width: 100 , align: "center"},
                    { name: "설문조사4", type: "number", width: 100 , align: "center"},
                    { name: "설문조사5", type: "number", width: 100 , align: "center"},
                    { name: "설문조사6", type: "number", width: 100 , align: "center"},
                    { name: "설문조사7", type: "number", width: 100 , align: "center"},
                    { name: "설문조사8", type: "number", width: 100 , align: "center"},
                ],
                rowDoubleClick: function(args) {
                    //console.log("args " + args);
                    var caId  = args.item.caId;
                    var pNo  = args.item.참가번호;

                    var url = "/result/result?caId="+caId+"&pNo="+pNo;
                    $(location).attr('href',url);
                },
            });

        },
        error: function(request, status, error) {
            alert("개인정보 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

/* 결과 화면의 데이터 조회 */
function getChartInfo() {

    // 결과 조회를 위한 param 세팅
    // TODO : 조회 화면에서 넘겨받은 데이터로 설정
    var caId    = 98;
    var pNo     = 1;
    var chartId = $('#filter option:selected').val();
    var vid = document.getElementById("MyVideo");

    $.ajax({
        type : "GET",
        url : "/result/chart",
        data: {
            "caId"   : caId,
            "pNo"    : pNo,
            "chartId": chartId
        },
        success: function(data) {

            var chartInfo = data.chartInfo;

            var filterChart = [];

            $.each(chartInfo, function(index, item) {
                if (chartId == 1)
                    filterChart.push([index, item.meanRri]);
                else if (chartId == 2)
                    filterChart.push([index, item.stdRri]);
                else if (chartId == 3)
                    filterChart.push([index, item.meanHrv]);
                else if (chartId == 4)
                    filterChart.push([index, item.stdHrv]);
                else if (chartId == 5)
                    filterChart.push([index, item.rmssdd]);
                else if (chartId == 6)
                    filterChart.push([index, item.pnn50]);
                else if (chartId == 7)
                    filterChart.push([index, item.lfhf]);
                else if (chartId == 8)
                    filterChart.push([index, item.scl]);
            });

            // 한번 조회가 완료되면 그 후에는 동영상으로 로드하지 않음
            if (isSearch == false) {
                isSearch = true;

                var videoInfo = data.videoInfo;

                /* video url load */
                vid.src = videoInfo.url;
                vid.load();
                vid.play();
            }

            var line_data1 = {
                data: filterChart,
                color: "#3c8dbc"
            };

            $.plot("#line-chart", [line_data1], {
                grid: {
                    hoverable: true,
                    clickable: true,
                    borderColor: "#f3f3f3",
                    borderWidth: 1,
                    tickColor: "#f3f3f3"
                },
                series: {
                    shadowSize: 0,
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                lines: {
                    fill: false,
                    color: ["#3c8dbc", "#f56954"]
                },
                yaxis: {
                    show: true,
                },
                xaxis: {
                    show: true
                }
            });
            $("#line-chart").bind("plotclick", function (event, pos, item) {

                if (item) {
                    vid.currentTime = (item.dataIndex) * 60;
                    vid.play();
                } else {
                    $("#line-chart-tooltip").hide();
                }

            });

        },
        error: function(request, status, error) {
            alert("결과 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
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

            if (formName == "EventForm") {
                $.each(cases, function(index, item) {
                    $('#EventForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
            else if (formName == "BioForm") {
                $.each(cases, function(index, item) {
                    $('#BioForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
            else if (formName == "VideoForm") {
                $.each(cases, function(index, item) {
                    $('#VideoForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
            else if (formName == "SearchForm") {
                $.each(cases, function(index, item) {
                    $('#SearchForm select#caId').append("<option value='" + item.caId + "'>" + item.caseNm + "</option> ");
                });
            }
        },
        error: function(request, status, error) {
            alert("케이스 목록 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}

// 케이스별 참가자 목록 조회
function getPrivateList(formName, caId) {


    $.ajax({
        type : "GET",
        url : "/input/privateList?caId="+caId,
        success: function(data) {

            var pris = data.pris;

            if (formName == "BioForm") {

                $('#BioForm select#name option').not("[value='']").remove();
                $.each(pris, function(index, item) {
                    // TODO 케이스 조회시 리턴 오브젝트에 개인정보 이름 추가
                    $('#BioForm select#name').append("<option value='" + item.prId + "'>" + item.name + "</option> ");
                });
            }
            else if (formName == "VideoForm") {

                $('#VideoForm select#name option').not("[value='']").remove();
                $.each(pris, function(index, item) {
                    // TODO 케이스 조회시 리턴 오브젝트에 개인정보 이름 추가
                    $('#VideoForm select#name').append("<option value='" + item.prId + "'>" + item.name + "</option> ");
                });
            }


        },
        error: function(request, status, error) {
            alert("privateList 조회 실패 " + request.status + "\n" + "error message: " + error + "\n");
        }
    });

}
