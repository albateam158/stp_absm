<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="cont_top">
                <h1>${(project.name) !}</h1>
                <h3>${(project.summary) !}</h3>
                <div class="category">
                    <ul class="fr">
                        <li><i class="icon flag"></i> ${(project.category.name) !}</li>
                        <li><i class="icon map"></i> ${(project.location) !}</li>
                        <#if project.taxDeduction?default('N') == 'Y'>
                            <li class="ic_deduction">
                                <span>소득공제</span>
                                <div class="info none">
                                    <p class="fw-b fc-red">이 회사에 투자하면<br />"조세특례제한법(조특법)"상<br />소득공제를 받을 수 있습니다.</p>
                                    <p class="mt10 mb10 fw-b fc-black"><strong>소득공제율</strong></p>
                                    <p>1,500만원 이하 <strong>100%</strong></p>
                                    <p>5,000만원 이하 <strong>50%</strong></p>
                                    <p>5,000만원 초과 <strong>30%</strong></p>
                                </div>
                            </li>
                        </#if>
                    </ul>
                </div>
                <div class="detail_header">
                    <div class="thum">
                        <p class="img" style="background-image:url(<#if project.mainImageUrl?exists>${(project.mainImageUrl) !}<#else>'/images/sample-project.jpg'</#if>);"></p>
                    </div>
                    <div class="info">
                        <div class='top_cont'>
                            <#assign percent = (project.sbscAmt / project.targetAmt) * 100>
                            <#if (percent > 100)>
                                <#assign percent = percent?string("0")>
                            <#else>
                                <#assign percent = percent?string("0.#")>
                            </#if>
                            <p class="graph circleGraphic fl mr5" data-form="${percent}"></p>
                            <div>
                                <p class="price">목표액 ${(project.targetAmt?default(0)) !}원</p>
                                <p class="nowPrice price"><span>${(project.sbscAmt?default(0)) !}</span>원</p>
                                <p class="total">총 ${(project.sbscCount?default(0)) !}명 참여</p>
                                <p><#if project.secnTpcd == "11">채권<#else>주식</#if> 발행 모집</p>
                            </div>
                        </div>
                        <p class="timer">
                            <#if project.successState == 'success' || project.successState == 'fail' || project.successState == 'finish'>
                                <span class="fc-red">펀딩이 마감되었습니다.</span>
                            <#else>
                                <span>남은시간</span> <span class="icon clock"></span><span class="clock_txt"></span>
                            </#if>
                        </p>
                        <p class="text">
                            ${(project.description) !}
                        </p>

                        <#-- 투자하기  버튼-->
                        <#if pStatus?exists>
                            <a class="btn btn_type01 grey disabled">청약완료</a>
                        <#else>
                            <#if project.successState == 'success' || project.successState == 'fail' || project.successState == 'finish'>
                                <a class="btn btn_type01 grey disabled">투자종료</a>
                            <#elseif project.successState == 'ing'>
                                <a class="btn btn_type01" id="go_sbsc">투자하기</a>
                            <#else>
                                <a class="btn btn_type01 grey disabled">청약대기</a>
                            </#if>
                        </#if>

                        <ul class="sns_box fr" title="${(project.name) !}">
                            <li><a sns_type="fb"><i class="sns ic_fbook"></i>페이스북</a></li>
                            <li><a sns_type="tw"><i class="sns ic_twtr"></i>트위터</a></li>
                            <li><a sns_type="in"><i class="sns ic_in"></i>링크드인</a></li>
                        </ul>
                    </div>
                </div>
                <div class="detail_info">
                    <div class="firm_info">
                        <p class="img firm_logo fl" style="background-image:url(${(project.user.userPublisher.logoImageUrl)?default('/images/sample-project.jpg') !});"></p>
                        <div class="fl">
                            <dl>
                                <dt>회사명</dt>
                                <dd>${(project.user.userPublisher.corpName) !}</dd>
                            </dl>
                            <dl>
                                <dt>업종</dt>
                                <dd>${(project.business?default("-")) !}</dd>
                            </dl>
                            <dl>
                                <dt>대표자명</dt>
                                <dd>${(project.ceoName) !}</dd>
                            </dl>
                            <dl>
                                <dt>설립일자</dt>
                                <dd><#if project.establishDate?exists && project.establishDate != "">${(project.establishDate?date("yyyyMMdd")?string("yyyy.MM.dd")) !}<#else>-</#if> </dd>
                            </dl>
                        </div>
                        <div class="fr">
                            <dl>
                                <dt>임직원수</dt>
                                <dd>${(project.staff?default("- ")) !}명</dd>
                            </dl>
                            <dl>
                                <dt>소재지</dt>
                                <dd>${(project.address?default("-")) !}</dd>
                            </dl>
                            <dl>
                                <dt>홈페이지</dt>
                                <dd>
                                    <a href="http://${(project.user.userPublisher.homepage?replace("http://", "")) !}" target="_blank">
                                        ${(project.user.userPublisher.homepage) !}
                                    </a>
                                </dd>
                            </dl>
                            <dl>
                                <dt>이메일</dt>
                                <dd>
                                    <a href="mailto:kastera1025@naver.com" target="_blank">
                                        ${(project.user.userPublisher.email) !}
                                    </a>
                                </dd>
                            </dl>
                        </div>
                    </div>
                    <div class="project_info">
                        <div class="fl line_left">
                            <dl>
                                <dt>시작일</dt>
                                <dd>${(project.sbscStDt?date("yyyyMMdd")?string("yyyy.MM.dd")) !}</dd>
                            </dl>
                            <dl>
                                <dt>마감일</dt>
                                <dd>${(project.sbscNdDt?date("yyyyMMdd")?string("yyyy.MM.dd")) !}</dd>
                            </dl>
                            <dl>
                                <dt>교부 예정일</dt>
                                <dd>${(project.issueDate?date("yyyyMMdd")?string("yyyy.MM.dd")) !}</dd>
                            </dl>
                            <dl>
                                <dt>발행후배정지분율</dt>
                                <dd>${(project.shareRatio)?default('-') !}%</dd>
                            </dl>
                        </div>
                        <div class="fr line_left">
                            <dl>
                                <dt>주당발행가격</dt>
                                <dd>${(project.targetStockPrice) !}원</dd>
                            </dl>
                            <dl>
                                <dt>액면가액</dt>
                                <dd>${(project.faceValue?default(0)) !}원</dd>
                            </dl>
                            <dl>
                                <dt>최소투자금액</dt>
                                <dd><#if project.minSbscCount?exists && project.minSbscCount &gt; 0>${(project.minSbscCount * project.targetStockPrice) !}<#else>${(project.targetStockPrice) !}</#if>원</dd>
                            </dl>
                            <dl>
                                <dt>최소투자주식수</dt>
                                <dd><#if project.minSbscCount?exists && project.minSbscCount &gt; 0>${(project.minSbscCount) !}<#else>1</#if>주</dd>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cont_bottom">
                <div class="cont_tab web">
                    <ul>
                        <li class="ir active" data-form="ir"><h2><i>온라인 IR</i></h2></li>
                        <li class="publisher" data-form="publisher"><h2><i>발행인 게재사항</i></h2></li>
                        <li class="update" data-form="update"><h2><i>타임라인</i><span class="updateCount">${project.updateCount}</span></h2></li>
                        <li class="feedback" data-form="feedback"><h2><i>투자자 의견</i></h2></li>
                    </ul>
                </div>

                <div class="cont_tab mobile">
                    <ul>
                        <li class="active" data-form="ir">
                            <h2>온라인 IR</h2>
                            <div class="sub">
                                <ul>
                                    <li data-form="ir"><h2><i>온라인 IR</i></h2></li>
                                    <li data-form="publisher"><h2><i>발행인 게재사항</i></h2></li>
                                    <li data-form="update"><h2><i>타임라인</i><span class="updateCount">${project.updateCount}</span></h2></li>
                                    <li data-form="feedback"><h2><i>투자자 의견</i></h2></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="tab_page">

                    <#if !user??>
                        <!-- 로그인 필요 -->
                        <div class="tab_cont cont_login">
                            <div class="noti_box mb40">
                                <div class="text t-c">
                                    <h3>로그인이 필요한 서비스 입니다.</h3>
                                    <p>
                                        WiCrowd에 등록된 발행기업 정보를 보시려면 로그인 하시기 바랍니다.
                                    </p>
                                </div>
                            </div>
                        </div>
                    <#else>
                        <#if project.user.userId == user.userId>
                            <#assign userType = 1> <!-- 발행인 로그인 -->
                        <#else>
                            <#assign userType = 2>
                        </#if>

                        <!-- 내용 -->
                        <div class="tab_cont cont_ir">
                            <div class="contents editor_view ir">${(project.content) !}</div>
                            <div class="contents editor_view publisher none">${(project.publishNotice) !}</div>
                            <div class="tab_files">
                                <div class="file_group images">
                                    <h4>이미지</h4>
                                    <#if project.images?has_content>
                                        <ul class="card_list">
                                            <#list project.images as img>
                                                <#if img.imageType != 'main'>
                                                    <li><a href="${img.url}" data-lightbox="roadtrip" target="_blank"><p class="img" style="background-image: url('${img.url}');"></p></a></li>
                                                </#if>
                                            </#list>
                                        </ul>
                                    </#if>
                                </div>
                                <div class="file_group files">
                                    <h4>문서</h4>
                                    <#if project.files?has_content>
                                        <ul class="card_list">
                                            <#list project.files as file>
                                                <li>
                                                    <#assign fileType=file.url?lower_case?keep_after_last(".")>
                                                    <#if fileType == 'pdf'>
                                                        <#assign fileIco='PDF'>
                                                    <#elseif fileType == 'docx'>
                                                        <#assign fileIco='DOC'>
                                                    <#else>
                                                        <#assign fileIco='ETC'>
                                                    </#if>
                                                    <dl>
                                                        <dt class="${fileIco}">${fileIco}</dt>
                                                        <dd>
                                                            <a href="${file.url}" title="${file.fileName}" target="_blank">${file.fileName}</a>
                                                        </dd>
                                                    </dl>
                                                </li>
                                            </#list>
                                        </ul>
                                    </#if>
                                </div>
                            </div>
                        </div>
                        <div class="tab_cont cont_update">
                            <div class="noti_box">
                                <p>
                                    총 <span><span>${project.updateCount}</span>건</span>의 업데이트가 있습니다.
                                    <#if user?exists && (user.userId == project.user.userId)>
                                        <a href="/project/${projectId}/update_form" class="btn_type02 fr">글쓰기</a>
                                    </#if>
                                </p>
                            </div>
                            <div class="cont_list"></div>
                        </div>
                        <div class="tab_cont cont_feedback">
                            <div class="noti_box mb20">
                                <ul>
                                    <li><i class="icon ic_investor1"></i>일반 투자자 <span>${invCount1?default(0) !}</span></li>
                                    <li><i class="icon ic_investor2"></i>소득적격 투자자 <span>${invCount2?default(0) !}</span></li>
                                    <li><i class="icon ic_investor3"></i>전문 투자자 <span>${invCount3?default(0) !}</span></li>
                                </ul>
                            </div>
                            <div class="cont_list">
                                <div class="post_box">
                                    <div class="comments">
                                        <#if user?? && user.userType == 'investor'>
                                            <div class="comment_input">
                                                <h3>발행기업에 대해 자유롭게 소통하세요.</h3>
                                                <div class="input_wrap mt20">
                                                    <textarea cols="75" rows="4" placeholder="투자자 의견 작성하기"></textarea>
                                                    <p class="fr t-c">
                                                        <input class="btn_type02 btn_submit" data-form="feedback" type="submit" value="확인">
                                                    </p>
                                                </div>
                                            </div>
                                        </#if>

                                        <div class="comment_list">
                                            <h4>총 <span class="feedbackCount">${(project.feedbackCount) !}</span>건의 의견이 있습니다.</h4>
                                            <ul></ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <#--<div class="tab_cont cont_investor">-->
                            <#--<div class="noti_box mb40">-->
                                <#--<p class="text">-->
                                    <#--다수의 투자자로부터 투명하게 자금을 모집하는 크라우드펀딩입니다. 발행기업에 투자 청약하신 투자자에 대한 현황입니다.-->
                                <#--</p>-->
                            <#--</div>-->
                            <#--<div class="cont_list">-->
                                <#--<div class="post_box">-->
                                    <#--<div class="comments">-->
                                        <#--<div class="comment_list">-->
                                            <#--<h4>총 <span>${project.sbscCount}</span>명의 투자자가 있습니다.</h4>-->
                                            <#--<ul></ul>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</div>-->
                    </#if>
                </div>
                <div class="loading"><img src="/images/bx_loader.gif" style="width: 32px; height: 32px;"/></div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var fbAppId = '${socialSettings.fbAppId}';
        var successState = '${project.successState}';
        var startDate = new Date('${project.sbscStDt}'.substr(0, 4), parseInt('${project.sbscStDt}'.substr(4, 2)) - 1, '${project.sbscStDt}'.substr(6, 2));
        startDate.setHours(0);
        startDate.setMinutes(0);
        startDate.setSeconds(0);
        var endDate = new Date('${project.sbscNdDt}'.substr(0, 4), parseInt('${project.sbscNdDt}'.substr(4, 2)) - 1, '${project.sbscNdDt}'.substr(6, 2));
        endDate.setHours(17);
        endDate.setMinutes(59);
        endDate.setSeconds(59);
        var time1 = startDate.getTime();
        var time2 = endDate.getTime();
        var counter = null;
        var tabId = '${(tabId) !}';
        var projectId = '${project.projectId}';
        var userType = '${(userType) !}';
        var status = '${(member.userInvestor.status) !}';
        var userInvType = '${(user.userType) !}';
        var invSortCd = '${(user.userInvestor.invSortCd) !}';
    </script>

    <script type="text/javascript" src="/js/project/detail.js"></script>

    </@layout.put>

</@layout.extends>