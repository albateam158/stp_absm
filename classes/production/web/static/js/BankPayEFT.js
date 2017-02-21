/**
 * Created by xenix on 2015. 12. 10..
 */
var WalletClassDef="<OBJECT ID=BankPayEFT CLASSID=clsid:B0A75875-3622-48BA-B5FF-45AD77AC2D0E width=0 height=0 CODEBASE=https://www.bankpay.or.kr/BankPayEFT.cab#version=1,2,3,4></OBJECT>";

var sendflag = false;
var servercert = "-----BEGIN CERTIFICATE-----MIIE9jCCA96gAwIBAgIEFyOkvDANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYDVQQDDBF5ZXNzaWduQ0EgQ2xhc3MgMTAeFw0xNDA5MDMxNTAwMDBaFw0xNjA5MjExNDU5NTlaMGoxCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMQ8wDQYDVQQLDAZzZXJ2ZXIxEDAOBgNVBAsMB3llc3NpZ24xDTALBgNVBAsMBEtGVEMxFzAVBgNVBAMMDnd3dy5rZnRjLm9yLmtyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtdV5dPRgp36MU4XvPU3is0Itq9JtM6pfXBKuI0EahzajJFxjASRQkh1Zdqha1HLQI8FiuVPASLMX1ksnQt37Fi7ltfguEiIHLIfL71RbkTgsf5b3mCO98DiRefJGXnQ7dWj1MY1PU3m8zsgJjrFpR0e/5XRw71ChABpOq8TNbULs9LbJzfK4HLN0kChqWcgVCl2rKpFjnBsJlg9ziTecHM2YDMTvG1tQEb+bHJ4V+B4i9+IbRuqbr6ITj3AZD7lcv3vE/oecW75OIzEPL2nomtT+IVUwcmM8XgDcLBU91j/p/pVvVN6FmlVf/28HV/ij1QI70UrQNh+QOQcc7rArFQIDAQABo4IBujCCAbYwgY8GA1UdIwSBhzCBhIAUUgQyn4+dIXK6+jOYqGF+JzMkjV+haKRmMGQxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRYwFAYDVQQDDA1LSVNBIFJvb3RDQSA0ggIQAzAdBgNVHQ4EFgQUraqud/gTGJJbo7RLGKaVU+F0HB4wDgYDVR0PAQH/BAQDAgUgMBkGA1UdIAEB/wQPMA0wCwYJKoMajJpFAQEDMCoGA1UdEQQjMCGgHwYJKoMajJpECgEBoBIwEAwOd3d3LmtmdGMub3Iua3IwcgYDVR0fBGswaTBnoGWgY4ZhbGRhcDovL2RzLnllc3NpZ24ub3Iua3I6Mzg5L291PWRwNHA0MjY3OCxvdT1BY2NyZWRpdGVkQ0Esbz15ZXNzaWduLGM9a3I/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDA4BggrBgEFBQcBAQQsMCowKAYIKwYBBQUHMAGGHGh0dHA6Ly9vY3NwLnllc3NpZ24ub3JnOjQ2MTIwDQYJKoZIhvcNAQELBQADggEBAMADb21Xj9cALgXqTqdS4c69Au0jmvuVIJrpFldnNSdCyZkK7pcIPWEUjUwVErHKwb9mahSPqvZ5daqTPcQnMBNCLN1DEg3+sE/W2wifDgrjpyVIWIytSkP7X2679g+ROcqfkfZ/Wlgqbi12g77SJErYVMeBmPc0KXHAMP2SEB1H8I9nIOeOwYbmoGQ4/NDsU0+MHF4k5fwKMlzLGyKpsmmO39EluIY/739xjjZ1wZDhDxw2zOv6PSqOgOf9Wb8Y3e5XJ+HJuMDEzJrxAUkvvu3fVUjAFpeMl9OPN+dzpXyIRqLr/sMfNe2FICx0MGNH/nM2gzlkuangVviYa+gls18=-----END CERTIFICATE-----";

// 인증서 디스플레이 옵션
var YESSIGN_FINANCIAL_PE  = 0x00000001; // YESSIGN 개인은행보험
var YESSIGN_FINANCIAL_CO  = 0x00000002; // YESSIGN 법인은행보험
var YESSIGN_FINANCIAL     = YESSIGN_FINANCIAL_PE | YESSIGN_FINANCIAL_CO;
var YESSIGN_GENERAL_PE    = 0x00000004; // YESSIGN 개인범용
var YESSIGN_GENERAL_CO    = 0x00000008; // YESSIGN 법인범용
var YESSIGN_GENERAL       = YESSIGN_GENERAL_PE | YESSIGN_GENERAL_CO;
var OTHERCA_CERT_PE       = 0x00000200; // 타기관  개인범용
var OTHERCA_CERT_CO       = 0x00000400; // 타기관  법인범용
var OTHERCA_CERT_FI_PE    = 0x00200000; // 타기관  개인은행보험
var OTHERCA_CERT_INV_PE   = 0x10000000;  // 개인 금융투자용(구 증권용)
var OTHERCA_CERT_INV_CO   = 0x20000000;  // 법인 금융투자용(구 증권용)
var OTHERCA_CERT_INV      = OTHERCA_CERT_INV_PE | OTHERCA_CERT_INV_CO;

