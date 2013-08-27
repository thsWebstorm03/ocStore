<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <div id="content" class="col-12"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <div class="row">
        <div class="col-sm-3">
          <h3><?php echo $text_location; ?></h3>
          <div class="contact-info">
            <div class="content">
              <address>
              <strong><?php echo $text_address; ?></strong><br>
              <?php echo $store; ?><br>
              <?php echo $address; ?><br>
              <?php if ($telephone) { ?>
              <abbr title="<?php echo $text_telephone; ?>"><?php echo $text_telephone; ?></abbr><br>
              <?php echo $telephone; ?><br>
              <?php } ?>
              <?php if ($fax) { ?>
              <?php echo $text_fax; ?><br>
              <?php echo $fax; ?><br>
              <?php } ?>
              </address>
            </div>
          </div>
        </div>
        <div class="col-sm-9">
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
            <fieldset>
              <h3><?php echo $text_contact; ?></h3>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
                  <?php if ($error_name) { ?>
                  <div class="text-danger"><?php echo $error_name; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $entry_email; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="email" value="<?php echo $email; ?>" class="form-control" />
                  <?php if ($error_email) { ?>
                  <div class="text-danger"><?php echo $error_email; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $entry_enquiry; ?></label>
                <div class="col-sm-10">
                  <textarea name="enquiry" rows="10" class="form-control"><?php echo $enquiry; ?></textarea>
                  <?php if ($error_enquiry) { ?>
                  <div class="text-danger"><?php echo $error_enquiry; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label"><?php echo $entry_captcha; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="captcha" value="<?php echo $captcha; ?>" class="form-control" />
                  <img class="captcha" src="index.php?route=information/contact/captcha" alt="" />
                  <?php if ($error_captcha) { ?>
                  <div class="text-danger"><?php echo $error_captcha; ?></div>
                  <?php } ?>
                </div>
              </div>
            </fieldset>
            <div class="buttons">
              <div class="pull-right">
                <input class="btn btn-primary" type="submit" value="<?php echo $button_continue; ?>" />
              </div>
            </div>
          </form>
        </div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>