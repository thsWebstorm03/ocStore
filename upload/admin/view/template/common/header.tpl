<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<script type="text/javascript" src="view/javascript/jquery/jquery-2.0.3.min.js"></script>
<link href="view/javascript/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.js"></script>
<link href="view/javascript/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" />
<link type="text/css" href="view/stylesheet/stylesheet.css" rel="stylesheet" media="screen" />
<?php foreach ($styles as $style) { ?>
<link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="view/javascript/common.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
</head>
<body>
<div id="container">
<header id="header" class="navbar navbar-inverse navbar-static-top">
  <div class="container">
    <div class="navbar-header"><a href="<?php echo $home; ?>" class="navbar-brand"><img src="view/image/logo.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></a>
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
    </div>
    <?php if ($logged) { ?>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <?php if ($image) { ?>
          <a class="dropdown-toggle" data-toggle="dropdown"><img src="<?php echo $image; ?>" alt="<?php echo $username; ?>" /> <i class="fa fa-angle-down"></i></a>
          <?php } else { ?>
          <a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user fa-lg"></i> <i class="fa fa-angle-down"></i></a>
          <?php } ?>
          <ul class="dropdown-menu">
            <li><a href="<?php echo $profile; ?>"><?php echo $text_profile; ?></a></li>
            <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
          </ul>
        </li>
        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><span class="label label-danger pull-right">4</span> <i class="fa fa-bell fa-lg"></i></a>
          <ul class="dropdown-menu">
            <li><a href="<?php echo $profile; ?>">test</a></li>
          </ul>
        </li>
        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i> <i class="fa fa-angle-down"></i></a>
          <ul class="dropdown-menu">
            <li class="dropdown-header"><?php echo $text_store; ?> <i class="fa fa-shopping-cart"></i></li>
            <?php foreach ($stores as $store) { ?>
            <li><a href="<?php echo $store['href']; ?>" target="_blank"><?php echo $store['name']; ?></a></li>
            <?php } ?>
            <li class="divider"></li>
            <li class="dropdown-header"><?php echo $text_help; ?> <i class="fa fa-question-circle"></i></li>
            <li><a href="http://www.opencart.com" target="_blank"><?php echo $text_opencart; ?></a></li>
            <li><a href="http://docs.opencart.com" target="_blank"><?php echo $text_documentation; ?></a></li>
            <li><a href="http://forum.opencart.com" target="_blank"><?php echo $text_support; ?></a></li>
          </ul>
        </li>
      </ul>
    </div>
    <?php } ?>
  </div>
</header>
<?php if ($logged) { ?>
<nav id="menu" class="navbar navbar-default navbar-static-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex2-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
    </div>
    <div class="collapse navbar-collapse navbar-ex2-collapse">
      <ul class="nav navbar-nav">
        <li id="dashboard"><a href="<?php echo $home; ?>"><?php echo $text_dashboard; ?></a></li>
        <li id="catalog" class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><?php echo $text_catalog; ?> <span class="visible-xs"><i class="fa fa-caret-down"></i></span></a>
          <ul class="dropdown-menu">
            <li><a href="<?php echo $category; ?>"><?php echo $text_category; ?></a></li>
            <li><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
            <li><a href="<?php echo $filter; ?>"><?php echo $text_filter; ?></a></li>
            <li class="dropdown-submenu"><a><?php echo $text_attribute; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $attribute; ?>"><?php echo $text_attribute; ?></a></li>
                <li><a href="<?php echo $attribute_group; ?>"><?php echo $text_attribute_group; ?></a></li>
              </ul>
            </li>
            <li><a href="<?php echo $option; ?>"><?php echo $text_option; ?></a></li>
            <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            <li><a href="<?php echo $review; ?>"><?php echo $text_review; ?></a></li>
            <li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
          </ul>
        </li>
        <li id="extension" class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><?php echo $text_extension; ?> <span class="visible-xs"><i class="fa fa-caret-down"></i></span></a>
          <ul class="dropdown-menu">
            <li><a href="<?php echo $installer; ?>"><?php echo $text_installer; ?></a></li>
            <li><a href="<?php echo $modification; ?>"><?php echo $text_modification; ?></a></li>
            <li><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
            <li><a href="<?php echo $shipping; ?>"><?php echo $text_shipping; ?></a></li>
            <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
            <li><a href="<?php echo $total; ?>"><?php echo $text_total; ?></a></li>
            <li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
          </ul>
        </li>
        <li id="sale" class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><?php echo $text_sale; ?> <span class="visible-xs"><i class="fa fa-caret-down"></i></span></a>
          <ul class="dropdown-menu">
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
            <li class="dropdown-submenu"><a><?php echo $text_customer; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
                <li><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
                <li><a href="<?php echo $custom_field; ?>"><?php echo $text_custom_field; ?></a></li>
                <li><a href="<?php echo $customer_ban_ip; ?>"><?php echo $text_customer_ban_ip; ?></a></li>
              </ul>
            </li>
            <li class="dropdown-submenu"><a><?php echo $text_voucher; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                <li><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
              </ul>
            </li>
            <li class="dropdown-submenu"><a><?php echo $text_marketing; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $marketing; ?>"><?php echo $text_marketing; ?></a></li>
                <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                <li><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
                <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
              </ul>
            </li>
          </ul>
        </li>
        <li id="system" class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><?php echo $text_system; ?> <span class="visible-xs"><i class="fa fa-caret-down"></i></span></a>
          <ul class="dropdown-menu">
            <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
            <li class="dropdown-submenu"><a><?php echo $text_design; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
                <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
              </ul>
            </li>
            <li class="dropdown-submenu"><a><?php echo $text_users; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
                <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
              </ul>
            </li>
            <li class="dropdown-submenu"><a><?php echo $text_localisation; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $location; ?>"><?php echo $text_location; ?></a></li>
                <li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
                <li><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
                <li><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
                <li><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
                <li class="dropdown-submenu"><a><?php echo $text_return; ?></a>
                  <ul class="dropdown-menu">
                    <li><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
                    <li><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
                    <li><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
                  </ul>
                </li>
                <li><a href="<?php echo $country; ?>"><?php echo $text_country; ?></a></li>
                <li><a href="<?php echo $zone; ?>"><?php echo $text_zone; ?></a></li>
                <li><a href="<?php echo $geo_zone; ?>"><?php echo $text_geo_zone; ?></a></li>
                <li class="dropdown-submenu"><a><?php echo $text_tax; ?></a>
                  <ul class="dropdown-menu">
                    <li><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
                    <li><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
                  </ul>
                </li>
                <li><a href="<?php echo $length_class; ?>"><?php echo $text_length_class; ?></a></li>
                <li><a href="<?php echo $weight_class; ?>"><?php echo $text_weight_class; ?></a></li>
              </ul>
            </li>
            <li class="divider"></li>
            <li><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
            <li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
          </ul>
        </li>
        <li id="reports" class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><?php echo $text_reports; ?> <span class="visible-xs"><i class="fa fa-caret-down"></i></span></a>
          <ul class="dropdown-menu">
            <li class="dropdown-submenu"><a><?php echo $text_sale; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $report_sale_order; ?>"><?php echo $text_report_sale_order; ?></a></li>
                <li><a href="<?php echo $report_sale_tax; ?>"><?php echo $text_report_sale_tax; ?></a></li>
                <li><a href="<?php echo $report_sale_shipping; ?>"><?php echo $text_report_sale_shipping; ?></a></li>
                <li><a href="<?php echo $report_sale_return; ?>"><?php echo $text_report_sale_return; ?></a></li>
                <li><a href="<?php echo $report_sale_coupon; ?>"><?php echo $text_report_sale_coupon; ?></a></li>
              </ul>
            </li>
            <li class="dropdown-submenu"><a><?php echo $text_product; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $report_product_viewed; ?>"><?php echo $text_report_product_viewed; ?></a></li>
                <li><a href="<?php echo $report_product_purchased; ?>"><?php echo $text_report_product_purchased; ?></a></li>
              </ul>
            </li>
            <li class="dropdown-submenu"><a><?php echo $text_customer; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $report_customer_online; ?>"><?php echo $text_report_customer_online; ?></a></li>
                <li><a href="<?php echo $report_customer_activity; ?>"><?php echo $text_report_customer_activity; ?></a></li>
                <li><a href="<?php echo $report_customer_order; ?>"><?php echo $text_report_customer_order; ?></a></li>
                <li><a href="<?php echo $report_customer_reward; ?>"><?php echo $text_report_customer_reward; ?></a></li>
                <li><a href="<?php echo $report_customer_credit; ?>"><?php echo $text_report_customer_credit; ?></a></li>
              </ul>
            </li>
            <li class="dropdown-submenu"><a><?php echo $text_marketing; ?></a>
              <ul class="dropdown-menu">
                <li><a href="<?php echo $report_marketing; ?>"><?php echo $text_marketing; ?></a></li>
                <li><a href="<?php echo $report_affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                <li><a href="<?php echo $report_affiliate_activity; ?>"><?php echo $text_affiliate_activity; ?></a></li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>
<?php } ?>
