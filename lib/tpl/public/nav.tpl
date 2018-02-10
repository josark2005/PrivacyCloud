<nav class="navbar navbar-expand-lg navbar-dark bg-dark" id="navbar">
  <div class="container">
    <a class="navbar-brand" href="javascript:;">
      <img src="./lib/tpl/img/logo_pc.png" width="30" height="30" alt="logo">
      Privacy Cloud
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#nav" aria-controls="nav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="nav">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <a class="nav-link" href="?page=upload"><i class="fas fa-fw fa-cloud-upload-alt"></i> 上传</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="?page=manager"><i class="fas fa-fw fa-cloud"></i> 管理</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="?mode=api&a=main&m=logout"><i class="fas fa-fw fa-sign-out-alt"></i> 注销</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-fw fa-ellipsis-h"></i> 其他
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="?page=configurate"><i class="fas fa-fw fa-cogs"></i> 配置</a>
            <a class="dropdown-item" href="?page=update"><i class="fas fa-fw fa-upload"></i> 升级</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="?page=about"><i class="fas fa-fw fa-info-circle"></i> 关于</a>
          </div>
        </li>
      </ul>
      <span class="navbar-text text-white">
        服务：<span id="SP">null</span> | 流量：<span id="flux">null</span>
      </span>
    </div>
  </div>
</nav>
