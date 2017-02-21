<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">
    <style type="text/css">

    </style>
    </@layout.put>
    <@layout.put block="contents">
    <!-- START JUMBOTRON -->
    <div class="jumbotron" data-pages="parallax">
        <div class="container-fixed-lg">
            <div class="row">
                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a>Home</a></li>
                    <li><a>Project</a></li>
                    <li><a class="active">Add</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="col-lg-4 no-padding m-b-10">
                            <h3>Project</h3>
                            <p>WiCrowd 투자모집 등록 페이지 입니다.</p>
                        </div>
                        <div class="col-lg-8 m-t-35 p-r-25 t-r">
                            <a href="/project/${(project.projectId) !}/excel?dType=0" class="btn btn-success">투자자청약내역관리</a>
                            <a href="/project/${(project.projectId) !}/excel?dType=1" class="btn btn-success">계좌유효성확인(중개업자)</a>
                            <a href="/project/${(project.projectId) !}/excel?dType=2" class="btn btn-success">모집최종결과</a>
                            <#--<a href="/project/${(project.projectId) !}/excel?dType=3" class="btn btn-success">청약신청명세서</a>-->
                            <a href="/project/${(project.projectId) !}/excel?dType=4" class="btn btn-success">증권금융입금계좌</a>
                            <a href="#" class="btn btn-success project-info">모집정보</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->

    <!-- START CONTAINER FLUID -->
    <div class="container-fluid container-fixed-lg">
        <div id="rootwizard">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs nav-tabs-linetriangle nav-tabs-separator nav-stack-sm">
                <li class="active">
                    <a data-toggle="tab" href="#tab1"><i class="fa fa-file-text tab-icon"></i> <span>Basic Information</span></a>
                </li>
                <#--<li <#if !(project)?exists>style="display: none;"</#if>>-->
                    <#--<a data-toggle="tab" href="#update" url="/project/update/list?projectId=${(project.projectId) !}"><i class="fa fa-list-alt tab-icon"></i> <span>Project Update</span></a>-->
                <#--</li>-->
                <#--<li <#if !(project)?exists>style="display: none;"</#if>>-->
                    <#--<a data-toggle="tab" href="#feedback" url="/project/feedback/list?projectId=${(project.projectId) !}"><i class="fa fa-list-alt tab-icon"></i> <span>Project Feedback</span></a>-->
                <#--</li>-->
                <#--<li <#if !(project)?exists>style="display: none;"</#if>>-->
                    <#--<a data-toggle="tab" href="#investors" url="/project/investors/list?projectId=${(project.projectId) !}"><i class="fa fa-list-alt tab-icon"></i> <span>Investors</span></a>-->
                <#--</li>-->
            </ul>

            <!-- START PANEL -->
            <div class="tab-content">
                <div class="tab-pane padding-20 active slide-left" id="tab1">
                    <form id="frmData" role="form" autocomplete="off">

                        <input type="hidden" name="projectId" value="${(project.projectId) !}" />
                        <input type="hidden" id="form_type" value="${(project.projectId) !}" />
                        <input type="hidden" id="projectContent" value="${(project.content?html) !}" />
                        <input type="hidden" id="mainImage" name="mainImage" value="${(mainProjectImageJson?html) !}" />


                        <div class="clearfix padding-10">
                            <button class="btn btn-primary btn-cons pull-right m-b-10" type="submit">
                                <i class="pg-form"></i>
                                <span class="bold">Submit</span>
                            </button>
                            <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                                <i class="pg-form"></i>
                                <span class="bold">List</span>
                            </button>
                            <a href="http://wicrowd.co.kr/project/${(project.projectId) !}" target="_blank" class="btn btn-primary btn-cons pull-right m-b-10 go-preview">
                                <i class="pg-form"></i>
                                <span class="bold">Preview</span>
                            </a>
                            <button class="btn btn-primary btn-cons pull-right m-b-10 sbsc-info-btn" type="button">
                                <i class="pg-form"></i>
                                <span class="bold">청약정보등록</span>
                            </button>
                        </div>

                        <div class="row m-t-10">
                            <div class="col-md-6" style="padding-left:0;">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>카테고리</label><br/>
                                                    <select class="cs-select cs-skin-slide" name="categoryId" data-init-plugin="cs-select">
                                                        <#list categories as category>
                                                            <option value="${category.categoryId}" <#if project?exists && category.categoryId == project.category.categoryId>selected</#if>>${category.name}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>발행인</label><br/>
                                                    <select class="cs-select cs-skin-slide" name="userId" data-init-plugin="cs-select">
                                                        <#list publishers as publisher>
                                                            <option value="${publisher.userId}" <#if project?exists && publisher.userId == project.user.userId>selected</#if>>${publisher.name}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>기업단계</label><br/>
                                                    <select class="cs-select cs-skin-slide" name="publisherStage" data-init-plugin="cs-select">
                                                        <#list stgCodes as stgCode>
                                                            <option value="${stgCode.code}" <#if project?exists && stgCode.code == project.publisherStage?default('')>selected</#if>>${stgCode.codeName}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>상태</label><br/>
                                                    <select class="cs-select cs-skin-slide" name="status" data-init-plugin="cs-select">
                                                        <option value="visible" <#if project?exists == false || (project.status) == "visible">selected</#if>>보임</option>
                                                        <option value="invisible" <#if project?exists == true && project.status == "invisible">selected</#if>>안보임</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>모집상태</label><br/>
                                                    <select class="cs-select cs-skin-slide" name="successState" data-init-plugin="cs-select">
                                                        <option value="ready" <#if project?exists == false || project.successState == "ready">selected</#if>>대기</option>
                                                        <option value="ing" <#if project?exists == false || project.successState == "ing">selected</#if>>진행중</option>
                                                        <option value="success" <#if project?exists == true && project.successState == "success">selected</#if>>성공</option>
                                                        <option value="fail" <#if project?exists == true && project.successState == "fail">selected</#if>>실패</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>대표 이름</label>
                                                    <input type="text" name="ceoName" class="form-control" value="${(project.ceoName) !}" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>투자모집제목</label>
                                            <input type="text" name="name" class="form-control" value="${(project.name) !}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>모집명</label>
                                            <input type="text" name="sbscIssNm" class="form-control" value="${(project.sbscIssNm) !}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>위치</label>
                                            <input type="text" name="location" class="form-control" value="${(project.location) !}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>노출 멘트</label>
                                            <input type="text" name="comment" class="form-control" value="${(project.comment) !}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>모집요약</label>
                                            <textarea name="summary" class="form-control" style="min-height:100px;;" required>${(project.summary) !}</textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>모집설명</label>
                                            <textarea name="description" class="form-control" style="min-height:100px;;" required>${(project.description) !}</textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>메인 이미지</label>
                                            <div id="main_image_div" style="background-image: url(<#if mainProjectImage?exists>${mainProjectImage.url}<#else >'/assets/img/gallery/2_1.jpg'</#if>);background-size: contain;background-repeat: no-repeat;margin-bottom: 13px;min-height: 285px;"></div>
                                            <input type="file" name="main_image" id="main_image" class="form-control" <#if !mainProjectImage?exists>required</#if>>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6" style="padding-right:0;">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>담당자명</label>
                                                        <input type="text" name="managerName" class="form-control" value="${(project.managerName) !}" required>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>담당자 직급</label>
                                                        <input type="text" name="managerPosition" class="form-control" value="${(project.managerPosition) !}" required>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>담당자 연락처</label>
                                                        <input type="text" name="managerPhone" class="form-control" value="${(project.managerPhone) !}" required>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>청약종목번호 <#if project?exists && project.sbscIssNo?exists><a href="javascript:deleteSbscInfo(${(project.sbscIssNo) !})">[삭제]</a></#if></label>
                                                        <input type="text" name="sbscIssNo" readonly class="form-control" value="${(project.sbscIssNo) !}" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>업종</label>
                                                        <input type="text" name="business" class="form-control" value="${(project.business) !}" required>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>소재지</label>
                                                        <input type="text" name="address" class="form-control" value="${(project.address) !}" required>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>임직원 수</label>
                                                        <input type="text" name="staff" class="form-control" value="${(project.staff) !}" required>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group">
                                                        <label>설립일</label>
                                                        <div class="datepicker-component input-group date">
                                                            <input type="text" name="establishDate" class="form-control" value="${(project.establishDate) !}" data-format="yyyymmdd" required>
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>모집 방법</label>
                                                        <div class="radio radio-success">
                                                            <input type="radio" name="subscribeType" value="1" id="subscribeType02" <#if (project.subscribeType)?default("1") == "1">checked</#if> />
                                                            <label for="subscribeType02">공모</label>
                                                            <input type="radio" name="subscribeType" value="2" id="subscribeType01" <#if (project.subscribeType)?default("1") == "2">checked</#if> />
                                                            <label for="subscribeType01">사모</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>배정방법</label>
                                                        <div class="radio radio-success">
                                                            <input type="radio" name="assignType" value="정율" id="assignType01" <#if (project.assignType)?default("정율") == "정율">checked</#if> />
                                                            <label for="assignType01">정율</label>
                                                            <input type="radio" name="assignType" value="정액" id="assignType02" <#if (project.assignType)?default("정율") == "정액">checked</#if> />
                                                            <label for="assignType02">정액</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>증거금 입금계좌 타입</label>
                                                        <div class="radio radio-success">
                                                            <input type="radio" name="depositType" value="보호예수" id="depositType01" <#if (project.depositType)?default("보호예수") == "보호예수">checked</#if> />
                                                            <label for="depositType01">보호예수</label>
                                                            <input type="radio" name="depositType" value="예탁" id="depositType02" <#if (project.depositType)?default("보호예수") == "예탁">checked</#if> />
                                                            <label for="depositType02">예탁</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <label>증거금 입금계좌</label>
                                                        <input type="text" name="depositAccno" class="form-control" value="${(project.depositAccno) !}" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>청약개시일</label>
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="sbscStDt" class="form-control" value="${(project.sbscStDt) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>청약종료일</label>
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="sbscNdDt" class="form-control" value="${(project.sbscNdDt) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>종목코드 </label>
                                                    <input type="text" name="isin" class="form-control" value="${(project.isin) !}" required>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>증권 구분</label>
                                                    <div class="radio radio-success">
                                                        <#list secnTpcdCodes as secnTpcdCode>
                                                        <input type="radio" name="secnTpcd" value="${(secnTpcdCode.code) !}" id="secnTpcd${secnTpcdCode_index + 1}" <#if project?exists && secnTpcdCode.code == project.secnTpcd>checked<#elseif secnTpcdCode_index == 0>checked</#if>/>
                                                        <label for="secnTpcd${secnTpcdCode_index + 1}">${(secnTpcdCode.codeName) !}</label>
                                                        </#list>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>증권종류</label>
                                                    <div class="radio radio-success">
                                                        <input type="radio" name="stockType" value="우선주" id="stockType01" <#if (project.stockType)?default("우선주") == "우선주">checked</#if> />
                                                        <label for="stockType01">우선주</label>
                                                        <input type="radio" name="stockType" value="보통주" id="stockType02" <#if (project.stockType)?default("우선주") == "보통주">checked</#if> />
                                                        <label for="stockType02">보통주</label>
                                                        <input type="radio" name="stockType" value="일반회사채" id="stockType03" <#if (project.stockType)?default("우선주") == "일반회사채">checked</#if> />
                                                        <label for="stockType03">일반회사채</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>발행증권종류</label>
                                                    <div class="radio radio-success">
                                                        <#list pblSctsKndCodes as pblSctsKndCode>
                                                        <input type="radio" name="pblSctsKnd" value="${(pblSctsKndCode.code) !}" id="pblSctsKnd${pblSctsKndCode_index + 1}" <#if project?exists && pblSctsKndCode.code == project.pblSctsKnd>checked<#elseif pblSctsKndCode_index == 0>checked</#if> />
                                                        <label for="pblSctsKnd${pblSctsKndCode_index + 1}">${(pblSctsKndCode.codeName) !}</label>
                                                        </#list>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>증권납입계좌 은행</label>
                                                    <select class="cs-select cs-skin-slide" name="pblBnkCd" data-init-plugin="cs-select">
                                                        <#list bnkCodes as bnkCode>
                                                            <option value="${bnkCode.code}" <#if project?exists && bnkCode.code == project.pblBnkCd>selected</#if>>${bnkCode.codeName}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>증권납입계좌 예금주</label>
                                                    <div class="required">
                                                        <input type="text" name="pblAcnoNm" class="form-control" value="${(project.pblAcnoNm) !}" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>증권납입계좌번호</label>
                                                    <div class="required">
                                                        <input type="text" name="pblAcno" class="form-control" value="${(project.pblAcno) !}" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>발행전 주식수</label>
                                                    <div class="required">
                                                        <input type="text" name="corpStockString" class="form-control number" value="${(project.corpStock?string?number) !}" required>
                                                        <input type="hidden" name="corpStock" class="form-control" value="${(project.corpStock?eval) !}">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>최대 투자자 수</label>
                                                    <div class="required">
                                                        <input type="text" name="maxSbscCountString" class="form-control number" value="${(project.maxSbscCount) !}" required>
                                                        <input type="hidden" name="maxSbscCount" class="form-control" value="${(project.maxSbscCount?c) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>최소 수량</label>
                                                    <div class="required">
                                                        <input type="text" name="minSbscCountString" class="form-control number" value="${(project.minSbscCount) !}" required>
                                                        <input type="hidden" name="minSbscCount" class="form-control" value="${(project.minSbscCount?c) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>배당지분율</label>
                                                    <div class="required">
                                                        <input type="text" name="shareRatio" class="form-control" value="${(project.shareRatio) !}" required>
                                                    </div>
                                                </div>
                                            </div>
                                        <#--<div class="col-sm-3">-->
                                        <#--<div class="form-group">-->
                                        <#--<label>주당 인수 희망가격</label>-->
                                        <#--<div class="required">-->
                                        <#--<input type="text" name="expectationPrice" class="form-control" value="${(project.expectationPrice) !}">-->
                                        <#--</div>-->
                                        <#--</div>-->
                                        <#--</div>-->
                                        </div>
                                        <div class="row">

                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>모집가액</label>
                                                    <div class="required">
                                                        <input type="text" name="targetAmtString" class="form-control number" value="${(project.targetAmt) !}" required>
                                                        <input type="hidden" name="targetAmt" class="form-control" value="${(project.targetAmt?c) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>모집수량</label>
                                                    <div class="required">
                                                        <input type="text" name="targetStockQtyString" class="form-control number" value="${(project.targetStockQty) !}" required>
                                                        <input type="hidden" name="targetStockQty" class="form-control" value="${(project.targetStockQty?c) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>발행가액</label>
                                                    <div class="required">
                                                        <input type="text" name="targetStockPriceString" class="form-control number" value="${(project.targetStockPrice) !}" required>
                                                        <input type="hidden" name="targetStockPrice" class="form-control" value="${(project.targetStockPrice?c) !}">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>액면가액</label>
                                                    <div class="required">
                                                        <input type="text" name="faceValueString" class="form-control number" value="${(project.faceValue) !}" required>
                                                        <input type="hidden" name="faceValue" class="form-control" value="${(project.faceValue?c) !}">
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>기업 가치 </label>
                                                    <input type="text" name="companyValue" class="form-control" value="${(project.companyValue) !}" required>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>소득공제 유무</label>
                                                    <div class="radio radio-success">
                                                        <input type="radio" name="taxDeduction" value="Y" id="taxDeductionY" <#if project?exists><#if project.taxDeduction?default("Y") == "Y">checked</#if><#else>checked</#if> />
                                                        <label for="taxDeductionY">Y</label>
                                                        <input type="radio" name="taxDeduction" value="N" id="taxDeductionN" <#if project?exists && project.taxDeduction?default("Y") == "N">checked</#if>/>
                                                        <label for="taxDeductionN">N</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label>투자 가이드 </label>
                                                    <input type="text" name="investNotice" class="form-control" value="${(project.investNotice) !}" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>발행일</label>
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="publishDate" class="form-control" value="${(project.publishDate) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>교부일</label>
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="issueDate" class="form-control" value="${(project.issueDate) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>납기일</label>
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="deadlineDate" class="form-control" value="${(project.deadlineDate) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>납부일</label>
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="pmtDt" class="form-control" value="${(project.pmtDt) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label>환불일</label>
                                                    <div class="datepicker-component input-group date">
                                                        <input type="text" name="rfnDt" class="form-control" value="${(project.rfnDt) !}" data-format="yyyymmdd" required>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <#if project?exists>
                    <h5>
                        첨부파일 업로드
                        <button class="btn btn-success btn-cons btn_addfile" style="min-width: 50px; margin-left: 10px;">
                            <i class="fa fa-plus"></i>
                        </button>
                    </h5>
                    <div class="row">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-sm-6">
                                    <div id="add_file_list">
                                        <#if project.files?has_content>
                                            <#list project.files as file >
                                                <div class="add_file_div" fileId="${(file.fileId) !}">
                                                    <div class="form-group">
                                                        <label style="display: block;">파일 이름</label>
                                                        <input type="text" name="file_name[]" class="form-control file_name" readonly value="${(file.fileName) !}" style="display:inline-block; width: 90%;">
                                                        <button class="btn btn-danger btn-cons btn-del-file" style="min-width: 50px; float: right;">
                                                            <i class="fa fa-close"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </#list>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h5>이미지 업로드</h5>
                    <div class="row">
                        <div class="panel-body no-scroll no-padding">
                            <form action="/project/upload" class="dropzone no-margin" id="dropzone-image" projectId="${(project.projectId) !}">
                                <div class="fallback">
                                    <input name="imageFile" type="file" accept="image/*" multiple />
                                </div>
                            </form>
                        </div>
                    </div>
                    </#if>
                    <#--<div class="row xeditor m-t-20">-->
                        <#--<div class="panel panel-default">-->
                            <#--<div class="panel-body no-padding">-->
                                <#--&lt;#&ndash;<div class="editor_header">&ndash;&gt;-->
                                    <#--&lt;#&ndash;<div class="editor_btn">&ndash;&gt;-->
                                        <#--&lt;#&ndash;<ul class="edit_btn">&ndash;&gt;-->
                                            <#--&lt;#&ndash;<li>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<button id="text2" class="btn_icon btn_text" onclick="addLink()">Link</button>&ndash;&gt;-->
                                            <#--&lt;#&ndash;</li>&ndash;&gt;-->
                                            <#--&lt;#&ndash;<li>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<button id="text2" class="btn_icon btn_text" onclick="addTextHeader()">Header</button>&ndash;&gt;-->
                                            <#--&lt;#&ndash;</li>&ndash;&gt;-->
                                            <#--&lt;#&ndash;<li>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<button id="text2" class="btn_icon btn_text" onclick="addTextNormal()">Normal</button>&ndash;&gt;-->
                                            <#--&lt;#&ndash;</li>&ndash;&gt;-->
                                            <#--&lt;#&ndash;<li>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<button id="text2" class="btn_icon btn_text" onclick="addTextQuote()">Quote</button>&ndash;&gt;-->
                                            <#--&lt;#&ndash;</li>&ndash;&gt;-->
                                            <#--&lt;#&ndash;<li>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<button class="btn_icon btn_img" onclick="addImage()">Image</button>&ndash;&gt;-->
                                            <#--&lt;#&ndash;</li>&ndash;&gt;-->
                                            <#--&lt;#&ndash;<li>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<button class="btn_icon btn_video" onclick="addVideo()">Video</button>&ndash;&gt;-->
                                            <#--&lt;#&ndash;</li>&ndash;&gt;-->
                                            <#--&lt;#&ndash;<li>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<button class="btn_icon btn_video" onclick="addYoutube()">Youtube</button>&ndash;&gt;-->
                                            <#--&lt;#&ndash;</li>&ndash;&gt;-->
                                        <#--&lt;#&ndash;</ul>&ndash;&gt;-->
                                    <#--&lt;#&ndash;</div>&ndash;&gt;-->
                                <#--&lt;#&ndash;</div>&ndash;&gt;-->
                                <#--&lt;#&ndash;<input id="coverFile" type="file" name="file" style="display:none" accept=".gif, .jpg, .png, .mov, .mp4, .avi"/>&ndash;&gt;-->
                                <#--&lt;#&ndash;<input id="imageFile" type="file" name="file" style="display:none" accept="image/*" multiple/>&ndash;&gt;-->
                                <#--&lt;#&ndash;<input id="videoFile" type="file" name="file" style="display:none" accept="video/*" multiple/>&ndash;&gt;-->

                                <#--&lt;#&ndash;<div id="xeditor" class="x_container"></div>&ndash;&gt;-->


                                <#--<div class="summernote-wrapper">-->
                                    <#--<div id="summernote" style="min-height: 200px;">${(project.content) !}</div>-->
                                <#--</div>-->

                            <#--</div>-->
                        <#--</div>-->
                    <#--</div>-->

                    <#--<div class="clearfix padding-10">-->
                        <#--<button class="btn btn-primary btn-cons pull-right m-b-10" id="formSubmitBtn" type="button">-->
                            <#--<i class="pg-form"></i>-->
                            <#--<span class="bold">Submit</span>-->
                        <#--</button>-->
                        <#--<button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">-->
                            <#--<i class="pg-form"></i>-->
                            <#--<span class="bold">List</span>-->
                        <#--</button>-->
                        <#--<button class="btn btn-primary btn-cons pull-right m-b-10 sbsc-info-btn" type="button">-->
                            <#--<i class="pg-form"></i>-->
                            <#--<span class="bold">청약정보등록</span>-->
                        <#--</button>-->
                    <#--</div>-->
                </div>

                <div class="tab-pane padding-20 slide-left" id="update">


                </div>

                <div class="tab-pane padding-20 slide-left" id="feedback">

                </div>

                <div class="tab-pane padding-20 slide-left" id="investors">

                </div>

            </div>
        </div>
    </div>


    <!-- Modal -->
    <div class="modal fade slide-up disable-scroll" id="infoFormDiv" tabindex="-1" role="dialog" aria-hidden="false">
        <div class="modal-dialog ">
            <div class="modal-content-wrapper">
                <div class="modal-content">
                    <div class="modal-header clearfix text-left">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="pg-close fs-14"></i>
                        </button>
                        <h5>모집 정보 다운로드</h5>
                    </div>
                    <div class="modal-body">
                        <p>
                            파일을 만드는데 시간이 오래 걸릴 수 있습니다. <br/>파일 생성 완료 후 아래 생성되는 다운로드 링크를 클릭하여 해당 파일을 다운로드 해주세요.
                        </p>
                        <p>
                            <a href="#" id="project_info_download"></a>
                        </p>
                        <div class="progress">
                            <div id="progress_div" class="progress-bar-indeterminate"></div>
                        </div>
                    <#--<div class="row">-->
                    <#--<div class="col-sm-8">-->
                    <#--<div class="p-t-20 clearfix p-l-10 p-r-10">-->
                    <#--<div class="pull-left">-->

                    <#--</div>-->
                    <#--<div class="pull-right">-->

                    <#--</div>-->
                    <#--</div>-->
                    <#--</div>-->
                    <#--<div class="col-sm-4 m-t-10 sm-m-t-10">-->
                    <#--<button type="button" class="btn btn-primary btn-block m-t-5 btn_admin_submit">확인</button>-->
                    <#--</div>-->
                    <#--</div>-->
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
    </div>



    </@layout.put>





    <@layout.put block="script">

    <script src="/assets/plugins/boostrap-form-wizard/js/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
    <script src="/assets/js/form_wizard.js" type="text/javascript"></script>
    <script src="/assets/plugins/dropzone/dropzone.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var mainId = 2, subId = 0;
        var projectId = '${(project.projectId)!}';

        $( document ).ready(function()
        {
            $('#summernote').summernote({
                height : 600,
                onImageUpload : function(files, editor, welEditable) {
                    var formData = new FormData();
                    formData.append("file", files[0]);

                    console.log(files[0]);

                    var xUpload = new XUpload();
                    var uploadResult = xUpload.crossUpload(formData, function (data) {
                        editor.insertImage(welEditable, data.url);
                    });
                },
                oninit : function () {
                    $('.note-editable').css('min-height','300px');
                }
            });


            $('.project-info').click(function () {
                $('#infoFormDiv').modal('show');

                $.ajax({
                    url: "/project/"+projectId+"/info",
                    type: "GET",
                    dataType: 'json',
                    data: '',
                    success: function (result) {
                        //location.reload();
                        console.log(result);
                        //$('#progress_div').attr('class', 'progress-bar');
                        $('.progress').remove();
                        $('#project_info_download').text(result.url);
                        $('#project_info_download').attr('href', result.url);
                    }
                });
            });




            $('.btn_addfile').click(function () {
                var innerHtml = '';
                innerHtml += '<div class="add_file_div">';
                innerHtml += '<div class="form-group">';
                innerHtml += '<label style="display: block;">파일 이름</label>';
                innerHtml += '<input type="text" name="file_name[]" class="form-control file_name" value="" style="display:inline-block; width: 90%;">';
                innerHtml += '<button class="btn btn-danger btn-cons btn-del-file" style="min-width: 50px; float: right;"><i class="fa fa-close"></i></button>';
                innerHtml += '</div>';
                innerHtml += '<div class="form-group">';
                innerHtml += '<input type="file" name="files[]" class="form-control files" value="">';
                innerHtml += '</div>';
                innerHtml += '</div>';

                $('#add_file_list').append(innerHtml);
            });

            $(document).on('click', '.btn-del-file', function(){
                var fileId = $(this).parent().parent('.add_file_div').attr('fileId');
                var addFileDiv = $(this).parent().parent('.add_file_div');

                if(fileId == undefined) {
                    $(addFileDiv).remove();
                }
                else {
                    NoticeCommon.Dialog.confirm({
                        content: '선택된 파일을 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/project/file?fileId="+fileId+"&dropzoneId=dropzone-attached",
                                type: "DELETE",
                                dataType: 'json',
                                data: '',
                                success: function (result) {
                                    //location.reload();
                                    console.log(result);
                                    $(addFileDiv).remove();
                                }
                            });
                        }
                    });
                }
            });

            $('.go-list').click(function () {
                document.location.href = '/project/list';
            });

            $('.sbsc-info-btn').click(function () {
                var sbscIssNm = '${(project.sbscIssNm) !}'
                if(sbscIssNm == '') {
                    NoticeCommon.Dialog.alert('모집명을 등록해주세요.');
                }
                else {
                    var sbscIssNo = $('input[name=sbscIssNo]').val();
                    NoticeCommon.Dialog.confirm({
                        content: '청약정보를 입력하시겠습니까?'
                        ,ok: function(){
                            var projectId = $('input[name=projectId]').val();
                            $.ajax({
                                url: "/project/insertSbscInfo",
                                type: "POST",
                                dataType: 'json',
                                data: 'projectId='+projectId+'&sbscIssNo='+sbscIssNo,
                                success: function (result) {
                                    //location.reload();
                                    console.log(result);

                                    if(result.success) {
                                        NoticeCommon.Dialog.alert('청약정보등록 성공하였습니다.');

                                        $('input[name=sbscIssNo]').val(result.sbscIssNo);
                                        //$('.sbsc-info-btn').addClass('disabled');
                                    }
                                    else {
                                        NoticeCommon.Dialog.alert(result.message);
                                    }
                                }
                            });
                        }
                    });
                }
            });


            Dropzone.options.dropzoneAttached = {
                dictDefaultMessage: "test",
                addRemoveLinks: true,
                init: function () {
                    <#if project?exists>
                        <#list project.files as file>
                            var mockFile = {
                                name: "${(file.fileName) !}",
                                size: "${(file.fileSize?c) !}",
                                status: Dropzone.ADDED,
                                projectId: "${(file.projectId) !}",
                                fileId: "${(file.fileId) !}",
                                dropzoneId: 'dropzone-attached'
                            };

                            // Call the default addedfile event handler
                            this.emit("addedfile", mockFile);

                            // And optionally show the thumbnail of the file:
                            this.emit("thumbnail", mockFile, openFile('${(file.fileName) !}', '${(file.url) !}'));

                            this.emit("success", mockFile);
                            this.emit("complete", mockFile);
                            this.files.push(mockFile);
                        </#list>
                    </#if>
                }
            }

            Dropzone.options.dropzoneImage = {
                dictDefaultMessage: "test",
                addRemoveLinks: true,
                acceptedFiles: 'image/*',
                init: function () {
                    <#if project?exists>
                        <#list project.images as image>
                            <#if image.imageType != "main">
                                var mockFile = {
                                    name: "${(image.fileName) !}",
                                    size: "${(image.fileSize?c) !}",
                                    status: Dropzone.ADDED,
                                    projectId: "${(image.projectId) !}",
                                    fileId: "${(image.imageId) !}",
                                    dropzoneId: 'dropzone-image'
                                };

                                // Call the default addedfile event handler
                                this.emit("addedfile", mockFile);

                                // And optionally show the thumbnail of the file:
                                this.emit("thumbnail", mockFile, openFile('${(image.fileName) !}', '${(image.url) !}'));

                                this.emit("success", mockFile);
                                this.emit("complete", mockFile);
                                this.files.push(mockFile);
                            </#if>
                        </#list>
                    </#if>
                }
            }




            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("href") // activated tab
                var url = $(e.target).attr("url") // activated tab

                $(target).load(url, function(responseTxt, statusTxt, xhr){

                    if(statusTxt == "success") {

                        //alert("Error: " + xhr.status + ": " + xhr.statusText);

                    }

                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });

            $('input.number').keyup(function(event) {

                // skip for arrow keys
                if(event.which >= 37 && event.which <= 40) return;

                // format number
                $(this).val(function(index, value) {
                    return value
                            .replace(/\D/g, "")
                            .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                            ;
                });
            });


            $('#main_image').change(function () {
                var formData = new FormData();
                var mainImageObj = {
                    'fileName': $(this)[0].files[0].name,
                    'fileSize': $(this)[0].files[0].size
                };

                formData.append("file", $(this)[0].files[0]);

                console.log($(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    $("#main_image_div").css('background-image',"url("+data.url+")");

                    mainImageObj.url = data.url;
                    mainImageObj.width = data.width;
                    mainImageObj.height = data.height;

                    $('#mainImage').val(JSON.stringify(mainImageObj));
                });
            });


            $(document).on('change', '.files', function () {
                var addFileDiv = $(this).parents('.add_file_div');
                var fileName = $(this).parent().prev().find('.file_name').val();
                if(fileName == '') {
                    fileName = $(this)[0].files[0].name;
                }

                var fileSize = $(this)[0].files[0].size;
                var formData = new FormData();
                formData.append("file", $(this)[0].files[0]);

                var xUpload = new XUpload();
                var uploadResult = xUpload.crossUpload(formData, function (data) {
                    var projectId = $('input[name=projectId]').val();
                    var dropzoneId = 'dropzone-attached';

                    data.fileName = fileName;
                    data.fileSize = fileSize;

                    console.log(data);

                    $.ajax({
                        url: '/project/upload',
                        type: 'POST',
                        dataType: 'json',
                        data: 'uploadedFile='+JSON.stringify(data)+'&projectId='+projectId+'&dropzoneId='+dropzoneId,
                        error: function (result) {
                            console.log(result);
                        },
                        success: function (result) {
                            console.log(result);

                            $(addFileDiv).attr('fileId', result.file.fileId);
                        }
                    });

                });

//                if(/\s/g.test(fileName)) {
//                    NoticeCommon.Dialog.alert('띄어쓰기가 있는 파일은 업로드 할 수 없습니다.');
//                    $(this).val('');
//                }
//                else {
//
//                }
            });


            $('#frmData').submit(function(){
                //var content = save();
                var alert_message = '등록 성공하였습니다.';

                if($('#form_type').val())
                {
                    alert_message = '수정 성공하였습니다.';
                }

                // set string to number
                $('input[name=targetAmt]').val(setStringToNumber($('input[name=targetAmtString]').val()));
                $('input[name=maxSbscCount]').val(setStringToNumber($('input[name=maxSbscCountString]').val()));
                $('input[name=faceValue]').val(setStringToNumber($('input[name=faceValueString]').val()));
                $('input[name=minSbscCount]').val(setStringToNumber($('input[name=minSbscCountString]').val()));
                $('input[name=targetStockQty]').val(setStringToNumber($('input[name=targetStockQtyString]').val()));
                $('input[name=targetStockPrice]').val(setStringToNumber($('input[name=targetStockPriceString]').val()));
                $('input[name=corpStock]').val(setStringToNumber($('input[name=corpStockString]').val()));

                var formData = new FormData($('#frmData')[0]);
                //formData.append("content", $('#summernote').code());

                $.ajax({
                    url: '/project/form',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);

                        if($('#form_type').val())
                        {
                            alert('수정 성공하였습니다.');
                        }
                        else {
                            alert('등록 성공하였습니다.');
                            location.href = '/project/form?projectId='+result.projectId;
                        }
                    }
                });
                return false;
            });

            $('#formSubmitBtn').click(function () {

                console.log($('#frmData').validate());

                if($('#frmData').validate()) {
                    $('#frmData').trigger('submit');
                }

            });


        });

        function setStringToNumber(val, sel) {
            return val.replace(/,/gi, '');
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function deleteSbscInfo() {
            var sbscIssNo = $('input[name=sbscIssNo]').val();
            NoticeCommon.Dialog.confirm({
                content: '청약정보를 삭제하시겠습니까?'
                ,ok: function(){
                    var projectId = $('input[name=projectId]').val();
                    $.ajax({
                        url: "/project/insertSbscInfo",
                        type: "POST",
                        dataType: 'json',
                        data: 'projectId='+projectId+'&sbscIssNo='+sbscIssNo+'&flag=delete',
                        success: function (result) {
                            //location.reload();
                            console.log(result);

                            if(result.success) {
                                NoticeCommon.Dialog.alert('청약정보삭제 성공하였습니다.');

                                $('input[name=sbscIssNo]').val('');
                            }
                            else {
                                NoticeCommon.Dialog.alert(result.message);
                            }
                        }
                    });
                }
            });
        }

        function openFile(fileName, fileUrl) {
            var extension = fileName.substr( (fileName.lastIndexOf('.') +1)).toLowerCase();
            switch(extension) {
                case 'jpg':
                case 'png':
                case 'gif':
                    return fileUrl;
                    break;                         // the alert ended with pdf instead of gif.
                case 'doc':
                case 'docx':
                    return '/assets/img/local/ic_doc.png';
                    break;
                case 'pdf':
                    return '/assets/img/local/ic_pdf.png'
                    break;
                default:
                    return '/assets/img/local/ic_file.png';
            }
        }


    </script>
    </@layout.put>
</@layout.extends>