<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title>WiCrowd - 청약 신청</title>
    <meta name="author" content="WICROWD" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
</head>
<body style="font-family:'돋움','dotum','굴림','Gulim';">
<div style="width:660px; padding:50px;; background-color:#f5f5f5;">
    <div style="width:100%;padding-left:10px;">
        <img src="https://wicrowd.co.kr/files/images/20160405/317b514029fb16e4553dcbe402d28172.png">
        <span style="font-size:14px; color:#353535; font-weight:bold; position:relative;">청약 신청</span>
    </div>
    <div style="width:100%; border-top:1px solid #e1e1e1; border-bottom:1px solid #e1e1e1; margin-top:10px;">
        <div style="margin:0px; padding:30px 50px; font-size:14px; letter-spacing:-1px; color:#353535; font-weight:normal; line-height:24px; ">
            <p>안녕하세요. 위크라우드입니다.</p>
            <p>
                <strong>${userName !}</strong> 님의 <strong>${company !}</strong> 청약신청이 접수되었습니다.
            </p>
            <ul>
                <li style="margin-bottom: 5px;">발행기업명: <strong>${company !}</strong></li>
                <li style="margin-bottom: 5px;">청약 금액: <strong>${resultPrice !}</strong></li>
                <li style="margin-bottom: 5px;">접수 날짜: <strong>${regDate?date?string('yyyy.MM.dd') !}</strong></li>
            </ul>
            <p style="margin-top:30px;">
                <strong>${company !}</strong>의 청약 모집 마감 예정일은 <strong>${sbscNdDt?date("yyyyMMdd")?string("yyyy.MM.dd") !}</strong> 입니다.<br />
                추후 펀딩 진행 사항이 메일로 전달 될 예정이니 참고하시기 바랍니다.<br />
                위크라우드를 이용해 주셔서 감사합니다.
            </p>
        </div>
    </div>

    <div style="position:relative; margin-top:20px;">
        <table cellpadding="0" cellspacing="0" style="width:100%">
            <tr>
                <td width="80%">
                    <p style="font-size:12px; color:#959595; letter-spacing:-1.2px;  line-height:17px">
                        이 메일은 발신 전용 메일입니다.</br>
                        위크라우드 이용에 대한 문의 사항이나 불편 사항은 고객센터로 문의해 주세요.
                    </p>
                    <div style="font-size:12px; overflow:hidden;">
                        <p style="margin:5px 8px 0 0;"><a href="https://wicrowd.co.kr/faq/list?faqType=invest" style="color:#353535; text-decoration:underline;" target="_blank">[사이트 고객센터 바로가기]</a></p>
                    </div>
                    <div style="font-size:12px; color:#959595; overflow:hidden;">
                        <p style="margin:15px 0 0;">
                            대표전화: 02-560-6300
                            이메일: <a href="mailto:wicrowd@kasset.co.kr" style="color:#353535; text-decoration:underline;" target="_blank">wicrowd@kasset.co.kr</a>
                        </p>
                        <p style="margin:5px 0 0;">서울특별시 영등포구 여의나루로 57, 12층 (여의도동 신송센터빌딩) 코리아에셋투자증권</p>
                    </div>
                </td>
                <td width="20%" style="text-align:right; vertical-align:bottom;">
                    <img src="https://wicrowd.co.kr/files/images/20160312/a6d1fd9d04fce7d3f5ff8c4a986f4a64.png">
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>