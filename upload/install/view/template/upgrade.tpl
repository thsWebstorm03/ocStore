<?php echo $header; ?>
<div class="container">
  <header>
    <div class="row">
      <div class="col-sm-12"><img src="view/image/logo.png" alt="ocStore" title="ocStore" /></div>
    </div>
  </header>
  <h1>Upgrade</h1>
  <div class="row">
    <div class="col-sm-9">
      <?php if ($error_warning) { ?>
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <fieldset>
          <p><b>����� ��������� ����������, ����������� ���������� ���������:</b></p>
          <ol>
            <li>�������� ��� �������� � ������� �� ��� ��������� � ������ <b>system/cache</b> � <b>image/cache</b>.</li>
            <li>��������� � ������ �������������� � <i>(������)</i> ������� Ctrl+F5 ����� �������� CSS ���������.</li>
            <li>��������� � ������� -> ������������ -> ������ ������������� � ��������� ��� ��� ��� ���������� ��� �����.</li>
            <li>��������� � ������� -> ��������� � ������� ��� ���� - ������� ������ ���������, ���� ���� ������ �� ����������!</li>
            <li>�������� ������� ��������  � <i>(������)</i> ������� Ctrl+F5 ����� �������� CSS ���������.</li>
            <li>���������, ��� � ����� ������� ������, ������� �������� � ����� <b>system/logs</b> - ��� ������� �������!</li>
            <li>���� � ���, ��������� ����� ���� ������ ��� ��������, ����������� �������� � ��� �� ������ ������������!</li>
          </ol>
        </fieldset>
        <div class="buttons">
          <div class="text-right">
            <input type="submit" value="����������" class="button" />
          </div>
        </div>
      </form>
    </div>
    <div class="col-sm-3">
      <ul class="list-group">
        <li class="list-group-item"><b>����������</b></li>
        <li class="list-group-item">���������� ����������</li>
      </ul>
    </div>
  </div>
</div>
<?php echo $footer; ?>