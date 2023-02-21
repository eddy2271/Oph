var IS_DEBUG_MODE = true;

var RES_SUCCESS = "000";

function request(url, params, callback, error) {
	if(params == null) {
		params = {};
	}
	$.ajax({
		url:url,
		data:JSON.stringify(params),
		dataType:"json",
		contentType : "application/json; charset=utf-8",
		method:"post", 
		success:function(response, status){
			logd("RESPONSE : " + JSON.stringify(response));
			callback(response, status);
		},
		error:function(request, status) {
			loge("error:"+request);
			error(request, status);
		}
	});
}

function logd(log) {
	if(IS_DEBUG_MODE) {
		console.debug(log);
	}
}
