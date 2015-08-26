<div class="form-group required">
  <label class="col-sm-2 control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
  <div class="col-sm-10">
    <input type="text" name="captcha" id="input-captcha" class="form-control" />
    <img src="index.php?route=captcha/basic_captcha/captcha" alt="" />
    <?php if ($error_captcha) { ?>
    <div class="text-danger"><?php echo $error_captcha; ?></div>
    <?php } ?>
  </div>
</div>
