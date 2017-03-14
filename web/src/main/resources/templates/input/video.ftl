<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <section class="mb10">
        <div class="pd7">
            <h2 class="input">동영상 자료 입력</h2>
            <div class="bg_wh">
                <form action="">
                    <label for="caId" class="wd100">케이스명</label>
                    <select name="caId" id="caId"  class="box_bd wd80 mb10">
                        <option value="">1</option>
                        <option value="">2</option>
                    </select>
                    <label for="name" class="wd35">이름</label>
                    <select name="name" id=""  class="box_bd wd80 mb10">
                        <option value="">한후자</option>
                        <option value="">이옥자</option>
                    </select>
                    <br />

                    <label for="" class="wd100">동영상 파일명</label>
                    <input type="text" class="box_bd mr0 mb10 wd164" title="파일찾기" readonly="readonly"  id="videoFindFile">
                    <label for="fileName" id="" class="file_label">파일찾기</label>
                    <input id="" type="file" class="attach_file" name="fileName" onchange="javascript:document.getElementById('videoFindFile').value=this.value" onkeydown="return flase" >
                    <button type="button" id="" name="save" class="input_btn fr">입력</button>
                </form>
                <span class="line"></span>

                <video width="" height="280px" controls class="ma_t">
                    <source src="/video/sample.mp4" type="video/mp4">
                </video>
            </div><!-- //bg_wh -->
        </div><!-- //pd7 -->
    </section>
	</@layout.put>


	<@layout.put block="script">
    <script type="text/javascript">

    </script>
	</@layout.put>

</@layout.extends>
