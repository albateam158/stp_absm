<@layout.extends name="layout/base.ftl">

    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">동영상 자료 입력</h2>
            <div class="bg_wh">
                <form id="VideoForm">
                    <h3> 선택한 1명의 피험자의 동영상파일 입력, 파일제한크기는 1기가바이트입니다. </h3>

                    <label for="caId" class="wd100">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd160 mb10">
                        <option value="">선택하세요</option>
                    </select>
                    <label for="name" class="wd35">이름</label>
                    <select name="name" id="name"  class="box_bd wd160 mb10">
                        <option value="">선택하세요</option>
                    </select>
                    <br />

                    <input type="hidden" name="caId" value="" />
                    <input type="hidden" name="prId" value="" />

                    <label for="" class="wd160">동영상 파일명(mp4)</label>
                    <input type="text" class="box_bd mr0 mb10 wd164" title="파일찾기" readonly="readonly"  id="videoFindFile">
                    <label for="file1" id="" class="file_label">파일찾기</label>
                    <input id="file1" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('videoFindFile').value=this.value" onkeydown="return false" >
                    <button type="button" id="" name="save" class="input_btn fr" onclick="vaildationCheck();">입력</button>
                </form>
                <span class="line"></span>

                <video id="video1" name="video1" width="" height="280px" controls class="ma_t">
                    <source src="" type="video/mp4">
                </video>
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

        $(document).ready(function() {
            getCaseList("VideoForm");
        });

        function vaildationCheck() {

            var msg = '';

            if ($('#caId').val() == '') {
                msg = '케이스명을 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#name').val() == '') {
                msg = '이름을 선택하세요';
                createToast('info', msg);
                return;
            }

            if ($('#file1')[0].files.length == 0) {
                msg = '동영상 파일을 선택하세요';
                createToast('info', msg);
                return;
            }

            saveVideo();

        }

        // select box 변경시 히든 prId 설정
        $('#VideoForm select#name').on('change', function(){
            var selVal = $(this).val();
            $('#VideoForm input[name="prId"]').val(selVal);

        });

        // select box 변경시 히든 caId 설정
        $('#VideoForm select#caId').on('change', function(){
            var selVal = $(this).val();
            $('#VideoForm input[name="caId"]').val(selVal);

            // case별 참가자 목록 조회
            getPrivateList("VideoForm", selVal);

        });

    </script>
    </@layout.put>

</@layout.extends>