var OTHERCA_CERT_ALL = OTHERCA_CERT_PE | OTHERCA_CERT_CO | OTHERCA_CERT_FI_PE | OTHERCA_CERT_INV_PE | OTHERCA_CERT_INV_CO;

var DISABLE_MOBILEPHONE   = 0x02000000;
var CONFIRM_CERT_SSN      = 0x00008000;

var pgYessignPolicy       = YESSIGN_FINANCIAL | YESSIGN_GENERAL | OTHERCA_CERT_PE | OTHERCA_CERT_CO | OTHERCA_CERT_FI_PE;
var pgYessignPolicyStock  = YESSIGN_GENERAL | OTHERCA_CERT_PE | OTHERCA_CERT_CO |  OTHERCA_CERT_INV;

// 인증모듈 환경 설정
var fileName = "pg";
var keyboard_secu_level = "E2E";
var i3g_snd_data = "SEND";
var configInfo = "vdRecipient=FALSE" +
    "$selectTitle=BankPay 공인인증서 확인" +
    "$xcMobileList=FALSE" +
    "$mobisignURL=https://mobile.yessign.or.kr/move/mobisigndll.htm" +
    "$mobisignDllVersion=3,1,0,8" +
    "$mobisignSiteInfo=1010004" +
    "$infovineURL=https://www.bankpay.or.kr/infovine/InfovineDownload.html" +
    "$infovineDllURL=YESSIGN_PG|https://www.bankpay.or.kr/infovine/DownloadList" +
    "$infovineSecurity=YESSIGN|KINGS_INFOVINE" +
    "$infovineDllVersion=1,2,4,5" +
    "$dlgTabMode=C" +
    "$keyCryptDriver=SOFO_V1";

function InstallCertManager()
{
    document.writeln("<script language='javascript' src='https://ck.softforum.co.kr/CKKeyPro/yessign/CKKeyProInst.js'></script>");
    //document.writeln("<script language='javascript' src='https://ck.softforum.co.kr/CKKeyPro/yessign/CKKeyProInst.js'></script>");
}

function SmartUpdate()
{
    if ( (navigator.appName == 'Netscape') && (navigator.userAgent.toLowerCase().indexOf('trident') == -1) )
    {
        alert("죄송합니다. 현재 Netscape은 전자지갑을 지원하지 않고 있습니다.");
        return;
    }
    document.writeln(WalletClassDef);
}

function CheckCtrl()
{
    if(IsSP2())
    {
        if( (BankPayEFT == null) || (typeof(BankPayEFT) == "undefined") || (BankPayEFT.object == null) )
        {
            alert("[플러그인]이 정상적으로 설치되지 않았습니다.\n\n브라우저의 상단 노란색[알림 표시줄]을 클릭하신 후 [AxtiveX 컨트롤 설치]를 클릭하세요.");
            return false;
        }
        return true;
    }

    if( (BankPayEFT == null) || (typeof(BankPayEFT) == "undefined") || (BankPayEFT.object == null) )
    {
        cw = 800; ch = 700;         // 창크기
        sw=screen.availWidth; sh=screen.availHeight; // 스크린크기
        px=(sw-cw)/2; py=(sh-ch)/2; // 창 위치

        farwindow = window.open("","", "left="+px+",top="+py+",width="+cw+",height="+ch+",resizable=no");
        if(farwindow != null)
        {
            if( farwindow.opener == null ) {
                farwindow.opener = self;
            }
            farwindow.location.href = "https://www.bankpay.or.kr/bankpay_new/custom/InstallGuideAll.htm";
        }
        return false;
    }

    return true;
}

