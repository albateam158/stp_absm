<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="form_box complete">
                <h2>회원가입</h2>
                <div class="top">
                    <div class="login_box">
                        <p class="ic_completion"></p>
                        <h1>회원가입이 성공적으로 완료되었습니다.</h1>
                    </div>
                </div>
                <div class="bottom">
                    <a href="/main" class="btn_type03">메인으로</a>
                    <a href="/user/investor_form" class="btn_type04">투자자 정보 입력</a>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">


    </@layout.put>

</@layout.extends>