
get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js",  "public/javascripts/jquery.js"
get_remote_https_file "https://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
get "http://html5shiv.googlecode.com/svn/trunk/html5.js", "public/javascripts/shiv.js"
run 'rm public/javascripts/application.js'

create_file 'public/javascripts/core.js' do
<<-FILE
(function($){
  var Ql = Ql || {};

  Ql = {
    init: function Ql_init(){
	  // some code that needs to be executed after doc ready
	  Ql.bindEvents();
    },
    bindEvents: function Ql_liveEvents(){
      $('a[rel*=external]').live('click',function(){
        window.open(this.href);
        return false;
      });

    // more globally bound events
	  },
    submit: function(ajax_url,ajax_data,ajax_type,callback){
      $.ajax({
        type: ajax_type,
        url: ajax_url,
        data: ajax_data,
        success: function(data) {
          if(typeof callback.onSuccess == 'function'){
            callback.onSuccess.call(this, data);
          }
        },
        error: function(data,status){
          if(typeof callback.onError == 'function'){
            if(data.status == '403') {
              return callback.onDenied.call(this, data);
            }
            callback.onError.call(this, data);
          }
        },
        complete: function(data){
          if(typeof callback.onComplete == 'function'){
            callback.onComplete.call(this, data);
          }
        },
        denied: function(data){
          if(typeof callback.onDenied == 'function'){
            callback.onDenied.call(this, data);
          }
        }
      });
    },
    helpers: {
      // helper for searching through arrays
      arraySearch: function(a){
        var o = {};
        for(var i=0;i<a.length;i++){
          o[a[i]]='';
        }
        return o;
      }
    }
  }

  window.Ql = Ql;
  $(document).ready(Ql.init);

})(jQuery);
FILE
end

