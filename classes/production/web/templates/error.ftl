<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

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
                    <a href="/main" class="btn_type03">메인으로</a>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">


    </@layout.put>

</@layout.extends>