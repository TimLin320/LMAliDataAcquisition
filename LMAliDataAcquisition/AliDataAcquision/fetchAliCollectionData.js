//注入收藏夹
//监听jsonp请求完成的方法：
//1.监听script的onload的事件，但是如果已经load了，那么这样不行
//2.覆盖jsonp返回的callback方法，以此作为监听
(function(){
  try{
    var tempValue = function(){};
     if(window.mtopjsonp2 !== undefined){
        var oldMethod = window.mtopjsonp2;
         window.mtopjsonp2 = function(){
             var args = Array.prototype.slice.call(arguments);
             window.webkit && window.webkit.messageHandlers &&
             window.webkit.messageHandlers.fetchAliCollectionData.postMessage(args[0])
             return oldMethod.apply(window, args);
         }
     }else{
        Object.defineProperty(window, 'mtopjsonp2', {
          get: function(){
            return tempValue;
          },
          set: function(fn){
            tempValue = function(){
              var args = Array.prototype.slice.call(arguments);
              window.webkit && window.webkit.messageHandlers &&
              window.webkit.messageHandlers.fetchAliCollectionData.postMessage(args[0])
              return fn.apply(window, args);
            }
          }
        })
     }
  }catch(e){
    alert('error')
  }
})()
