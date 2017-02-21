<html>
<head></head>
<body>
<#escape x as x?html>
    <#if updates?has_content>
        <#list updates as update>
            <div class="post_box">
                <div class="top">
                    <h2>${(update.title) !}</h2>
                    <p class="date">${(update.regDate) !}</p>
                </div>
                <div class="text editor_view">
                    <#noescape>
                            ${(update.content)?replace('\n', '<br>')!}
                    </#noescape>
                </div>
            </div>
        </#list>
    </#if>
</#escape>
</body>
</html>