function setField(form)
{
    //document.domain = '192.168.0.10';

    BankPayEFT.SetValue("server_cert", servercert);
    BankPayEFT.SetValue("hd_ep_type", form.hd_ep_type.value);
    BankPayEFT.SetValue("hd_firm_name", form.hd_firm_name.value);
    BankPayEFT.SetValue("keyboard_secu_level", keyboard_secu_level);
    BankPayEFT.SetValue("i3g_snd_data", i3g_snd_data);
    BankPayEFT.SetValue("sbp_service_use", "Y");
    BankPayEFT.SetValue("sbp_first_tab",   "N");
    if(  ( form.hd_approve_no.value == "15200369" )
        || ( form.hd_approve_no.value == "15600042" )
        || ( form.hd_approve_no.value == "15600028" )
        || ( form.hd_approve_no.value == "15600011" )
        || ( form.hd_approve_no.value == "15700018" )
        || ( form.hd_approve_no.value == "11001184" )
    )
    {
        BankPayEFT.SetValue("sbp_service_use", "N");
    }
    BankPayEFT.SetValue("hd_fw_use", "Y");
    BankPayEFT.SetValue("hd_fw_option", "011");

    if (form.hd_personal != null)
        BankPayEFT.SetValue("hd_personal", form.hd_personal.value);
    if (form.hd_corporation != null)
        BankPayEFT.SetValue("hd_corporation", form.hd_corporation.value);
    if (form.hd_ep_option != null)       // 전자지갑 출력옵션필드가 있으면 SET
        BankPayEFT.SetValue("hd_ep_option", form.hd_ep_option.value);
    if (form.hd_input_option != null)    // 전자지갑 입력옵션필드가 있으면 SET
        BankPayEFT.SetValue("hd_input_option", form.hd_input_option.value);
    if (form.hd_timeout_yn != null)      // 전자지갑 TIMEOUT옵션필드가 있으면 SET
        BankPayEFT.SetValue("hd_timeout_yn", form.hd_timeout_yn.value);
    if (form.hd_timeout != null)         // 전자지갑 TIMEOUT옵션필드가 있으면 SET
        BankPayEFT.SetValue("hd_ep_timeout", form.hd_timeout.value);
    if (form.tx_email_addr != null)
        BankPayEFT.SetValue("ep_email_addr", form.tx_email_addr.value);
    if (form.tx_bill_yn != null)
        BankPayEFT.SetValue("tx_bill_yn", form.tx_bill_yn.value);
    if (form.hd_ep_color != null)
        BankPayEFT.SetValue("hd_ep_color", form.hd_ep_color.value);
    if (form.tx_user_key != null)
        BankPayEFT.SetValue("tx_user_key", form.tx_user_key.value);
    if (form.sbp_service_use != null)
        BankPayEFT.SetValue("sbp_service_use", form.sbp_service_use.value);
    if (form.sbp_tab_first != null)
        BankPayEFT.SetValue("sbp_tab_first", form.sbp_tab_first.value);
    if (form.hd_fw_use != null)
        BankPayEFT.SetValue("hd_fw_use", form.hd_fw_use.value);
    if (form.hd_fw_option != null)
        BankPayEFT.SetValue("hd_fw_option", form.hd_fw_option.value);

    if (form.ep_bank_code != null) {
        if( !BankPayEFT.SetValue("ep_bank_code", form.ep_bank_code.value) )
            return false;
    }
    if (form.ep_account_no != null) {
        if( !BankPayEFT.SetValue("ep_account_no", form.ep_account_no.value) )
            return false;
    }
    if (form.hd_default_institution != null) {
        if( !BankPayEFT.SetValue("hd_default_institution", form.hd_default_institution.value) )
            return false;
    }
    if (form.hd_item_name != null) {
        if( !BankPayEFT.SetValue("hd_item_name", form.hd_item_name.value) )
            return false;
    }
    if (form.hd_email_yn != null) {
        if( !BankPayEFT.SetValue("hd_email_yn", form.hd_email_yn.value) )
            return false;
    }


    if ( !BankPayEFT.SetValue("ep_approve_no", form.hd_approve_no.value) )
        return false;
    if ( !BankPayEFT.SetValue("ep_serial_no", form.hd_serial_no.value) )
        return false;
    if ( !BankPayEFT.SetValue("ep_amount", form.tx_amount.value) )
        return false;

    return true;
}

function setCertInfo()
{
    // 인증모듈 옵션
    BankPayEFT.SetValue("hd_cert_file", fileName);
    BankPayEFT.SetValue("hd_cert_info", configInfo);
    BankPayEFT.SetValue("hd_cert_policy", pgYessignPolicy);
    BankPayEFT.SetValue("hd_cert_policy_stock", pgYessignPolicyStock);
    return true;
}

