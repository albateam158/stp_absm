<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="form_box">
                <form id="frmData">
                    <h2>정보입력</h2>
                    <div class="top">
                        <div class="publisher_box">
                            <div class="publisher_form">
                                <div class="tab_form">
                                    <h3>기업 회원 가입 위한 정보 요청</h3>
                                    <dl>
                                        <dt>법인명</dt>
                                        <dd><input type="text" name="corpName" class="full data" maxlength="100" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>주소</dt>
                                        <dd><input type="text" name="location" class="full data" maxlength="100" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>담당자 성명</dt>
                                        <dd><input type="text" name="managerName" class="full data" maxlength="20" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>연락처</dt>
                                        <dd><input type="text" name="managerPhone" class="full chkNum data" placeholder="숫자만 입력해주세요." maxlength="50"/></dd>
                                    </dl>
                                    <dl>
                                        <dt>이메일</dt>
                                        <dd><input type="text" name="managerEmail" class="full data" maxlength="100" /></dd>
                                    </dl>
                                </div>
                                <div class="tab_form">
                                    <h3>기업 정보 관련 문서 업로드</h3>
                                    <dl>
                                        <dt>회사 소개서</dt>
                                        <dd>
                                            <div class="filebox">
                                                <input type="text" class="upload_name" value="" disabled="disabled">

                                                <label for="ex_filename1">첨부</label>
                                                <input type="file" id="ex_filename1" name="cfile1" class="upload_hidden">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>사업 계획서</dt>
                                        <dd>
                                            <div class="filebox">
                                                <input type="text" class="upload_name" value="" disabled="disabled">

                                                <label for="ex_filename2">첨부</label>
                                                <input type="file" id="ex_filename2" name="cfile2" class="upload_hidden">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>재무제표</dt>
                                        <dd>
                                            <div class="filebox">
                                                <input type="text" class="upload_name" value="" disabled="disabled">

                                                <label for="ex_filename3">첨부</label>
                                                <input type="file" id="ex_filename3" name="cfile3" class="upload_hidden">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>제품 설명서</dt>
                                        <dd>
                                            <div class="filebox">
                                                <input type="text" class="upload_name" value="" disabled="disabled">

                                                <label for="ex_filename4">첨부</label>
                                                <input type="file" id="ex_filename4" name="cfile4" class="upload_hidden">
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <input class="btn_type03" id="btn_submit" type="button" value="확인" />
                    </div>
                </form>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript" src="/js/page/publisher_form.js"></script>
    </@layout.put>

</@layout.extends>