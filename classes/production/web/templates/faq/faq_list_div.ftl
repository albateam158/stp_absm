<ul id="faqList">
    <#if faqs?has_content>
        <#list faqs as faq>
        <li>
            <h3>Q. ${(faq.question) !}</h3>
            <div class="sub_box editor_view">
                ${(faq.answer) !}
            </div>
        </li>
        </#list>
    </#if>
</ul>