<@layout.extends name="layout/base.ftl">

    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">기초자료 및 개인특성 자료 입력</h2>
            <div class="bg_wh">
                <form id="PrivateForm">
                    <h3> 전체 피험자의 개인특성정보, 설문조사정보 입력</h3>

                    <label for="dt" class="wd160">측정일자</label><input type="text" id="datePicker" name="dt" class="box_bd wd160"><!-- 20170316 추가 datepicker -->
                    <label for="caseNm">케이스명</label>
                    <input type="text" id="caseNm" name="caseNm" class="box_bd wd160" />
                    <label for="note" class="wd35">설명</label><input type="text" id="note" name="note" class="box_bd wd189 mb10" /><br />

                    <label for="" class="wd160">개인특성 파일명(엑셀)</label>
                    <input type="text" class="box_bd mr0 mb10 wd189" title="파일찾기" readonly="readonly"  id="file_sch1">
                    <label for="file1" id="" class="file_label">파일찾기</label><!-- lable의 for : file1 -->
                    <input id="file1" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('file_sch1').value=this.value;" onkeydown="return false" ><!-- input의 id : file1 -->
                    <input type="hidden" name="fileType" value="PRIVATE" />
                    <!-- <INPUT TYPE="file" NAME="uploads" id="file" size="60" style="height:20px;" on change="this.select(); document.getElementById('excel_path').value=document.selection.createRange().text.toString();"> -->
                    <br />
                    <label for="" class="wd160">설문조사 파일명(엑셀)</label>
                    <input type="text" class="box_bd mr0 wd189" title="파일찾기" readonly="readonly"  id="file_sch2">
                    <label for="file2" id="" class="file_label">파일찾기</label><!-- lable의 for : file2 -->
                    <input id="file2" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('file_sch2').value=this.value" onkeydown="return false" ><!-- input의 id : file2 -->
                    <input type="hidden" name="fileType" value="SURVEY" />
                     <button type="button" id="" name="save" class="input_btn fr" onclick="vaildationCheck();">입력</button>
                </form>
                <span class="line"></span>
                <div id="jsGrid"></div>
            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
    <!-- 20170326 추가 loading -->
    <div class="loading hide">
        <img src="/images/loading.gif" class="loading_img" alt="로딩중입니다." />
    </div>
    <!-- //20170326 추가 loading -->
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">

        function vaildationCheck() {

            var msg = '';

            if ($('#datePicker').val() == '') {
                msg = '측정일자를 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#caseNm').val() == '') {
                msg = '케이스명을 입력하세요';
                createToast('info', msg);
                return;
            }

            if ($('#file1')[0].files.length == 0) {
                msg = '개인특성 파일을 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#file2')[0].files.length == 0) {
                msg = '설문조사 파일을 선택하세요';
                createToast('info', msg);
                return;
            }

            savePrivate();

        }

        var clients = [];


        $("#jsGrid").jsGrid({
            width: "100%",
            height: "400px",

            //inserting: true,
            // editing: true,
            sorting: true,
            paging: true,

            data: clients,

            fields: [
                { name: "케이스명", type: "text", width: 100 , align: "center"},
                { name: "참가번호", type: "number", width: 100 , align: "center"},
                { name: "이름", type: "text",  width: 100 , align: "center"},
                { name: "나이", type: "text",  width: 100 , align: "center"},
                { name: "성별", type: "text",  width: 100 , align: "center"}
            ]
        });
    </script>
    </@layout.put>

</@layout.extends>