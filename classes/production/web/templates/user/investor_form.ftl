<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">

            <div class="form_box">
                <h2>투자자 정보 입력</h2>
                <div class="top">
                    <div class="publisher_box">
                        <div class="publisher_type_box">
                            <ul class="tab_box">
                                <li class="active" rel="tab1" type="${statics["net.xenix.wicrowd.type.InvSortCdType"].NORMAL}">
                                    <div>
                                        <span class="ic_investor type1"></span>
                                        <p>일반 투자자</p>
                                    </div>
                                </li>
                                <li rel="tab2" type="${statics["net.xenix.wicrowd.type.InvSortCdType"].INCOME}">
                                    <div>
                                        <span class="ic_investor type2"></span>
                                        <p>소득 요건구비<span>투자자</span></p>
                                    </div>
                                </li>
                                <li rel="tab3" type="${statics["net.xenix.wicrowd.type.InvSortCdType"].SPECIAL}">
                                    <div>
                                        <span class="ic_investor type3"></span>
                                        <p>전문 투자자</p>
                                    </div>
                                </li>
                            </ul>
                            <div class="tab_container">
                                <div id="tab1">
                                    <h3>일반 투자자</h3>
                                    <p>
                                        만 14세 이상 증권계좌를 가지고 있는 개인으로 기업당 200만원, 연간 500만원의 한도내에서 크라우드 펀딩 투자를 하실 수 있습니다.
                                    </p>
                                </div>
                                <div id="tab2">
                                    <h3>소득 요건구비 투자자</h3>
                                    <p>
                                        소득 여건구비 투자자 : 동일기업 투자한도 1,000만원 연간 총 투자 한도 2,000만원.<br/>
                                        개인의 경우 : 금융소득종합과세 대상자 또는 사업소득 + 근로소득이 1억원 이상인 자.<br/>
                                        법인의 경우 : 최근 사업 연도 말 자기자본이 10억원 이상인 자.
                                    </p>
                                </div>
                                <div id="tab3">
                                    <h3>전문 투자자</h3>
                                    <p>
                                        벤처캐피탈, 전문엔젤투자자 등 관계 법령 [자본시장법 제9조 5항 시행령 제10조에 의해 지정전문투자자 또는 자본시장법
                                        제118의 15제 10항에 의해 전문성, 위험감수 능력을 갖춘 자]로 칭합니다.<br />
                                        - 당연 전문 투자자 - 전문가 - 지정전문 투자자<br />
                                        <a class="popup_investor fw-b mt5">전문투자자 자격요건</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="publisher_form form_list">
                            <div id="tab1_form" class="tab_form">
                                <form id="frm_${statics["net.xenix.wicrowd.type.InvSortCdType"].NORMAL}" method="post" action="" enctype="multipart/form-data">
                                    <input type="hidden" name="invSortCd" value="${statics["net.xenix.wicrowd.type.InvSortCdType"].NORMAL}" />
                                    <input type="hidden" name="uploadFile" value="" />
                                <div>
                                    <h3>투자자 정보</h3>
                                    <dl>
                                        <dt>이름</dt>
                                        <dd><input type="text" name="name" text="이름" class="full data" value="" maxlength="20" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>주민등록번호</dt>
                                        <dd><input type="password" name="jumin" text="주민등록번호" class="full chkNum data" placeholder="숫자만 입력해주세요." maxlength="13" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>핸드폰 번호</dt>
                                        <dd><input type="text" name="phone" text="핸드폰 번호" class="full chkNum data" placeholder="숫자만 입력해주세요." value="" maxlength="50" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>신분증 사본</dt>
                                        <dd>
                                            <div class="filebox">
                                                <input type="text" class="upload_name" placeholder="파일 형식은 jpg, png, pdf만 업로드가 가능합니다" disabled="disabled">

                                                <label for="ex_filename1">첨부</label>
                                                <input type="file" id="ex_filename1" name="file1" data-type="image" accept="image/*" class="upload_hidden">
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="mt50">

                                    <div class="tab_form">
                                        <h3>계좌 정보</h3>
                                        <ul>
                                            <li>
                                                <div class="select_box secucoAcopno">
                                                    <label>증권사 선택</label>
                                                    <select name="secucoAcopno" class="data select" text="증권사 선택">
                                                        <option value="">증권사 선택</option>
                                                        <#list acoCodes as acoCode>
                                                            <option value="${acoCode.code}">${acoCode.codeName}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt class="pl10">계좌번호</dt>
                                                    <dd>
                                                        <input type="text" name="invstrTrsacNo" class="full chkNum data" text="계좌번호" maxlength="100" />
                                                    </dd>
                                                </dl>
                                            </li>
                                        </ul>
                                    </div>


                                    <div class="tab_form">
                                        <h3>관심 카테고리 선택</h3>
                                        <ol>
                                            <#list categories as category>
                                                <li>
                                                    <input type="checkbox" name="categories" id="nin_category${category_index}" value="${category.categoryId}" class="data checkbox" />
                                                    <label for="nin_category${category_index}">${category.name}</label>
                                                </li>
                                            </#list>

                                        </ol>
                                    </div>
                                </div>
                                </form>
                            </div>
                            <div id="tab2_form" class="tab_form">
                                <form id="frm_${statics["net.xenix.wicrowd.type.InvSortCdType"].INCOME}" method="post" action="" enctype="multipart/form-data">
                                    <input type="hidden" name="invSortCd" value="${statics["net.xenix.wicrowd.type.InvSortCdType"].INCOME}" />
                                    <input type="hidden" name="uploadFile" value="" />
                                <div>
                                    <h3>투자자 정보</h3>
                                    <dl>
                                        <dt>이름</dt>
                                        <dd><input type="text" name="name" text="이름" class="full data" value="" maxlength="20" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>주민등록번호</dt>
                                        <dd><input type="password" name="jumin" text="주민등록번호" class="full chkNum data" placeholder="숫자만 입력해주세요." maxlength="13" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>핸드폰 번호</dt>
                                        <dd><input type="text" name="phone" text="핸드폰 번호" class="full chkNum data" placeholder="숫자만 입력해주세요." value="" maxlength="50" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>신분증 사본</dt>
                                        <dd>
                                            <div class="filebox">
                                                <input type="text" class="upload_name" placeholder="파일 형식은 jpg, png, pdf만 업로드가 가능합니다" disabled="disabled">

                                                <label for="ex_filename5">첨부</label>
                                                <input type="file" id="ex_filename5" name="file1" data-type="image" accept="image/*" class="upload_hidden">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>증빙 자료</dt>
                                        <dd>
                                            <div class="filebox">
                                                <input type="text" class="upload_name" value="" disabled="disabled">

                                                <label for="ex_filename6">첨부</label>
                                                <input type="file" id="ex_filename6" name="file2" class="upload_hidden">
                                            </div>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="mt50">

                                    <div class="tab_form">
                                        <h3>계좌 정보</h3>
                                        <ul>
                                            <li>
                                                <div class="select_box secucoAcopno">
                                                    <label>증권사 선택</label>
                                                    <select name="secucoAcopno" class="data select" text="증권사 선택">
                                                        <option value="">증권사 선택</option>
                                                        <#list acoCodes as acoCode>
                                                            <option value="${acoCode.code}">${acoCode.codeName}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt>계좌번호</dt>
                                                    <dd>
                                                        <input type="text" name="invstrTrsacNo" class="full chkNum data" text="계좌번호" maxlength="100" />
                                                    </dd>
                                                </dl>
                                            </li>
                                        </ul>
                                    </div>


                                    <div class="tab_form">
                                        <h3>관심 카테고리 선택</h3>
                                        <ol>
                                            <#list categories as category>
                                                <li>
                                                    <input type="checkbox" name="categories" id="iin_category${category_index}" value="${category.categoryId}" class="data checkbox" />
                                                    <label for="iin_category${category_index}">${category.name}</label>
                                                </li>
                                            </#list>

                                        </ol>
                                    </div>
                                </div>
                                </form>
                            </div>
                            <div id="tab3_form" class="tab_form">
                                <form id="frm_${statics["net.xenix.wicrowd.type.InvSortCdType"].SPECIAL}" method="post" action="">
                                    <input type="hidden" name="invSortCd" value="${statics["net.xenix.wicrowd.type.InvSortCdType"].SPECIAL}" />
                                    <input type="hidden" name="uploadFile" value="" />

                                <div>
                                    <h3>투자자 정보</h3>
                                    <dl>
                                        <dt>법인명</dt>
                                        <dd><input type="text" name="corporateName" text="법인명" class="full data" maxlength="100" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>사업자 등록번호</dt>
                                        <dd><input type="text" name="businessNum" text="사업자 등록번호" class="full chkNum data" placeholder="숫자만 입력해주세요." maxlength="100" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>법인번호</dt>
                                        <dd><input type="text" name="corporateNum" text="법인번호" class="full chkNum data" placeholder="숫자만 입력해주세요." maxlength="100" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>담당자 이름</dt>
                                        <dd><input type="text" name="managerName" text="담당자 이름" class="full data" maxlength="20" /></dd>
                                    </dl>
                                    <dl>
                                        <dt>담당자 연락처</dt>
                                        <dd><input type="text" name="managerPhone" text="담당자 연락처" class="full chkNum data" placeholder="숫자만 입력해주세요." maxlength="50"/></dd>
                                    </dl>
                                    <dl>
                                        <dt>담당자 이메일</dt>
                                        <dd><input type="text" name="managerEmail" text="담당자 이메일" class="full data" maxlength="100" /></dd>
                                    </dl>
                                    <#--<dl>-->
                                        <#--<dt>사업자등록증</dt>-->
                                        <#--<dd>-->
                                            <#--<div class="filebox">-->
                                                <#--<input type="text" class="upload_name" value="" disabled="disabled">-->

                                                <#--<label for="ex_filename4">첨부</label>-->
                                                <#--<input type="file" id="ex_filename4" name="cfile1" class="upload_hidden">-->
                                            <#--</div>-->
                                        <#--</dd>-->
                                    <#--</dl>-->
                                    <#--<dl>-->
                                        <#--<dt>대표자 신분증</dt>-->
                                        <#--<dd>-->
                                            <#--<div class="filebox">-->
                                                <#--<input type="text" class="upload_name" value="" disabled="disabled">-->

                                                <#--<label for="ex_filename2">첨부</label>-->
                                                <#--<input type="file" id="ex_filename2" name="cfile2" class="upload_hidden">-->
                                            <#--</div>-->
                                        <#--</dd>-->
                                    <#--</dl>-->
                                    <#--<dl>-->
                                        <#--<dt>법인등기부등본</dt>-->
                                        <#--<dd>-->
                                            <#--<div class="filebox">-->
                                                <#--<input type="text" class="upload_name" value="" disabled="disabled">-->

                                                <#--<label for="ex_filename3">첨부</label>-->
                                                <#--<input type="file" id="ex_filename3" name="cfile3" class="upload_hidden">-->
                                            <#--</div>-->
                                        <#--</dd>-->
                                    <#--</dl>-->
                                </div>
                                <div class="mt50">

                                    <div class="tab_form">
                                        <h3>계좌 정보</h3>
                                        <ul>
                                            <li>
                                                <div class="select_box secucoAcopno">
                                                    <label>증권사 선택</label>
                                                    <select name="secucoAcopno" class="select data" text="증권사 선택">
                                                        <option value="">증권사 선택</option>
                                                        <#list acoCodes as acoCode>
                                                            <option value="${acoCode.code}">${acoCode.codeName}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </li>
                                            <li>
                                                <dl>
                                                    <dt class="pl10">계좌번호</dt>
                                                    <dd>
                                                        <input type="text" name="invstrTrsacNo" class="full chkNum data" text="계좌번호" maxlength="100" />
                                                    </dd>
                                                </dl>
                                            </li>
                                        </ul>
                                    </div>


                                    <div class="tab_form">
                                        <h3>관심 카테고리 선택</h3>
                                        <ol>
                                            <#list categories as category>
                                                <li>
                                                    <input type="checkbox" name="categories" id="sin_category${category_index}" value="${category.categoryId}" class="data checkbox" />
                                                    <label for="sin_category${category_index}">${category.name}</label>
                                                </li>
                                            </#list>

                                        </ol>
                                    </div>
                                </div>
                                </form>
                            </div>
                        </div>

                        <div class="thum_wrap post investor">
                            <div class="term_box">
                                <div class="mb20">
                                    <input type="checkbox" name="a1" id="chk_1" class="data checkbox choice_y" value="N" />
                                    <label for="chk_1">개인정보 제 3자에 대한 정보제공에 동의합니다.</label>
                                    <p class="info pl15">아래 내용에 대하여 동의를 거부하실 수 있으며, 거부 시 청약거래 서비스 이용이 제한됩니다.</p>
                                </div>
                                <div>
                                    <p class="pl15 fw-b fs-14 mb10">개인정보 이용내역</p>
                                    <table cellpadding="5" cellspacing="1">
                                        <tbody>
                                        <tr>
                                            <th>제공받는 자</th>
                                            <td>코리아에셋투자증권</td>
                                        </tr>
                                        <tr>
                                            <th>목적</th>
                                            <td>
                                                자본시장과 금융투자업에 관한 법률 등 관계법령에 따라 온라인 소액투자중개업자가 증권발행기업, 한국예탁결제원, 한국증권금융 등
                                                예치기관에 제공하는 투자자 정보의 제공, 조회 등
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>항목</th>
                                            <td>성명, 실명확인번호, 이메일, 휴대폰번호</td>
                                        </tr>
                                        <tr>
                                            <th>보유기간</th>
                                            <td>거래정보등의 제공내용 기록관리내용은 금융실명거래 및 비밀보장에 관한 법률에 따라 5년 보존 후 파기</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bottom">
                    <input id="submitButton" class="btn_type03" id="btn_login" type="button" value="승인요청" />
                </div>
            </div>
        </div>

        <div class="pop_box investor none" >
            <div>
                <div class="pop_wrap">
                    <div class="pop_con">
                        <form>
                            <div class="pop_header">
                                <input type="button" class="close btn_cancel"/>
                                <h2>전문 투자자</h2>
                            </div>
                            <div class="top">
                                <div class="t-l">
                                    <div>
                                        <h3>1.	자본시장법상 전문투자자</h3>
                                        <table cellspacing="1" cellpadding="0">
                                            <colgroup>
                                                <col width="23%" />
                                                <col width="55%" />
                                                <col width="22%" />
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>구분</th>
                                                    <th>내용</th>
                                                    <th>비고</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th rowspan="4">당연 전문 투자자</th>
                                                    <td>1. 국가, 한국은행, 주권상장법인</td>
                                                    <td class="t-c">법 제9조 제5항</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        2. 은행(농•수협 포함), 특수은행(산은, 기은, 수은), 금융투자업자, 보험회사, 종합금융회사, 증권금융회사, 자금중개회사, 금융지주회사,
                                                        여신전문금융회사, 상호저축은행, 산림조합중앙회, 새마을금고 연합회, 신용협동조합중앙회, 이에 준하는 외국금융기관
                                                    </td>
                                                    <td class="t-c">시행령안 제10조 제2항</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        3. 예금보험공사, 정리금융기관, 한국자산관리공사, 한국주택금융공사, 한국투자공사, 금융투자협회, 한국예탁결제원, 거래소, 금융감독원,
                                                        집합투자기구(개별법 펀드 제외), 신용보증기금, 기술보증기금
                                                    </td>
                                                    <td class="t-c">시행령안 제 10조 제3항</td>
                                                </tr>
                                                <tr>
                                                    <td>4. 연기금, 공제법인, 지방자치단체, 해외주권상장국내법인, 외국정부, 국제기구, 외국중앙은행, 3.및 4.에 준하는 외국인</td>
                                                    <td class="t-c">시행령안 제10조 제3항</td>
                                                </tr>
                                                <tr>
                                                    <th rowspan="2">지정전문투자자</th>
                                                    <td>1. 국내법인•단체(금융투자상품잔고 100억원이상 등) 및 이에 준하는 외국법인•단체</td>
                                                    <td rowspan="2" class="t-c">시행령안 제10조 제 3항<br />(제 16, 17호)</td>
                                                </tr>
                                                <tr>
                                                    <td>2. 내국인(금융투자상품잔고 50억원이상 등) 및 이에 준하는 외국인 개인</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="mt30">
                                        <h3>2. 전문성, 위험감수능력을 갖춘 자</h3>
                                        <table cellspacing="1" cellpadding="0">
                                            <colgroup>
                                                <col width="23%" />
                                                <col width="55%" />
                                                <col width="22%" />
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th>구분</th>
                                                <th>내용</th>
                                                <th>비고</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <th>전문가</th>
                                                <td>
                                                    1. 회계법인, 신용평가회사, 발행인에게 회계•자문 등의 용역을 제공하는 공인회계사•감정인•변호사•변리사•세무사,중소기업창업투자회사<br />
                                                    (※증발공 2-1조 제2항에 반영)
                                                </td>
                                                <td rowspan="3" class="t-c">시행령안 제 118조의 15제 10항 (제1호)</td>
                                            </tr>
                                            <tr>
                                                <th>연고자</th>
                                                <td>2. 발행인의 최대주주 등 임원, 우리사주조합원, 계열회사•그 임원, 모집•매출 실적이 없는 주권비상장법인의 주주, 발기인(설립중회사)등</td>
                                            </tr>
                                            <tr>
                                                <th rowspan="3">투자전문그룹</th>
                                                <td>
                                                    3. 개별법(영 제6조 제1항 각호: 창지법, 여전법, 벤특법 등)에 따른 집합 투자기구 (창업투자조합, 신기술사업투자조합, 벤처투자조합 등)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>4. 벤처•창업자에 대한 일정 수준의 투자실적 (2년간 1건 1억 이상 or 2건 이상 4천만원)을 보유한 적격엔젤투자자</td>
                                                <td class="t-c">(제2호)</td>
                                            </tr>
                                            <tr>
                                                <td>5. 벤특법상 개인투자조합 및 전문엔젤투자자 등<br />(증발공 2-2조의 3 제 2항에 반영)</td>
                                                <td class="t-c">금융위 고시</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <p class="mt30">*시행령 이하 사항은 현재 개정절차가 진행되고 있으므로 향후 변경될 가능성이 있음</p>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>

    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript" src="/js/user/investor_form.js"></script>
    <script>
        var projectId = '${(projectId) !}';
    </script>
    </@layout.put>

</@layout.extends>