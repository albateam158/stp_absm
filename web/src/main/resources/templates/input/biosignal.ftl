<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">생체신호 측정자료 입력</h2>
            <div class="bg_wh">
                <form id="BioForm">
                    <label for="caId" class="wd100">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd80 mb10">
                        <option value="">선택하세요</option>
                    </select>
                    <label for="name" class="wd35">이름</label>
                    <select name="name" id="name"  class="box_bd wd80 mb10">
                        <option value="">선택하세요</option>
                    </select>
                    <br />

                    <input type="hidden" name="caId" value="" />
                    <input type="hidden" name="prId" value="" />

                    <label for="" class="wd100">ECG 파일명</label>
                    <input type="text" class="box_bd mr0 mb10 wd164" title="파일찾기" readonly="readonly"  id="ecgFindFile">
                    <label for="file1" id="" class="file_label">파일찾기</label>
                    <input id="file1" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('ecgFindFile').value=this.value" onkeydown="return false" >
                    <input type="hidden" name="fileType" value="ECG" />

                    <label for="" class="wd100">GSR 파일명</label>
                    <input type="text" class="box_bd mr0 mb10 wd164" title="파일찾기" readonly="readonly"  id="gsrfindFile">
                    <label for="file2" id="" class="file_label">파일찾기</label>
                    <input id="file2" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('gsrfindFile').value=this.value" onkeydown="return false" >
                    <input type="hidden" name="fileType" value="GSR" />
                    <br />

                    <label for="" class="wd100">분단위 파일명</label>
                    <input type="text" class="box_bd mr0 wd164" title="파일찾기" readonly="readonly"  id="orgfindFile">
                    <label for="file3" id="" class="file_label">파일찾기</label>
                    <input id="file3" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('orgfindFile').value=this.value" onkeydown="return false" >
                    <input type="hidden" name="fileType" value="ORG" />

                    <label for="" class="wd100">SPSS 파일명</label>
                    <input type="text" class="box_bd mr0 wd164" title="파일찾기" readonly="readonly"  id="filterfindFile">
                    <label for="file4" id="" class="file_label">파일찾기</label>
                    <input id="file4" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('filterfindFile').value=this.value" onkeydown="return false" >
                    <!--<input type="hidden" name="fileType" value="MODEL" />-->
                    <input type="hidden" name="fileType" value="FILTER" />
                    <button type="button" id="" name="save" class="input_btn fr" onclick="saveBiosignal();">입력</button>

                </form>
                <span class="line"></span>
                <div id="jsGrid"></div>

            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
	</@layout.put>

	<@layout.put block="script">
    <script type="text/javascript">

        $(document).ready(function() {
            getCaseList("BioForm");
        });

        // select box 변경시 히든 prId 설정
        $('#BioForm select#name').on('change', function(){
            var selVal = $(this).val();
            $('#BioForm input[name="prId"]').val(selVal);

        });

        // select box 변경시 히든 caId 설정
        $('#BioForm select#caId').on('change', function(){
            var selVal = $(this).val();
            $('#BioForm input[name="caId"]').val(selVal);

            // case별 참가자 목록 조회
            getPrivateList("BioForm", selVal);

        });

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
                { name: "참가번호", type: "text", width: 100 , align: "center"},
                { name: "ECG/GSR구분", type: "text",  width: 100 , align: "center"},
                { name: "측정시간", type: "text",  width: 100 , align: "center"},
                { name: "측정값", type: "text",  width: 100 , align: "center"}
            ]
        });
    </script>
	</@layout.put>

</@layout.extends>