<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">

            <div class="step_box mypage">
                <h2 class="active">투자자 정보</h2>
                <ul>
                    <li>
                        <a href="/mypage/profile"><p>개인정보 수정</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/investor"><p class="active"><i class="icon ic_check"></i>투자자 정보</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/password"><p>비밀번호 변경</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/project"><p>투자 내역</p></a>
                    </li>
                    <li class="t-r">
                        <a href="/mypage/qna"><p>1:1문의내역</p></a>
                    </li>
                </ul>
            </div>

            <div class="form_box faq">
                <form id="frmData" method="post" action="" enctype="multipart/form-data">
                    <h2>투자자 정보</h2>
                    <div class="top">
                        <div class="publisher_box">
                            <div class="publisher_form form_list">
                                <div class="tab_form">
                                    <h2 class="mb50">연고자 모집 신청</h2>

                                    <div class="relation_box project">
                                        <h3>1. 요청할 모집을 선택해주세요.</h3>
                                        <div>
                                            <table cellpadding="0" cellspacing="0">
                                                <tbody>
                                                <#if projects?has_content>
                                                    <#list projects as project>
                                                        <tr>
                                                            <td <#if project.successState == "ready"> class="ready"</#if>>
                                                                <div>
                                                                    <div class="check_box">
                                                                        <input type="radio" id="check${project_index}" name="projectId" value="${project.projectId}">
                                                                        <label for="check${project_index}"></label>
                                                                    </div>
                                                                    <div class="title">
                                                                        <div>
                                                                            <div><p class="img" style="background-image: url(${(project.mainImageUrl)?default('/images/sample-project.jpg')}"></p></div>
                                                                            <div>
                                                                                <h3>${(project.name) !}</h3>
                                                                                <h5>${(project.user.userPublisher.corpName) !}</h5>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="info">
                                                                        <#if project.successState == "ing">
                                                                            <p class="mb5"><span>${(project.dday)! }</span>일 남음</p>
                                                                            <p class="mb5"><span>${(project.sbscCount) !}</span>명</p>
                                                                        <#else>
                                                                            <p class="mb5"><span>D-${(project.readyDay)-1 !}</span></p>
                                                                            <p class="mb5">현재 <span>${(project.sbscCount) !}</span>명</p>
                                                                        </#if>
                                                                        <p class="price"><span>${(project.sbscAmt?default(0)) !}</span>원</p>
                                                                    </div>
                                                                    <div class="state">
                                                                        <#if project.successState == "ing">
                                                                            <p>진행중</p>
                                                                        <#else>
                                                                            <p class="fc-lightgrey">준비중</p>
                                                                        </#if>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </#list>
                                                <#else>
                                                    <tr>
                                                        <td style="line-height: 475px; text-align: center;">등록할 프로젝트가 없습니다.</td>
                                                    </tr>
                                                </#if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="relation_box file mt50">
                                        <h3>2. 관련 증빙서류를 업로드해주세요.</h3>
                                        <div>
                                            <h4>발행기업의 연고자는 아래의 요건에 해당되는 투자자입니다. 이를 증빙할 서류를 업로드 해주세요. </h4>
                                            <ul>
                                                <li>1. 발행기업의 주식을 소유한 자</li>
                                                <li>2. 발행기업의 임원, 우리사주조합원</li>
                                                <li>3. 계열 회사 또는 그 임원</li>
                                                <li>4. 모집,매출 실적이 없는 주권비상장법인의 주주, 발기인(설립중인 회사) 등</li>
                                            </ul>
                                            <dl>
                                                <dt>연고자 서류</dt>
                                                <dd>
                                                    <div class="filebox">
                                                        <input type="text" class="upload_name" disabled="disabled">

                                                        <label for="ex_filename1">첨부</label>
                                                        <input type="file" id="ex_filename1" name="file" class="upload_hidden">
                                                    </div>
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
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
    <script>
        var invSortCd = '${(member.userInvestor.invSortCd) !}';
    </script>

    <script type="text/javascript" src="/js/mypage/investor_relations.js"></script>

    </@layout.put>

</@layout.extends>