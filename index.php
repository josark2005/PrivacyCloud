<?php
// +----------------------------------------------------------------------
// | Writed by Jokin [ Think & Do & To Be Better ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 Jokin All rights reserved.
// +----------------------------------------------------------------------
// | Author: Jokin <Jokin@twocola.com>
// +----------------------------------------------------------------------

/**
 * Privacy Cloud
 * @version 1.1.0
 * @author Jokin
**/

// !以下设置请参考官网手册 pc.twocola.com
// 选择服务提供商（不区分大小写）
/**
 * 七牛云： qiniu
**/
define("SP","qiniu");

// Required Settings
define("AK", "");   // accesskey
define("SK", "");   // secretkey
define("BUK", "");  // bucket name
// DOMIAN BINDING
define("DM", "");  // If you have bound a domian, change 'false' into '<yourdomain>' (without 'http/https').

// Optional Settings
// ACCOUNT AUTHENTICATED
define("AA", false);  // If you use a real-name account, change 'false' into 'true'.
// FLUX CALCULATION(Query Doamin)
define("QD", DM); // If you wants to query other domains together, change 'DM' into '<yourdomains>', and separate by commas.

// ！以下内容请勿修改
// Load core
include "./lib/core.class.php";
\PrivacyCloud\Core::initialize();
?>
