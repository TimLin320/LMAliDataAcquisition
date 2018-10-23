//注入收藏夹
//监听jsonp请求完成的方法：
//1.监听script的onload的事件，但是如果已经load了，那么这样不行
//2.覆盖jsonp返回的callback方法，以此作为监听
(function(){
  try{
    var inputs = document.getElementsByTagName('input');
    [].forEach.call(inputs, function(item){
      item.setAttribute('disabled', 'disabled');
    })
  }catch(e){
    alert('error')
  }
})()
