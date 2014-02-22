<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
<?php 
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'].'<a href="'.$breadcrumb['href'].'">'.$breadcrumb['text'].'</a>';
        } 
?>
    </div> 
        
    <?php if ($success) { ?>
        <div class="success mBottom10"><?php echo $success; ?></div>
    <?php } ?>

    <div class="box mBottom130"> 
        <div class="heading">
            <h1><?php echo $lang_heading; ?></h1>
        </div>
        <div class="content">
            <div class="openbayLinks">
                <div class="openbayPod" onclick="location='<?php echo $link_settings; ?>'">
                    <img src="view/image/openbay/openbay_icon1.png" title="" alt="" border="0" />
                    <h3><?php echo $lang_heading_settings; ?></h3>
                </div>

                <?php if( $validation == true) { ?>
                    <div class="openbayPod" onclick="location='<?php echo $link_subscription; ?>'">
                        <img src="view/image/openbay/openbay_icon2.png" title="" alt="" border="0" />
                        <h3><?php echo $lang_heading_account; ?></h3>
                    </div>
                    <div class="openbayPod" onclick="location='<?php echo $link_item_link; ?>'">
                        <img src="view/image/openbay/openbay_icon3.png" title="" alt="" border="0" />
                        <h3><?php echo $lang_heading_links; ?></h3>
                    </div>
                    <div class="openbayPod" onclick="location='<?php echo $link_bulk_linking; ?>'">
                        <img src="view/image/openbay/openbay_icon3.png" title="" alt="" border="0" />
                        <h3><?php echo $lang_heading_bulk_linking; ?></h3>
                    </div>
                    <div class="openbayPod" onclick="location='<?php echo $link_bulk_listing; ?>'">
                        <img src="view/image/openbay/openbay_icon5.png" title="" alt="" border="0" />
                        <h3><?php echo $lang_heading_bulk_listing; ?></h3>
                    </div>
                    <div class="openbayPod" onclick="location='<?php echo $link_stock_updates; ?>'">
                        <img src="view/image/openbay/openbay_icon8.png" title="" alt="" border="0" />
                        <h3><?php echo $lang_heading_stock_updates; ?></h3>
                    </div>
                    <div class="openbayPod" onclick="location='<?php echo $link_saved_listings; ?>'">
                        <img src="view/image/openbay/openbay_icon12.png" title="" alt="" border="0" />
                        <h3><?php echo $lang_heading_saved_listings; ?></h3>
                    </div>
                <?php } else { ?>
                    <a class="openbayPod" href="http://uk-amazon.openbaypro.com/account/register" target="_BLANK">
                        <img src="view/image/openbay/openbay_icon2.png" title="" alt="" border="0" />
                        <h3><?php echo $lang_heading_register; ?></h3>
                    </a>
                <?php } ?>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript"><!--
    $(document).ready(function() {
        $('.openbayPod').hover( function(){
            $(this).css('background-color', '#CCCCCC').css('border-color', '#003366');
        },
        function(){
            $(this).css('background-color', '#FFFFFF').css('border-color', '#CCCCCC');
        });
    });
//--></script> 
<?php echo $footer; ?>