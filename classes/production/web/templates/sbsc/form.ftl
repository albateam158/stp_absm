<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box sbsc overflow-h">
            <div class="step_box">
                <ol>
                    <li>
                        <p class="active"><i class="icon ic_check"></i> 청약신청</p>
                    </li>
                    <li class="t-c">
                        <p><i class="icon ic_check"></i> 청약 증거금 이체</p>
                    </li>
                    <li class="t-r">
                        <p><i class="icon ic_check"></i> 투자완료</p>
                    </li>
                </ol>
            </div>

            <form id="frmData" method="post" action="/sbsc/${project.projectId}/transfer">
                <input type="hidden" name="totInvstLmtAmt">
                <input type="hidden" name="invSortCd" value="${(user.userInvestor.invSortCd)!}">
                <input type="hidden" name="invstrSortTpcd" value="${(user.userInvestor.invSortCd)!}">
                <div class="thum_wrap post">
                    <div class="form_box">
                        <h2>청약신청</h2>
                        <div class="top">
                            <div class="publisher_box sbsc">
                                <div class="publisher_header">
                                    <h1><span>${(project.name) !}</span>에 투자를 시작합니다.</h1>
                                    <#function fnInvSortName invSortCd>
                                        <#switch invSortCd>
                                            <#case "02">
                                                <#return "소득요건충족투자자 ${(user.name) !}">
                                                <#break>
                                            <#case "03">
                                                <#return "전문투자자 ${(userInvestor.corpName) !}">
                                                <#break>
                                            <#default> <#--01-->
                                                <#return "일반투자자 ${(user.name) !}">
                                        </#switch>
                                    </#function>
                                    <p class="mt20"><#if user.userInvestor.corpName?has_content>법인<#else>개인</#if>-${fnInvSortName(user.userInvestor.invSortCd)} 님</p>
                                    <p class="mt5 totInvstLmtAmtString"></p>
                                </div>

                                <div class="publisher_wrap">
                                    <div>
                                        <div class="publisher_form">
                                            <h1>청약 신청서</h1>
                                            <div class="calculate_box">
                                                <div class="calculate">
                                                    <p class="fl">
                                                        주당 인수 가격 ${(project.targetStockPrice) !}원 <span class="ml10">X</span>
                                                    </p>
                                                    <p class="fr">
                                                        <input type="text" name="sbscQty" class="chkNum data t-r sbscQty" text="청약 수량" maxlength="100" value="" placeholder="${(project.minSbscCount) !}" /> 주
                                                    <p>
                                                </div>
                                                <p class="info">투자가능 최소단위는 <span class="fs_price">${(project.minSbscCount) !}</span>주 입니다.</p>
                                                <p class="result_price price"><span>0</span>원</p>
                                                <p style="text-align: left;" class="target_over none">- 선착순 배정 방식임에 따라 입력하신 청약금액이 100%를 초과하여, 최종 배정이 변경 될 수 있습니다.<br>
                                                    변경된 배정에 따른 초과 금액은 환불될 것 입니다.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="bottom">
                            <h2>배정예상 결과 미리보기</h2>
                            <p class="result price mt15">
                                ${(project.name) !} 발행 주식 <span id="sbscCount">0</span>주  &nbsp; &nbsp;
                                <strong>배정 지분율 <span id="shareRatio">0</span>%</strong>
                            </p>
                        </div>
                    </div>
                    <p class="mt30 mb30 pl15 pr15 t-c">${(user.name) !}님 청약을 신청하기 전에 아래 내용에 대해 확인하셨나요?</p>
                    <div class="form_notice">
                        <div>
                            <h2>투자내용 및 투자위험 확인 내용</h2>
                            <ul>
                                <li>
                                    <strong>하나,</strong>
                                    홈페이지에 게재된 모집되는 증권의 취득에 따른 투자위험요소, 증권의 발행조건, 발행인의 재무상태가 기재된 서류 및 사업계획서의 내용을 충분히 확인하였으며, 또한 해당 게재된 사항은 청약기간 종료 전에 정정될 수 있다는 점을 인지하고 있습니다.
                                </li>
                                <li>
                                    <strong>둘,</strong>
                                    금번에 발행되는 비상장 증권의 발행이 한국거래소의 상장을 목적으로 하는 것이 아니며, 따라서 증권의 환금성에 큰 제약이 있다는 점과 예상 회수금액에 대한 일부 혹은 전부를 회수할 수 없는 위험이 있음을 이해하며, 본인은 이를 감당할 수 있음을 확인합니다.
                                </li>
                                <li>
                                    <strong>셋,</strong>
                                    법 제117조의10제7항에 따라 전문투자자에 대한 매도 등 예외적인 경우를 제외하고는 원칙적으로 1년간 전매가 제한된다는 점을 이해합니다.
                                </li>
                                <li>
                                    <strong>넷,</strong>
                                    청약기간 중에는 청약의 철회를 할 수 있으나, 청약기간 종료일 이후에는 청약을 철회할 수 없으며, 모집예정금액의 80% 미달시 증권발행이 취소된다는 점을 이해합니다.
                                </li>
                                <li>
                                    <strong>다섯,</strong>
                                    기타 사항 - 투자자에 대한 별도의 수수료는 없으나, 청약증거금 이체과정에서 발생하는 소정의 수수료는 투자자가 부담함을 이해합니다.
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="form_notice mt5">
                        <div>
                            <p class="t-c fs-12 fw-b">
                                청약의 주문내역에 대한 동의절차 진행을 위해 아래 투자 동의 버튼을 눌러 청약신청을 진행해주세요.
                            </p>
                            <p class="t-c mt30 mb20">
                                <input class="btn_type03" id="btn_submit" type="button" value="투자 동의" />
                            </p>
                        </div>
                    </div>
                </div>
            </form>
            <div class="thum_wrap project">

                <#function fnSubscribeTypeName subscribeType>
                    <#if subscribeType == "1"><#return "공모"><#else><#return "사모"></#if>
                </#function>

                <ul class="card_list">
                    <li>
                        <a href="/project/${projectId}" target="_blank">

                            <div class="category">
                                <div>
                                    <i class="icon">${(project.category.name) !}</i>
                                ${(fnSubscribeTypeName(project.subscribeType)) !}/${(project.location) !}
                                </div>
                                <#if project.taxDeduction?default('N') == 'Y'>
                                    <span class="ic_deduction">소득공제</span>
                                </#if>
                            </div>
                            <div class="thum">
                                <p class="image" style="background-image:url(${(project.mainImageUrl)?default('/images/sample.jpg') !});"></p>
                                <p class="blockUi"></p>
                                <div class="desc">
                                    <h4>
                                        <#assign endDate = project.sbscNdDt?datetime("yyyyMMdd")?long >
                                        <#assign nowDate = .now?string.yyyyMMdd?datetime("yyyyMMdd")?long >
                                        <#assign dDay = ((endDate - nowDate) / (1000 * 60 * 60 * 24))?int >
                                        <#if (dDay < 0)>
                                            청약종료 <br/>
                                        <#else>
                                            D-${(dDay)! } <br/>
                                        </#if>
                                        목표금액 ${(project.targetAmt?default(0)) !}원
                                    </h4>
                                    <p>${(project.comment?default(""))!}</p>
                                </div>
                            </div>
                            <div class="info">
                                <div class="title">
                                    <h4>${(project.name) !}</h4>
                                </div>
                                <p class="firm">${(project.user.userPublisher.corpName) !}</p>
                                <p><span>${(dDay)! }</span>일 남음</p>
                                <p>현재 <span>${(project.sbscCount) !}</span>명</p>
                                <p class="price"><span>${(project.sbscAmt?default(0)) !}</span>원</p>
                                <#assign percent = (project.sbscAmt / project.targetAmt) * 100>
                                <#if (percent > 100)>
                                    <#assign percent = percent?string("0")>
                                <#else>
                                    <#assign percent = percent?string("0.#")>
                                </#if>
                                <p class="graph circleGraphic" data-form="${percent}"></p>
                            </div>
                        </a>
                    </li>
                    <li class="no_hover">
                        <div class="info">
                            <h5>청약 기본 사항</h5>
                            <ul>
                                <li>상호: ${(project.name) !}</li>
                                <li>모집수량: ${(project.targetStockQty) !}주</li>
                                <li>신주의 발행가액: ${(project.targetStockPrice) !}원</li>
                                <li>신주의 배정방법: ${(fnSubscribeTypeName(project.subscribeType)) !}</li>
                                <li>청약기간: ${(project.sbscStDt?datetime("yyyyMMdd")?string("yyyy년 MM월 dd일")) !}부터 ${(project.sbscNdDt?datetime("yyyyMMdd")?string("yyyy년 MM월 dd일")) !}</li>
                                <li>주금 납입일: 청약기간의 종료일로부터 8일 이내 (예정)</li>
                                <li>청약취급처: 위크라우드</li>
                                <li>청약증거금 예치기관: 한국증권금융</li>
                                <li>증권입고일: 납입일로부터 10일 이내</li>
                                <li>보호예수: 예탁결제원에서 1년간의 무보유 예탁조치</li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var projectId = '${project.projectId}';
        var targetStockPrice = '${(project.targetStockPrice?c) !}';
        var targetStockQty = '${(project.targetStockQty?c)!}';        //목표 청약 수
        var minSbscCount = '${(project.minSbscCount?c) !}';        //청약 신청 min 수
        var maxSbscCount = '${(project.maxSbscCount?c) !}';        //청약 신청 max 수
        var targetStockPrice = '${(project.targetStockPrice?c)!}';    //개당 금액
        var invSortCd = '${(user.userInvestor.invSortCd)!}';    //투자자 유형
        var sbscAmt = '${(project.sbscAmt?c)!}';    //현재 투자 주수
        var targetAmt = '${(project.targetAmt?c)!}';    //목표 투자 금액
        var shareRatio = '${(project.shareRatio)!}';    //목표 투자 금액
    </script>
    <script type="text/javascript" src="/js/sbsc/form.js"></script>

    </@layout.put>

</@layout.extends>