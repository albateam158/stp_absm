<@layout.extends name="layout/base.ftl">

	<@layout.put block="head">

	</@layout.put>
	<@layout.put block="contents">
    <div class="content2">
        <ul class="bxslider">
            <li class="li1">
                <p>THE KOREA TRANSPORT INSTITUTE</p>
            </li>
            <li class="li2">
                <p>THE KOREA TRANSPORT INSTITUTE</p>
            </li>
            <li class="li3">
                <p>THE KOREA TRANSPORT INSTITUTE</p>
            </li>
        </ul>
    </div>
    </@layout.put>


	<@layout.put block="script">
    <script type="text/javascript">
        //메인 슬라이드
        $(document).ready(function(){
            $('.bxslider').bxSlider({
                auto: true,
                autoControls: true,
                controls:false
            });
        });
    </script>
	</@layout.put>

</@layout.extends>