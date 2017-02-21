<#escape x as x?html>
    <#if comments?has_content>
        <#list comments as comment>
            <div class="comment_tx">
                <p>${(comment.name) !} <span class="date">${(comment.regDate?string("yyyy.MM.dd")) !}</span></p>
                <p class="msg">
                    <#noescape>
                        ${(comment.content)?replace('\n', '<br>')!}
                    </#noescape>
                </p>
                <hr height="1" />
            </div>
        </#list>
    </#if>
</#escape>