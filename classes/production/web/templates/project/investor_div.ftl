<#list investors as investor>
    <li>
        <div>
            <#if (investor.profileImageUrl)?has_content>
                <#assign pImg = (investor.profileImageUrl)>
            <#else>
                <#assign pImg = "/images/img-person.jpg">
            </#if>
            <p class="img profile_thum fl" style="background:url('${pImg}')"></p>
            <div class="comment_tx">
                <#if investor.useName == 'Y'>
                    <p>${investor.name}</p>
                <#else>
                    <p>***</p>
                </#if>
                <p class="msg mt10">
                    <#if investor.investCount == 1>
                        현재 이 프로젝트에 투자하고 있습니다.
                    <#else>
                        현재 <b>${((investor.investCount)-1) !}개의 다른 프로젝트</b>와 함께 투자하고 있습니다.
                    </#if>
                </p>
            </div>
        </div>
    </li>
</#list>