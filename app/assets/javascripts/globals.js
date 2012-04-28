if (!Array.prototype.map)
{
  Array.prototype.map = function(fun /*, thisp*/)
  {
    var len = this.length;
    if (typeof fun != "function")
      throw new TypeError();

    var res = new Array(len);
    var thisp = arguments[1];
    for (var i = 0; i < len; i++)
    {
      if (i in this)
        res[i] = fun.call(thisp, this[i], i, this);
    }

    return res;
  };
}

function processPage(page, callback){
    var elements=['input','textarea', 'select'];
    var hash={};
    var error ="";
    var fill = function(_list){
        var list = $(page).find(_list);
        for(var i=0;i<list.length; i++){
            var input = $(list[i]);
            var name = input.attr('name');
            if(input.attr('noprocess')==null && typeof name !== "undefined") {
                if(input.attr('type')!="radio" || input.attr('checked'))
                    hash[name]=input.attr('value');
            }
            var scrollValid=true;
            if(list[i].checkValidity==null) list[i].checkValidity = function(){return true;};
            if(!list[i].checkValidity() || !scrollValid) {
                var label = $('label[for='+name+']').text();
                if(label.length==0) label = input.attr('placeholder');
                if(label.length==0) label = "??";
                error += label + ": " + list[i].validationMessage + "\n";
                break;
            }
        }
    };
    for(var i=0;i<elements.length; i++) {
        fill(elements[i]);
        if(error.length>0) break;
    }
    if(error.length >0) {
        alert(error);
    } else {
    	callback(hash)
    }
};
