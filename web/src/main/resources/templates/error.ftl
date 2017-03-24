<@layout.extends name="layout/base.ftl">

    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <section class="mb10">
        <div class="contents_wrap">
            <div class="content_box">
                <div class="form_box complete">
                    <h2>오류</h2>
                    <div class="top">
                        <div class="login_box">
                            <h1>서버 오류가 발생하였습니다. 관리자에게 문의하여 주십시오.</h1>
                        </div>
                    </div>
                    <div class="bottom">
                        <a href="/" class="btn_type03">메인으로</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
    </script>
    </@layout.put>

</@layout.extends>