<?php echo $header; ?><?php echo $menu; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right">
        <a onclick="confirmAction('<?php echo $cancel; ?>');" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn"><i class="fa fa-reply"></i></a>
      </div>
      <h1 class="panel-title"><i class="fa fa-pencil-square fa-lg"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="panel-body" id="page-listing">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <input type="hidden" name="product_id" value="<?php echo $product['product_id']; ?>" />
        <input type="hidden" name="auction_type" value="FixedPriceItem" />
        <input type="hidden" name="attributes" value="<?php echo $product['attributes']; ?>" />

        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-listing-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
          <li><a href="#tab-listing-feature" data-toggle="tab"><?php echo $text_tab_feature; ?></a></li>
          <li><a href="#tab-listing-catalog" data-toggle="tab"><?php echo $text_tab_ebay_catalog; ?></a></li>
          <li><a href="#tab-listing-description" data-toggle="tab"><?php echo $text_tab_description; ?></a></li>
          <li><a href="#tab-listing-images" data-toggle="tab"><?php echo $text_tab_images; ?></a></li>
          <li><a href="#tab-listing-price" data-toggle="tab"><?php echo $text_tab_price; ?></a></li>
          <li><a href="#tab-listing-payment" data-toggle="tab"><?php echo $text_tab_payment; ?></a></li>
          <li><a href="#tab-listing-shipping" data-toggle="tab"><?php echo $tab_shipping; ?></a></li>
          <li><a href="#tab-listing-returns" data-toggle="tab"><?php echo $text_tab_returns; ?></a></li>
        </ul>
        <div class="tab-content">
          <div id="tab-listing-general" class="tab-pane active">
            <?php if ($product['store_cats'] != false) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_shop_category; ?></label>
                <div class="col-sm-10">
                  <select name="eBayStoreCatId" id="eBayStoreCatId" class="form-control">
                    <?php foreach($product['store_cats'] as $key => $cat) { ?>
                    <option value="<?php echo $key; ?>"><?php echo $cat; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            <?php } ?>
            <?php if (!empty($product['popular_cats'])) { ?>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_category_popular; ?></label>
              <div class="col-sm-10">
                <p><input type="radio" name="popular" value="" id="popular_default" checked /> <strong><?php echo $text_none; ?></strong></p>
                <?php foreach($product['popular_cats'] as $cat) { ?>
                <p><input type="radio" name="popular" value="<?php echo $cat['CategoryID']; ?>" class="popular_category" /> <?php echo $cat['breadcrumb']; ?></p>
                <?php } ?>
              </div>
            </div>
            <?php } else { ?>
            <input type="hidden" name="popular" value="" />
            <?php } ?>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_category_suggested; ?><br /><span id="suggested-categories-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <div id="suggested-cats"></div>
              </div>
            </div>
            <div class="form-group" id="category-selections-row">
              <label class="col-sm-2 control-label"><?php echo $text_category; ?><br /><span id="category-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <div class="row form-group">
                  <div class="col-sm-12">
                    <select id="catsSelect1" class="form-control" onchange="loadCategories(2);"></select>
                  </div>
                </div>
                <div class="row form-group">
                  <div class="col-sm-12">
                    <select id="catsSelect2" class="form-control" onchange="loadCategories(3);" style="display:none;"></select>
                  </div>
                </div>
                <div class="row form-group">
                  <div class="col-sm-12">
                    <select id="catsSelect3" class="form-control" onchange="loadCategories(4);" style="display:none;"></select>
                  </div>
                </div>
                <div class="row form-group">
                  <div class="col-sm-12">
                    <select id="catsSelect4" class="form-control" onchange="loadCategories(5);" style="display:none;"></select>
                  </div>
                </div>
                <div class="row form-group">
                  <div class="col-sm-12">
                    <select id="catsSelect5" class="form-control" onchange="loadCategories(6);" style="display:none;"></select>
                  </div>
                </div>
                <div class="row form-group">
                  <div class="col-sm-12">
                    <select id="catsSelect6" class="form-control" onchange="loadCategories(7);" style="display:none;"></select>
                  </div>
                </div>
                <input type="hidden" name="finalCat" id="finalCat" />
              </div>
            </div>
            <div class="form-group" id="condition-container" style="display: none;">
              <label class="col-sm-2 control-label"><?php echo $text_listing_condition; ?><br /><span id="condition-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <select name="condition" id="condition-input" class="form-control" style="display: none;"></select>
              </div>
            </div>
            <div class="form-group" id="duration-container" style="display: none;">
              <label class="col-sm-2 control-label"><?php echo $text_listing_duration; ?><br /><span id="duration-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <select name="auction_duration" id="duration-input" class="form-control" style="display: none;"></select>
              </div>
            </div>
          </div>

          <div id="tab-listing-feature" class="tab-pane">
            <div class="alert alert-info"><?php echo $text_features_help; ?></div>
            <div class="form-group">
              <div class="col-sm-12">
                <span id="feature-loading" style="display: none;"><i class="fa fa-cog fa-lg fa-spin"></i></span>
                <div id="feature-content"></div>
              </div>
            </div>
          </div>

          <div id="tab-listing-catalog" class="tab-pane">
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_search_catalog; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-3">
                    <input type="text" name="catalog_search" id="catalog_search" class="form-control" value="" />
                  </div>
                  <div class="col-sm-1">
                    <a class="btn btn-primary" id="button-catalog-search"><i class="fa fa-search"></i> <?php echo $button_search; ?></a>
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_catalog; ?></label>
              <div class="col-sm-10">
                <input type="hidden" value="0" name="catalog_image">
                <input id="catalog_image" type="checkbox" value="1" name="catalog_image">
                <span class="help-block"><?php echo $text_catalog_help; ?></span>
              </div>
            </div>
            <div class="row" id="product-catalog-container"></div>
          </div>

          <div id="tab-listing-description" class="tab-pane">
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_title; ?></label>
              <div class="col-sm-10">
                <input type="text" name="name" value="<?php echo $product['name']; ?>" size="85" id="name" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_subtitle; ?></label>
              <div class="col-sm-10">
                <input type="text" name="sub_name" value="" size="85" id="sub_name" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_description; ?></label>
              <div class="col-sm-10">
                <textarea name="description" placeholder="<?php echo $entry_description; ?>" id="descriptionField"><?php echo $product['description']; ?></textarea>
              </div>
            </div>
          </div>

          <div id="tab-listing-images" class="tab-pane">
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_profile_load; ?><br /><span id="profile-theme-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <select name="profile_theme" id="profile-theme-input" class="form-control">
                  <option value="def"><?php echo $text_select; ?></option>
                  <?php if (is_array($product['profiles_theme'])) { ?>
                  <?php foreach ($product['profiles_theme'] as $profile) { ?>
                  <?php echo '<option value="'.$profile['ebay_profile_id'].'">'.$profile['name'].'</option>'; ?>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">
                <?php echo $text_template; ?>
                <br /><a href="http://shop.openbaypro.com/opencart_design_services/opencart_theme_design/ebay_html_template_openbay_pro" target="_BLANK"><?php echo $text_template_link; ?></a>
              </label>
              <div class="col-sm-10">
                <select name="template" id="template_id" class="form-control">
                  <option value="None">None</option>
                  <?php if (is_array($product['templates']) && !empty($product['templates'])) { ?>
                  <?php foreach($product['templates'] as $template) { ?>
                  <?php echo '<option value="'.$template['template_id'].'">'.$template['name'].'</option>'; ?>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_image_gallery; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-3">
                    <div class="input-group">
                      <span class="input-group-addon"><?php echo $text_height; ?></span>
                      <input type="text" name="gallery_height" value="<?php echo $product['defaults']['gallery_height']; ?>" maxlength="4" class="form-control" id="gallery_height" />
                      <span class="input-group-addon"><?php echo $text_px; ?></span>
                    </div>
                  </div>
                  <div class="col-sm-3">
                    <div class="input-group">
                      <span class="input-group-addon"><?php echo $text_width; ?></span>
                      <input type="text" name="gallery_width" value="<?php echo $product['defaults']['gallery_width']; ?>" maxlength="4" class="form-control" id="gallery_width" />
                      <span class="input-group-addon"><?php echo $text_px; ?></span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_image_thumb; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-3">
                    <div class="input-group">
                      <span class="input-group-addon"><?php echo $text_height; ?></span>
                      <input type="text" name="thumb_height" value="<?php echo $product['defaults']['thumb_height']; ?>" maxlength="4" class="form-control" id="thumb_height" />
                      <span class="input-group-addon"><?php echo $text_px; ?></span>
                    </div>
                  </div>
                  <div class="col-sm-3">
                    <div class="input-group">
                      <span class="input-group-addon"><?php echo $text_width; ?></span>
                      <input type="text" name="thumb_width" value="<?php echo $product['defaults']['thumb_width']; ?>" maxlength="4" class="form-control" id="thumb_width" />
                      <span class="input-group-addon"><?php echo $text_px; ?></span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_images_supersize; ?></label>
              <div class="col-sm-10">
                <input type="hidden" name="gallery_super" value="0" />
                <input type="checkbox" name="gallery_super" value="1" id="gallery_super" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_images_gallery_plus; ?></label>
              <div class="col-sm-10">
                <input type="hidden" name="gallery_plus" value="0" />
                <input type="checkbox" name="gallery_plus" value="1" id="gallery_plus" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_gallery_select_all; ?></label>
              <div class="col-sm-10">
                <p><input type="checkbox" name="allTemplateImages" value="1" id="allTemplateImages" style="margin-top:2px;" /> - <?php echo $text_template_images; ?></p>
                <p><input type="checkbox" name="allEbayImages" value="1" id="allEbayImages" style="margin-top:2px;" /> - <?php echo $text_ebay_images; ?></p>
              </div>
            </div>
            <div class="alert alert-info">
              <p>* <?php echo $text_images_text_1; ?></p>
              <p>* <?php echo $text_images_text_2; ?></p>
            </div>
            <div class="row">
              <?php if (!empty($product['product_images'])) { ?>
                <?php $i = 0; ?>
                <?php foreach($product['product_images'] as $img) { ?>
                  <div class="col-sm-3">
                    <div class="well">
                      <div class="row">
                        <div class="col-sm-12 text-center"><img src="<?php echo $img['preview']; ?>" class="img-thumbnail" /></div>
                      </div>
                      <div class="row">
                        <div class="col-sm-12 text-center"><input type="checkbox" id="imgUrl<?php echo $i; ?>" name="img_tpl[<?php echo $i; ?>]" value="<?php echo $img['image']; ?>" class="checkboxTemplateImage" /> <?php echo $text_template_image; ?></div>
                      </div>
                      <div class="row">
                        <div class="col-sm-12 text-center">
                          <input type="hidden" name="img[<?php echo $i; ?>]" value="null" />
                          <input type="checkbox" class="checkboxEbayImage" onchange="toggleRad(<?php echo $i; ?>);" id="image-checkbox-<?php echo $i; ?>" name="img[<?php echo $i; ?>]" value="<?php echo $img['image']; ?>" <?php echo ( ($i == 0) ? 'checked="checked" ' : ''); ?> /> <?php echo $text_image_ebay; ?>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-sm-12 text-center">
                          <input type="radio" name="main_image"<?php echo (($i == 0) ? ' checked' : ''); ?> value="<?php echo $i; ?>" id="image-radio-<?php echo $i; ?>" <?php echo ( ($i == 0) ? '' : 'disabled="disabled"'); ?> /> <?php echo $text_main_image_ebay; ?>
                        </div>
                      </div>
                    </div>
                  </div>
                  <?php $i++; ?>
                <?php } ?>
              <?php } else { ?>
                <div class="col-sm-2">
                  <div class="alert alert-danger"><?php echo $text_images_none; ?></div>
                </div>
              <?php } ?>
            </div>

<!-- OPENSTOCK CHANGES START @TODO -->
            <?php if (!empty($addon['openstock']) && $addon['openstock'] == true && !empty($product['options'])) { ?>
              <h2><?php echo $text_option_images; ?></h2>
              <p><?php echo $text_option_description; ?></p>
              <table class="form">
                  <tr>
                      <td><?php echo $text_option_images_grp; ?></td>
                      <td>
                          <select name="option_image_group" id="option_image_group">
                              <option value="def">-- <?php echo $text_select; ?> --</option>
                              <?php foreach($product['option_grp'] as $option_group) { echo'<option value="'.$option_group['option_id'].'">'.$option_group['name'].'</option>'; } ?>
                          </select>
                          <input type="hidden" id="option_image_group_name" name="option_image_group_name" value="" />
                      </td>
                  </tr>
                  <tr class="option_group_img_tr displayNone">
                      <td><?php echo $text_option_images_choice; ?></td>
                      <td>
                          <?php foreach($product['option_grp'] as $option_group) { ?>
                              <div id="option_group_img_<?php echo $option_group['option_id']; ?>" class="option_group_img">
                                  <table class="form">
                                      <?php foreach($option_group['product_option_value'] as $option_group_choice) { ?>
                                          <tr>
                                              <td>
                                                  <h4><?php echo $option_group_choice['name']; ?></h4>
                                                  <input type="hidden" name="option_image[<?php echo $option_group['option_id']; ?>][<?php echo $option_group_choice['product_option_value_id']; ?>][name]" value="<?php echo $option_group_choice['name']; ?>" />
                                                  <div class="buttons">
                                                      <a onclick="addVariationImage(<?php echo $option_group['option_id']; ?>, <?php echo $option_group_choice['product_option_value_id']; ?>);" class="button cursor"><span><?php echo $text_add; ?></span></a>
                                                  </div>
                                              </td>
                                              <td class="center" id="option_images_<?php echo $option_group_choice['product_option_value_id']; ?>">
                                                  <?php $x = 0; if (!empty($option_group_choice['image_thumb']) && ($option_group_choice['image'] != 'no_image.jpg')) { $x++; ?>
                                                      <div class="border p10 mBottom10 width100 left floatLeft mRight10" id="option_image_<?php echo $option_group['option_id']; ?>_<?php echo $option_group_choice['product_option_value_id']; ?>_<?php echo $x; ?>">
                                                          <img src="<?php echo $option_group_choice['image_thumb']; ?>" />
                                                          <input type="hidden" name="option_image[<?php echo $option_group['option_id']; ?>][<?php echo $option_group_choice['product_option_value_id']; ?>][images][]" value="<?php echo $option_group_choice['image']; ?>" />
                                                          <p class="textCenter"><a class="cursor" onclick="removeVariationImage(<?php echo $option_group['option_id']; ?>, <?php echo $option_group_choice['product_option_value_id']; ?>, <?php echo $x; ?>);"><?php echo $text_remove; ?></a></p>
                                                      </div>
                                                  <?php } ?>
                                                  <div style="clear:both"></div>
                                                  <input type="hidden" name="option_image_count_<?php echo $option_group['option_id']; ?>" id="option_image_count_<?php echo $option_group['option_id']; ?>" value="<?php echo $x; ?>" />
                                              </td>
                                          </tr>
                                      <?php } ?>
                                  </table>
                              </div>
                          <?php } ?>
                      </td>
                  </tr>
              </table>
            <?php } ?>
<!-- OPENSTOCK CHANGES FINSISH @TODO -->

          </div>

          <div id="tab-listing-price" class="tab-pane">
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_profile_load; ?><br /><span id="profile-generic-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <select name="profile_generic" id="profile-generic-input" class="form-control">
                  <option value="def"><?php echo $text_select; ?></option>
                  <?php if (is_array($product['profiles_generic'])) { foreach($product['profiles_generic'] as $profile) { ?>
                  <?php echo '<option value="'.$profile['ebay_profile_id'].'">'.$profile['name'].'</option>'; ?>
                  <?php } }?>
                </select>
              </div>
            </div>

<!-- OPENSTOCK CHANGES START @TODO -->

            <?php if (!empty($addon['openstock']) && $addon['openstock'] == true && !empty($product['options'])) { ?>
              <table class="form">
                      <tr>
                          <td><?php echo $text_stock_matrix; ?></td>
                          <td>
                              <table class="list m0">
                                  <thead>
                                      <tr>
                                          <td class="center"><?php echo $text_stock_col_qty_total; ?></td>
                                          <td class="center"><?php echo $text_stock_col_qty; ?></td>
                                          <td class="center"><?php echo $text_stock_col_qty_reserve; ?></td>
                                          <td class="left"><?php echo $text_stock_col_comb; ?></td>
                                          <td class="left"><?php echo $text_price_ex_tax; ?></td>
                                          <td class="left"><?php echo $text_price_inc_tax; ?></td>
                                          <td class="center"><?php echo $text_stock_col_enabled; ?></td>
                                      </tr>
                                  </thead>
                                  <tbody>
                                  <?php $t = array(); ?>
                                  <?php $t_rel = array(); ?>
<?php
                                  foreach($product['option_grp'] as $key => $grp) {
                                      $t_tmp = array();
                                      foreach($grp['product_option_value'] as $grp_node) {
                                          $t_tmp[$grp_node['option_value_id']] = $grp_node['name'];

                                          $t_rel[$grp_node['product_option_value_id']] = $grp['name'];
                                      }
                                      $t[] = array('name' => $grp['name'], 'child' => $t_tmp);
                                  }

                                  echo'<input type="hidden" name="optGroupArray" value="'.  base64_encode(serialize($t)).'" />';
                                  echo'<input type="hidden" name="optGroupRelArray" value="'.  base64_encode(serialize($t_rel)).'" />';

                                      $v = 0;
                                      foreach($product['options'] as $option) {
                                          if ($v == 0) {
                                              //create a php version of the opt array to use on server side
                                              echo'<input type="hidden" name="optArray" value="'.  base64_encode(serialize($option['opts'])).'" />';
                                          }

                                          echo'<input type="hidden" name="opt['.$v.'][sku]" value="'.$option['var'].'" />';

                                          echo'<input type="hidden" name="opt['.$v.'][active]" value="';
                                          if ($option['active'] == 1) {  echo '1'; } else { echo '0'; }
                                          echo '" />';

                                          if ($option['price'] == 0) {
                                              $option['price'] = $product['price'];
                                          }

                                          echo'<tr>';
                                              echo'<input type="hidden" name="varPriceExCount" class="varPriceExCount" value="'.$v.'" />';
                                              echo'<td class="center width50">'.$option['stock'].'</td>';
                                              echo'<td class="center width50"><input id="qty_'.$v.'" type="text" name="opt['.$v.'][qty]" value="'.$option['stock'].'" onkeyup="updateReserveMessage('.$v.', '.$option['stock'].');" class="width50 textCenter"/></td>';
                                              echo'<td class="center width50" id="qty_reserve_'.$v.'">0</td>';
                                              echo'<td class="left">'.$option['combi'].'</td>';
                                              echo'<td class="left width100"><input id="varPriceEx_'.$v.'" onkeyup="updateVarPriceFromEx('.$v.');" type="text" name="opt['.$v.'][priceex]" value="'.number_format($option['price'], 2, '.', '').'" style="width:80px;" /></td>';
                                              echo'<td class="left width100"><input class="varPriceInc" id="varPriceInc_'.$v.'" onkeyup="updateVarPriceFromInc('.$v.');"  type="text" name="opt['.$v.'][price]" value="0" style="width:80px;" /></td>';
                                              echo'<td class="center width100"'; if ($option['active'] != 1) { echo' style="background-color: #CC9933;"';} echo'>'; if ($option['active'] == 1) { echo $text_yes; } else { echo $text_no; } echo '</td>';
                                          echo'</tr>';

                                          echo'<tr><td colspan="4" class="optSpecifics" id="optSpecifics'.$v.'">';

                                          echo'</td></tr>';
                                          $v++;
                                      }
  ?>
                                  </tbody>
                              </table>
                          </td>
                      </tr>
                      <tr>
                          <td><?php echo $text_tax_inc; ?></td>
                          <td><input type="text" name="tax" id="taxRate" onkeyup="updateVarPrice();" value="<?php echo $product['defaults']['tax']; ?>" class="textRight width50" /> %</td>
                      </tr>
              </table>
            <?php } else { ?>
<!-- OPENSTOCK CHANGES FINSISH @TODO -->

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_qty; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="qty[0]" id="qty_0" value="<?php echo $product['quantity']; ?>" class="form-control" onkeyup="updateReserveMessage('0', '<?php echo $product['quantity']; ?>');" />
                  <span class="help-block">Total in stock: <?php echo $product['quantity']; ?><br/><span id="qty_reserve_0">0</span> will be reserved</span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_price_ex_tax; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="price_no_tax[0]" id="taxEx" value="<?php echo number_format($product['price'], 2, '.', ''); ?>" class="form-control" onkeyup="updatePriceFromEx();" />
                  <span class="help-block"><?php echo $text_price_ex_tax_help; ?></span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_price_inc_tax; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="price[0]" id="taxInc" value="<?php echo number_format($product['price'], 2, '.', ''); ?>" class="form-control" onkeyup="updatePriceFromInc();" />
                  <span class="help-block"><?php echo $text_price_inc_tax_help; ?></span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_tax_inc; ?></label>
                <div class="col-sm-10">
                  <div class="input-group col-xs-2">
                    <input type="text" name="tax" value="<?php echo $product['defaults']['tax']; ?>" id="taxRate" class="form-control text-right" onkeyup="updatePriceFromEx();" />
                    <span class="input-group-addon">%</span>
                  </div>
                </div>
              </div>
            <?php } ?>
            <?php if (empty($product['options'])) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_offers; ?></label>
                <div class="col-sm-10">
                  <input type="hidden" name="bestoffer" value="0" />
                  <input type="checkbox" name="bestoffer" value="1" id="bestoffer" />
                </div>
              </div>
            <?php } ?>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_private; ?></label>
              <div class="col-sm-10">
                <input type="hidden" name="private_listing" value="0" />
                <input type="checkbox" name="private_listing" value="1" id="private_listing" />
              </div>
            </div>
          </div>

          <div id="tab-listing-payment" class="tab-pane">
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_imediate_payment; ?></label>
              <div class="col-sm-10">
                <input type="hidden" name="ebay_payment_immediate" value="0" />
                <input type="checkbox" name="ebay_payment_immediate" value="1" id="ebay_payment_immediate" <?php if ($product['defaults']['ebay_payment_immediate'] != 1) { echo'checked '; } ?> />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_payment; ?></label>
              <div class="col-sm-10">
                <?php $paypal = false; ?>
                <?php foreach($product['payments'] as $payment) { ?>
                  <?php if ($payment['ebay_name'] == 'PayPal') { ?>
                    <?php $paypal = true; ?>
                  <?php } else { ?>
                    <p><input type="checkbox" name="payments[<?php echo $payment['ebay_name']; ?>]" value="1" <?php echo ($product['defaults']['ebay_payment_types'][$payment['ebay_name']] == 1 ? 'checked="checked" ' : ''); ?>/> - <?php echo $payment['local_name']; ?></p>
                  <?php } ?>
                <?php } ?>
              </div>
            </div>
            <?php if ($paypal == true) { ?>
            <div class="form-group">
              <label class="col-sm-2 control-label">PayPal</label>
              <div class="col-sm-10">
                <div class="input-group">
                  <span class="input-group-addon">
                    <input type="checkbox" name="payments[PayPal]" value="1" <?php echo ($product['defaults']['ebay_payment_types']['PayPal'] == 1 ? 'checked="checked" ' : ''); ?> />
                  </span>
                  <input type="text" class="form-control" name="paypal_email" value="<?php echo $product['defaults']['paypal_address']; ?>" placeholder="<?php echo $text_paypal; ?>"/>
                </div>
              </div>
            </div>
            <?php } ?>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_payment_instruction; ?></label>
              <div class="col-sm-10">
                <textarea name="payment_instruction" class="form-control" rows="3" id="payment_instruction"><?php echo $product['defaults']['payment_instruction']; ?></textarea>
              </div>
            </div>
          </div>

          <div id="tab-listing-shipping" class="tab-pane">
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_profile_load; ?><br /><span id="profile-shipping-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <select name="profile_shipping" id="profile-shipping-input" class="form-control">
                  <option value="def"><?php echo $text_select; ?></option>
                  <?php if (is_array($product['profiles_shipping'])) { foreach($product['profiles_shipping'] as $profile) { ?>
                    <?php echo '<option value="'.$profile['ebay_profile_id'].'">'.$profile['name'].'</option>'; ?>
                  <?php } }?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_item_postcode; ?></label>
              <div class="col-sm-10">
                <input type="text" name="postcode" id="postcode" class="form-control" />
                <span class="help-block"><?php echo $text_item_postcode_help; ?></span>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_item_location; ?></label>
              <div class="col-sm-10">
                <input type="text" name="location" id="location" class="form-control" />
                <span class="help-block"><?php echo $text_item_location_help; ?></span>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_despatch_country; ?></label>
              <div class="col-sm-10">
                <select name="country" id="country" class="form-control">
                  <?php foreach($setting['countries'] as $country) { ?>
                  <option value="<?php echo $country['code'];?>"><?php echo $country['name'];?></option>
                  <?php } ?>
                </select>
                <span class="help-block"><?php echo $text_despatch_country_help; ?></span>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_despatch_time; ?></label>
              <div class="col-sm-10">
                <select name="dispatch_time" id="dispatch_time" class="form-control">
                  <?php foreach($setting['dispatch_times'] as $dis) { ?>
                  <option value="<?php echo $dis['DispatchTimeMax'];?>"><?php echo $dis['Description'];?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_shipping_desc; ?></label>
              <div class="col-sm-10">
                <input type="hidden" name="shipping_in_desc" value="0" />
                <input type="checkbox" name="shipping_in_desc" value="1" id="shipping_in_desc" />
                <span class="help-block"><?php echo $text_shipping_desc_help; ?></span>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_shipping_getitfast; ?></label>
              <div class="col-sm-10">
                <input type="hidden" name="get_it_fast" value="0" />
                <input type="checkbox" name="get_it_fast" value="1" id="get_it_fast" />
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-2">
                <div class="row">
                  <div class="col-sm-12 text-right">
                    <p><label class="control-label text-right"><?php echo $text_shipping_national; ?></label></p>
                  </div>
                </div>
                <div class="row" id="maxShippingAlert" style="display:none;">
                  <div class="col-sm-12">
                    <div class="alert alert-warning"><?php echo $text_shipping_max_national; ?></div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12 text-right">
                    <p><a class="btn btn-primary" id="add-shipping-national" onclick="addShipping('national');"><i class="fa fa-plus-circle"></i> <?php echo $button_service; ?></a></p>
                  </div>
                </div>
              </div>
              <div class="col-sm-10">
                <div class="row">
                  <input type="hidden" name="count_national" value="0" id="count_national" />
                  <div class="col-sm-12" id="national-shipping-options"></div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-2">
                <div class="row">
                  <div class="col-sm-12 text-right">
                    <p><label class="control-label text-right"><?php echo $text_shipping_international; ?></label></p>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12 text-right">
                    <p><a class="btn btn-primary" id="add-shipping-international" onclick="addShipping('international');"><i class="fa fa-plus-circle"></i> <?php echo $button_service; ?></a></p>
                  </div>
                </div>
              </div>
              <div class="col-sm-10">
                <div class="row">
                  <input type="hidden" name="count_international" value="0" id="count_international" />
                  <div class="col-sm-12" id="international-shipping-options"></div>
                </div>
              </div>
            </div>
          </div>

          <div id="tab-listing-returns" class="tab-pane">
            <div class="form-group">
              <label class="col-sm-2 control-label"><?php echo $text_profile_load; ?><br /><span id="profile-returns-loading" style="display: none;"><a class="btn btn-info" disabled="disabled"><i class="fa fa-cog fa-lg fa-spin"></i></a></span></label>
              <div class="col-sm-10">
                <select name="profile_return" id="profile-return-input" class="form-control">
                  <option value="def"><?php echo $text_select; ?></option>
                  <?php if (is_array($product['profiles_returns'])) { foreach($product['profiles_returns'] as $profile) { ?>
                  <option value="<?php echo $profile['ebay_profile_id']; ?>"><?php echo $profile['name']; ?></option>
                  <?php } } ?>
                </select>
              </div>
            </div>
            <?php if (!empty($setting['returns']['accepted'])) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_return_accepted; ?></label>
                <div class="col-sm-10">
                  <select name="returns_accepted" id="returns_accepted" class="form-control">
                    <?php foreach($setting['returns']['accepted'] as $v) { ?>
                    <option value="<?php echo $v['ReturnsAcceptedOption']; ?>"><?php echo $v['Description']; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            <?php } ?>
            <?php if (!empty($setting['returns']['within'])) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_return_days; ?></label>
                <div class="col-sm-10">
                  <select name="returns_within" id="returns_within" class="form-control">
                    <?php foreach($setting['returns']['within'] as $v) { ?>
                    <option value="<?php echo $v['ReturnsWithinOption']; ?>"><?php echo $v['Description']; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            <?php } ?>
            <?php if (!empty($setting['returns']['paidby'])) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_return_scosts; ?></label>
                <div class="col-sm-10">
                  <select name="returns_shipping" id="returns_shipping" class="form-control">
                    <?php foreach($setting['returns']['paidby'] as $v) { ?>
                    <option value="<?php echo $v['ShippingCostPaidByOption']; ?>"><?php echo $v['Description']; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            <?php } ?>
            <?php if (!empty($setting['returns']['refund'])) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_return_type; ?></label>
                <div class="col-sm-10">
                  <select name="returns_option" id="returns_option" class="form-control">
                    <?php foreach($setting['returns']['refund'] as $v) { ?>
                    <option value="<?php echo $v['RefundOption']; ?>"><?php echo $v['Description']; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            <?php } ?>
            <?php if ($setting['returns']['description'] == true) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_return_policy; ?></label>
                <div class="col-sm-10">
                  <textarea name="return_policy" class="form-control" rows="3" id="return_policy"></textarea>
                </div>
              </div>
            <?php } ?>
            <?php if (!empty($setting['returns']['restocking_fee'])) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_return_restock; ?></label>
                <div class="col-sm-10">
                  <select name="returns_restocking_fee" id="returns_restocking_fee" class="form-control">
                    <?php foreach($setting['returns']['restocking_fee'] as $v) { ?>
                    <option value="<?php echo $v['RestockingFeeValueOption']; ?>"><?php echo $v['Description']; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
            <?php } ?>
          </div>

          <div class="well">
            <div class="row">
              <div class="col-sm-12 text-right">
                <a class="btn btn-primary" id="button-verify"><span><?php echo $text_verify; ?></span></a>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>

    <div class="panel-body" style="display: none;" id="page-review">
      <div class="alert alert-info" id="listing-fee-container"></div>
      <div class="well">
        <div class="row">
          <div class="col-sm-6 text-left">
            <a class="btn btn-primary" target="_BLANK" id="button-preview" style="display:none;"><i class="fa fa-external-link fa-lg"></i> <?php echo $text_preview; ?></a>
            <a class="btn btn-primary" id="button-edit"><i class="fa fa-pencil fa-lg"></i> <?php echo $text_review_edit; ?></a>
          </div>
          <div class="col-sm-6 text-right">
            <a class="btn btn-primary" id="button-save"><i class="fa fa-save fa-lg"></i> <?php echo $button_save_listing; ?></a>
          </div>
        </div>
      </div>
    </div>
    <div class="panel-body" style="display: none;" id="page-complete">
      <div class="alert alert-success">
        <h5><?php echo $text_created_title; ?></h5>
        <p><?php echo $text_created_msg; ?>: <span id="item-number"></span></p>
      </div>
      <div class="well">
        <div class="row">
          <div class="col-sm-6 text-left">
            <a class="btn btn-primary" id="button-view" target="_BLANK"><i class="fa fa-external-link fa-lg"></i> <?php echo $text_view; ?></a>
            <a class="btn btn-primary" href="<?php echo $product['edit_link']; ?>"><i class="fa fa-pencil fa-lg"></i> <?php echo $text_edit; ?></a>
          </div>
          <div class="col-sm-6 text-right">
            <a class="btn btn-primary" href="<?php echo $cancel; ?>"><i class="fa fa-reply fa-lg"></i> <?php echo $text_return; ?></a>
          </div>
        </div>
      </div>
    </div>
    <div class="panel-body" style="display: none;" id="page-failed">
      <div class="alert alert-danger">
        <h5><?php echo $text_failed_title; ?></h5>
        <p><?php echo $text_failed_msg1; ?></p>
        <ul>
          <li><?php echo $text_failed_li1; ?></li>
          <li><?php echo $text_failed_li2; ?></li>
          <li><?php echo $text_failed_li3; ?></li>
        </ul>
        <p><?php echo $text_failed_contact; ?></p>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

<script type="text/javascript"><!--
  CKEDITOR.replace('description', {
    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
  });

  function updateReserveMessage(elementId, total) {
      var reserve = total - $('#qty_'+elementId).val();
      $('#qty_reserve_'+elementId).text(reserve);
  }

  function getSuggestedCategories() {
        var qry = $('#name').val();
        $.ajax({
            url: 'index.php?route=openbay/ebay/getSuggestedCategories&token=<?php echo $token; ?>&qry='+qry,
            type: 'GET',
            dataType: 'json',
            beforeSend: function() {
              $('#suggested-categories-loading').show();
            },
            success: function(data) {
                if (data.error == false) {
                    $('#suggested-cats').empty();

                    var htmlInj = '';

                        if (data.data) {
                            htmlInj += '<p><input type="radio" name="suggested" value="" id="suggested_default" checked="checked"/> <strong><?php echo $text_none; ?></strong></p>';

                            data.data = $.makeArray(data.data);

                            $.each(data.data, function(key,val) {
                                if (val.percent != 0) {
                                    htmlInj += '<p><input type="radio" class="suggested_category" name="suggested" value="'+val.id+'" /> ('+val.percent+'% match) '+val.name+'</p>';
                                }
                            });
                        }

                        $('#suggested-cats').html(htmlInj);
                        $('input[name=suggested]').bind('change', function() {

                        if ($(this).val() != '') {
                            categorySuggestedChange($(this).val());
                        }
                    });

                  $('.suggested_category').bind('click', function() {
                    $('#category-selections-row').hide();
                    $('input[name=popular]').removeAttr('checked');
                    $('#popular_default').prop('checked', true);
                  });

                  $('.popular_category').bind('click', function() {
                    $('#category-selections-row').hide();
                    $('input[name=suggested]').removeAttr('checked');
                    $('#suggested_default').prop('checked', true);
                  });

                  $('#suggested_default').bind('click', function() {
                    $('#category-selections-row').show();
                    $('#showFeatureDiv').hide();
                    $('#product-catalog-container').hide();
                    $('#feature-content').empty();
                    $('#specifics').empty();
                    $('input[name=popular]').removeAttr('checked');
                    $('#popular_default').prop('checked', 'checked');
                  });
                } else {
                    alert(data.msg);
                }

                $('#suggested-categories-loading').hide();
            },
            error: function (xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

  function categoryFavChange(id) {
        loadCategories(1, true);
        $('input[name=finalCat]').attr('value', id);
        getCategoryFeatures(id);
    }

  function categorySuggestedChange(id) {
        loadCategories(1, true);
        $('input[name=finalCat]').attr('value', id);
        getCategoryFeatures(id);
    }

  function loadCategories(level, skip) {
        $('#showFeatureDiv').hide();
        $('#product-catalog-container').hide();
        $('#feature-content').empty();
        $('#specifics').empty();

        if (level == 1) {
            var parent = '';
        } else {
            var prevLevel = level - 1;
            var parent = $('#catsSelect'+prevLevel).val();
            $('#popular_default').attr('checked', true);
        }

        var countI = level;

        while(countI <= 6) {
            $('#catsSelect'+countI).hide().empty();
            countI++;
        }

        $.ajax({
            url: 'index.php?route=openbay/ebay/getCategories&token=<?php echo $token; ?>&parent='+parent,
            type: 'POST',
            dataType: 'json',
            beforeSend: function() {
                $('#category-loading').show();
            },
            success: function(data) {
                if (data.items != null) {
                    $('#catsSelect'+level).empty();
                    $('#catsSelect'+level).append('<option value="">-- <?php echo $text_select; ?> --</option>');

                    data.cats = $.makeArray(data.cats);

                    $.each(data.cats, function(key, val) {
                        if (val.CategoryID != parent) {
                            $('#catsSelect'+level).append('<option value="'+val.CategoryID+'">'+val.CategoryName+'</option>');
                        }
                    });

                    if (skip != true) {
                        $('#finalCat').val('');
                    }

                    $('#catsSelect'+level).show();
                } else {
                    if (data.error) {
                        alert(data.error);
                        $('#button-verify').hide();
                        $('#content').prepend('<div class="alert alert-warning"><?php echo $text_ajax_catproblem; ?></div>');
                        $('#page-listing, .heading').hide();
                    } else {
                        $('#finalCat').val($('#catsSelect'+prevLevel).val());
                        getCategoryFeatures($('#catsSelect'+prevLevel).val());
                    }
                }
                $('#category-loading').hide();
            },
            error: function (xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

  function getCategoryFeatures(cat) {
        itemFeatures(cat);

        $('#duration-input').hide();
        $('#duration-loading').show();
        $('#duration-container').show();
        $('#condition-input').hide();
        $('#condition-loading').show();
        $('#condition-container').show();

        $.ajax({
            url: 'index.php?route=openbay/ebay/getCategoryFeatures&token=<?php echo $token; ?>&category='+cat,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                if (data.error == false) {
                    var htmlInj = '';
                    listingDuration(data.data.durations);

                    if (data.data.maxshipping != false) {
                        $('#maxShippingAlert').append(data.data.maxshipping).show();
                    }

                    if (data.data.conditions && data.data.conditions != '') {
                        data.data.conditions = $.makeArray(data.data.conditions);

                        $.each(data.data.conditions, function(key, val) {
                            htmlInj += '<option value='+val.id+'>'+val.name+'</option>';
                        });

                        $('#condition-input').empty().html(htmlInj).show();
                        $('#condition-loading').hide();
                    } else {
                      $('#condition-loading').hide();
                      $('#condition-container').hide();
                    }
                } else {
                    if (data.msg == null) {
                        alert('<?php echo $text_error_features; ?>');
                    } else {
                        alert(data.msg);
                    }
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

  $('#button-catalog-search').bind('click', function() {
        var qry = $('#catalog_search').val();
        var cat = $('#finalCat').val();

        if (cat <= 0) {
            alert('<?php echo $text_error_choose_category; ?>');
            return;
        }

        if (qry == '') {
            alert('<?php echo $text_error_enter_text; ?>');
            return;
        }

        var html = '';

        $.ajax({
            url: 'index.php?route=openbay/ebay/searchEbayCatalog&token=<?php echo $token; ?>',
            type: 'POST',
            dataType: 'json',
            data: { categoryId: cat, page: 1,  search: qry },
            beforeSend: function() {
                $('#product-catalog-container').empty().show();
                $('#button-catalog-search').empty().html('<i class="fa fa-cog fa-lg fa-spin"></i>').attr('disabled','disabled');
                $('#catalog-search-alert').remove();
            },
            success: function(data) {
                if (data.error == false) {
                    if (data.data.productSearchResult.paginationOutput.totalEntries == 0 || data.data.ack == 'Failure') {
                        $('#product-catalog-container').before('<div class="alert alert-warning" id="catalog-search-alert"><?php echo $text_error_no_catalog_data; ?></div>');
                    } else {
                        data.data.productSearchResult.products = $.makeArray(data.data.productSearchResult.products);

                        $.each(data.data.productSearchResult.products, function(key, val) {
                          html = '<div class="col-sm-3">';
                            html += '<div class="well">';
                              html += '<div class="row">';
                                html += '<div class="col-sm-12 text-left"><input type="radio" name="catalog_epid" value="'+val.productIdentifier.ePID+'" /></div>';
                              html += '</div>';
                              html += '<div class="row">';
                                html += '<div class="col-sm-12 text-center" style="height:125px;">';
                                if (typeof(val.stockPhotoURL) != "undefined" && val.stockPhotoURL !== null) {
                                  html += '<img class="img-thumbnail" src="'+val.stockPhotoURL.thumbnail.value+'" style="height:96px;"/>';
                                } else {
                                  html += '<span class="img-thumbnail"><i class="fa fa-camera fa-5x"></i></span>';
                                }
                                html += '</div>';
                              html += '</div>';
                              html += '<div class="row">';
                                html += '<div class="col-sm-12 text-center" style="min-height:70px;">'+val.productDetails.value.text.value+'</div>';
                              html += '</div>';
                            html += '</div>';
                          html += '</div>';

                          $('#product-catalog-container').append(html);
                        });
                    }
                } else {
                    if (data.msg == null) {
                        alert('<?php echo $text_error_catalog; ?>');
                    } else {
                        alert(data.msg);
                    }
                }

                $('#button-catalog-search').show();
            },
            complete: function() {
              $('#button-catalog-search').empty().removeAttr('disabled').html('<i class="fa fa-search"></i> <?php echo $button_search; ?>');
            },
            error: function (xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });
    });

  function listingDuration(data) {
      var lang            = new Array();
      var listingDefault  = "<?php echo $product['defaults']['listing_duration']; ?>";

      lang["Days_1"]      = '<?php echo $text_listing_1day; ?>';
      lang["Days_3"]      = '<?php echo $text_listing_3day; ?>';
      lang["Days_5"]      = '<?php echo $text_listing_5day; ?>';
      lang["Days_7"]      = '<?php echo $text_listing_7day; ?>';
      lang["Days_10"]     = '<?php echo $text_listing_10day; ?>';
      lang["Days_30"]     = '<?php echo $text_listing_30day; ?>';
      lang["GTC"]         = '<?php echo $text_listing_gtc; ?>';

      htmlInj        = '';

      data = $.makeArray(data);

      $.each(data, function(key, val) {
        htmlInj += '<option value="'+val+'"';
          if (val == listingDefault) { htmlInj += ' selected="selected"'; }
        htmlInj += '>'+lang[val]+'</option>';
      });

      $('#duration-input').empty().html(htmlInj).show();
      $('#duration-loading').hide();
    }

  function itemFeatures(cat) {
        $.ajax({
            url: 'index.php?route=openbay/ebay/getEbayCategorySpecifics&token=<?php echo $token; ?>&category='+cat,
            type: 'GET',
            dataType: 'json',
            beforeSend: function() {
                $('#feature-content').show();
                $('#feature-loading').show();
                $('#showFeatureDiv').show();
                $('#showFeatureDivPreload').hide();
            },
            success: function(data) {
                if (data.error == false) {
                    $('#feature-content').empty();
                    $('.optSpecifics').empty().hide();

                    var htmlInj = '';
                    var htmlInj2 = '';
                    var specificCount = 0;

                    if (data.data.Recommendations.NameRecommendation) {
                        data.data.Recommendations.NameRecommendation = $.makeArray(data.data.Recommendations.NameRecommendation);

                        $.each(data.data.Recommendations.NameRecommendation, function(key, val) {
                          htmlInj2 = '';
                          htmlInj += '<div class="form-group">';
                          htmlInj += '<label class="col-sm-2 control-label">'+val.Name+'</label>';
                          htmlInj += '<div class="col-sm-10">';

                            if (("ValueRecommendation" in val) && (val.ValidationRules.MaxValues == 1)) {
                                htmlInj2 += '<option value="">-- <?php echo $text_select; ?> --</option>';

                                val.ValueRecommendation = $.makeArray(val.ValueRecommendation);

                                $.each(val.ValueRecommendation, function(key2, option) {
                                    htmlInj2 += '<option value="'+option.Value+'">'+option.Value+'</option>';
                                });

                                if (val.ValidationRules.SelectionMode == 'FreeText') {
                                    htmlInj2 += '<option value="Other"><?php echo $text_other; ?></option>';
                                }
                              htmlInj += '<div class="row">';
                                htmlInj += '<div class="col-sm-7">';
                                  htmlInj += '<select name="feat['+val.Name+']" class="form-control" id="spec_sel_'+specificCount+'" onchange="toggleSpecOther('+specificCount+');">'+htmlInj2+'</select>';
                                htmlInj += '</div>';
                                htmlInj += '<div class="col-sm-5" id="spec_'+specificCount+'_other" style="display:none;">';
                                  htmlInj += '<input placeholder="<?php echo $text_other; ?>" type="text" name="featother['+val.Name+']" class="form-control" />';
                                htmlInj += '</div>';
                              htmlInj += '</div>';
                            }else if (("ValueRecommendation" in val) && (val.ValidationRules.MaxValues > 1)) {
                                val.ValueRecommendation = $.makeArray(val.ValueRecommendation);

                              htmlInj += '<div class="row">';
                                $.each(val.ValueRecommendation, function(key2, option) {
                                  htmlInj += '<div class="col-sm-2">';
                                    htmlInj += '<label class="checkbox-inline">';
                                      htmlInj += '<input type="checkbox" name="feat['+val.Name+'][]" value="'+option.Value+'" /> '+option.Value;
                                    htmlInj += '</label>';
                                  htmlInj += '</div>';
                                });
                              htmlInj += '</div>';
                            } else {
                              htmlInj += '<div class="row">';
                                htmlInj += '<div class="col-sm-7">';
                                  htmlInj += '<input type="text" name="feat['+val.Name+']" class="form-control" />';
                                htmlInj += '</div>';
                              htmlInj += '</div>';
                            }

                          htmlInj += '</div>';
                          htmlInj += '</div>';
                          specificCount++;
                        });

                        $('#feature-content').append(htmlInj);
                    } else {
                        $('#feature-content').text('None');
                    }
                } else {
                    if (data.msg == null) {
                        alert('<?php echo $text_error_features; ?>');
                    } else {
                        alert(data.msg);
                    }
                }

                $('#feature-loading').hide();
            },
            error: function (xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

  function toggleSpecOther(id) {
    if ($('#spec_sel_'+id).val() == 'Other') {
        $('#spec_'+id+'_other').show();
    } else {
        $('#spec_'+id+'_other').hide();
    }
  }

  $('#profile-shipping-input').change(function() {
    profileShippingUpdate();
  });

  function profileShippingUpdate() {
    if ($('#profile-shipping-input').val() != 'def') {
      $('#profile-shipping-loading').show();

      $.ajax({
        type:'GET',
        dataType: 'json',
        url: 'index.php?route=openbay/ebay_profile/profileGet&token=<?php echo $token; ?>&ebay_profile_id='+$('#profile-shipping-input').val(),
        success: function(data) {
          setTimeout(function() {
            $('#location').val(data.data.location);
            $('#postcode').val(data.data.postcode);
            $('#dispatch_time').val(data.data.dispatch_time);
            $('#shipping_in_desc').prop('checked', false);
            if (data.data.shipping_in_desc == 1) {
              $('#shipping_in_desc').prop('checked', true);
              $('#shipping_table_rows').hide();
            } else {
              $('#shipping_in_desc').prop('checked', false);
              $('#shipping_table_rows').show();
            }
            if (data.data.get_it_fast == 1) {
              $('#get_it_fast').prop('checked', true);
            } else {
              $('#get_it_fast').prop('checked', false);
            }
            if (typeof data.data.country !== undefined && data.data.country) {
              $('#country').val(data.data.country);
            }
            $('#national-shipping-options').html(data.html.national);
            $('#international-shipping-options').html(data.html.international);
            $('#count_international').val(data.html.international_count);
            $('#count_national').val(data.html.national_count);
            $('#profile-shipping-loading').hide();
          }, 1000);
        },
        error: function (xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    }
  }

  function addShipping(id) {
    if (id == 'national') {
      var loc = '0';
    } else {
      var loc = '1';
    }

    var count = $('#count_' + id).val();
    count = parseInt(count);
    count = count + 1;

    $.ajax({
      url: 'index.php?route=openbay/ebay/getShippingService&token=<?php echo $token; ?>&loc=' + loc,
      beforeSend: function(){
        $('#add-shipping-'+id).empty().html('<i class="fa fa-cog fa-lg fa-spin"></i>').attr('disabled','disabled');
      },
      type: 'GET',
      dataType: 'json',
      success: function(data) {
        html = '';
        html += '<div class="well shipping_' + id + '_' + count + '">';
          html += '<div class="row form-group">';
            html += '<div class="col-sm-1 text-right"><label class="control-label"><?php echo $text_shipping_service; ?><label></div>';
            html += '<div class="col-sm-11">';
              html += '<select name="service_' + id + '[' + count + ']" class="form-control">';
              $.each(data.svc, function(key, val) {
                html += '<option value="' + val.ShippingService + '">' + val.description + '</option>';
              });
              html += '</select>';
            html += '</div>';
          html += '</div>';
          if (id == 'international') {
            html += '<div class="row form-group">';
              html += '<div class="col-sm-1 text-right"><label class="control-label"><?php echo $text_shipping_zones; ?></label></div>';
              html += '<div class="col-sm-10">';
                html += '<label class="checkbox-inline"><input type="checkbox" name="shipto_international[' + count + '][]" value="Worldwide" /> <?php echo $text_shipping_worldwide; ?></label>';
                <?php foreach($data['shipping_international_zones'] as $zone) { ?>
                  html += '<label class="checkbox-inline"><input type="checkbox" name="shipto_international[' + count + '][]" value="<?php echo $zone['shipping_location']; ?>" /> <?php echo $zone['description']; ?></label>';
                <?php } ?>
              html += '</div>';
            html += '</div>';
          }
          html += '<div class="row form-group">';
            html += '<div class="col-sm-1 text-right"><label class="control-label"><?php echo $text_shipping_first; ?></label></div>';
            html += '<div class="col-sm-3"><input type="text" name="price_' + id + '[' + count + ']" class="form-control" value="0.00" class="form-control" /></div>';
            html += '<div class="col-sm-2 text-right"><label class="control-label"><?php echo $text_shipping_add; ?></label></div>';
            html += '<div class="col-sm-3"><input type="text" name="priceadditional_' + id + '[' + count + ']" class="form-control" value="0.00" /></div>';
            html += '<div class="col-sm-2"><a onclick="removeShipping(\'' + id + '\',\'' + count + '\');" class="btn btn-danger"><i class="fa fa-minus-circle"></i> <?php echo $text_remove; ?></a></div>';
          html += '</div>';
        html += '</div>';

        $('#' + id + '-shipping-options').append(html);
        $('#count_' + id).val(count);
      },
      complete: function() {
        $('#add-shipping-'+id).empty().html('<i class="fa fa-plus-circle"></i> <?php echo $text_add; ?>').removeAttr('disabled');
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }

  function removeShipping(id, count) {
      $('.shipping_'+id+'_'+count).remove();
  }

  $('#button-verify').bind('click', function() {
    var err = 0;
    $('.listing-error').remove();

    if ($('.checkboxEbayImage:checked').length > 0) {
      var main_image = $('[name=main_image]:checked').val();
      if (!$('#image-checkbox-'+main_image).attr('checked')) {
        $('#page-listing').prepend('<div class="alert alert-warning listing-error"><?php echo $text_ajax_mainimage; ?></div>');
        err = 1;
      }
    } else {
      $('#page-listing').prepend('<div class="alert alert-warning listing-error"><?php echo $text_ajax_noimages; ?></div>');
      err = 1;
    }

    if ($('#finalCat').val() == '') {
      $('#page-listing').prepend('<div class="alert alert-warning listing-error"><?php echo $text_ajax_error_cat; ?></div>');
      err = 1;
    }

        if ($('#auction_duration').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_duration; ?>');
        }

        if ($('#gallery_height').val() == '' || $('#gallery_width').val() == '' || $('#thumb_height').val() == '' || $('#thumb_width').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_image_size; ?>');
        }

        if ($('#sku').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_error_sku; ?>');
        }

        if ($('#name').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_error_name; ?>');
        }

        if ($('#name').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_error_name_len; ?>');
        }

        if ($('#location').val() == '' && $('#postcode').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_error_loc; ?>');
        }

        if ($('#dispatch_time').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_error_time; ?>');
        }

        if ($('#count_national').val() == 0) {
            err = 1;
            alert('<?php echo $text_ajax_error_nat_svc; ?>');
        }

        if ($('#duration-input').val() == '') {
            err = 1;
            alert('<?php echo $text_ajax_error_duration; ?>');
        }

        <?php if (!empty($addon['openstock']) && $addon['openstock'] == true && !empty($product['options'])) { ?>
            var hasOptions = "yes";
        <?php } else { ?>
            var hasOptions = "no";

            if ($('#qty').val() < 1) {
                err = 1;
                alert('<?php echo $text_ajax_error_stock; ?>');
            }
        <?php } ?>

        if (err == 0) {
            $.ajax({
                type:'POST',
                dataType: 'json',
                url: 'index.php?route=openbay/ebay/verify&token=<?php echo $token; ?>&options='+hasOptions,
                data: $("#form").serialize(),
                beforeSend: function() {
                  $('#button-save').hide();
                  $('#button-preview').hide();
                  $('#listing-fee-container').hide();
                  $('#button-verify').empty().html('<i class="fa fa-cog fa-lg fa-spin"></i>').attr('disabled','disabled');
                },
                success: function(data) {
                    if (data.error != true) {
                        $('#page-listing').hide();

                        if (data.data.Errors) {
                          data.Errors = $.makeArray(data.Errors);
                          $.each(data.data.Errors, function(key, val) {
                            $('#page-review').prepend('<div class="alert alert-danger">'+val+'</div>');
                          });
                        }

                        if (data.data.Ack != 'Failure') {
                          var fee_total = parseFloat(0.00);
                          var currency = '';
                          var html = '';

                          data.data.Fees = $.makeArray(data.data.Fees);

                          $.each(data.data.Fees, function(key, val) {
                            if (val.Fee != 0.0 && val.Name != 'ListingFee') {
                              fee_total = fee_total + parseFloat(val.Fee);
                            }
                            currency = val.Cur;
                          });
                          html += '<h5><?php echo $text_review_costs; ?>: '+currency+' '+fee_total.toFixed(2)+'</h5>';

                          $('#listing-fee-container').html(html).show();
                          $('#button-preview').attr('href', data.data.link).show();
                          $('#button-save').show();
                        }

                        $('#page-review').show();
                    } else {
                        alert(data.msg);
                    }
                },
                complete: function () {
                  $('#button-verify').empty().html('<?php echo $text_verify; ?>').removeAttr('disabled');
                },
                error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
              }
            });
        } else {
          return;
        }
    });

  $('#button-save').bind('click', function() {
      var hasOptions = "<?php if (!empty($addon['openstock']) && $addon['openstock'] == true && !empty($product['options'])) { echo'yes'; } else { echo 'no'; }?>";

      $.ajax({
        type:'POST',
        dataType: 'json',
        url: 'index.php?route=openbay/ebay/listItem&token=<?php echo $token; ?>&options='+hasOptions,
        data: $("#form").serialize(),
        beforeSend: function() {
          $('#button-save').empty().html('<i class="fa fa-cog fa-lg fa-spin"></i>').attr('disabled','disabled');
        },
        success: function(data) {
          if (data.error == true) {
            alert(data.msg);
          } else {
            if (data.data.Errors) {
              data.data.Errors = $.makeArray(data.data.Errors);

              $.each(data.data.Errors, function(key, val) {
                $('#page-failed').prepend('<div class="alert alert-danger">'+val+'</div>');
                $('#page-complete').prepend('<div class="alert alert-danger">'+val+'</div>');
              });
            }

            if (data.data.Failed == true) {
              $('#page-failed').show();
            } else {
              $('#item-number').text(data.data.ItemID);
              $('#button-view').attr('href', data.data.viewLink).show();
              $('#page-complete').show();
              $('#cancel_button').hide();
            }
          }
        },
        complete: function () {
          $('#button-save').show();
          $('#button-save-loading').hide();
          $('#page-review').hide();
          $('#button-save').empty().html('<?php echo $button_save_listing; ?>').removeAttr('disabled');
        },
        error: function (xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    });

  $('#button-edit').bind('click', function() {
        $('.alert-danger').remove();
        $('#page-review').hide();
        $('#page-listing').show();
    });

  function toggleRad(id) {
    if ($("#image-checkbox-"+id).is(':checked')) {
      $("#image-radio-"+id).removeAttr('disabled');
    } else {
      $("#image-radio-"+id).attr('disabled', 'disabled');
    }
  }

  function updatePrice() {
    var taxEx = $('#taxEx').val();
    var rate = $('#taxRate').val();
    var taxInc = taxEx * ((rate /100)+1);
    $('#taxInc').val(parseFloat(taxInc).toFixed(2));
  }

  function updateVarPrice() {
    var rate = $('#taxRate').val();
    var taxEx = '';
    var id = '';
    var taxInc = '';

    $.each($('.varPriceExCount'), function() {
      id = $(this).val();
      taxEx = $('#varPriceEx_'+id).val();
      taxInc = taxEx * ((rate /100)+1);
      $('#varPriceInc_'+id).val(parseFloat(taxInc).toFixed(2));
    });
  }

  function updateVarPriceFromEx(id) {
    var taxEx = $('#varPriceEx_'+id).val();
    var rate = $('#taxRate').val();
    var taxInc = taxEx * ((rate /100)+1);
    $('#varPriceInc_'+id).val(parseFloat(taxInc).toFixed(2));
  }

  function updatePriceFromEx() {
    var taxEx = $('#taxEx').val();
    var rate = $('#taxRate').val();
    var taxInc = taxEx * ((rate /100)+1);
    $('#taxInc').val(parseFloat(taxInc).toFixed(2));
  }

  function updateVarPriceFromInc(id) {
    var taxInc = $('#varPriceInc_'+id).val();
    var rate = $('#taxRate').val();
    var taxEx = taxInc / ((rate /100)+1);
    $('#varPriceEx_'+id).val(parseFloat(taxEx).toFixed(2));
  }

  function updatePriceFromInc() {
    var taxInc = $('#taxInc').val();
    var rate = $('#taxRate').val();
    var taxEx = taxInc / ((rate /100)+1);
    $('#taxEx').val(parseFloat(taxEx).toFixed(2));
  }

  $('#popular_default').click(function() {
    $('#category-selections-row').show();
    $('#showFeatureDiv').hide();
    $('#product-catalog-container').hide();
    $('#feature-content').empty();
    $('#specifics').empty();
    $('input[name=suggested]').removeAttr('checked');
    $('#suggested_default').prop('checked', 'checked');
  });

  $('input[name=popular]').bind('change', function() {
    if ($(this).val() != '') {
      categoryFavChange($(this).val());
    }
  });

  $('#allTemplateImages').bind('change', function() {
    if ($('#allTemplateImages').is(':checked')) {
      $('.checkboxTemplateImage').prop('checked', 'checked');
    } else {
      $('.checkboxTemplateImage').removeAttr('checked');
    }
  });

  $('#allEbayImages').bind('change', function() {
    if ($('#allEbayImages').is(':checked')) {
      $('.checkboxEbayImage').prop('checked', 'checked');
    } else {
      $('.checkboxEbayImage').removeAttr('checked');
    }
  });

  $('#shipping_in_desc').bind('change', function() {
    if ($('#shipping_in_desc').is(':checked')) {
      $('#shipping_table_rows').hide();
    } else {
      $('#shipping_table_rows').show();
    }
  });

  $('#profile-generic-input').change(function() {
    profileGenericUpdate();
  });

  $('#profile-return-input').change(function() {
    profileReturnUpdate();
  });

  $('#profile-theme-input').change(function() {
    profileThemeUpdate();
  });

  function profileReturnUpdate() {
      if ($('#profile-return-input').val() != 'def') {
          $('#profile-returns-loading').show();

          $.ajax({
              type:'GET',
              dataType: 'json',
              url: 'index.php?route=openbay/ebay_profile/profileGet&token=<?php echo $token; ?>&ebay_profile_id='+$('#profile-return-input').val(),
              success: function(data) {
                  setTimeout(function() {
                      if ($('#returns_accepted').length) {
                          $('#returns_accepted').val(data.data.returns_accepted);
                      }
                      if ($('#returns_option').length) {
                          $('#returns_option').val(data.data.returns_option);
                      }
                      if ($('#returns_within').length) {
                          $('#returns_within').val(data.data.returns_within);
                      }
                      if ($('#returns_policy').length) {
                          $('#returns_policy').val(data.data.returns_policy);
                      }
                      if ($('#returns_shipping').length) {
                          $('#returns_shipping').val(data.data.returns_shipping);
                      }
                      if ($('#returns_restocking_fee').length) {
                          $('#returns_restocking_fee').val(data.data.returns_restocking_fee);
                      }

                      $('#profile-returns-loading').hide();
                  }, 1000);
              },
              error: function (xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
          });
      }
  }

  function profileThemeUpdate() {
  if ($('#profile-theme-input').val() != 'def') {
      $('#profile-theme-loading').show();

      $.ajax({
          type:'GET',
          dataType: 'json',
          url: 'index.php?route=openbay/ebay_profile/profileGet&token=<?php echo $token; ?>&ebay_profile_id='+$('#profile-theme-input').val(),
          success: function(data) {
              setTimeout(function() {
                  $('#gallery_height').val(data.data.ebay_gallery_height);
                  $('#gallery_width').val(data.data.ebay_gallery_width);
                  $('#thumb_height').val(data.data.ebay_thumb_height);
                  $('#thumb_width').val(data.data.ebay_thumb_width);

                  if (data.data.ebay_gallery_plus == 1) {
                      $('#gallery_plus').prop('checked', true);
                  } else {
                      $('#gallery_plus').removeAttr('checked');
                  }

                  if (data.data.ebay_supersize == 1) {
                      $('#gallery_super').prop('checked', true);
                  } else {
                      $('#gallery_super').removeAttr('checked');
                  }

                  if (data.data.ebay_img_ebay == 1) {
                      $('.checkboxEbayImage').prop('checked', true);
                      $('#allEbayImages').prop('checked', true);
                  }

                  if (data.data.ebay_img_template == 1) {
                      $('.checkboxTemplateImage').prop('checked', true);
                      $('#allTemplateImages').prop('checked', true);
                  }

                  if ($.inArray('ebay_template_id', data.data)) {
                      $('#template_id').val(data.data.ebay_template_id);
                  }

                  $('#profile-theme-loading').hide();
              }, 1000);
          },
          error: function (xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
  }
}

  function profileGenericUpdate() {
      if ($('#profile-generic-input').val() != 'def') {
          $('#profile-generic-loading').show();

          $.ajax({
              type:'GET',
              dataType: 'json',
              url: 'index.php?route=openbay/ebay_profile/profileGet&token=<?php echo $token; ?>&ebay_profile_id='+$('#profile-generic-input').val(),
              success: function(data) {
                  setTimeout(function() {
                      if (data.data.private_listing == 1) {
                          $('#private_listing').prop('checked', true);
                      } else {
                          $('#private_listing').removeAttr('checked');
                      }

                      $('#profile-generic-loading').hide();
                  }, 1000);
              },
              error: function (xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
          });
      }
  }

  function removeVariationImage(grp_id, id, number) {
      $('#option_image_'+grp_id+'_'+id+'_'+number).remove();

      var count = $('#option_image_count_'+grp_id).val() - 1;

      $('#option_image_count_'+grp_id).val(count);
  }

  function addVariationImage(grp_id, id) {
      var count = parseInt($('#option_image_count_'+grp_id).val()) + 1;
      $('#option_image_count_'+grp_id).val(count);

      var html = '';
      html += '<div class="border p10 mBottom10 width100 left floatLeft mRight10" id="option_image_'+grp_id+'_'+id+'_'+count+'">';
          html += '<img src="<?php echo $no_image; ?>" id="option_image_img_'+grp_id+'_'+id+'_'+count+'" />';
          html += '<input type="hidden" name="option_image['+grp_id+']['+id+'][images][]" id="option_image_input_'+grp_id+'_'+id+'_'+count+'" value="" />';
          html += '<p class="textCenter"><a class="cursor" onclick="removeVariationImage('+grp_id+','+id+','+count+');"><?php echo $text_remove; ?></a></p>';
      html += '</div>';

      $('#option_images_'+id).append(html);

      image_upload('option_image_input_'+grp_id+'_'+id+'_'+count, 'option_image_img_'+grp_id+'_'+id+'_'+count,'option_image_'+grp_id+'_'+id+'_'+count,'option_image_input_'+grp_id+'_'+id+'_'+count);
  }

  function confirmAction(url) {
    if (confirm("<?php echo $text_confirm_action; ?>")) {
      window.location = url;
    }
  }

  $('#option_image_group').change(function() {
    $('.option_group_img').hide();

    if ($(this).val() != 'def') {
      $('.option_group_img_tr').show();
      $('#option_group_img_'+$(this).val()).show();
      $('#option_image_group_name').val($(this).find("option:selected").text());
    } else {
      $('#option_image_group_name').val('');
      $('.option_group_img_tr').hide();
    }
  });

  $(document).ready(function() {
      loadCategories(1);
      getSuggestedCategories();
      updatePrice();
      updateVarPrice();

      <?php if ($product['profiles_returns_def'] > 0) { ?>
          $('#profile-return-input').val(<?php echo $product['profiles_returns_def']; ?>);
          profileReturnUpdate();
      <?php } ?>

      <?php if ($product['profiles_generic_def'] > 0) { ?>
          $('#profile-generic-input').val(<?php echo $product['profiles_generic_def']; ?>);
          profileGenericUpdate();
      <?php } ?>

      <?php if ($product['profiles_shipping_def'] > 0) { ?>
          $('#profile-shipping-input').val(<?php echo $product['profiles_shipping_def']; ?>);
          profileShippingUpdate();
      <?php } ?>

      <?php if ($product['profiles_theme_def'] > 0) { ?>
          $('#profile-theme-input').val(<?php echo $product['profiles_theme_def']; ?>);
          profileThemeUpdate();
      <?php } ?>
  });
//--></script>
<?php echo $footer; ?>