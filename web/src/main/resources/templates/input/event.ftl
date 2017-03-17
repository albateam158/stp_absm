<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">이벤트 자료 입력</h2>
            <div class="bg_wh">
                <form id="EventForm">
                    <label for="caId" class="wd100">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd80 mb10">
                    </select>
                    <label for="" class="wd100">이벤트 파일명</label>
                    <input type="text" class="box_bd mr0 wd164" title="파일찾기" readonly="readonly"  id="eventFile">
                    <label for="file1" id="" class="file_label">파일찾기</label>
                    <input id="file1" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('eventFile').value=this.value" onkeydown="return false" >
                    <input type="hidden" name="fileType" value="EVENT" />
                    <button type="button" id="" name="save" class="input_btn fr" onclick="saveEvent();">입력</button>
                </form>
                <span class="line"></span>
                <div id="jsGrid"></div>
            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
	</@layout.put>


	<@layout.put block="script">
    <script type="text/javascript">

        $(window).ready(function(){
        });

        $(document).ready(function() {
            getCaseList("EventForm");
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
    </script>
	</@layout.put>

</@layout.extends>