function payRequest(form)
{
    // A/X가 제대로 설치되어 있는지 확인
    if ( !CheckCtrl() )
        return false;

    // 현재 결제처리 중인지 확인
    if ( AlreadySend() )
        return false;

    // 인증모듈 정보를 전자지갑 A/X로 전송 (반드시 전자지갑 모듈 초기화보다 선행되어야 함)
    if ( !setCertInfo() )
        return false;

    // 전자지갑 모듈 초기화
    if (!BankPayEFT.Init()) {
        BankPayEFT.WalletDestroy();
        return false;
    }

    // 웹 결제 정보를 전자지갑 A/X로 전송
    if ( !setField(form) ) {
        BankPayEFT.WalletDestroy();
        return false;
    }

    // 전자지갑 A/X PopUp
    if ( !BankPayEFT.ShowBankPayEFTWallet() )
    {
        BankPayEFT.WalletDestroy();
        return false;
    }

    try {
        BankPayEFT.FreeKeycrypt();
    }catch(err) {
        //
    }

    // 전자지갑버젼등 기타정보 form값에 추가
    AddOptionalInfo(form);

    // 전자지갑 암호화 방식(hd_ep_type)과 암호결과(hd_pi)값을 form(pay.cgi로 전송)으로 보낸다.
    sendflag = true;
    var hd_pi_value = BankPayEFT.GetEncryptData();
    form.hd_pi.value = hd_pi_value;
    form.hd_ep_type.value=BankPayEFT.GetEpType();

    return true;
}

function DestroyDlg()
{
    BankPayEFT.DestroyWaitDlg();
}

function payResult(msg)
{
    BankPayEFT.DestroyWaitDlg();
    BankPayEFT.DecryptWI(msg);
    BankPayEFT.WalletDestroy();
}

function payRequestLink(form)
{
    return payRequest(form);
    //if (payRequest(form))
    //    form.submit();
    //else
    //    form.reset();
}

function walletDestroy()
{
    BankPayEFT.WalletDestroy();
}

function downloadNow()
{
    if ( navigator.javaEnabled() )
    {
        trigger = netscape.softupdate.Trigger;
        if ( trigger.UpdateEnabled() )
        {
            if (navigator.platform == "Win32") trigger.StartSoftwareUpdate( JarFileURL, trigger.DEFAULT_MODE);
            else alert('[BankPayEFT은 윈도우즈 95/98/NT 환경에서 작동합니다.');
        }
        else alert('Netscape의 SmartUpdate 설치를 할 수 없습니다.');
    }
    else alert('Java 실행을 가능하도록 해야합니다.');
}

function AlreadySend()
{
    if (!sendflag) return false;
    alert("처리중입니다. 잠시만 기다려 주십시오");
    return true;
}

function IsSP2()
{
    var g_flsSP2 = false;
    g_flsSP2 = (window.navigator.userAgent.indexOf("SV1") != -1 );
    return g_flsSP2;
}

function IsWin98()
{
    if((navigator.userAgent.indexOf('Win') != -1) && (navigator.userAgent.indexOf('98') != -1))
        return true;
    return false;
}

function IsVista()
{
    if(navigator.appVersion.toUpperCase().indexOf("Windows NT 6.0".toUpperCase(), 0) > 0)
        return true;
    return false;
}

function CheckInstallCtrl()
{
    if ( typeof(BankPayEFT.Init) == "undefined" )
        alert("수동설치에 실패하였습니다.\n다시 [전자지갑 설치]을 눌러 전자지갑을 설치하시기를 바랍니다.");
    else
        alert("성공적으로 설치되었습니다.\n 수동설치페이지창을 닫고 결제를 진행하십시오.");
}

function GotoInstallPage()
{
    document.location.replace("https://www.bankpay.or.kr/bankpay_new/custom/InstallGuideAll.htm");
}

function AddOptionalInfo(form)
{
    try
    {
        // do nothing
    }
    catch (err)
    {
        // do nothing
    }
}


function PopupInstallPage()
{
    cw = 800; ch = 700;         // 창크기
    sw=screen.availWidth; sh=screen.availHeight; // 스크린크기
    px=(sw-cw)/2; py=(sh-ch)/2; // 창 위치

    if( IsWin98() ) {
        ch = 700;
    }else if (IsVista()) {
        ch = 700;
    }else {
        ch = 720;
    }

    farwindow = window.open("","", "left="+px+",top="+py+",width="+cw+",height="+ch+",resizable=no");
    if(farwindow != null)
    {
        if( farwindow.opener == null ) farwindow.opener = self;

        farwindow.location.href =" https://www.bankpay.or.kr/bankpay_new/custom/InstallGuideAll.htm";
    }
}



/* Hitel 을 위한 함수이므로 삭제 금지 */
function payRequestLink_Hitel(form) {
    BankPayEFT.Init();
    if (payRequest(form)) {
        //form.submit();
        return XecureSubmit(form);
    }
    else { form.reset(); }
}
