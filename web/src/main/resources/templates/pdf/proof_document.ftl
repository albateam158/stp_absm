<html>
<head>
    <title>Xenixstudio</title>
</head>
<body>
<!-- publisher 내용 -->
<div class="tab_cont cont_publisher">
    <#if files?has_content>
        <#list files as file>
            <div class="contentst editor_view"><img src="${file}"/></div>
        </#list>
    </#if>
</div>
</body>
</html>