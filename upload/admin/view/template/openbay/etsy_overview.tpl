<?php echo $header; ?><?php echo $menu; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>

  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>

  <div class="panel panel-default">
    <div class="panel-heading">
      <h1 class="panel-title"><i class="fa fa-dashboard fa-lg"></i> <?php echo $text_heading; ?></h1>
    </div>
    <div class="panel-body">
      <div class="row">
        <div class="col-md-3 text-center">
          <div class="well">
            <a href="<?php echo $links_settings; ?>">
              <span class="fa-stack fa-3x">
                <i class="fa fa-square-o fa-stack-2x"></i>
                <i class="fa fa-wrench fa-stack-1x"></i>
              </span>
              <h4><?php echo $text_heading_settings; ?></h4>
            </a>
          </div>
        </div>
        <div class="col-md-3 text-center">
          <div class="well">
            <a href="<?php echo $links_shipping; ?>">
                <span class="fa-stack fa-3x">
                  <i class="fa fa-square-o fa-stack-2x"></i>
                  <i class="fa fa-truck fa-stack-1x"></i>
                </span>
              <h4><?php echo $text_heading_shipping; ?></h4>
            </a>
          </div>
        </div>
        <div class="col-md-3 text-center">
          <div class="well">
            <a href="<?php echo $links_products; ?>">
                <span class="fa-stack fa-3x">
                  <i class="fa fa-square-o fa-stack-2x"></i>
                  <i class="fa fa-link fa-stack-1x"></i>
                </span>
              <h4><?php echo $text_heading_products; ?></h4>
            </a>
          </div>
        </div>
        <?php if($validation == true){ ?>

        <?php }else{ ?>
          <div class="col-md-3 text-center">
            <div class="well">
              <a href="https://account.openbaypro.com/etsy/apiRegister/" target="_BLANK">
                <span class="fa-stack fa-3x">
                  <i class="fa fa-square-o fa-stack-2x"></i>
                  <i class="fa fa-star fa-stack-1x"></i>
                </span>
                <h4><?php echo $text_heading_register; ?></h4>
              </a>
            </div>
          </div>
        <?php } ?>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>