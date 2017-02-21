<div id="project_list" class="gallery">
    <#if projects?has_content>
        <ul>
        <#list projects as project>
            <li>
                <div class="gallery-item <#if featuredProjectId?exists && featuredProjectId == project.projectId>active</#if>" data-width="1" data-height="1">
                    <input type="hidden" name="projectId[]" value="${(project.projectId)!}" />
                    <input type="hidden" name="projectName[]" value="${(project.name)!}" />
                    <!-- START PREVIEW -->
                    <p class="thum image-responsive-height" style="background-image: url('${(project.mainImageUrl)!}')"></p>
                    <!-- END PREVIEW -->
                    <!-- START ITEM OVERLAY DESCRIPTION -->
                    <div class="overlayer bottom-left full-width">
                        <div class="overlayer-wrapper item-info">
                            <div class="gradient-grey p-l-20 p-r-20 p-t-20 p-b-5 m-b-0">
                                <div>
                                    <p class="pull-left bold text-white fs-14 p-t-5">${(project.name)!}</p>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="p-t-0 p-b-5">
                                    <div class="inline">
                                        <p class="no-margin text-white fs-12">${(project.user.name)!}</p>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END PRODUCT OVERLAY DESCRIPTION -->
                </div>
            </li>
        </#list>
        </ul>
    <#else>
        <p class="t-c" style="line-height: 220px; font-size: 16px;">카테고리내에 등록된 프로젝트가 없습니다.</p>
    </#if>
</div>
<#if projects?has_content>
    ${paging}
</#if>