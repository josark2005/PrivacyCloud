function del(key,hash){
  $.ajax({
    url: "?mode=api&m=del&key="+key,
    dataType: "json",
    timeout: 10000,
    success: function(data){
      console.log(data);
      if( data.code === "0"){
        $("tr#"+hash).remove();
        alert(data.msg_zh);
        $("#confirmer").modal("hide");
        $("#manager").modal("hide");
      }else{
        alert(data.msg_zh+" "+data.msg);
      }
    }
  });
}
function manager(key, url, oKey, hash){
  $.ajax({
    url: "?mode=api&m=download&url="+url,
    dataType: "json",
    timeout: 10000,
    complete: function(XMLHttpRequest, status){
      if( status === "timeout" ){
        alert("连接服务器超时，请稍候再试");
      }
    },
    success: function(data){
      if( data.code === "0"){
        console.log(data);
        $("#download_href").attr("href", data.data);
        $("#filekey").text(key);
        $("#del_href").attr("onclick", "del('"+oKey+"','"+hash+"')");
        $("#del_href_enter").on('click', function(){
          $('#manager').modal('hide');
          $("#confirmer").modal('show');
        });
        $("#name").val(key);
        $("#btn-rename").on('click', function(){
          rename(oKey, $("#name").val(), hash);
        })
        $("#manager").modal("show");
      }else{
        alert(data.msg_zh+" "+data.code);
      }
    }
  });
}
function rename(oKey, key, hash){
  if( key === "" ){
    alert("请输入名称后再修改");
    return false;
  }
  $.ajax({
    url: "?mode=api&m=rename",
    type: "post",
    data: {"okey": oKey, "key": key},
    timeout: 10000,
    dataType: "json",
    complete: function(XMLHttpRequest, status){
      if( status === "timeout" ){
        alert("连接服务器超时，请稍候再试");
      }
    },
    success: function(data){
      if( data.code === "0"){
        console.log(data);
        $("#rename").modal("hide");
        $("#"+hash+">td.text-truncate").text(key);
        alert("修改成功");
      }else{
        alert(data.msg_zh+" "+data.code);
      }
    }
  });
}
function enter(prefix){
  location.href="?page=manager&prefix="+prefix;
}

// 加载文件夹
function analyzeFolders(data){
  var tpl_folders = $("#tpl_folders").prop("outerHTML");
  $.each(data, function(key, value){
    // 去前缀
    value = value.substr(prefix_len, value.length-prefix_len);
    var temp = tpl_folders.replace(/~~#1!/g, value);
    temp = temp.replace(/~~#3!/g, t_pf+value);
    temp = temp.replace("id=\"tpl_folders\"", "");
    temp = temp.replace("class=\"d-none\"", "");
    $("#file-list").append(temp);
  });
}
// 加载文件
function analyzeFiles(data, need_process=true){
  var tpl_files = $("#tpl_files").prop("outerHTML");
  $.each(data, function(key, value){
    if( need_process === true ){
      var pKey = value.key.substr(prefix_len, value.key.length-prefix_len);
    }else{
      var pKey = value.key
    }
    var temp = tpl_files.replace(/~~#1!/g, pKey);
    var fUrl = ("http://"+dm+"/"+value.key).replace(/\'/g, "\\\'");
    console.log(fUrl)
    temp = temp.replace(/~~#4!/g, fUrl);
    var size = value.fsize/1024 >= 1024 ? (value.fsize/1024/1024).toFixed(2)+" M" : (value.fsize/1024).toFixed(2)+" K";
    temp = temp.replace(/~~#5!/g, value.key.replace(/\'/g, "\\\'")); // 未处理Key
    temp = temp.replace(/~~#2!/g, size);
    temp = temp.replace(/~~#3!/g, value.hash);
    temp = temp.replace("id=\"tpl_files\"", "id=\""+value.hash+"\"");
    temp = temp.replace("class=\"d-none\"", "");
    $("#file-list").append(temp);
  });
}
function rem(id, is_remove=true){
  console.log(id);
  uploader.stop();
  for(var i in uploader.files){
    if(uploader.files[i].id === id){
      var toremove = i;
    }
  }
  var file = uploader.files.splice(toremove, 1);
  if( is_remove === true ){
    $("li#" + id).remove();
  }
  uploader.start();
}
function newFloder(){
  // 创建并进入新文件夹
  var floderName = $("#newFloderName").val();
  if( floderName === "" ){
    alert("请输入完整的文件夹名称");
    return ;
  }
  var t_pf = "";
  $.each(prefix, function(key, value){
    t_pf += value+"/";
  });
  location.href="?page=manager&prefix="+t_pf+floderName+"/";
}
