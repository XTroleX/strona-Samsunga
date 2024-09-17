Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source;
				var docHead = document.getElementsByTagName("head")[0];
				//if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				if (typeof(usi_commons.last_precapture_siteID) !== "undefined" && usi_commons.last_precapture_siteID == usiSiteID) return;
				usi_commons.last_precapture_siteID = usiSiteID;
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_products:function(options) {
			try {
				if (!options.siteID || !options.pid) return;
				var queryStr = "";
				var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'force_exact', 'match', 'nomatch', 'name_from', 'image_from', 'price_from', 'url_from', 'extra_from', 'custom_callback', 'allow_dupe_names', 'expire_seconds', 'name', 'ordersID', 'cartsID', 'viewsID', 'companyID', 'order_by'];
				params.forEach(function(name, index){
					if (options[name]) {
						queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
					}
				});
				if (options.filters) {
					queryStr += "&filters=" + encodeURIComponent(options.filters.map(function(filter){
						return encodeURIComponent(filter);
					}).join("&"));
				}
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations_filter_v3.jsp' + queryStr, function(){
					if (typeof options.callback === 'function') {
						options.callback();
					}
				});
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		},
		customer_ip:function(last_purchase) {
			try {
				if (last_purchase != -1) {
					usi_cookies.set("usi_suppress", "1", usi_cookies.expire_time.never);
				} else {
					usi_app.main();
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		},
		customer_check:function(company_id) {
			try {
				if (!usi_app.is_enabled && !usi_cookies.value_exists("usi_ip_checked")) {
					usi_cookies.set("usi_ip_checked", "1", usi_cookies.expire_time.day);
					usi_commons.load_script(usi_commons.domain + "/utility/customer_ip2.jsp?companyID=" + company_id);
					return false;
				}
				return true;
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}

usi_cookieless = "1";
usi_session_storage = "1";
if (typeof (usi_app) == "undefined") {
	if("undefined"==typeof usi_cookies){if(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,i,n){try{var t=-1;if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t=r.getTime()}var o=window.top||window,l=0;null!=i&&-1!=i.indexOf("=")&&(i=i.replace(RegExp("=","g"),"USIEQLS")),null!=i&&-1!=i.indexOf(";")&&(i=i.replace(RegExp(";","g"),"USIPRNS"));for(var a=o.name.split(";"),u="",f=0;f<a.length;f++){var c=a[f].split("=");3==c.length?(c[0]==e&&(c[1]=i,c[2]=t,l=1),null!=c[1]&&"null"!=c[1]&&(u+=c[0]+"="+c[1]+"="+c[2]+";")):""!=a[f]&&(u+=a[f]+";")}0==l&&(u+=e+"="+i+"="+t+";"),o.name=u}catch(s){}},flush_window_name:function(e){try{for(var i=window.top||window,n=i.name.split(";"),t="",r=0;r<n.length;r++){var o=n[r].split("=");3==o.length&&(0==o[0].indexOf(e)||(t+=n[r]+";"))}i.name=t}catch(l){}},get_from_window_name:function(e){try{for(var i,n,t=(window.top||window).name.split(";"),r=0;r<t.length;r++){var o=t[r].split("=");if(3==o.length){if(o[0]==e&&(n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),!("-1"!=o[2]&&0>usi_cookies.datediff(o[2]))))return i=[n,o[2]]}else if(2==o.length&&o[0]==e)return n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),i=[n,new Date().getTime()+6048e5]}}catch(l){}return null},datediff:function(e){return e-new Date().getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),i=e[e.length-1];if("com"==i||"net"==i||"org"==i||"us"==i||"co"==i||"ca"==i)return e[e.length-2]+"."+e[e.length-1]}catch(n){}return 0==document.domain.indexOf("www.")?document.domain.replace("www.",""):document.domain},create_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled&&void 0===window.usi_nocookies){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(l=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(i)+t+"; path=/;domain="+l+"; "+o}},create_nonencoded_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled&&void 0===window.usi_nocookies){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();document.cookie=e+"="+i+t+"; path=/;domain="+location.host+"; "+o,document.cookie=e+"="+i+t+"; path=/;domain="+l+"; "+o,document.cookie=e+"="+i+t+"; path=/;domain=; "+o}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var i=e+"=",n=[];try{n=document.cookie.split(";")}catch(t){}for(var r=0;r<n.length;r++){for(var o=n[r];" "==o.charAt(0);)o=o.substring(1,o.length);if(0==o.indexOf(i))return decodeURIComponent(o.substring(i.length,o.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(i){}},get_ls:function(e){try{var i=localStorage.getItem(e);if(null!=i){if(0==i.indexOf("{")&&-1!=i.indexOf("usi_expires")){var n=JSON.parse(i);if(new Date().getTime()>n.usi_expires)return localStorage.removeItem(e),null;i=n.value}return decodeURIComponent(i)}}catch(t){}return null},get:function(e){var i=usi_cookies.read_cookie(e);if(null!=i)return i;try{if(null!=localStorage&&(i=usi_cookies.get_ls(e),null!=i))return i;if(null!=sessionStorage&&(i=sessionStorage.getItem(e),void 0===i&&(i=null),null!=i))return decodeURIComponent(i)}catch(n){}var t=usi_cookies.get_from_window_name(e);if(null!=t&&t.length>1)try{i=decodeURIComponent(t[0])}catch(r){return t[0]}return i},get_json:function(e){var i=null,n=usi_cookies.get(e);if(null==n)return null;try{i=JSON.parse(n)}catch(t){n=n.replace(/\\"/g,'"');try{i=JSON.parse(JSON.parse(n))}catch(r){try{i=JSON.parse(n)}catch(o){}}}return i},search_cookies:function(e){e=e||"";var i=[];return document.cookie.split(";").forEach(function(n){var t=n.split("=")[0].trim();(""===e||0===t.indexOf(e))&&i.push(t)}),i},set:function(e,i,n,t){"undefined"!=typeof usi_nevercookie&&!0==usi_nevercookie&&(t=!1),void 0===n&&(n=-1);try{i=i.replace(/(\r\n|\n|\r)/gm,"")}catch(r){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",i+"",n);try{if(n>0&&null!=localStorage){var o=new Date,l={value:i,usi_expires:o.getTime()+1e3*n};localStorage.setItem(e,JSON.stringify(l))}else null!=sessionStorage&&sessionStorage.setItem(e,i)}catch(a){}if(t||null==i){if(null!=i){if(null==usi_cookies.read_cookie(e)&&!t&&usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count){usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);return}if(i.length>usi_cookies.max_cookie_length){usi_cookies.report_error('Cookie "'+e+'" truncated ('+i.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length);return}}usi_cookies.create_cookie(e,i,n)}},set_json:function(e,i,n,t){var r=JSON.stringify(i).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,r,n,t)},flush:function(e){e=e||"usi_";var i,n,t,r=document.cookie.split(";");for(i=0;i<r.length;i++)0==(n=r[i]).trim().toLowerCase().indexOf(e)&&(t=n.trim().split("=")[0],usi_cookies.del(t));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var o in localStorage)0==o.indexOf(e)&&localStorage.removeItem(o);if(null!=sessionStorage)for(var o in sessionStorage)0==o.indexOf(e)&&sessionStorage.removeItem(o)}catch(l){}},print:function(){for(var e=document.cookie.split(";"),i="",n=0;n<e.length;n++){var t=e[n];0==t.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(t.trim())+" (cookie)"),i+=","+t.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&"string"==typeof localStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+usi_cookies.get_ls(r)+" (localStorage)"),i+=","+r+",");if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&"string"==typeof sessionStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+sessionStorage[r]+" (sessionStorage)"),i+=","+r+",")}catch(o){}for(var l=(window.top||window).name.split(";"),a=0;a<l.length;a++){var u=l[a].split("=");if(3==u.length&&0==u[0].indexOf("usi_")&&-1==i.indexOf(","+u[0]+",")){var f=u[1];-1!=f.indexOf("USIEQLS")&&(f=f.replace(/USIEQLS/g,"=")),-1!=f.indexOf("USIPRNS")&&(f=f.replace(/USIPRNS/g,";")),console.log(u[0]+"="+f+" (window.name)"),i+=","+t.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,i;for(e=0;e<arguments.length;e++)if(i=usi_cookies.get(arguments[e]),""===i||null===i||"null"===i||"undefined"===i)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie)try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-new Date().getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}-1!=location.href.indexOf("usi_clearcookies")&&usi_cookies.flush()}

if (typeof usi_samsung === 'undefined') {
	usi_samsung = {};
	usi_samsung.scrape_sku = function () {
		try {
			if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelcode") != null) {
				return document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelcode");
			} else if (document.querySelector("[class^='wearable-option'] input") != null) {
				return document.querySelector("[class^='wearable-option'] input").getAttribute("data-modelcode");
			} else if (document.getElementById("shopSKU") != null) {
				return document.getElementById("shopSKU").value;
			} else if (document.getElementsByClassName("s-product-sku").length > 0) {
				return document.getElementsByClassName("s-product-sku")[0].innerText;
			} else if (document.querySelector("[data-bv-productid]") != null) {
				return document.querySelector("[data-bv-productid]").getAttribute("data-bv-productid");
			} else if (document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked").length > 0) {
				return document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelcode");
			} else if (document.querySelector('.w-product-model [itemprop="model"]') != null) {
				return document.querySelector('.w-product-model [itemprop="model"]').textContent;
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].id.replace(" ", "");
				}
			} else if (document.getElementsByClassName("product-sku ng-binding").length > 0) {
				return document.getElementsByClassName("product-sku ng-binding")[0].innerText;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};

	usi_samsung.populate_prices = function(usi_prod_array, locale, callback) {
		var i=0;
		var usi_pid_list = "";
		while (typeof(usi_prod_array["product"+i]) != "undefined") {
			usi_pid_list += usi_prod_array["product" + i].pid + ",";
			i++;
		}
		var usi_url = "https://searchapi.samsung.com/v6/front/b2c/product/card/detail/newhybris?siteCode="+locale+"&modelList="+usi_pid_list+"&saleSkuYN=N&onlyRequestSkuYN=Y&vd3PACardYN=Y&commonCodeYN=N";
		$.ajax({
			url: usi_url,
			type: "GET",
			dataType: "json",
			success: function (data) {
				var api_data = data.response.resultData.productList;
				var i=1;
				while (typeof(usi_prod_array["product"+i]) != "undefined") {
					var usi_prices = usi_samsung.grab_price_from_api(usi_prod_array["product"+i].pid, api_data);
					if (usi_prices != null && usi_prices.indexOf("null") == -1) {
						usi_prod_array["product" + i].price = usi_prices.split("_")[0];
						if (typeof(usi_prod_array["product" + i].extra) === "string") {
							var usi_extra = JSON.parse(usi_samsung.decode_html(usi_prod_array["product" + i].extra));
							usi_extra.original_price = usi_prices.split("_")[1];
							usi_prod_array["product" + i].extra = JSON.stringify(usi_extra);
						} else {
							usi_prod_array["product" + i].extra.original_price = usi_prices.split("_")[1];
						}
					}
					i++;
				}
				callback();
			},
			error: function (err) {
				usi_commons.report_error(err);
			}
		});
	};

	usi_samsung.decode_html = function(html){
		var txt = document.createElement("textarea");
		txt.innerHTML = html;
		return txt.value;
	}

	usi_samsung.grab_price_from_api = function(pid, api_data) {
		for (var i=0; i<api_data.length;i++) {
			if (api_data[i].modelList[0].modelCode == pid) {
				return api_data[i].modelList[0].promotionPrice + "_" + api_data[i].modelList[0].price;
			}
		}
		return null;
	};

	usi_samsung.grab_category_restrictions = function(cat) {
		if (cat.indexOf("01") ==0) {
			return  "category2\":\"01,"
		} else if (cat.indexOf("02") ==0) {
			return  "category2\":\"01,category2\":\"02,category2\":\"09,"
		} else if (cat.indexOf("03") ==0) {
			return  "category2\":\"03,category2\":\"07,category2\":\"0104,category2\":\"0102,"
		} else if (cat.indexOf("04") ==0) {
			return  "category2\":\"05,category2\":\"04,"
		} else if (cat.indexOf("05") ==0) {
			return  "category2\":\"05,category2\":\"04,"
		} else if (cat.indexOf("06") ==0) {
			return "category2\":\"06,category2\":\"04,"
		} else if (cat.indexOf("070") ==0) {
			return  "category2\":\"010,"
		} else if (cat.indexOf("07") ==0) {
			return  "category2\":\"07,category2\":\"03,"
		} else if (cat.indexOf("08") ==0) {
			return  "category2\":\"08,"
		} else if (cat.indexOf("09") ==0) {
			return  "category2\":\"09,category2\":\"03,category2\":\"02,"
		}
		return "";
	};

	usi_samsung.product_img_matches = function (product) {
		usi_commons.log('product_img_matches: START');

		try {
			var img = product.image;
			var extra = {};
			if (product.hasOwnProperty("extra")) {
				extra = JSON.parse(product.extra);
			}

			var colour = "no color";
			var customizable = extra.hasOwnProperty("customizable") ? extra.customizable : "";
			if (customizable.indexOf("colour:") !== -1) {
				var colorString = customizable.substring(customizable.indexOf("colour:") + 7, customizable.length);
				var colorSections = colorString.split("~");
				if (colorSections.length > 1) {
					var colorName = colorSections[0];
					colour = colorName.indexOf(" ") == -1 ? colorName : colorName.substring(colorName.lastIndexOf(" ") + 1, colorName.length);
				}
			}

			usi_commons.log('product_img_matches: img = ' + img);
			usi_commons.log('product_img_matches: colour = ' + colour);

			return img.indexOf(colour) !== -1;
		} catch (err) {
			usi_commons.log("product_img_matches:  ERR - " + err);
		}

		//If there's an error here, assume true to retain previous behavior
		return true;
	};

	usi_samsung.check_for_consistency = function (product) {
		try {
			if (typeof (usi_app.last_product) === "undefined" || (usi_app.last_product != JSON.stringify(product))) {
				usi_commons.log("usi_app.check_for_consistency: product changed, let's see if it holds.");
				usi_app.last_product = JSON.stringify(product);
				usi_app.first_check = true;
				return false;
			} else if (usi_app.last_product == JSON.stringify(product) && !usi_app.first_check) {
				usi_commons.log("usi_app.check_for_consistency: already returned true for this product");
				return false;
			} else if (usi_app.last_product == JSON.stringify(product)) {
				usi_commons.log("usi_app.check_for_consistency: it held!");
				usi_app.last_product = JSON.stringify(product);
				usi_app.first_check = false;
				return true;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return false
	};
	usi_samsung.scrape_details = function() {
		try {
			var usi_base_name = usi_samsung.scrape_name();
			var usi_details = "";
			for (var i=0; i<document.getElementsByClassName("s-product-opiton").length; i++) {
				if (usi_base_name.indexOf(document.getElementsByClassName("s-product-opiton")[i].innerText) == -1 && document.getElementsByClassName("s-product-opiton")[i].innerText.indexOf(usi_base_name) == -1) {
					if (usi_details != "") usi_details += " ";
					usi_details += document.getElementsByClassName("s-product-opiton")[i].innerText;
				}
			}
			if (usi_details == "" && document.querySelector(".summary__select-option") != null) {
				for (var i = 0; i < document.getElementsByClassName("summary__select-option").length; i++) {
					if (usi_base_name.indexOf(document.getElementsByClassName("summary__select-option")[i].innerText) == -1 && document.getElementsByClassName("summary__select-option")[i].innerText.indexOf(usi_base_name) == -1) {
						if (usi_details != "") usi_details += " ";
						usi_details += document.getElementsByClassName("summary__select-option")[i].innerText;
					}
				}
			} else if (document.querySelectorAll(".w-product-selected-group-properties span").length != 0) {
				for (var i = 0; i < document.querySelectorAll(".w-product-selected-group-properties span").length; i++) {
					if (usi_base_name.indexOf(document.querySelectorAll(".w-product-selected-group-properties span")[i].innerText) == -1 && document.querySelectorAll(".w-product-selected-group-properties span")[i].innerText.indexOf(usi_base_name) == -1) {
						if (usi_details != "") usi_details += " ";
						usi_details += document.querySelectorAll(".w-product-selected-group-properties span")[i].innerText;
					}
				}
			}
			return usi_details.replace(/ \| /g, ' ').replace(/\|/g, '').replace(/"/g, ' inch');
		} catch (err) {
			usi_commons.report_error(err);
		}
		return ""
	};

	usi_samsung.scrape_name  = function () {
		try {
			var usi_name = "";
			if (document.getElementById("deviceName") != null && document.getElementById("deviceName").getAttribute("content") != null) {
				usi_name =  document.getElementById("deviceName").getAttribute("content");
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 &&  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modeldisplay") != null) {
				usi_name =  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modeldisplay");
			} else if (document.getElementsByClassName("pd-info__title").length > 0) {
				var usi_name = document.getElementsByClassName("pd-info__title")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("s-product-name").length > 0) {
				var usi_name = document.getElementsByClassName("s-product-name")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("hubble-product__summary-product-inner").length > 0 && document.getElementsByClassName("hubble-product__summary-product-inner")[0].innerText != "") {
				var usi_name = document.getElementsByClassName("hubble-product__summary-product-inner")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("hubble-price-bar__detail-title").length > 0) {
				var usi_name = document.getElementsByClassName("hubble-price-bar__detail-title")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("pd-header-navigation__headline-text").length > 0) {
				var usi_name = document.getElementsByClassName("pd-header-navigation__headline-text")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					usi_name =  usi_data_layer.ecommerce.detail.products[0].name;
				} else if (typeof (usi_data_layer.ecommerce) !== "undefined" && usi_data_layer.event == "view_item") {
					usi_name = usi_data_layer.ecommerce.items[0].item_name;
				}
			} else if (document.getElementsByClassName("product-label ng-star-inserted").length > 2) {
				usi_name =  document.getElementsByClassName("product-label ng-star-inserted")[2].innerText;
			} else if (document.getElementsByClassName("configurator-buying-tool__info-product").length > 0) {
				usi_name =  document.getElementsByClassName("configurator-buying-tool__info-product")[0].innerText;
			} else if (document.getElementsByClassName("primary-image ng-scope").length > 0) {
				usi_name = document.getElementsByClassName("primary-image ng-scope")[0].alt;
			} else if (document.querySelector(".wearable-option__select-item.js-input-checked input") != null && document.querySelector(".wearable-option__select-item.js-input-checked input").getAttribute("data-modeldisplay")) {
				usi_name = document.querySelector(".wearable-option__select-item.js-input-checked input").getAttribute("data-modeldisplay");
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return usi_name.replace(/Awesome|Black|Blue(?!(tooth))|Bora|Bronze|Brown|Burgundy|Cloud|Cream|Dark|Gold|Graphite|Gray|Green|Grey|Lavender|Light|Mint|Mystic|Navy|Olive|Peach|Phantom|Pink|Purple|Red|Rose|Sapphire|Silver|Sky|Titanium|Violet|White|Yellow| 5G/g,'').replace(/  /g, ' ').replace(/  /g, ' ').trim();
	};
	usi_samsung.scrape_link = function () {
		try {
			var usi_link = location.protocol + '//' + location.host + location.pathname;
			if (usi_link.indexOf("?") != -1) usi_link = usi_link.substring(0, usi_link.indexOf("?"));
			if (usi_link.indexOf("/uk/") != -1) {
				var pid = usi_samsung.scrape_sku() || "";
				if (pid) {
					var regex_pid = pid;
					if (pid.indexOf("/") != -1) regex_pid = pid.replace("/","(/|-)?");
					var pid_regex = new RegExp(regex_pid, 'i');
					if (usi_link.match(pid_regex) == null) usi_link = usi_link + "?modelCode=" + pid;
				}
			}
			if (usi_link.indexOf("#") != -1) usi_link = usi_link.substring(0, usi_link.indexOf("#"));
			return usi_link;
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_model_name = function () {
		try {
			if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0) {
				return document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelname");
			} else if (document.getElementById("modelName") != null) {
				return document.getElementById("modelName").value;
			} else if (document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked").length > 0 && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input").length > 0 && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelname") != null) {
				return document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelname");
			} else if (typeof (digitalData) !== "undefined" && typeof (digitalData.product) !== "undefined" && typeof (digitalData.product.model_name) !== "undefined" && digitalData.product.model_name != "") {
				return digitalData.product.model_name.split(',')[0];
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].id;
				}
			} else if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color").length == 1) {
				return document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getAttribute("data-modelname");
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_image = function () {
		var usi_img = "";
		try {
			var usi_found = 0;
			if (typeof BC_GROUP != "undefined" && typeof BC_GROUP.products != "undefined" && typeof BC_GROUP.products[usi_samsung.scrape_sku()] != "undefined" && typeof BC_GROUP.products[usi_samsung.scrape_sku()].smallImage != "undefined") {
				usi_found = 1;
				usi_img = BC_GROUP.products[usi_samsung.scrape_sku()].smallImage;
			} else if (document.getElementsByClassName("hubble-product__options-color-img").length > 0 && document.getElementsByClassName("hubble-product__options-color-img")[0].getElementsByTagName("img").length > 0) {
				usi_found = 2;
				usi_img = document.getElementsByClassName("hubble-product__options-color-img")[0].getElementsByTagName("img")[0].src;
			} else if (document.getElementsByClassName("product-details-simple__product").length > 0 && document.getElementsByClassName("product-details-simple__product")[0].getElementsByTagName("img").length > 0) {
				usi_found = 3;
				usi_img = document.getElementsByClassName("product-details-simple__product")[0].getElementsByTagName("img")[0].src;
			} else if (document.getElementById("wtbSrc") != null && document.getElementById("wtbSrc").value != null && document.getElementById("wtbSrc").value.indexOf("thumb") != -1) {
				usi_found = 4;
				usi_img = document.getElementById("wtbSrc").value;
			} else if (document.getElementsByClassName("pd-header-gallery__item-wrap").length > 0 && document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img").length > 0) {
				usi_found = 5;
				if (document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img")[0].getAttribute("data-desktop-src")) {
					usi_img = document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img")[0].getAttribute("data-desktop-src");
				} else {
					usi_img = document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img")[0].src;
				}
			} else if (document.querySelector(".first-image img") != null && document.querySelector(".first-image img").src) {
				usi_found = 13;
				usi_img = document.querySelector(".first-image img").src;
			} else if (document.querySelector('meta[property="og:image"]') != null && document.querySelector('meta[property="og:image"]').content.indexOf("logo-square-letter.png") == -1) {
				usi_found = 6;
				usi_img = document.querySelector('meta[property="og:image"]').content;
			} else if (document.querySelector(".image-carousel__mobile") != null && document.querySelector(".image-carousel__mobile").src != "") {
				usi_found = 8;
				usi_img = document.querySelector(".image-carousel__mobile").src;
			} else if (document.getElementsByClassName("carousel-item").length > 0 && document.getElementsByClassName("carousel-item")[0].getElementsByTagName("img").length > 0) {
				usi_found = 9;
				usi_img = document.getElementsByClassName("carousel-item")[0].getElementsByTagName("img")[0].src;
			} else if (document.querySelector(".configurator-buying-tool__product [data-custom-lazy]") != null) {
				usi_found = 10;
				usi_img = document.querySelector(".configurator-buying-tool__product [data-custom-lazy]").getAttribute("data-custom-lazy");
			} else if (document.getElementById("repSmallImgPath") != null) {
				usi_found = 11;
				usi_img = document.getElementById("repSmallImgPath").value ;
			} else if (document.getElementsByClassName("primary-image ng-scope").length > 0) {
				usi_found = 12;
				usi_img = document.getElementsByClassName("primary-image ng-scope")[0].src;
			} else if (document.querySelector(".slick-active img") != null && document.querySelector(".slick-active img").src != "") {
				usi_found = 7;
				usi_img = document.querySelector(".slick-active img").getAttribute("data-srcset") ? document.querySelector(".slick-active img").getAttribute("data-srcset") : document.querySelector(".slick-active img").src;
			} else if (document.querySelector("link[rel='preload']") != null && document.querySelector("link[rel='preload']").href) {
				usi_found = 0;
				usi_img = document.querySelector("link[rel='preload']").href;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		if (usi_img == null) return "";
		if (usi_img.indexOf("/icons/Delivery.png") != -1) {
			usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?samsung_image_issue="+usi_found);
			return "";
		}
		if (usi_img.indexOf("$") != -1) {
			usi_img = usi_img.substring(0, usi_img.indexOf("$")) + "$THUB_SHOP_L$";
		}
		if (usi_img.indexOf("//") == 0) usi_img = "https:" + usi_img;
		return usi_img;
	};
	usi_samsung.scrape_price = function () {
		try {
			var found = 0;
			var usi_price = "";
			if (document.querySelector(".wearable-option__select-item.js-input-checked input") != null && document.querySelector(".wearable-option__select-item.js-input-checked input").getAttribute("data-modelcode") == usi_samsung.scrape_sku() && document.querySelector(".wearable-option__select-item.js-input-checked input").hasAttribute("data-modelprice")) {
				usi_price = document.querySelector(".wearable-option__select-item.js-input-checked input").getAttribute("data-modelprice");
			} else if (document.querySelector(".cta[data-discountprice]") != null && document.querySelector(".cta[data-discountprice]").getAttribute("data-modelcode") == usi_samsung.scrape_sku()) {
				found = 1;
				usi_price = document.querySelector(".cta[data-discountprice]").getAttribute("data-discountprice");
				usi_price = usi_price.split(",")[0];
			} else if (document.getElementById("promotionPrice") != null) {
				found = 2;
				usi_price = document.getElementById("promotionPrice").value;
			} else if (document.getElementsByClassName("cost-box__price-now").length > 0) {
				found = 3;
				usi_price = document.getElementsByClassName("cost-box__price-now")[0].innerHTML.trim();
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				found = 5;
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].price;
				}
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0) {
				found = 6;
				usi_price =  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelrevenue");
			} else if (document.querySelector(".s-price-total .s-price-num") != null) {
				found = 7;
				usi_price = document.querySelector(".s-price-total .s-price-num").textContent;
			} else if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color").length > 0 &&  document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getAttribute("data-modelrevenue") != null) {
        found = 8;
        usi_price = document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getAttribute("data-modelrevenue");
			} else if (document.getElementsByClassName("price ng-binding ng-scope").length > 0) {
				found = 9;
				usi_price = document.getElementsByClassName("price ng-binding ng-scope")[0].innerText;
			} else if (document.querySelector(".wearable-bc-calculator__price-newprice") != null) {
				found = 10;
				usi_price = document.querySelector(".wearable-bc-calculator__price-newprice").textContent;
			}
			usi_price = usi_price + "";
			if (usi_price.indexOf("hubble-block-text") != -1)	usi_price = usi_price.substring(usi_price.lastIndexOf('">') + 2, usi_price.length).split("\u20AC")[0].trim().replace(/[^0-9.,]+/g, "");
			if (usi_price.indexOf("lei") != -1) usi_price = usi_price.split(" lei")[0];
			if (usi_price.indexOf(">") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(">") + 1, usi_price.length);
			if (usi_price.indexOf(" or ") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(" or ") + 4, usi_price.length);
			if (usi_price.indexOf(" oder ") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(" oder ") + 6, usi_price.length);
			if (usi_price.indexOf(" ou ") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(" ou ") + 4, usi_price.length);
			if (usi_price.indexOf(" z\u0142") != -1) usi_price = usi_price.substring(0, usi_price.indexOf(" z\u0142"));
			if (usi_price.indexOf(" Ft") != -1) usi_price = usi_price.substring(0, usi_price.indexOf(" Ft"));
			if (usi_price.indexOf("{{") != -1) return "";
 			if (/[A-Za-z]/.test(usi_price)) return ""; //alpha in the price = bad
			if (usi_price != "") {
				if (location.href.indexOf("galaxy-s23-ultra/buy") != -1) {
					if (typeof(usi_app.last_report) == "undefined" || usi_app.last_report != usi_price) {
						usi_app.last_report = usi_price;
              usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?samsung_new_price_"+found+"="+usi_price);
            }
          }
				return usi_samsung.standardize_currency(usi_price)
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_stock = function () {
		try {
			if (document.getElementById("apiChangeStockStatus") != null && document.getElementById("apiChangeStockStatus").value == 'OUTOFSTOCK') {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("s-btn-encased s-blue js-buy-now").length > 0 && document.getElementsByClassName("s-btn-encased s-blue js-buy-now")[0].innerText.indexOf("PRE ORDER") != -1) {
				return "PREORDER";
			} else if (document.getElementById("btn-notify") != null && document.getElementById("btn-notify").style.display != "none") {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("tg-out-stock").length > 0 ) {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("tg-pre-order").length > 0) {
				return "PREORDER";
			} else if (document.getElementsByClassName("s-hubble-total-cta").length > 0 &&
				(document.getElementsByClassName("s-hubble-total-cta")[0].innerText.indexOf("Not for Sale") != -1 || document.getElementsByClassName("s-hubble-total-cta")[0].innerText.indexOf("Receive stock alerts") != -1)) {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("add-to-cart-btn").length > 0 && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ac") != null && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ac").indexOf("stock alert") != -1) {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("btn-2 add-to-cart").length > 0 ) {
				//Removed: || document.getElementsByClassName("js-buy-now").length > 0 ||
				return "INSTOCK";
			} else if (document.getElementsByClassName("add-to-cart-btn").length > 0 && document.getElementsByClassName("add-to-cart-btn")[0].className.indexOf("usi_") == -1 && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ca") !== "stock alert" && document.getElementsByClassName("add-to-cart-btn")[0].className.indexOf("is-cta-disabled") == -1) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now tg-add-to-cart").length > 0) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging tg-add-to-cart").length > 0) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now tg-continue").length > 0) {
				return "INSTOCK";
			} else if (document.querySelector(".product-details-simple.js-buy-now") != null) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-an-la") == "secondary navi:add to cart") {
				return "INSTOCK";
			} else if (document.querySelector('.product-basket [data-an-tr="stock-alert"]') != null) {
				return "OUTOFSTOCK";
			} else if (document.querySelector('[data-an-tr="add-to-cart"]') != null) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging tg-bespoke").length > 0) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("btn-add-to-basket").length > 0 && document.getElementsByClassName("btn-add-to-basket")[0].getAttribute("data-stock-level") == 'inStock') {
				return "INSTOCK";
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "OUTOFSTOCK";
	};
	usi_samsung.scrape_category = function (how_deep) {
		try {
			if (typeof (digitalData) !== "undefined" && typeof (digitalData.page) !== "undefined" && typeof (digitalData.page.pathIndicator) !== "undefined") {
				if (digitalData.page.pathIndicator.depth_4 == "" && how_deep >= 3) how_deep = 2;
				if (digitalData.page.pathIndicator.depth_3 == "" && how_deep >= 2) how_deep = 1;
				if (how_deep == 3) {
					return digitalData.page.pathIndicator.depth_2 + "~" + digitalData.page.pathIndicator.depth_3 + "~" + digitalData.page.pathIndicator.depth_4;
				} else if (how_deep == 2) {
					return digitalData.page.pathIndicator.depth_2 + "~" + digitalData.page.pathIndicator.depth_3;
				} else if (how_deep == 1) {
					return digitalData.page.pathIndicator.depth_2;
				}
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].category;
				} else if (typeof (usi_data_layer.ecommerce.items[0].item_category) !== "undefined" && usi_data_layer.event == "view_item") {
					return usi_data_layer.ecommerce.items[0].item_category;
				}
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_category2 = function (how_deep) {
		try {
			if (document.getElementById("categorySubTypeCode") != null) {
				return document.getElementById("categorySubTypeCode").value;
			} else if (document.getElementById("wtb-categorySubTypeCode") != null && document.getElementById("wtb-categorySubTypeCode").value != "") {
				return document.getElementById("wtb-categorySubTypeCode").value;
			} else if (typeof(BC_GROUP) !== "undefined") {
				return BC_GROUP.categorySubTypeCode;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_customizations = function () {
		var usi_customizable = "";
		try {
			if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color").length == 1) {
				var componentToHex = function(c) {
				  var hex = Number(c).toString(16);
				  return hex.length == 1 ? "0" + hex : hex;
				};
				if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getElementsByClassName("product-list-halo").length > 0) {
					var usi_rbg = document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getElementsByClassName("product-list-halo")[0].style.backgroundColor.replace(/[^0-9\.,]+/g,"");
					return "colour:" + document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getElementsByClassName("product-list-name")[0].innerText + "~" + usi_samsung.scrape_model_name().toLowerCase() + "~" + usi_samsung.scrape_sku() + "~#" + componentToHex(usi_rbg.split(",")[0]) + componentToHex(usi_rbg.split(",")[1]) + componentToHex(usi_rbg.split(",")[2]);
				}
			}
			if (document.getElementsByClassName("bttn selected").length == 1 && document.getElementsByClassName("bttn selected")[0].parentNode.className == "variant-btn-container ng-star-inserted") {
				var componentToHex = function(c) {
				  var hex = Number(c).toString(16);
				  return hex.length == 1 ? "0" + hex : hex;
				};
				var usi_color = document.getElementsByClassName("bttn selected")[0].parentNode;
				var usi_rbg = document.getElementsByClassName("bttn selected")[0].parentNode.getElementsByClassName("circle-inner")[0].style.backgroundColor.replace(/[^0-9,]+/g,"")
				return "colour:"+document.getElementsByClassName("bttn selected")[0].parentNode.getElementsByClassName("label")[0].innerText.toLowerCase()+"~"+usi_samsung.scrape_model_name().toLowerCase()+"~"+usi_samsung.scrape_sku()+"~#" + componentToHex(usi_rbg.split(",")[0]) + componentToHex(usi_rbg.split(",")[1]) + componentToHex(usi_rbg.split(",")[2]);
			}
			for (var i = 0; i < document.getElementsByClassName("hidden option-input add-special-tagging buyingoption-api checked").length; i++) {
				var usi_option = document.getElementsByClassName("hidden option-input add-special-tagging buyingoption-api checked")[i];
				if (usi_option.checked) {
					if (usi_option.getAttribute("an-la") != null && usi_option.getAttribute("an-la").indexOf("colo") == 0) {
						usi_customizable = "";
						usi_customizable += usi_option.getAttribute("an-la").replace("color:", "colour:") + "~";
						usi_customizable += usi_option.getAttribute("data-modelname") + "~";
						usi_customizable += usi_option.getAttribute("data-modelcode") + "~";
						var usi_color = usi_option.value;
						if (usi_color != null && usi_color.indexOf("#") != -1) {
							usi_color = usi_color.substring(usi_color.indexOf("#"), usi_color.length);
							usi_customizable += usi_color;
							return usi_customizable;
						} else if (usi_option.parentNode.getElementsByClassName("pd-option-selector__color").length > 0) {
							usi_color = usi_option.parentNode.getElementsByClassName("pd-option-selector__color")[0].getAttribute("style");
							if (usi_color != null && usi_color.indexOf("#") != -1) {
								usi_color = usi_color.substring(usi_color.indexOf("#"), usi_color.length);
								usi_customizable += usi_color.replace(";", "");
								return usi_customizable;
							} else if (usi_option.hasAttribute("data-multicolorsubtitle")) {
								usi_color = usi_option.getAttribute("data-multicolorsubtitle");
								usi_customizable += usi_color.replace(", ",",");
								return usi_customizable;
							}
						}
					}
				}
			}
			for (var i = 0; i < document.querySelectorAll(".pr_color_wrapper .js-prop-val:checked").length; i++) {
				var componentToHex = function(c) {
					var hex = Number(c).toString(16);
					return hex.length == 1 ? "0" + hex : hex;
				};
				var usi_option = document.querySelectorAll(".pr_color_wrapper .js-prop-val:checked")[i];
				if (usi_option.checked){
					usi_customizable = "";
					usi_customizable += "colour:" + usi_option.parentNode.querySelector(".val2").textContent.trim().replace(/[^a-zA-Z ]/g, "") + "~";
					usi_customizable += document.querySelector(".box.w-product-model span[itemprop=model]").textContent + "~";
					usi_customizable += document.querySelector(".box.w-product-model span[itemprop=model]").textContent + "~";
					var usi_rgb = usi_option.parentNode.querySelector(".pr_color").style.backgroundColor.replace(/[^0-9,]+/g,"");
					usi_customizable += "#" + componentToHex(usi_rgb.split(",")[0]) + componentToHex(usi_rgb.split(",")[1]) + componentToHex(usi_rgb.split(",")[2]);
					return usi_customizable;
				}
			}
			for (var i = 0; i < document.querySelectorAll(".wearable-option__select-item.case-color input").length; i++) {
				var usi_option = document.querySelectorAll(".wearable-option__select-item.case-color input")[i];
				if (usi_option.checked) {
					if (usi_option.getAttribute("an-la") != null && usi_option.getAttribute("an-la").indexOf("colo") != -1) {
						usi_customizable = "";
						usi_customizable += usi_option.getAttribute("an-la").substring(usi_option.getAttribute("an-la").indexOf("colo")).replace("color:", "colour:") + "~";
						usi_customizable += usi_option.getAttribute("data-modelname") + "~";
						usi_customizable += usi_option.getAttribute("data-modelcode") + "~";
						var usi_color = usi_option.value;
						if (usi_color && usi_color.indexOf("#") != -1) {
							usi_color = usi_color.substring(usi_color.indexOf("#"), usi_color.length);
							usi_customizable += usi_color;
						} else if (usi_customizable.match(/gold/i) != null) {
							usi_customizable += "#f0eae0";
						} else if (usi_customizable.match(/graphite/i) != null) {
							usi_customizable += "#4a4a4d";
						} else if (usi_customizable.match(/silver/i) != null) {
							usi_customizable += "#c7c8ca";
						} else if (usi_customizable.match(/black/i) != null) {
							usi_customizable += "#000000";
						}
						return usi_customizable;
					}
				}
			}
			for (var i = 0; i < document.getElementsByClassName("sdf-comp-option-chip").length; i++) {
				var usi_option = document.getElementsByClassName("sdf-comp-option-chip")[i];
				if (usi_option.checked) {
					if (usi_option.getAttribute("an-la") != null && usi_option.getAttribute("an-la").indexOf("colo") == 0) {
						usi_customizable = "";
						usi_customizable += usi_option.getAttribute("an-la").replace("color:", "colour:") + "~";
						usi_customizable += usi_option.getAttribute("data-modelname") + "~";
						usi_customizable += usi_option.getAttribute("data-modelcode") + "~";
						var usi_color = usi_option.value;
						usi_color = usi_color.substring(usi_color.indexOf("#"), usi_color.length);
						usi_customizable += usi_color;
						return usi_customizable;
					}
				}
			}
			for (var i = 0; i < document.getElementsByClassName("s-box-option js-radio-wrap is-checked").length; i++) {
				var usi_option = document.getElementsByClassName("s-box-option js-radio-wrap is-checked")[i];
				if (usi_option.getAttribute("data-omni") != null && usi_option.getAttribute("data-omni").indexOf("colour") != -1) {
					var color_details = usi_option.getAttribute("data-omni").replace(/\|/g, "~");
					var hex_color = "";
					if (usi_option.getElementsByClassName("s-item-color-chip").length > 0) {
						hex_color = usi_option.getElementsByClassName("s-item-color-chip")[0].getAttribute("style").replace("background-color:", "").replace(";", "");
					} else {
						hex_color = "#cccccc";
					}
					return color_details + ":" + hex_color;
				}
			}
			if (document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked").length > 0 && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("img").length > 0) {
				//colour:dark gray~sm-x200~SM-X200NZAEEUA~#777777
				var color_details = document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("img")[0].alt;
				if (color_details == "" && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].querySelector(".s-color-name") != null && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].querySelector(".s-color-name").textContent != "") {
					color_details = document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].querySelector(".s-color-name").textContent.toLowerCase().trim();
				}
				var color_img = document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("img")[0].src;
				var model_input = document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0];
				var model_name = "";
				if (model_input.hasAttribute("data-displaycode")) {
					model_name = model_input.getAttribute("data-displaycode");
				} else if (model_input.hasAttribute("data-displayname")) {
					model_name = model_input.getAttribute("data-displayname");
				}
				return "colour:"+color_details + "~" +  model_name.toLowerCase() + "~" +  model_input.getAttribute("data-modelcode") + "~" + color_img;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_ratings = function () {
		try {
			if (document.getElementsByClassName("rating__point").length > 0) {
				return document.getElementsByClassName("rating__point")[0].innerText.replace(/[^0-9\.,]+/g, "");
			} else if (document.getElementsByClassName("bv_avgRating_component_container").length > 0) {
				return document.getElementsByClassName("bv_avgRating_component_container")[0].innerText;
			} else if (document.querySelector(".revoo-review iframe") != null && document.querySelector(".revoo-review iframe").contentDocument != null && document.querySelector(".revoo-review iframe").contentDocument.querySelector('[data-score]') != null) {
				return document.querySelector(".revoo-review iframe").contentDocument.querySelector('[data-score]').getAttribute("data-score") / 2;
			} else if (document.querySelector("#reviews_summary iframe") != null && document.querySelector("#reviews_summary iframe").contentDocument != null && document.querySelector("#reviews_summary iframe").contentDocument.querySelector('[data-score]') != null) {
				return document.querySelector("#reviews_summary iframe").contentDocument.querySelector('[data-score]').getAttribute("data-score") / 2;
			} else if (document.querySelector('[type="application/ld+json"]') != null && JSON.parse(document.querySelector('[type="application/ld+json"]').textContent).aggregateRating) {
				return JSON.parse(document.querySelector('[type="application/ld+json"]').textContent).aggregateRating.ratingValue;
			} else if (document.getElementsByClassName("rating").length > 0 && document.getElementsByClassName("rating")[0].getElementsByClassName("sr-only").length > 0) {
				return document.getElementsByClassName("rating")[0].getElementsByClassName("sr-only")[0].innerText.replace(/[^0-9\.]+/g,"");
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_msrp = function () {
		try {
			var usi_msrp = "";
			var usi_buttons = document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now");
			if (usi_buttons.length > 0 && usi_buttons[0].getAttribute("data-modelprice") != null) {
				usi_msrp = usi_buttons[0].getAttribute("data-modelprice");
				usi_msrp = usi_msrp.split(",")[0];
			} else if (usi_buttons.length > 1 && usi_buttons[1].getAttribute("data-modelprice") != null) {
				usi_msrp = usi_buttons[1].getAttribute("data-modelprice");
				usi_msrp = usi_msrp.split(",")[0];
			} else if (document.getElementsByClassName("cost-box__price-original").length > 0) {
				usi_msrp = document.getElementsByClassName("cost-box__price-original")[0].textContent;
			} else if (document.getElementById("originalPrice") != null) {
				usi_msrp = document.getElementById("originalPrice").value;
			} else if (document.getElementById("product-price-old") != null) {
				usi_msrp = document.getElementById("product-price-old").innerText;
			} else if (document.getElementsByClassName("hubble-product__summary-product-price").length > 0 && document.getElementsByClassName("hubble-product__summary-product-price")[0].getElementsByTagName("span").length > 0) {
				usi_msrp = document.getElementsByClassName("hubble-product__summary-product-price")[0].getElementsByTagName("span")[0].innerText;
			} else if (document.getElementsByClassName("hubble-product__summary-product-price").length > 0) {
				usi_msrp = document.getElementsByClassName("hubble-product__summary-product-price")[0].innerText;
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelprice") != null) {
				usi_msrp =  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelprice");
			} else if (document.querySelector(".s-price-total .del-price") != null) {
				usi_msrp = document.querySelector(".s-price-total .del-price").textContent;
			} else if (document.getElementsByClassName("product-promo ng-scope").length > 0) {
				usi_msrp = document.getElementsByClassName("product-promo ng-scope")[0].innerText;
			}
			if (usi_msrp.indexOf("{{") != -1) return "";
			if (usi_msrp.indexOf(" z\u0142") != -1) usi_msrp = usi_msrp.substring(0, usi_msrp.indexOf(" z\u0142"));
			if (usi_msrp.indexOf(" Ft") != -1) usi_msrp = usi_msrp.substring(0, usi_msrp.indexOf(" Ft"));
			if (/[A-Za-z]/.test(usi_msrp)) return ""; //alpha in the price = bad
			if (usi_msrp != "") return usi_samsung.standardize_currency(usi_msrp);
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.standardize_currency = function (currency_str) {
		var usi_final = 0;
		currency_str = currency_str.replace(/[^0-9\.,]+/g, "");
		if (currency_str.indexOf(",") != -1 && (currency_str.split(",")[1].length == 2 || currency_str.split(",")[1].length == 1)) {
			//This is a 199,99 format
			usi_final = currency_str.split(",")[0].replace(/[^0-9]+/g, "") + "." + currency_str.split(",")[1];
		} else {
			usi_final = currency_str.replace(/[^0-9\.]+/g, "");
		}
		if (isNaN(Number(usi_final)) || Number(usi_final) > 80000) return "";
		return (Number(usi_final).toFixed(2)) + "";
	};
	usi_samsung.grab_ecomm_datalayer = function () {
		if (typeof (dataLayer) !== "undefined") {
			for (var i = 0; i < dataLayer.length; i++) {
				if (typeof (dataLayer[i].ecommerce) !== "undefined") {
					return dataLayer[i];
				}
			}
		}
		return null;
	};
	usi_samsung.test_product_page = function() {
		usi_samsung.is_product_page = usi_samsung.scrape_sku() != "" && location.href.indexOf("compare") == -1;
		if (document.getElementById("tempTitle") != null && document.getElementById("tempTitle").value == "page-feature-pd") {
			//Feature pages look like product pages, but they arne't.
			usi_samsung.is_product_page = false;
		}
	}
	usi_samsung.test_product_page();
}if (typeof usipr_client === 'undefined') {
    usipr_client = {
        getUpsellId: function() {
            var usi_id = null;
            try {
                if (usi_cookies.get('usi_upr_id') == null && usi_cookies.get('usi_id') == null) {
                    var usi_rand_str = Math.random().toString(36).substring(2);
                    if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
                    usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
                    usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
                    return usi_id;
                }
                if (usi_cookies.get('usi_upr_id') != null) usi_id = usi_cookies.get('usi_upr_id');
                if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
                usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
            } catch(err) {
                usi_commons.report_error(err);
            }
            return usi_id;
        },

        validateNumber: function(val, errorMsg) {
            if (isNaN(parseFloat(val))) {
                throw Error(errorMsg + " - " + val);
            }
        },

        isBlank: function(s) {
            return typeof(s) !== 'string' || !s.trim();
        },

        validateNotBlank: function(s, errorMsg) {
            if (usipr_client.isBlank(s)) {
                throw Error(errorMsg + " - " + s);
            }
        },

        validateFunction: function(val, errorMsg) {
            if (typeof(val) === 'undefined') {
                throw Error(errorMsg + " - undefined");
            }

            if ((val != null) && (typeof(val) !== 'function')) {
                throw Error(errorMsg + " - " + val);
            }
        },

        viewClientBuilder: function() {
            var chatId = '', siteId = '', configurationId = '', debug = false, products = [];
            var target = {
                type: '',
                value: '',
                price: '0'
            };

            var buildReportProductUrl = function(visitorId, siteId, configurationId, chatId, targetValue, targetType,
                                                 targetPrice, shownPids, shownPrices) {
                return usi_commons.domain + '/utility/report_productv2.jsp?usi_upr_id=' + encodeURIComponent(visitorId) +
                    '&siteID=' + encodeURIComponent(siteId) +
                    '&configurationID=' + encodeURIComponent(configurationId) +
                    '&chatID=' + encodeURIComponent(chatId) +
                    '&target_value=' + encodeURIComponent(targetValue) + '&target_price=' + encodeURIComponent(targetPrice) +
                    '&target_type=' + encodeURIComponent(targetType) +
                    '&shown_products=' + encodeURIComponent(JSON.stringify(shownPids)) +
                    '&shown_prices=' + encodeURIComponent(JSON.stringify(shownPrices));
            };

            var reportProducts = function(chatId, siteId, configurationId, targetValue, targetType, targetPrice, shownPids, shownPrices, callback) {
                var visitorId = usipr_client.getUpsellId();
                var url = buildReportProductUrl(visitorId, siteId, configurationId, chatId, targetValue+"",
                    targetType,targetPrice+"", shownPids, shownPrices);
                usi_commons.load_script(url, callback);
            };

            var report_product_view = function(chatId, siteId, configurationId, seenProducts, target, callback) {
                var shownPids = [];
                var shownPrices = [];

                //Only record max of 10 recommended products
                for (var i = 0; i < 10; i++) {
                    if (typeof(seenProducts[i]) === "undefined") {
                        break;
                    }
                    shownPids.push(seenProducts[i].pid);
                    shownPrices.push(seenProducts[i].price);
                }

                reportProducts(chatId, siteId+"", configurationId+"",
                    target.value + "", target.type, target.price +  "", shownPids, shownPrices, callback);
            };

            var validate_state = function() {
                usipr_client.validateNumber(chatId, "viewClientBuilder.sendEvent():  chatId must be numeric");
                usipr_client.validateNumber(siteId, "viewClientBuilder.sendEvent():  siteId must be numeric");
                usipr_client.validateNumber(configurationId, "viewClientBuilder.sendEvent():  configurationId must be numeric");
                usipr_client.validateNotBlank(target.type, "viewClientBuilder.sendEvent():  target.type cannot be blank");
                if (target.type === 'product') {
                    usipr_client.validateNotBlank(target.value,
                        "viewClientBuilder.sendEvent():  product target type/pid cannot be blank");
                    usipr_client.validateNumber(target.price,
                        "viewClientBuilder.sendEvent():  product target price must be numeric");
                }

                if (products.length === 0) {
                    throw Error("viewClientBuilder.sendEvent() requires at least one recommended product");
                }

                for (var i = 0; i < products.length; i++) {
                    usipr_client.validateNotBlank(products[i].pid,
                        "viewClientBuilder.sendEvent():  recommended product pid cannot be blank");
                    usipr_client.validateNumber(products[i].price,
                        "viewClientBuilder.sendEvent():  recommended product price must be numeric");
                }
            };

            return {
                setDebug: function(d) {
                    debug = !!d;
                    return this;
                },

                setChatId: function(id) {
                    usipr_client.validateNumber(id, "Invalid chat id");
                    chatId = id;
                    return this;
                },

                setSiteId: function(id) {
                    usipr_client.validateNumber(id, "Invalid site id");
                    siteId = id;
                    return this;
                },

                setConfigurationId: function(id) {
                    usipr_client.validateNumber(id, "Invalid configuration id");
                    configurationId = id;
                    return this;
                },

                setTarget: function(type, value, price) {
                    //Validate target
                    if (!type) {
                        throw Error("Invalid target type:  " + type);
                    }

                    if (typeof(type) !== 'string') {
                        throw Error("Non-string target type:  " + type);
                    }

                    if ((type === 'product') && usipr_client.isBlank(value)) {
                        throw Error("Target type 'product' requires a pid value")
                    }

                    if (type === 'product') {
                        usipr_client.validateNumber(price, "Target type 'product' requires numeric price");
                    }

                    target.type = type;
                    target.value = value;
                    target.price = price;

                    return this;
                },


                build: function() {
                    return {
                        addProduct: function(pid, price) {
                            //Validate Product
                            if (!pid) {
                                throw Error("Invalid pid:  " + pid);
                            }

                            products.push({
                                pid: pid,
                                price: price
                            });
                        },

                        sendEvent: function(callback) {
                            try {
                                validate_state();

                                report_product_view(chatId, siteId, configurationId, products, target, callback);
                            } catch (err) {
                                usi_commons.report_error(err);
                            }
                        }
                    }
                }
            }
        },

        clickClientBuilder: function() {
            var chatId = '', siteId = '', configurationId = '', debug = false, callback = null;
            var product = {
                pid: '',
                price: 0
            };

            var target = {
                type: '',
                value: ''
            };

            return {
                setDebug: function(d) {
                    debug = !!d;
                    return this;
                },

                setChatId: function(id) {
                    usipr_client.validateNumber(id, "Invalid chat id");
                    chatId = id;
                    return this;
                },

                setSiteId: function(id) {
                    usipr_client.validateNumber(id, "Invalid site id");
                    siteId = id;
                    return this;
                },

                setConfigurationId: function(id) {
                    usipr_client.validateNumber(id, "Invalid configuration id");
                    configurationId = id;
                    return this;
                },

                setTarget: function(type, value) {
                    //Validate target
                    if (!type) {
                        throw Error("Invalid target type:  " + type);
                    }

                    if (typeof(type) !== 'string') {
                        throw Error("Non-string target type:  " + type);
                    }

                    if ((type === 'product') && usipr_client.isBlank(value)) {
                        throw Error("Target type 'product' requires a pid value")
                    }

                    target.type = type;
                    target.value = value;
                    return this;
                },

                setCallback: function(f) {
                    usipr_client.validateFunction(f, 'clickClientBuilder.setCallback: invalid function');
                    callback = f;
                    return this;
                },

                build: function() {
                    var buildClickUrl = function(visitorId, siteId, configurationId, chatId, targetValue, targetType,
                                                 clickedPid, clickedPrice) {
                        return usi_commons.domain + '/utility/report_clickv2.jsp?usi_upr_id=' + encodeURIComponent(visitorId) +
                            '&siteID=' + encodeURIComponent(siteId) +
                            '&configurationID=' + encodeURIComponent(configurationId) +
                            '&chatID=' + encodeURIComponent(chatId) +
                            '&target_value=' + encodeURIComponent(targetValue) + '&target_type=' + encodeURIComponent(targetType) +
                            '&clicked_product=' + encodeURIComponent(clickedPid) + '&clicked_price=' + encodeURIComponent(clickedPrice);
                    };

                    var reportClicks = function(chatId, siteId, configurationId, targetValue, targetType, clickedPid, clickedPrice, usi_callback) {
                        var visitorId = usipr_client.getUpsellId();
                        var url = buildClickUrl(visitorId, siteId, configurationId, chatId, targetValue+"", targetType, clickedPid, clickedPrice);
                        usi_commons.load_script(url, usi_callback);
                    };

                    var report_product_click = function (chatId, siteId, configurationId, clickedProduct, target, usi_callback) {
                        reportClicks(chatId, siteId+"", configurationId+"", target.value, target.type,
                            clickedProduct.pid, clickedProduct.price, usi_callback);
                    };

                    var validate_state = function() {
                        usipr_client.validateNumber(chatId, "clickClientBuilder.sendEvent():  chatId must be numeric");
                        usipr_client.validateNumber(siteId, "clickClientBuilder.sendEvent():  siteId must be numeric");
                        usipr_client.validateNumber(configurationId, "clickClientBuilder.sendEvent():  configurationId must be numeric");
                        usipr_client.validateNotBlank(target.type, "clickClientBuilder.sendEvent():  target.type cannot be blank");
                        usipr_client.validateFunction(callback, "clickClientBuilder.sendEvent():  callback must be null or a function");


                        if (target.type === 'product') {
                            usipr_client.validateNotBlank(target.value,
                                "clickClientBuilder.sendEvent():  product target type/pid cannot be blank");
                        }

                        usipr_client.validateNotBlank(product.pid,
                                "clickClientBuilder.sendEvent():  recommended product pid cannot be blank");
                    };

                    return {
                        setProduct: function(pid, price) {
                            product.pid = pid;
                            product.price = price;
                        },

                        sendEvent: function() {
                            var isValidState = true;

                            try {
                                validate_state();
                            } catch(err) {
                                usi_commons.report_error(err);
                                usi_commons.log(err);
                                isValidState = false;
                            }

                            if (isValidState) {
                                try {
                                    report_product_click(chatId, siteId, configurationId, product, target, callback);
                                } catch (err) {
                                    usi_commons.report_error(err);
                                    usi_commons.log(err);
                                }
                            } else {
                                //Always call callback
                                if (typeof(callback) === 'function') {
                                    callback();
                                }
                            }
                        }
                    }
                }
            }
        },

        saleClientBuilder: function() {
            var chatId = '', orderId = '', orderAmt = '', debug = false, products = [];

            var buildReportSaleUrl = function(visitorId, chatId, pids, prices, quantities, order_id, order_amt) {
                return usi_commons.domain + '/utility/report_salev2.jsp?usi_upr_id=' + encodeURIComponent(visitorId) +
                    '&chatID=' + encodeURIComponent(chatId) + '&pids=' + encodeURIComponent(JSON.stringify(pids)) +
                    '&prices=' + encodeURIComponent(JSON.stringify(prices)) +
                    '&quantities=' + encodeURIComponent(JSON.stringify(quantities)) +
                    '&order_id=' + encodeURIComponent(order_id) + '&order_amt=' + encodeURIComponent(order_amt);
            };

            var reportSale = function(chatId, soldProducts, order_id, order_amt, callback) {
                var visitorId = usipr_client.getUpsellId();
                var pids = [];
                var prices = [];
                var quantities = [];

                //Limit number of reported products to 10
                var numProducts = Math.min(10, soldProducts.length);
                for (var i = 0; i < numProducts; i++) {
                    pids.push(soldProducts[i].pid);
                    prices.push(soldProducts[i].price);
                    quantities.push(Math.floor(soldProducts[i].quantity));
                }
                var url = buildReportSaleUrl(visitorId, chatId, pids, prices, quantities, order_id, order_amt);
                usi_commons.load_script(url, callback);
            };

            return {
                setDebug: function (d) {
                    debug = !!d;
                    return this;
                },

                setChatId: function (id) {
                    usipr_client.validateNumber(id, "Invalid chat id");
                    chatId = id;
                    return this;
                },

                setOrderId: function (id) {
                    usipr_client.validateNotBlank(id, "Order id cannot be blank");
                    orderId = id;
                    return this;
                },

                setOrderAmt: function (amt) {
                    usipr_client.validateNumber(amt, "Invalid order amount");
                    orderAmt = amt;
                    return this;
                },


                build: function () {
                    var validate_state = function() {
                        /*
                         var chatId = '', orderId = '', orderAmt = '', debug = false, products = [];
                         */
                        usipr_client.validateNumber(chatId, "saleClientBuilder.sendEvent():  chatId must be numeric");
                        usipr_client.validateNotBlank(orderId, "saleClientBuilder.sendEvent():  orderId cannot be blank");
                        usipr_client.validateNumber(orderAmt, "saleClientBuilder.sendEvent():  orderAmt must be numeric");

                        if (products.length === 0) {
                            throw Error("saleClientBuilder.sendEvent() requires at least one recommended product");
                        }

                        for (var i = 0; i < products.length; i++) {
                            usipr_client.validateNotBlank(products[i].pid,
                                "saleClientBuilder.sendEvent():  recommended product pid cannot be blank");
                            usipr_client.validateNumber(products[i].price,
                                "saleClientBuilder.sendEvent():  recommended product price must be numeric");
                            usipr_client.validateNumber(products[i].quantity,
                                "saleClientBuilder.sendEvent():  recommended product quantity must be numeric");
                        }
                    };

                    return {
                        addProduct: function(pid, price, quantity) {
                            products.push({
                                pid: pid,
                                price: price,
                                quantity: quantity
                            });
                        },

                        sendEvent: function (callback) {
                            try {
                                validate_state();
                                reportSale(chatId, products, orderId, orderAmt, callback);
                            } catch (err) {
                                usi_commons.report_error(err);
                                usi_commons.log(err);
                            }
                        }
                    }
                }
            }
        }
    };
}
"undefined"==typeof usi_split_test&&(usi_split_test={split_test_name:"usi_dice_roll",split_group:"-1",split_siteID:"-1",split_test_cookie_length:2,get_split_var:function(t){if(t=t||"",null==usi_cookies.get("usi_visitor_id"+t)){var i=Math.random().toString(36).substring(2);i.length>6&&(i=i.substring(0,6));var s="v_"+i+"_"+Math.round(new Date().getTime()/1e3)+"_"+t;return usi_cookies.set("usi_visitor_id"+t,s,86400*this.split_test_cookie_length,!0),s}return usi_cookies.get("usi_visitor_id"+t)},report_test:function(t,i){usi_commons.load_script(usi_commons.domain+"/utility/split_test.jsp?siteID="+t+"&group="+i+"&usi_visitor_id="+this.get_split_var(t)),void 0!==usi_split_test.set_verification&&setTimeout("usi_split_test.set_verification("+i+");",1e3)},get_group:function(t){return usi_cookies.get(this.split_test_name+t)},instantiate_callback:function(t,i){usi_cookies.get("usi_force_group")?i(usi_cookies.get("usi_force_group")):null==usi_cookies.get(this.split_test_name+t)?(usi_app["control_group_callback"+t]=i,usi_commons.load_script(usi_commons.domain+"/utility/split_test.jsp?siteID="+t+"&usi_visitor_id="+this.get_split_var(t))):i(usi_cookies.get(this.split_test_name+t))},instantiate:function(t,i){null==usi_cookies.get(this.split_test_name+t)?(0===i||i&&""!=i?this.split_group=i:Math.random()>.5?this.split_group="0":this.split_group="1",this.report_test(t,this.split_group),usi_cookies.set(this.split_test_name+t,this.split_group,86400*this.split_test_cookie_length,!0)):this.split_group=usi_cookies.get(this.split_test_name+t)}});

if (typeof usi_analytics === 'undefined') {
	usi_analytics = {
		cookie_length : 30,
		load_script:function(source) {
			var docHead = document.getElementsByTagName("head")[0];
			//if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			docHead.appendChild(newScript);
		},
		get_id:function() {
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_analytics') == null && usi_cookies.get('usi_id') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_analytics') != null) usi_id = usi_cookies.get('usi_analytics');
				if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
				usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		send_page_hit:function(report_type, companyID, data1) {
			var qs = "";
			if (data1) qs += data1;
			usi_analytics.load_script(usi_commons.domain + "/analytics/hit.js?usi_a="+usi_analytics.get_id(companyID)+"&usi_t="+(Date.now())+"&usi_r="+report_type+"&usi_c="+companyID+qs+"&usi_u="+encodeURIComponent(location.href));
		}
	};
}"undefined"==typeof usi_date&&((usi_date={}).add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+36e5*t)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+6e4*t)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),r=new Date(e);return t.getTime()>r.getTime()}catch(s){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(s)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),r=new Date(e);return t.getTime()<r.getTime()}catch(s){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(s)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.string_to_date=function(e,t){t=t||!1;var r=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),n=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(r=new Date(e),""===(s[1]||"")&&!0===t){var a=new Date;r=usi_date.add_hours(r,a.getHours()),r=usi_date.add_minutes(r,a.getMinutes()),r=usi_date.add_seconds(r,a.getSeconds())}}else if(3===(n||[]).length){var c=n[1].split(/\-/g),i=c[1]+"/"+c[2]+"/"+c[0];return i+=n[2]||"",usi_date.string_to_date(i,t)}return r},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var r=usi_date.string_to_date(t,!0);null!=r?(e=r,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,r,s){null==s&&(s=1),""!=(r||"")&&(r=usi_date.get_units(r));var n=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var a=Math.abs(t-e);switch(r){case"ms":n=a;break;case"seconds":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3),s);break;case"minutes":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(c){n=null}return n},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});
if (typeof usi_aff === 'undefined') {
	usi_aff = {

		fix_linkshare: function() {
			try {
				if (usi_commons.gup("ranSiteID") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var now = new Date();
						var date = now.getUTCFullYear() + ((now.getUTCMonth() + 1 < 10 ? "0" : "") + (now.getUTCMonth() + 1)) + ((now.getUTCDate() < 10 ? "0" : "") + now.getDate());
						var time = (now.getUTCHours() < 10 ? "0" : "") + now.getUTCHours() + ((now.getUTCMinutes() < 10 ? "0" : "") + now.getUTCMinutes());
						usi_cookies.create_nonencoded_cookie("usi_rmStore", "ald:" + date + "_" + time + "|atrv:" + usi_commons.gup("ranSiteID"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_rmStore") != null) {
					usi_cookies.create_nonencoded_cookie("rmStore", usi_cookies.read_cookie("usi_rmStore"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_cj: function() {
			try {
				if (usi_commons.gup("cjevent") != "" || usi_commons.gup("CJEVENT") != "") {
					usi_aff.log_url();
					var cjevent = usi_commons.gup("cjevent");
					if (cjevent == "") {
						cjevent = usi_commons.gup("CJEVENT");
					}
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_cjevent", cjevent, usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_cjevent") != null) {
					usi_cookies.create_nonencoded_cookie("cjevent", usi_cookies.read_cookie("usi_cjevent"), usi_cookies.expire_time.month);
					localStorage.setItem("as_onsite_cjevent", usi_cookies.read_cookie("usi_cjevent"));
					localStorage.setItem("cjevent", usi_cookies.read_cookie("usi_cjevent"));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_sas: function() {
			try {
				if (usi_commons.gup("sscid") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_sscid", usi_commons.gup("sscid"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_sscid") != null) {
					usi_cookies.create_nonencoded_cookie("sas_m_awin", "{\"clickId\":\"" + usi_cookies.read_cookie("usi_sscid")+ "\"}", usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_awin: function(id) {
			try {
				if (usi_commons.gup("awc") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_awc", usi_commons.gup("awc"), usi_cookies.expire_time.month);
						usi_cookies.del("_aw_j_"+id);
					}
				}
				if (usi_cookies.read_cookie("usi_awc") != null) {
					usi_cookies.create_nonencoded_cookie("AwinChannelCookie","aw",30*24*60*60,true);
					usi_cookies.create_nonencoded_cookie("AwinCookie","aw",30*24*60*60,true);
					usi_cookies.create_nonencoded_cookie("_aw_m_"+id, usi_cookies.read_cookie("usi_awc"), usi_cookies.expire_time.month);
					if (typeof(AWIN) !== "undefined") {
						AWIN.Tracking.StorageProvider.setAWC(id, usi_cookies.read_cookie("usi_awc"));
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_pj: function() {
			try {
				if (usi_commons.gup("clickId") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var now = new Date();
						var usi_days = Math.floor(now / 8.64e7);
						usi_cookies.create_nonencoded_cookie('usi-pjn-click', '[{"id":"' + usi_commons.gup("clickId") + '","days":' + usi_days + ',"type":"p"}]', usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi-pjn-click") != null) {
					usi_cookies.create_nonencoded_cookie("pjn-click", usi_cookies.read_cookie("usi-pjn-click"), usi_cookies.expire_time.month);
					localStorage.setItem("pjnClickData", usi_cookies.read_cookie("usi-pjn-click"));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_ir: function(id) {
			try {
				if (usi_commons.gup("irclickid") != "" || usi_commons.gup("clickid") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var usi_click = usi_commons.gup("irclickid");
						if (usi_click == "") {
							usi_click = usi_commons.gup("clickid");
						}
						var date_now = Date.now().toString();
						var cookie_value = date_now + "|-1|" + date_now + "|" + usi_click + "|";
						usi_cookies.create_nonencoded_cookie("usi_IR_" + id, cookie_value, usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_IR_" + id) != null) {
					usi_cookies.create_nonencoded_cookie("IR_" + id, usi_cookies.read_cookie("usi_IR_" + id), usi_cookies.expire_time.month);
					usi_cookies.create_nonencoded_cookie("irclickid", usi_cookies.read_cookie("usi_IR_" + id).split("|")[3], usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_cf: function() {
			try {
				if (usi_commons.gup("cfclick") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi-cfjump-click", usi_commons.gup("cfclick"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi-cfjump-click") != null) {
					usi_cookies.create_nonencoded_cookie("cfjump-click", usi_cookies.read_cookie("usi-cfjump-click"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_avantlink:function() {
			try {
				if (usi_commons.gup("avad") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_avad", usi_commons.gup("avad"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_avad") != null) {
					usi_cookies.create_nonencoded_cookie("avmws", usi_cookies.read_cookie("usi_avad"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		get_impact_pixel: function () {
			var pixel = "";
			try {
				var scripts = document.getElementsByTagName("script");
				for (var i = 0; i < scripts.length; i++) {
					var text = scripts[i].innerText;
					if (text && (text.indexOf("ire('trackConversion'") != -1 || text.indexOf('ire("trackConversion"') != -1)) {
						pixel = text.trim().replace(/\s/g, '')
						pixel = pixel.split("trackConversion")[1];
						pixel = pixel.split("});")[0];
						return pixel;
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return pixel;
		},
		log_url: function() {
			usi_aff.load_script("https://www.upsellit.com/launch/blank.jsp?aff_click=" + encodeURIComponent(location.href));
		},
		monitor_affiliate_pixel: function (callback) {
			try {
				var pixels = usi_aff.report_affiliate_pixels();
				if (pixels) {
					if (typeof callback === "function") callback(pixels);
					return usi_aff.parse_pixels(pixels);
				}
				setTimeout(function () {
					usi_aff.monitor_affiliate_pixel(callback);
				}, 1000);
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		parse_pixels: function(pixels){
			try {
				usi_aff.load_script("https://www.upsellit.com/launch/blank.jsp?pixel_found=" + encodeURIComponent(location.href) +"&"+pixels);
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		report_affiliate_pixels: function () {
			var params = '';
			try {
				var pixels = {
					cj: document.querySelector("[src*='emjcd.com']"),
					sas: document.querySelector("[src*='shareasale.com/sale.cfm']"),
					linkshare: document.querySelector("[src*='track.linksynergy.com']"),
					pj: document.querySelector("[src*='t.pepperjamnetwork.com/track']"),
					avant: document.querySelector("[src*='tracking.avantlink.com/ptcfp.php']"),
					ir: { src: usi_aff.get_impact_pixel() },
					awin1: document.querySelector("[src*='awin1.com/sread']"),
					awin2: document.querySelector("[src*='zenaps.com/sread.js']"),
					cf: document.querySelector("[src*='https://cfjump.'][src*='.com/track']"),
					saasler1: document.querySelector("[src*='engine.saasler.com']"),
					saasler2: document.querySelector("[src*='saasler-impact.herokuapp.com']")
				};
				for (var i in pixels) {
					if (pixels[i] && pixels[i].src) {
						params += '&' + i + '=' + encodeURIComponent(pixels[i].src);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return params;
		},
		load_script: function(source) {
			try {
				var docHead = document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				newScript.src = source;
				docHead.appendChild(newScript);
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	}
}

"undefined"==typeof usi_dom&&((usi_dom={}).get_elements=function(e,t){var n=[];return t=t||document,n=Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"!==Object.prototype.toString.call(e))return t.querySelector(e);for(var n=null,r=0;r<e.length;r++){var i=e[r];if(null!=(n=usi_dom.get_first_element(i,t)))break}return n},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var r=0;r<e.childNodes.length;++r)3===e.childNodes[r].nodeType&&(n+=e.childNodes[r].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){return"string"!=typeof e?void 0:(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(r){usi_commons.log("Error: "+r.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(r){usi_commons.log("Error: "+r.message)}return t},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_currency=function(e,t,n){var r="";return isNaN(e)&&(e=usi_dom.currency_to_decimal(e)),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},r=Number(e).toLocaleString(t,n)):r=e),r},usi_dom.currency_to_decimal=function(e){return 0==e.indexOf("&")&&-1!=e.indexOf(";")?e=e.substring(e.indexOf(";")+1):-1!=e.indexOf("&")&&-1!=e.indexOf(";")&&(e=e.substring(0,e.indexOf("&"))),isNaN(e)&&(e=e.replace(/[^0-9,.]/g,"")),e.indexOf(",")==e.length-3&&(-1!=e.indexOf(".")&&(e=e.replace(".","")),e=e.replace(",",".")),e=e.replace(/[^0-9.]/g,"")},usi_dom.to_decimal_places=function(e,t){if(null==e||"number"!=typeof e||null==t||"number"!=typeof t)return null;if(0==t)return parseFloat(Math.round(e));for(var n=10,r=1;r<t;r++)n*=10;return parseFloat(Math.round(e*n)/n)},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var r=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,r),r.addEventListener?r.addEventListener(e,t,!1):r.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var r=usi_dom.find_supported_element(e,n);r.removeEventListener?r.removeEventListener(e,t,!1):r.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e||""===(t||""))return!1;var n=!0,r=e;return t.split(".").forEach(function(e){!0===n&&(null==r||"object"!=typeof r||!1===r.hasOwnProperty(e)?n=!1:r=r[e])}),n},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},r={};for(var i in n)t.hasOwnProperty(i)?r[i]=t[i]:r[i]=n[i];var l=Object.prototype.toString.call(e);function o(e,t){a=e.innerHTML,d=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),c=(n=e,r=window.getComputedStyle(n,null),(n.clientWidth-parseInt(r.getPropertyValue("padding-left"),10)-parseInt(r.getPropertyValue("padding-right"),10))/d),u=(i=e,l=window.getComputedStyle(i,null),(i.clientHeight-parseInt(l.getPropertyValue("padding-top"),10)-parseInt(l.getPropertyValue("padding-bottom"),10))/d),c&&(t.widthOnly||u)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===a.indexOf("textFitted")?((o=document.createElement("span")).className="textFitted",o.style.display="inline-block",o.innerHTML=a,e.innerHTML="",e.appendChild(o)):o=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),f=t.minFontSize,s=t.maxFontSize;for(var n,r,i,l,o,u,a,c,d,f,p,s,$=f,g=1e3;f<=s&&g>0;)g--,p=s+f-.1,o.style.fontSize=p+"em",o.scrollWidth/d<=c&&(t.widthOnly||o.scrollHeight/d<=u)?($=p,f=p+.1):s=p-.1;o.style.fontSize!==$+"em"&&(o.style.fontSize=$+"em")}"[object Array]"!==l&&"[object NodeList]"!==l&&"[object HTMLCollection]"!==l&&(e=[e]);for(var u=0;u<e.length;u++)o(e[u],r)});

	try {
		usi_app = {};
		usi_app.main = function () {
			try {
				usi_app.url = location.href.toLowerCase();

				/*
				usi_app.list_40p = "EF-BP610PLEGEU,EF-BX710PBEGWW,EF-BX710PWEGWW,EF-BX810PBEGWW,EF-BX810PWEGWW,EF-BX910PBEGWW,EF-BX910PWEGWW,EF-DX710UBEGWW,EF-DX810UBEGWW,EF-DX910UBEGWW,EF-GA536TNEGWW,EF-GA536TWEGWW,EF-OF94KKBEGWW,EF-OF94PCBEGWW,EF-OF94PCLEGWW,EF-OF94PCUEGWW,EF-PA536TBEGWW,EF-PF731TMEGWW,EF-PF731TNEGWW,EF-PF731TOEGWW,EF-PF731TUEGWW,EF-PF731TVEGWW,EF-PS711TBEGWW,EF-PS711TMEGWW,EF-PS711TOEGWW,EF-PS901TBEGWW,EF-PS901TPEGWW,EF-PS921TEEGWW,EF-PS921TGEGWW,EF-PS921TVEGWW,EF-PS926TEEGWW,EF-PS926TGEGWW,EF-PS926TVEGWW,EF-PS928TEEGWW,EF-PS928TGEGWW,EF-PS928TVEGWW,EF-QA546CTEGWW,EF-QS711CTEGWW,EF-QS911CTEGWW,EF-QS916CTEGWW,EF-QS918CTEGWW,EF-RX610CBEGWW,EF-RX710CBEGWW,EF-US711CTEGWW,EF-US921CTEGWW,EF-US926CTEGWW,EF-US928CTEGWW,EF-VF946PBEGWW,EF-VF946PLEGWW,EF-XF731CTEGWW,EF-XS921CTEGWW,EF-XS926CTEGWW,EF-XS928CTEGWW,EF-ZA546CBEGWW,EF-ZS711CBEGWW,EF-ZS711CMEGWW,EF-ZS711CWEGWW,EF-ZS901CBEGEE,EF-ZS901CEEGEE,EF-ZS911CBEGWW,EF-ZS911CGEGWW,EF-ZS911CUEGWW,EF-ZS911CVEGWW,EF-ZS916CBEGWW,EF-ZS916CGEGWW,EF-ZS916CUEGWW,EF-ZS916CVEGWW,EF-ZS918CBEGWW,EF-ZS918CGEGWW,EF-ZS918CUEGWW,EF-ZS918CVEGWW,EF-ZS921CBEGWW,EF-ZS921CGEGWW,EF-ZS921CVEGWW,EF-ZS926CBEGWW,EF-ZS926CGEGWW,EF-ZS926CVEGWW,EF-ZS928CBEGWW,EF-ZS928CGEGWW,EF-ZS928CVEGWW,EF-ZX712PWEGWW,EF-ZX812PWEGWW,EI-T5600BBEGEU,EI-T5600BWEGEU,EI-T5600KWEGEU,EJ-P5600SWEGEU,EJ-PS928BBEGEU,EP-OR900BBEGWW,EP-P5400BBEGEU,EP-P5400BWEGEU,EP-T1510NBEGEU,EP-T1510XBEGEU,EP-T1510XWEGEU,EP-T2510NBEGEU,EP-T2510NWEGEU,EP-T2510XBEGEU,EP-T2510XWEGEU,EP-T4510XBEGEU,ET-SFR93SBEGEU,ET-SFR93SLEGEU,ET-SFR93SMEGEU,ET-SFR93SNEGEU,ET-SFR93SSEGEU,ET-SFR93SUEGEU,ET-SHR96LBEGEU,ET-SHR96LNEGEU,ET-SHR96LSEGEU,ET-SVR94LBEGEU,ET-SVR94LLEGEU,ET-SVR94LUEGEU,GP-FPR510SBHOW,GP-FPR510SBHRW,GP-FPR510SBHYW,GP-FPR510SBJBW,GP-FPR510SBKVW,GP-FPS921SAATW,GP-FPS926SAATW";
				if (usi_date.is_after("2024-03-11T00:00:00-00:00")) {
					usi_app.list_40p += ",ET-SFR39MGEGEU,ET-SFR39MOEGEU";
				}
				usi_app.list_25p = "SM-R177NLVAEUE,SM-R177NZGAEUE,SM-R177NZKAEUE,SM-R177NZTAEUE,SM-R177NZWAEUE,SM-R180NZKAEUE,SM-R180NZNAEUE,SM-R180NZTAEUE,SM-R180NZWAEUE,SM-R400NZAAEUE,SM-R400NZWAEUE,SM-R510NLVAEUE,SM-R510NZAAEUE,SM-R510NZWAEUE,SM-R860NZDAEUE,SM-R860NZKAEUE,SM-R860NZSAEUE,SM-R865FZDAEUE,SM-R865FZKAEUE,SM-R865FZSAEUE,SM-R870NZGAEUE,SM-R870NZKAEUE,SM-R870NZSAEUE,SM-R875FZGAEUE,SM-R875FZKAEUE,SM-R875FZSAEUE,SM-R880NZKAEUE,SM-R880NZSAEUE,SM-R885FZKAEUE,SM-R885FZSAEUE,SM-R890NZKAEUE,SM-R890NZSAEUE,SM-R895FZKAEUE,SM-R895FZSAEUE,SM-R900NZAAEUE,SM-R900NZDAEUE,SM-R900NZSAEUE,SM-R905FZAAEUE,SM-R905FZDAEUE,SM-R905FZSAEUE,SM-R910NZAAEUE,SM-R910NZBAEUE,SM-R910NZSAEUE,SM-R915FZAAEUE,SM-R915FZBAEUE,SM-R915FZSAEUE,SM-R920NZKAEUE,SM-R920NZTAEUE,SM-R925FZKAEUE,SM-R925FZTAEUE,SM-R930NZEAEUE,SM-R930NZKAEUE,SM-R935FZEAEUE,SM-R935FZKAEUE,SM-R940NZKAEUE,SM-R940NZSAEUE,SM-R945FZKAEUE,SM-R945FZSAEUE,SM-R950NZKAEUE,SM-R950NZSAEUE,SM-R955FZKAEUE,SM-R955FZSAEUE,SM-R960NZKAEUE,SM-R960NZSAEUE,SM-R965FZKAEUE,SM-R965FZSAEUE";
				if (usi_date.is_after("2024-03-10T00:00:00-00:00")) {
					usi_app.list_25p += ",SM-R390NZAAEUE,SM-R390NZSAEUE,SM-R390NIDAEUE";
				}
				*/
				usi_app.list_40p = "";
				usi_app.list_25p = "";

				usi_app.company_id = "8641";

				usi_app.product_page_recs = "37437";
				usi_app.cart_page_recs = "35487";
				usi_app.force_group = usi_commons.gup_or_get_cookie('usi_force_group');

				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.day, true) != "";
				usi_app.is_cart_page = location.href.indexOf("/pl/cart") != -1;
				usi_app.smartphone = false;
				usi_app.modified_price = {};
				usi_app.selected_skus = "RF65A977FSG/EF,RF65A967ESR/EO,RF65A967FB1/EO,RF23M8090SG/EF,RF23R62E3B1/EO,RF23R62E3S9/EO,RF50A5202B1/EO,RF50A5202S9/EO,RF50A5002B1/EO,RH69B8941B1/EF,RH69B8941S9/EF,RH69B8931B1/EF,RH68B8841B1/EF,RH68B8831B1/EF,RH68B8831S9/EF,RH68B8821B1/EF,RH68B8820B1/EF,RS6HA8891B1/EF,RS6HA8880B1/EF,RS68A884CB1/EF,RS65R54422C/EO,RS65R54412C/EO,RS65R54112C/EO,RS68A8842B1/EF,RS65R5441B4/EO,RS68A8841B1/EF,RS68A8841S9/EF,RS65R5411M9/EO,RS65R5411B4/EO,RS68A8840B1/EF,RS68A8840S9/EF,RS68A8540B1/EF,RS65R5401M9/EO,RS50N3913BC/EO,RS68A8831S9/EF,RS68A8531B1/EF,RS68A8840WW/EF,RS68A8830S9/EF,RS50N3903SA/EO,RS50N3513BC/EO,RS68A8520S9/EF,RS68A8820B1/EF,RS68A8820S9/EF,RS67A8811S9/EF,RS67A8811B1/EF,RS67A8811WW/EF,RS50N3803SA/EO,RS67A8810S9/EF,RS67A8810B1/EF,RS67A8810WW/EF,RS66A8101B1/EF,RS66A8101S9/EF,RS66A8100B1/EF,RS66A8100S9/EF,RB38A7B5322/EF,RB38A7B6348WEF,RB38A7B6C41/EF,RB38A7B5C12/EF,RB38A7B6D22/EF,RB38A7B5D22/EF,RB38A7B6D41/EF,RB38A7B6D34/EF,RB38A7B5D39/EF,RB38A7B5D27/EF,RB38A7B5DS9/EF,RB38A7B5DB1/EF,RB38A6B1DCE/EF,RB38A7B5E22/EF,RB38A6B2E22/EF,RB38A7B5ECE/EF,RB38A6B5ECL/EF,RB38A6B2EB1/EF,RB34A7B5D22/EF,RB34A7B5D39/EF,RB34A7B5D41/EF,RB34A7B5DCE/EF,RB34A7B5E12/EF,RB34A6B3E22/EF,RB34A7B5EB1/EF,RB34A6B2F22/EF,RB38A7B6AAP/EF,RB38A7B6BAP/EF,RB38A7B6CAP/EF,RR25A5470AP/EF,RZ32A7485AP/EF,RB38A7B6DAP/EF,RB34A7B5CAP/EF,RR39A7463AP/EF,RB38A7B6EAP/EF,RB34A7B5DAP/EF,RB34A6B5DAP/EF,RZ32A748522/EF,RR39A746322/EF,RR39M7565B1/EO,RR39M7565B1/EF,RZ32M753EB1/EF,RR39M7320S9/EO,RZ32M7115S9/EF,RR39M7130S9/EF,RB36R8899SR/EF,RB36R8837S9/EF,RB36R872PB1/EF,RB33R8737S9/EF,RB38T776CB1/EF,RB38T776CS9/EF,RB38T775CSR/EF,RB38T775CS9/EF,RB38T705CB1/EF,RB38T774DB1/EF,RB38T776DS9/EF,RB38T676CSA/EF,RB38T675CS9/EF,RB38T606CSA/EF,RB38T603CS9/EF,RB38T606DB1/EF,RB38T675DS9/EF,RB38T672CS9/EF,RB38T605CWW/EF,RB38T675DSA/EF,RB38T603DB1/EF,RB38T605DS9/EF,RB38T635ES9/EF,RB38T672CWW/EF,RB38T674EB1/EF,RB38T650EB1/EF,RB38T605DWW/EF,RB38T650ESA/EF,RB38T602DSA/EF,RB38T675EEL/EF,RB38T606EWW/EF,RB38T602EB1/EF,RB38T672ESA/EF,RB38T603FSA/EF,RB38T600EB1/EF,RB38T603FWW/EF,RB38T600ESA/EF,RB38T600FSA/EF,RB36T675CS9/EF,RB36T605CB1/EF,RB36T672CS9/EF,RB36T602CSA/EF,RB36T602DB1/EF,RB36T675ESA/EF,RB36T604FSA/EF,RB36T602EB1/EF,RB36T602FB1/EF,RB34T775CB1/EF,RB34T775CS9/EF,RB34T665DBN/EF,RB34T675DS9/EF,RB34T605DBN/EF,RB34T635EBN/EF,RB34T675DWW/EF,RB34T674EB1/EF,RB34T672DBN/EF,RB34T675EBN/EF,RB34T652EBN/EF,RB34T672DSA/EF,RB34T671DSA/EF,RB34T675ESA/EF,RB34T601DSA/EF,RB34T632ESA/EF,RB31FDRNDBC/EO,RB34T672EBN/EF,RB34T600DSA/EF,RB31FWRNDSA/EO,RB34T602EB1/EF,RB33J3230BC/EO,RB31FDRNDSA/EO,RB34T670ESA/EF,RB34T671FSA/EF,RB31FERNDEL/EO,RB34T672EWW/EF,RB34T671EWW/EF,RB34T600EBN/EF,RB34T601FS9/EF,RB31FERNDBC/EO,RB34T600ESA/EF,RB34T672FWW/EF,RB34T672FEL/EF,RB34T602FSA/EF,RB33J3215WW/EO,RB33B612EBN/EF,RB33J3030SA/EO,RB33B610EBN/EF,RB33B612ESA/EF,RB33B612FBN/EF,RB34T600EWW/EF,RB34T601FWW/EF,RB33B610ESA/EF,RB33B610FBN/EF,RB33B612FSA/EF,RB34T600FWW/EF,RB33J3205SA/EO,RB33J3420WW/EO,RB33B610FSA/EF,RB33B612EWW/EF,RB33B610EWW/EF,RB33B612FWW/EF,RB33J3000WW/EO,RB31HSR2DWW/EO,RB31HSR2DSA/EO,RB33B610FWW/EF,WW11BB944DGBS6,WW11BB944DGMS6,WW11BB744DGBS6,WW11BB744DGES6,WW11BB504DAWS6,DV90BB9445GBS6,DV90BB9445GMS6,DV90BB7445GBS6,DV90BB7445GES6,DV90BB5245AWS6,DV16T8520BV/EO,DV90T8240SX/S6,DV90T8240SH/S6,DV90T7240BH/S6,DV90T7240BT/S6,DV80T6220LH/S6,DV80T6220LE/S6,DV90T6240LH/S6,DV90T5240AE/S6,DV90T5240AT/S6,DV80T5220AE/S6,DV90TA240AH/EO,DV90TA240AE/EO,DV80T5220TW/S6,DV90TA240TE/EO,DV80TA220TT/EO,DV90TA020AE/EO,DV80TA020AE/EO,WD90T954ASH/S6,WD80T654DBH/S6,WD80T554DBX/S6,WD80T554DBE/S6,WD10T534DBE/S6,WD80TA046BE/EO,WD80TA046BH/EO,WD70TA046BH/EO,WD8NK52E0ZX/EO,WD8NK52E0ZW/EO,WD8NK52E0AW/EO,WD8NK52E3AW/EO,WW90T986ASH/S6,WW90T954ASX/S6,WW90T954ASH/S6,WW80T954ASH/S6,WW90T754ABH/S6,WW90T754ABT/S6,WW10T654DLH/S6,WW90T654DLH/S6,WW80T654DLH/S6,WW80T654DLE/S6,WW80T554DAE/S6,WW80T554DAT/S6,WW70T554DAE/S6,WW70T552DAE/S6,WW70T552DAT/S6,WW70T552DTW/S6,WW8NK62E0RW/EO,WW8NK52E0VX/EO,WW8NK52E0VW/EO,WF18T8000GV/EO,WW90T634DLH/S6,WW90T534DAE/S6,WW10T504DAE/S6,WW80T534DAE/S6,WW90T504DAE/S6,WW90T504DAT/S6,WW11BGA046AEEO,WW90TA046AT/EO,WW90TA046AE/EO,WW80T504DAE/S6,WW90TA046TH/EO,WW90TA046TE/EO,WW70TA026AX/EO,WW80TA026AT/EO,WW80TA026AE/EO,WW80TA026AH/EO,WW70TA046AE/EO,WW80TA026TH/EO,WW80TA026TE/EO,WW70TA026AT/EO,WW70TA026AE/EO,WW70TA026AH/EO,WW70TA026TT/EO,WW70TA026TH/EO,WW70TA026TE/EO,WW8NK52E0PX/EO,WW8NK52E3PW/EO,WW8NK52E0PW/EO,WW90T4020CE/EO,WW90T4020CT/EO,WW90T4020EE/EO,WW60A3120BE/EO,WW60A3120BH/EO,WW60A3120WE/EO,WW60A3120WH/EO,DF10A9500CG/E3,DF60A8500CG/E2,VR50T95735W/GE,VR30T85513W/GE,VR30T80313W/GE,VS20A95973W/GE,VS20A95973B/GE,VS20A95943N/GE,VS20A95843W/GE,VS20A95823W/GE,VS20R9079T7/GE,VS20R9076T7/GE,VS20R9048T3/GE,VS20R9046T3/GE,VS20R9044T2/GE,VS20R9042T2/GE,VS20T7535T5/GE,VS20T7538T5/GE,VS20T7536T5/GE,VS20T7532T1/GE,VS20T7534T4/GE,VS15T7036R5/GE,VS15T7033R4/GE,VS15T7031R1/GE,VS15A6032R5/GE,VS15A6031R1/GE,VC07K51L9H1/GE,VC07M21N9VD/GE,VCC45W0S36/XEO,VC079HNJGGD/EO,VC07M25E0WR/GE,AX47R9080SS/EU,AX90R7080WD/EU,AX60R5080WD/EU,AX60T5080WF/EU,AX40R3030WM/EU,AX34R3020WW/EU,AX32BG3100GGEU,MC35R8058CC/EO,MG23T5018CG/EO,MC28H5015AK/EO,MG28F303TFK/EO,MC28A5135CK/EO,MG30T5018CK/EO,MG23T5018CG/EO,MS23T5018AK/EO,MG23K3575AS/EO,MG23K3515CK/EO,MG23J5133AT/EO,MG23K3515AS/EO,MG23K3515AK/EO,GE83X-P/EO,MS23K3513AS/EO,MS23K3513AK/EO,MG23F301TAS/EO,MG23F301TAK/EO,GE83X/XEO,MS23F301TFK/EO,MS23F301TAS/EO,ME83X-P/EO,GE83M/XEO,ME83X/XEO,ME83M/XEO,ME732K-S/XEO,ME711K/XEO,NZ84T9747VK/UR,NV75T9979CD/EO,NV75T9879CD/EO,NV75T8979RK/EO,NQ50T9939BD/EO,NV75T8879RK/EO,NQ50T9539BD/EO,NV75T9549CD/EO,NQ50T8939BK/EO,NQ50T8539BK/EO,NV75T8549RK/EO,NK36T9804VD/UR,NV73J9770RS/EO,NZ84J9770EK/EO,NQ50J9530BS/EO,NZ63J9770EK/EO,NV7B6799JAK/U2,NV7B6795JAK/U2,NV7B6785KAK/U2,NV7B5785JAK/U2,NV7B5785KAK/U2,NV7B5765RAK/U2,NV7B5765XAK/U2,NV7B5745PAK/U2,NV7B5745PAS/U2,NV7B4545VAK/U2,NV7B4345VAK/U2,NV7B4545VAS/U2,NV7B4345VAS/U2,NV7B7997AAK/U2,NV7B7980AAK/U2,NV7B6685AAN/U2,NV7B6665IAA/U2,NV7B6685BAK/U2,NV7B5685AAK/U2,NV7B5685BAK/U2,NV7B5660RAK/U2,NV7B5660XAK/U2,NV7B5645TAK/U2,NV7B5645TAS/U2,NV7B4445VAK/U2,NV7B4245VAW/U2,NV7B4245VAK/U2,NV7B4445VAS/U2,NV7B4440VAK/U2,NV7B4245VAS/U2,NV7B4240VAK/U2,NV7B4145VAK/U2,NV7B4045VAK/U2,NV7B4140VAK/U2,NV7B4040VAW/U2,NV7B4040VAK/U2,NV7B4140VAS/U2,NV7B4040VAS/U2,NV7B4525ZAK/U2,NV7B4325ZAK/U2,NV7B45251AK/U2,NV7B43251AK/U2,NV7B4525ZAS/U2,NV7B4325ZAS/U2,NV7B4425ZAK/U2,NV7B4225ZAK/U2,NV7B44251AK/U2,NV7B42251AK/U2,NV7B4425ZAS/U2,NV7B4225ZAS/U2,NV7B44257AK/U2,NV7B44205AK/U2,NV7B44207AK/U2,NV7B44205AS/U2,NV7B44207AS/U2,NV7B4020ZAK/U2,NV7B41201AK/U2,NV7B41205AK/U2,NV7B4020ZAS/U2,NV7B41207AK/U2,NV7B41201AS/U2,NV7B41207AS/U2,NV75N7677RS/EO,NV75A6679RK/EO,NV75N7647RS/EO,NV75N5671RM/EO,NV75N762ARK/EO,NV75N5671RB/EO,NV75A6649RK/EO,NV75N7646RB/EO,NV75N7626RB/EO,NV75A6649RS/EO,NV75N7646RS/EO,NV75N5641RB/EO,NV75N5621RB/EO,NV75N5622RT/EO,NV75N5641RS/EO,BQ1VD6T131/XEO,NV75J7570RS/EO,NV75J5540RS/EO,NV75A6549RK/EO,NV75A6549RS/EO,NV75N7546RB/EO,NV70H5787CB/EO,NV68R5545CB/EO,NV75N7546RS/EO,NV75K5541RG/EO,NV75K5541RM/EO,NV70M5520CB/EO,NV75K5541RB/EO,NV68R5525CB/EO,NV75K5541RS/EO,NV66M3571BB/EO,NV70M3541RB/EO,NV70M3541RS/EO,NV70M3521RB/EO,NV66M3535BB/EO,NV64R3531BB/EO,NV66M3531BB/EO,NV64R3531BS/EO,NV66M3531BS/EO,NV70H5587BB/EO,NV68R5345CB/EO,NV70K2340RG/EO,NV70K2340RM/EO,NV70K2340RB/EO,NV75J3140RB/EO,NV70K2340RS/EO,NV75J3140BB/EO,NV75J3140BS/EO,NV68A1145CK/EO,NV68A1145RK/EO,NV68A1140RS/EO,NV68A1140BK/EO,NV68A1140BB/EO,NV70K1340BB/EO,NV68A1140BS/EO,NV70K1340BS/EO,NQ5B7993AAK/U2,NQ5B6753CAA/U2,NQ5B6753CAN/U2,NQ5B6753CAK/U2,NQ5B5763DBK/U2,NQ5B5763DBS/U2,NQ5B4353HBK/U2,NQ5B4553HBK/U2,NQ5B4353FBK/U2,NQ5B4553FBK/U2,NQ5B4553FBS/U2,NQ50J5530BS/EO,NQ50A6539BK/EO,NQ50A6539BS/EO,NQ50H5537KB/EO,NQ50K3530BG/EO,NQ50H5535KB/EO,NQ50J3530BB/EO,NQ50H5533KS/EO,NQ50J3530BS/EO,NQ5B5713GBK/U2,NQ5B5713GBS/U2,NQ5B4313IBK/U2,NQ5B4513IBK/U2,NQ5B4313GBK/U2,NQ5B4513GBK/U2,NQ5B4313GBW/U2,NQ5B4513GBS/U2,NQ5B4313GBS/U2,NQ50R7130BK/EO,NQ50R3130BK/EO,NQ50A6139BK/EO,NQ50A6139BS/EO,NQ50K5130BS/EO,NQ50K3130BM/EO,NQ50K3130BB/EO,NQ50K3130BG/EO,NQ50K5137KB/EO,NQ50K3130BS/EO,NQ50K3130BT/EO,MG22M8074AT/EO,MG22M8274AT/E1,MG22T8254AB/E1,MG22T8054AB/EO,MG22M8254AK/E1,MS22M8074AM/EO,MG22M8054AK/EO,MS22T8054AB/EO,MS22T8254AB/E1,MG23A7318CK/E1,MS22M8254AK/E1,MG23A7118CK/EO,MS22M8054AK/EO,MG23A7013NB/EO,MG23A7013CB/EO,MG20A7013CB/EO,MG23A7013AB/EO,MG23A7013CT/EO,MG20A7013CT/EO,MS23A7318AK/E1,MS23A7013GB/EO,MS23A7118AK/EO,MS23A7013AB/EO,MS23A7013AT/EO,NZ64B7799GK/U2,NZ64B5067YY/U2,NZ64B5067YH/U2,NZ64B5067YJ/U2,NZ64B6058GK/U2,NZ64B6056JK/U2,NZ64B6056GK/U2,NZ64B6056FK/U2,NZ64B5066GK/U2,NZ64B5066FK/U2,NZ64B5046KK/U2,NZ64B5046JK/U2,NZ64B5046GK/U2,NZ64B5046FK/U2,NZ64B5045KK/U2,NZ64B5045GK/U2,NZ64B5045FK/U2,NZ64N9777GK/EO,NZ64R9787GK/EO,NZ64N9777BK/E2,NZ64N7757GK/E2,NZ64N7757FK/EO,NZ84F7NC6AB/EO,NZ84F7NB6AB/EO,NZ64R7757BK/EO,NZ64K7757BK/EO,NZ64A3747DK/EO,NZ64R3747BK/UR,NZ64H57479K/EO,NZ64K5747BK/EO,NZ64T3707A1/UR,NZ64T3707C1/UR,NZ64T3707AK/EO,NZ64H37070K/EO,NZ64H37075K/EO,NZ64M3707AK/UR,NZ64T3706A1/UR,NZ64T3706C1/UR,NZ64F3NM1AB/UR,NZ64M3NM1BB/UR,CTR164NC01/XEO,NZ32R1506BK/EO,NA75J3030AS/EO,NA64H3000AK/O1,NA64H3010AK/O1,NA64H3030BK/O1,NA64H3031AK/O1,NA64H3030AS/O1,NA64H3040AS/O1,NA64H3010AS/O1,NA64H3010BS/O1,NK36N9804VB/UR,NK24N9804VB/UR,NK36M7070VB/UR,NK36M7070VS/UR,NK24M7070VB/UR,NK24M7070VS/UR,NK36M5070BG/UR,NK36M5070BM/UR,NK24M5070BM/UR,NK24M5070BG/UR,NK36M5070BS/UR,NK24M5070FS/UR,NK24M5070BS/UR,NK36M5060SS/UR,NK24M1030IS/UR,NK24M1030IB/UR,BRB30715DWW/EF,BRB30705DWW/EF,BRB30705EWW/EF,BRB30615EWW/EF,BRB30703EWW/EF,BRB30603EWW/EF,BRB30602FWW/EF,BRB30600FWW/EF,BRB26715CWW/EF,BRB26705CWW/EF,BRB26715DWW/EF,BRB26705DWW/EF,BRB26605DWW/EF,BRB26715FWW/EF,BRB26705EWW/EF,BRB26713EWW/EF,BRB26705FWW/EF,BRB26703EWW/EF,BRB26615FWW/EF,BRB26605EWW/EF,BRB26605FWW/EF,BRB26603EWW/EF,BRB26602EWW/EF,BRB26602FWW/EF,BRB26600FWW/EF,DW60A8050FB/ET,DW60A8050FS/EO,DW60R7050FS/EO,DW60A6092FS/EO,DW60A6082FS/EO,DW60M6050FS/EC,DW50R4070FS/EC,DW50R4050FS/EO,DW60A8060IB/EO,DW60A8070BB/EO,DW60A8070US/EO,DW60A8071BB/EO,DW60A8060BB/EO,DW60A8050BB/EO,DW60R7070BB/EO,DW6KR7051BB/EO,DW60R7050BB/EO,DW60R7040BB/EO,DW60A6092IB/EO,DW60A6092BB/EO,DW60A6090BB/EO,DW60A6082BB/EO,DW60M6070IB/ET,DW60M6050SS/EO,DW50R4070BB/EO,DW50R4071BB/EO,DW60M6031BB/EO,DW60M6050BB/EO,DW60M6051BB/EO,DW50R4060BB/EO,DW60M6040BB/EO,DW50R4050BB/EO,DW50R4051BB/EO,DW60M5050BB/EO,DW50R4040BB/EO,GE711K/XEO,MJ26A6053AT/UR,MJ26A6091AT/UR,MJ26A6093AT/UR,MS23K3513AW/EO,BRB260189WW/EF,CM1089A/XEU,CM1099A/XEU,MG28J5255UW/EO,QE43LS03BAUXXH,QE43LS03BGUXXH,QE43QN91BATXXH,QE50LS03BAUXXH,QE50LS03BGUXXH,QE50QN91BATXXH,QE55QN85BATXXH,QE55QN91BATXXH,QE55QN700BTXXH,QE55S90CATXXH,QE55S95BATXXH,QE65LS03BGUXXH,QE65QN85BATXXH,QE65QN91BATXXH,QE65QN700BTXXH,QE65QN800BTXXH,QE65QN900BTXXH,QE65S95BATXXH,QE75LS03BAUXXH,QE75LS03BGUXXH,QE75QN85BATXXH,QE75QN85CATXXH,QE75QN91BATXXH,QE75QN700BTXXH,QE75QN800BTXXH,QE75QN900BTXXH,QE85LS03BAUXXH,QE85LS03BGUXXH,QE85QN85BATXXH,QE85QN95BATXXH,QE85QN800BTXXH,QE85QN900ATXXH,QE85QN900BTXXH,QE55LS03BGUXXH";

				usi_app.their_widget_showing = document.getElementsByClassName("at-table").length > 0 && document.getElementsByClassName("at-table hide").length == 0;

				usi_aff.fix_awin("21709");

				usi_app.monitor_for_receipt();
				usi_app.monitor_for_analytics();

				usi_app.site = "main";
				if (location.href.indexOf("/employee/") != -1 || location.href.indexOf("/uk_employee/") != -1) usi_app.site = "employee";
				else if (location.href.indexOf("/networks/") != -1 || location.href.indexOf("/uk_networks/") != -1) usi_app.site = "networks";
				else if (location.href.indexOf("/students/") != -1 || location.href.indexOf("/uk_student/") != -1) usi_app.site = "students";
				if ((location.href.indexOf("/smallbusiness") != -1 || location.href.indexOf("/business") != -1) && location.href.indexOf("shop.samsung.com") != -1) usi_app.site = "business";
				if (location.href.indexOf("/bulb/") != -1) return;
				if (location.href.indexOf("/exclusive-offers/") != -1) return;
				if (location.href.indexOf("/partners/") != -1) return;

				if (usi_samsung.is_product_page && !usi_app.their_widget_showing) {
					usi_app.send_product_data();
				} else if (usi_app.is_cart_page) {
					usi_app.scrape_cart();
					//usi_app.load_temp_promo();
				}

				if (location.pathname.match("^(/pl/lifestyle-tvs/the-sero/|/pl/tvs/qled-tv/|/pl/tvs/all-tvs/)$") != null || location.search.match("(uhd|qled-8k|neo-qled-4k|full-hd-tv|the-frame|oled|qled-4k-tv)") != null) {
					// load TV Size Guide
					var key = "inpage";
					usi_commons.load("J4l278n8M1N4t2QXKjVNU08", "53867", key);
				}

				// Load affiliate link
				if (usi_app.is_cart_page && usi_cookies.value_exists("usi_needs_link")) {
					usi_cookies.del("usi_needs_link");
					usi_app.link_injection("https://www.awin1.com/cread.php?awinmid=21709&awinaffid=743003&ued=");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_product_page = function () {
			try {
				var enabled_categories = "/pl/smartphones/|/pl/tablets/|/pl/watches/|/pl/audio-sound/|/pl/monitors/|/pl/memory-storage/";
				var enabled_pids =  "WW|WD|DV|RB|RR|RT|RF|RS|RZ|BRB|RA|NV|NQ|NL|MG|MC|MS|VR|VS|DF|AX|NZ|NA|NK|DW";
				// low stock s21 pids and oos
				usi_app.product = usi_app.product_page_data;
				usi_app.low_stock_pids = "SM-G991BZVDEUE|SM-G991BZADEUE|SM-G991BZWDEUE|SM-G991BZIDEUE|SM-G991BZVGEUE|SM-G991BZAGEUE|SM-G991BZWGEUE|SM-G991BZIGEUE|SM-G996BZVGEUE|SM-G996BZKGEUE|SM-G996BZSGEUE|SM-G996BZVDEUE|SM-G996BZKDEUE|SM-G996BZSDEUE";
				usi_app.new_prod_upsell = "QE65Q80CATXXH,QE75Q80CATXXH,QE85Q80CATXXH,QE65Q77CATXXH,QE55Q77CATXXH,QE75Q77CATXXH,QE55QN85CATXXH,QE65QN85CATXXH,QE75QN85CATXXH,QE85QN85CATXXH,QE65S90CATXXH,QE43QN92CATXXH,QE55QN92CATXXH,QE75QN92CATXXH,QE77S95CATXXH,UE43CU8002KXXH,UE55CU8002KXXH,QE75LS03BGUXXH,QE65LS03BGUXXH,QE55LS03BGUXXH,QE43LS03BGUXXH";
				if (usi_app.new_prod_upsell.indexOf(usi_app.product.pid) != -1) {
					usi_split_test.instantiate_callback("53073", function(group){
						if (group === '0') {
							usi_commons.log("Control Group: " + group);
						} else if (group === '1') {
							var usi_key = "_tv";
							usi_commons.log("Split Group: " + group);
							usi_commons.log("[LOAD] TV Upsell");
							usi_commons.load_view("fGaVheZfSe6uVrvmu8fP9xw", "53069", usi_commons.device + usi_key);
						}
					});

				}
				if (location.href.indexOf("s23") == -1 && typeof (usi_app.product_page_data) !== "undefined" && usi_app.product_page_data.stock == "OUTOFSTOCK") {
					if (location.href.match(enabled_categories) != null || usi_app.url.match("/pl/lifestyle-tvs/the-frame/ls03b-65-inch-the-frame-qled-4k-smart-tv-black-qe65ls03bauxxh/") != null || usi_app.product.pid.match(enabled_pids) != null) {
						usi_app.depth_level = 3;
						if (typeof(usi_app.legit_OOS) !== "undefined") {
							usi_app.load_oos();
						}
					}
				} else {
					usi_app.load_product_campaigns();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.link_injection = function (src, callback) {
			try {
				usi_cookies.del("usi_clicked");
				var iframe = document.createElement("iframe");
				iframe.src = src;
				iframe.style.width = "1px";
				iframe.style.height = "1px";
				if (callback != null) iframe.onload = callback;
				document.getElementsByTagName('body')[0].appendChild(iframe);
				usi_commons.log("[ link_injection ] Link Injection Success");
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.monitor_for_receipt = function() {
			try {
				if (location.href.indexOf("order-success") != -1 || location.href.indexOf("orderConfirmation") != -1 || location.href.indexOf("order-confirm") != -1) {
					usi_commons.load_script('https://www.upsellit.com/active/samsungpoland_pixel.jsp');
				} else if (typeof AWIN != 'undefined' && typeof AWIN.Tracking != 'undefined' && typeof AWIN.Tracking.Sale != 'undefined') {
					usi_commons.load_script("https://www.upsellit.com/active/samsungpoland_pixel.jsp");
				} else {
					setTimeout(usi_app.monitor_for_receipt, 2000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.remove_loads = function() {
			try {
				usi_commons.remove_loads();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.grab_oos_matches = function(p) {
			if (p=="QE55LS03BAUXXH") return "QE55LS03BGUXXH,";
			if (p=="QE65LS03BAUXXH") return "QE65LS03BGUXXH,";
			if (p=="QE75LS03BAUXXH") return "QE75LS03BGUXXH,";
			if (p=="QE85LS03BAUXXH") return "QE85LS03BGUXXH,";
			if (p=="QE55S95BATXXH") return "QE55S90CATXXH,";
			if (p=="QE65S95BATXXH") return "QE65S90CATXXH,";
			if (p=="RF65A977FSG/EF") return "RF65A977FSG/EF,RF23M8090SG/EF,";
			if (p=="RF50A5202B1/EO") return "RF23R62E3B1/EO,RF23R62E3S9/EO,";
			if (p=="RF50A5202S9/EO") return "RF23R62E3B1/EO,RF23R62E3S9/EO,";
			if (p=="RF50A5002B1/EO") return "RF23R62E3B1/EO,RF23R62E3S9/EO,";
			if (p=="RH68B8831B1/EF") return "RH68B8831S9/EF,RH69B8941S9/EF,";
			if (p=="RH68B8821B1/EF") return "RH68B8831S9/EF,RH69B8941S9/EF,";
			if (p=="RH68B8820B1/EF") return "RH68B8831S9/EF,RH69B8941S9/EF,";
			if (p=="RS65R54112C/EO") return "RS68A8841B1/EF,RS68A8842B1/EF,";
			if (p=="RS65R5441B4/EO") return "RS68A8841B1/EF,RS68A8842B1/EF,";
			if (p=="RS65R5411B4/EO") return "RS68A8841B1/EF,RS68A8842B1/EF,";
			if (p=="RS65R5411M9/EO") return "RS68A8531B1/EF,RS68A8841B1/EF,";
			if (p=="RS65R5401M9/EO") return "RS68A8841S9/EF,RS68A8531B1/EF,";
			if (p=="RS50N3803SA/EO") return "RS67A8811B1/EF,RS50N3903SA/EO,";
			if (p=="RS50N3513BC/EO") return "RS67A8811WW/EF,RS67A8811B1/EF,";
			if (p=="RS67A8811S9/EF") return "RS68A8820B1/EF,RS68A8840S9/EF,";
			if (p=="RS68A8830S9/EF") return "RS67A8810B1/EF,RS68A8820B1/EF,";
			if (p=="RS66A8101B1/EF") return "RS67A8810B1/EF,RS68A8820B1/EF,";
			if (p=="RS68A8520S9/EF") return "RS68A8820S9/EF,RS67A8810WW/EF,";
			if (p=="RR39A7463AP/EO") return "RR39A7463AP/EF,RR25A5470AP/EF,";
			if (p=="RZ32A7485AP/EO") return "RZ32A7485AP/EF,RR39A7463AP/EF,";
			if (p=="RB38A7B6348WEF") return "RB38A7B6C41/EF,RB38A7B5322/EF,";
			if (p=="RB38A7B6D22/EF") return "RB38A7B5D39/EF,RB38A7B6D34/EF,";
			if (p=="RB38A7B5DS9/EF") return "RB38A7B5DB1/EF,RB38A7B5E22/EF,";
			if (p=="RB38A6B1DCE/EF") return "RB38A6B2EB1/EF,RB38A6B5ECL/EF,";
			if (p=="RB34A7B5D39/EF") return "RB34A7B5D41/EF,RB34A7B5D22/EF,";
			if (p=="RB34A7B5DCE/EF") return "RB34A6B3E22/EF,RB34A7B5E12/EF,";
			if (p=="RB34A7B5EB1/EF") return "RB34A6B3E22/EF,RB34A6B2F22/EF,";
			if (p=="RZ32A748522/EO") return "RZ32A748522/EF,RR39A746322/EF,";
			if (p=="RR39A746322/EO") return "RZ32A748522/EF,RR39A746322/EF,";
			if (p=="RB38T705CB1/EF") return "RB38T775CS9/EF,RB38T775CSR/EF,";
			if (p=="RB38T676CSA/EF") return "RB38T776DS9/EF,RB38T775CS9/EF,";
			if (p=="RB38T774DB1/EF") return "RB38T776DS9/EF,RB38T775CS9/EF,";
			if (p=="RB38T606DB1/EF") return "RB38T606CSA/EF,RB38T675CS9/EF,";
			if (p=="RB38T672CWW/EF") return "RB38T674EB1/EF,RB38T605CWW/EF,";
			if (p=="RB38T603CS9/EF") return "RB38T603DB1/EF,RB38T675DS9/EF,";
			if (p=="RB38T605DS9/EF") return "RB38T675EEL/EF,RB38T603DB1/EF,";
			if (p=="RB38T650EB1/EF") return "RB38T602EB1/EF,RB38T602DSA/EF,";
			if (p=="RB38T672ESA/EF") return "RB38T600EB1/EF,RB38T606EWW/EF,";
			if (p=="RB38T650ESA/EF") return "RB38T600EB1/EF,RB38T606EWW/EF,";
			if (p=="RB38T603FSA/EF") return "RB38T600ESA/EF,RB38T600EB1/EF,";
			if (p=="RB38T603FWW/EF") return "RB38T600ESA/EF,RB38T600EB1/EF,";
			if (p=="RB36T605CB1/EF") return "RB36T675CS9/EF,RB36T602DB1/EF,";
			if (p=="RB36T672CS9/EF") return "RB36T675CS9/EF,RB36T602DB1/EF,";
			if (p=="RB36T602CSA/EF") return "RB36T675CS9/EF,RB36T602DB1/EF,";
			if (p=="RB36T675ESA/EF") return "RB36T675CS9/EF,RB36T602DB1/EF,";
			if (p=="RB36T602EB1/EF") return "RB36T675CS9/EF,RB36T602DB1/EF,";
			if (p=="RB36T602FB1/EF") return "RB36T675CS9/EF,RB36T602DB1/EF,";
			if (p=="RB34T605DBN/EF") return "RB34T674EB1/EF,RB34T635EBN/EF,";
			if (p=="RB34T672DBN/EF") return "RB34T674EB1/EF,RB34T635EBN/EF,";
			if (p=="RB34T675EBN/EF") return "RB34T675DWW/EF,RB34T674EB1/EF,";
			if (p=="RB34T652EBN/EF") return "RB34T675DWW/EF,RB34T674EB1/EF,";
			if (p=="RB34T675DS9/EF") return "RB34T675DWW/EF,RB34T674EB1/EF,";
			if (p=="RB34T602EB1/EF") return "RB34T675ESA/EF,RB34T672DSA/EF,";
			if (p=="RB34T600EBN/EF") return "RB34T675ESA/EF,RB34T672DSA/EF,";
			if (p=="RB34T601FS9/EF") return "RB34T675ESA/EF,RB34T672DSA/EF,";
			if (p=="RB31FDRNDSA/EO") return "RB34T672EWW/EF,RB34T632ESA/EF,";
			if (p=="RB31FERNDBC/EO") return "RB34T672EWW/EF,RB34T632ESA/EF,";
			if (p=="RB33J3230BC/EO") return "RB34T672EWW/EF,RB34T632ESA/EF,";
			if (p=="RB34T602FSA/EF") return "RB34T672EWW/EF,RB34T632ESA/EF,";
			if (p=="RB34T671EWW/EF") return "RB34T600DSA/EF,RB34T672EWW/EF,";
			if (p=="RB31FDRNDBC/EO") return "RB34T600DSA/EF,RB34T672EWW/EF,";
			if (p=="RB33J3215WW/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB33J3205SA/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB34T672FWW/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB31FWRNDSA/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB34T601FWW/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB34T671FSA/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB34T600ESA/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB31FERNDEL/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB34T600FWW/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB33J3030SA/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB34T600EWW/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB31HSR2DSA/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB33J3420WW/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB31HSR2DWW/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB33J3000WW/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3215SS/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3215S9/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3415S9/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3405S9/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FDRNDSA/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3200SS/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3000BC/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3005SA/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FERNCSA/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FERNCSS/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FERNDSA/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FERNDSS/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FWJNDBC/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3005WW/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29HSR2DSA/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FSRNDSA/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FSRNDSS/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3000SA/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29FSRNDWW/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB29HSR2DWW/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RB30J3000WW/EF") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RT38K553PS9/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RT35K553PS9/EO") return "RB34T672FEL/EF,RB34T600DSA/EF,";
			if (p=="RR39M7565B1/EF") return "RZ32M753EB1/EO,RR39M7565B1/EO,";
			if (p=="RZ32M7535B1/EO") return "RR39M7130S9/EF,RZ32M753EB1/EF,";
			if (p=="RR39M7130S9/EO") return "RR39M7130S9/EF,RZ32M753EB1/EF,";
			if (p=="RZ32M7115S9/EO") return "RZ32M7115S9/EF,RR39M7130S9/EF,";
			if (p=="RR39M7145S9/EO") return "RZ32M7115S9/EF,RR39M7130S9/EF,";
			if (p=="RR39M7320S9/EO") return "RZ32M7115S9/EF,RR39M7130S9/EF,";
			if (p=="DV90T7240BT/S6") return "DV80T6220LH/S6,DV90T7240BH/S6,";
			if (p=="DV80T6220LE/S6") return "DV90T6240LH/S6,DV80T6220LH/S6,";
			if (p=="DV90T5240AT/S6") return "DV90TA240AE/EO,DV90T5240AE/S6,";
			if (p=="DV80T5220AE/S6") return "DV90TA240AE/EO,DV90T5240AE/S6,";
			if (p=="DV90TA240AH/EO") return "DV90TA240AE/EO,DV90T5240AE/S6,";
			if (p=="WD80TA046BH/EO") return "WD8NK52E0ZX/EO,WD80TA046BE/EO,";
			if (p=="WD70TA046BE/EO") return "WD8NK52E0ZX/EO,WD80TA046BE/EO,";
			if (p=="WD70TA046BH/EO") return "WD8NK52E0ZX/EO,WD80TA046BE/EO,";
			if (p=="WD80T4046CE/EO") return "WD8NK52E0ZX/EO,WD80TA046BE/EO,";
			if (p=="WD8NK52E0AW/EO") return "WD8NK52E3AW/EO,WD8NK52E0ZW/EO,";
			if (p=="WW80T954ASH/S6") return "WW90T754ABH/S6,WW90T954ASH/S6,";
			if (p=="WW90T754ABT/S6") return "WW90T754ABH/S6,WW90T954ASH/S6,";
			if (p=="WW90T654DLH/S6") return "WW80T654DLH/S6,WW10T654DLH/S6,";
			if (p=="WW80T654DLE/S6") return "WW70T552DAE/S6,WW80T654DLH/S6,";
			if (p=="WW80T554DAE/S6") return "WW70T552DAE/S6,WW80T654DLH/S6,";
			if (p=="WW80T554DAT/S6") return "WW70T552DAE/S6,WW80T654DLH/S6,";
			if (p=="WW70T554DAE/S6") return "WW70T552DAE/S6,WW80T654DLH/S6,";
			if (p=="WW70T552DAT/S6") return "WW70T552DTW/S6,WW70T552DAE/S6,";
			if (p=="WW8NK52E0VW/EO") return "WW8NK62E0RW/EO,WW8NK52E0VX/EO,";
			if (p=="WW70AA626AH/EO") return "WW8NK62E0RW/EO,WW8NK52E0VX/EO,";
			if (p=="WW70AA626AE/EO") return "WW8NK62E0RW/EO,WW8NK52E0VX/EO,";
			if (p=="WW65AA626AE/EO") return "WW8NK62E0RW/EO,WW8NK52E0VX/EO,";
			if (p=="WW70AA626TE/EO") return "WW8NK62E0RW/EO,WW8NK52E0VX/EO,";
			if (p=="WW65AA626TH/EO") return "WW8NK62E0RW/EO,WW8NK52E0VX/EO,";
			if (p=="WW90T634DLH/S6") return "WW90T534DAE/S6,WW10T504DAE/S6,";
			if (p=="WW90T504DAE/S6") return "WW90TA046AE/EO,WW80T534DAE/S6,";
			if (p=="WW90T504DAT/S6") return "WW90TA046AE/EO,WW80T534DAE/S6,";
			if (p=="WW90TA046AT/EO") return "WW90TA046AE/EO,WW80T534DAE/S6,";
			if (p=="WW90TA046TH/EO") return "WW90TA046TE/EO,WW80T504DAE/S6,";
			if (p=="WW70TA026AX/EO") return "WW80TA026TE/EO,WW90TA046TE/EO,";
			if (p=="WW80TA026AT/EO") return "WW80TA026TE/EO,WW90TA046TE/EO,";
			if (p=="WW80TA026AE/EO") return "WW80TA026TE/EO,WW90TA046TE/EO,";
			if (p=="WW80TA026AH/EO") return "WW80TA026TE/EO,WW90TA046TE/EO,";
			if (p=="WW70TA046AE/EO") return "WW80TA026TE/EO,WW90TA046TE/EO,";
			if (p=="WW80TA026TH/EO") return "WW80TA026TE/EO,WW90TA046TE/EO,";
			if (p=="WW70TA026AT/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW70TA026AH/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW70TA026TT/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW70TA026TH/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW70TA026TE/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW8NK52E0PX/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW8NK52E3PW/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW8NK52E0PW/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW80AA126AX/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW80AA126AE/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW80AA126AH/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW80AA126TE/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW70AA126AE/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW70AA126AH/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW65AA126AH/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW65AA126AE/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW70AA126TH/EO") return "WW70TA026AE/EO,WW80TA026TE/EO,";
			if (p=="WW90T4020CT/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW90T4020EE/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW70T4020CE/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW70T4020CH/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW90T304MBW/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW90T304MWW/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW80T304MBW/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW70T304MBW/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW70T302MBW/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW70T304MWW/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW70T302MWW/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW60A3120BE/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW60A3120BH/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW60A3120WE/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="WW60A3120WH/EO") return "WW70T4020EE/EO,WW90T4020CE/EO,";
			if (p=="VC07K51L9H1/GE") return "VS15A6031R1/GE,VS15T7031R1/GE,";
			if (p=="VC07M21N9VD/GE") return "VS15A6031R1/GE,VS15T7031R1/GE,";
			if (p=="VCC45W0S36/XEO") return "VS15A6031R1/GE,VS15T7031R1/GE,";
			if (p=="VC079HNJGGD/EO") return "VS15A6031R1/GE,VS15T7031R1/GE,";
			if (p=="VC07M25E0WR/GE") return "VS15A6031R1/GE,VS15T7031R1/GE,";
			if (p=="AX47R9080SS/EU") return "AX90R7080WD/EU,AX60R5080WD/EU,";
			if (p=="MS23T5018AK/EO") return "MG23K3575AS/EO,MG23T5018CG/EO,";
			if (p=="MG23K3515CK/EO") return "MG23K3515AS/EO,MG23K3575AS/EO,";
			if (p=="MG23J5133AT/EO") return "MG23K3515AS/EO,MG23K3575AS/EO,";
			if (p=="MG23K3515AK/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="GE83X-P/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="MS23K3513AK/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="MG23F301TAS/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="MG23F301TAK/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="GE83X/XEO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="MS23F301TFK/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="MS23F301TAS/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="ME83X-P/EO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="GE83M/XEO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="ME83X/XEO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="ME83M/XEO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="ME732K-S/XEO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="ME711K/XEO") return "MS23K3513AS/EO,MG23K3515AS/EO,";
			if (p=="NQ50K3130BG/EO") return "NQ50K5137KB/EO,NQ50K3130BB/EO,";
			if (p=="NQ50K3130BT/EO") return "MG22M8074AT/EO,NQ50K3130BS/EO,";
			if (p=="MG23A7013NB/EO") return "MG23A7013AB/EO,MS22M8054AK/EO,";
			if (p=="MG23A7013CB/EO") return "MG23A7013AB/EO,MS22M8054AK/EO,";
			if (p=="MG20A7013CB/EO") return "MG23A7013AB/EO,MS22M8054AK/EO,";
			if (p=="MG20A7013CT/EO") return "MS23A7013AB/EO,MG23A7013CT/EO,";
			if (p=="MS23A7013GB/EO") return "MS23A7013AB/EO,MG23A7013CT/EO,";
			if (p=="MS23A7118AK/EO") return "MS23A7013AB/EO,MG23A7013CT/EO,";
			if (p=="NV7B6799JAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B6795JAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B6785KAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5785JAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5785KAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5765RAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5765XAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5745PAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5745PAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4545VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4345VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4545VAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4345VAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B7997AAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B7980AAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B6685AAN/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B6685BAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5685AAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5685BAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5660RAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5660XAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5645TAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B5645TAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4445VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4245VAW/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4245VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4445VAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4440VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4245VAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4240VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4145VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4045VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4140VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4040VAW/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4040VAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4140VAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4040VAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4525ZAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4325ZAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B45251AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B43251AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4525ZAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4325ZAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4425ZAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B44251AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B42251AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4425ZAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4225ZAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B44257AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B44205AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B44207AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B44205AS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B44207AS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4020ZAK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B41201AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B41205AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B4020ZAS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B41207AK/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B41201AS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NV7B41207AS/U2") return "NV75N5641RS/EO,NV75N7677RS/EO,";
			if (p=="NQ5B7993AAK/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B6753CAN/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B6753CAK/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B5763DBK/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B5763DBS/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B4353FBK/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B4553FBK/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B4553FBS/U2") return "NQ50J3530BS/EO,NQ50J5530BS/EO,";
			if (p=="NQ5B5713GBK/U2") return "MS23A7013AT/EO,NQ50R7130BK/EO,";
			if (p=="NQ5B5713GBS/U2") return "MS23A7013AT/EO,NQ50R7130BK/EO,";
			if (p=="NQ5B4313GBK/U2") return "MS23A7013AT/EO,NQ50R7130BK/EO,";
			if (p=="NQ5B4513GBK/U2") return "MS23A7013AT/EO,NQ50R7130BK/EO,";
			if (p=="NQ5B4313GBW/U2") return "MS23A7013AT/EO,NQ50R7130BK/EO,";
			if (p=="NQ5B4513GBS/U2") return "MS23A7013AT/EO,NQ50R7130BK/EO,";
			if (p=="NQ5B4313GBS/U2") return "MS23A7013AT/EO,NQ50R7130BK/EO,";
			if (p=="NZ64B7799GK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B6058GK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B6056JK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B6056GK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B6056FK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5066GK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5066FK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5046KK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5046JK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5046GK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5046FK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5045KK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5045GK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="NZ64B5045FK/U2") return "NZ64F3NM1AB/UR,NZ64N9777GK/EO,";
			if (p=="BRB30705EWW/EF") return "BRB30615EWW/EF,BRB30705DWW/EF,";
			if (p=="BRB30703EWW/EF") return "BRB30602FWW/EF,BRB30615EWW/EF,";
			if (p=="BRB30603EWW/EF") return "BRB30602FWW/EF,BRB30615EWW/EF,";
			if (p=="BRB30600FWW/EF") return "BRB30602FWW/EF,BRB30615EWW/EF,";
			if (p=="BRB26713EWW/EF") return "BRB26705FWW/EF,BRB26715FWW/EF,";
			if (p=="BRB26703EWW/EF") return "BRB26615FWW/EF,BRB26705FWW/EF,";
			if (p=="BRB26605EWW/EF") return "BRB26605FWW/EF,BRB26615FWW/EF,";
			if (p=="BRB26603EWW/EF") return "BRB26602FWW/EF,BRB26605FWW/EF,";
			if (p=="BRB26602EWW/EF") return "BRB26602FWW/EF,BRB26605FWW/EF,";
			if (p=="BRB26600FWW/EF") return "BRB26602FWW/EF,BRB26605FWW/EF,";
			if (p=="NV75A6679RK/EO") return "NV75N7647RS/EO,NV75N7677RS/EO,";
			if (p=="NV75N762ARK/EO") return "NV75N5671RB/EO,NV75N5671RM/EO,";
			if (p=="NV75N7646RB/EO") return "NV75N7626RB/EO,NV75A6649RK/EO,";
			if (p=="NV75N7646RS/EO") return "NV75N5641RB/EO,NV75A6649RS/EO,";
			if (p=="NV75N5621RB/EO") return "NV75N5641RS/EO,NV75N5641RB/EO,";
			if (p=="NV75N5622RT/EO") return "NV75N5641RS/EO,NV75N5641RB/EO,";
			if (p=="NV75J5540RS/EO") return "NV75A6549RK/EO,NV75J7570RS/EO,";
			if (p=="NV68R5545CB/EO") return "NV75K5541RM/EO,NV70H5787CB/EO,";
			if (p=="NV75N7546RS/EO") return "NV75K5541RM/EO,NV70H5787CB/EO,";
			if (p=="NV75K5541RG/EO") return "NV75K5541RM/EO,NV70H5787CB/EO,";
			if (p=="NV70M5520CB/EO") return "NV75K5541RB/EO,NV75K5541RM/EO,";
			if (p=="NV70M3521RB/EO") return "NV70H5587BB/EO,NV70M3541RS/EO,";
			if (p=="NV68R5345CB/EO") return "NV66M3531BB/EO,NV70H5587BB/EO,";
			if (p=="NV66M3535BB/EO") return "NV66M3531BB/EO,NV70H5587BB/EO,";
			if (p=="NV64R3531BB/EO") return "NV66M3531BB/EO,NV70H5587BB/EO,";
			if (p=="NV64R3531BS/EO") return "NV66M3531BS/EO,NV66M3531BB/EO,";
			if (p=="NV70K2340RG/EO") return "NV70K2340RM/EO,NV66M3531BS/EO,";
			if (p=="NV70K2340RB/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV75J3140RB/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV75J3140BB/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV75J3140BS/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV68A1145CK/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV68A1145RK/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV68A1140RS/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV68A1140BK/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV68A1140BB/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV70K1340BB/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV68A1140BS/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NV70K1340BS/EO") return "NV70K2340RS/EO,NV70K2340RM/EO,";
			if (p=="NQ50K3530BG/EO") return "NQ50J3530BB/EO,NQ50H5537KB/EO,";
			if (p=="NQ50H5535KB/EO") return "NQ50J3530BB/EO,NQ50H5537KB/EO,";
			if (p=="NQ50H5533KS/EO") return "NQ50J3530BS/EO,NQ50J3530BB/EO,";
			if (p=="NZ64N7757FK/EO") return "NZ84F7NC6AB/EO,NZ64N7757GK/E2,";
			if (p=="NZ64R7757BK/EO") return "NZ64K7757BK/EO,NZ84F7NB6AB/EO,";
			if (p=="NZ64R3747BK/UR") return "NZ64K5747BK/EO,NZ64A3747DK/EO,";
			if (p=="NZ64H57479K/EO") return "NZ64K5747BK/EO,NZ64A3747DK/EO,";
			if (p=="NZ64T3707AK/EO") return "NZ64H37070K/EO,NZ64T3707C1/UR,";
			if (p=="NZ64H37075K/EO") return "NZ64F3NM1AB/UR,NZ64H37070K/EO,";
			if (p=="NZ64M3707AK/UR") return "NZ64F3NM1AB/UR,NZ64H37070K/EO,";
			if (p=="NZ64T3706A1/UR") return "NZ64F3NM1AB/UR,NZ64H37070K/EO,";
			if (p=="NZ64T3706C1/UR") return "NZ64F3NM1AB/UR,NZ64H37070K/EO,";
			if (p=="NZ64M3NM1BB/UR") return "NZ64F3NM1AB/UR,NZ64H37070K/EO,";
			if (p=="NZ32R1506BK/EO") return "NZ64F3NM1AB/UR,CTR164NC01/XEO,";
			if (p=="NA64H3031AK/O1") return "NA64H3030AS/O1,NA64H3030BK/O1,";
			if (p=="NA64H3040AS/O1") return "NA64H3030AS/O1,NA64H3030BK/O1,";
			if (p=="NA64H3010AS/O1") return "NA64H3030AS/O1,NA64H3030BK/O1,";
			if (p=="NA64H3010BS/O1") return "NA64H3030AS/O1,NA64H3030BK/O1,";
			if (p=="NK36M5070BG/UR") return "NK36M5070BM/UR,NK24M7070VS/UR,";
			if (p=="NK24M5070BM/UR") return "NK36M5070BS/UR,NK36M5070BM/UR,";
			if (p=="NK24M5070BG/UR") return "NK36M5070BS/UR,NK36M5070BM/UR,";
			if (p=="DW60A6082FS/EO") return "DW60M6050FS/EC,DW60A6092FS/EO,";
			if (p=="DW60A8070BB/EO") return "DW60A8070US/EO,DW60A8060IB/EO,";
			if (p=="DW60A8060BB/EO") return "DW60A8050BB/EO,DW60A8071BB/EO,";
			if (p=="DW60R7070BB/EO") return "DW60R7050BB/EO,DW60A8050BB/EO,";
			if (p=="DW6KR7051BB/EO") return "DW60R7050BB/EO,DW60A8050BB/EO,";
			if (p=="DW60A6092BB/EO") return "DW60A6090BB/EO,DW60A6092IB/EO,";
			if (p=="DW60A6082BB/EO") return "DW60M6070IB/ET,DW60A6090BB/EO,";
			if (p=="DW60M6050SS/EO") return "DW50R4070BB/EO,DW60M6070IB/ET,";
			if (p=="DW50R4071BB/EO") return "DW60M6050BB/EO,DW50R4070BB/EO,";
			if (p=="DW60M6031BB/EO") return "DW60M6050BB/EO,DW50R4070BB/EO,";
			if (p=="DW60M6051BB/EO") return "DW50R4050BB/EO,DW60M6050BB/EO,";
			if (p=="DW50R4060BB/EO") return "DW50R4050BB/EO,DW60M6050BB/EO,";
			if (p=="DW60M6040BB/EO") return "DW50R4050BB/EO,DW60M6050BB/EO,";
			if (p=="DW50R4051BB/EO") return "DW60M5050BB/EO,DW50R4050BB/EO,";
			if (p=="DW50R4040BB/EO") return "DW60M5050BB/EO,DW50R4050BB/EO,";
			if (p=="SKK-DDX") return "SKK-UDW,SKK-UDX,";
			if (p=="VCA-SBTA60") return "VCA-WB650/GL,VCA-SAE903/GE,";
			if (p=="VCA-SAK90/GL") return "VCA-SAK90W/GL,VCA-TAB90A,";
			if (p=="VCA-SAPA95/WA") return "VCA-RAK80,VCA-RAK95,";
			if (p=="VCA-WBA95/GL") return "VCA-RAK80,VCA-RAK95,";
			if (p=="VCA-SABA95") return "VCA-RAK80,VCA-RAK95,";
			if (p=="VCA-TABA95") return "VCA-RAK80,VCA-RAK95,";
			if (p=="VCA-SPW95") return "VCA-RAK80,VCA-RAK95,";
			if (p=="VCA-ADB952") return "VCA-RAK80,VCA-RAK95,";
			if (p=="VCA-SPA95/GL") return "VCA-RAK80,VCA-RAK95,";
			return "";
		};

		 usi_app.load_wtb = function() {
		 	try {
		 		if (usi_app.url.match("/mobile-accessories/") != null) return;
		 		if (usi_commons.device == "desktop" &&  usi_app.mouse_over == 0) {
		 			return;
				}
		 		if (document.getElementById("usi_overwrite_button") != null) {
		 			document.getElementById("usi_overwrite_button").style.display = "none";
				}
		 		if (usi_cookies.get("usi_wtb_loaded") == null) {
		 			//usi_cookies.set("usi_wtb_loaded", "1", 24*60*60, true);
				} else {
		 			return;
				}
				// Load site
				usi_commons.log("Split Group: USI");
				if (typeof(usi_45247) == "undefined") {
					var usi_key;
					if (usi_app.product && (usi_app.selected_skus.indexOf(usi_app.product.pid) != -1 || usi_app.product.category.toLowerCase().indexOf("monitor") != -1)) {
						usi_key = "_selected";
					} else if (usi_app.product && usi_app.product.category && usi_app.product.category.toLowerCase().indexOf("mobile") != -1) {
						usi_key = "_mx";
					} else if (usi_app.product && usi_app.product.category && (usi_app.product.category.toLowerCase().indexOf("memory") != -1 || usi_app.product.category.toLowerCase().indexOf("vacuum") != -1 || usi_app.product.category.toLowerCase().indexOf("projector") != -1 || usi_app.product.category.toLowerCase().indexOf("soundbar") != -1 || usi_app.product.category.toLowerCase().indexOf("purifier") != -1)) {
						usi_key = "_other";
					} else if (usi_app.product && "QE32LS03BBUXXH,QE43LS01BAUXXH,QE43LS01BBUXXH,QE43LS01TAUXXH,QE43Q67BAUXXH,QE50LS01BBUXXH,QE50LS01TBUXXH,QE50Q67BAUXXH,QE55LS01BAUXXH,QE55LS01BBUXXH,QE55LST7TCUXXH,QE55Q67BAUXXH,QE55Q77BATXXH,QE55Q80BATXXH,QE65LS01BAUXXH,QE65LS01BBUXXH,QE65LST7TCUXXH,QE65Q67BAUXXH,QE65Q77BATXXH,QE65Q80BATXXH,QE75LST7TCUXXH,QE75Q67BAUXXH,QE75Q77BATXXH,QE75Q80BATXXH,QE85Q70BATXXH,QE85Q80BATXXH,QE98QN90AATXXH,SP-LSP3BLAXXH,SP-LSP9TFAXXH,UE32T4002AKXXH,UE32T4302AKXXH,UE43CU8002KXXH,UE65CU8002KXXH,UE75AU7192UXXH,UE75BU8002KXXH".indexOf(usi_app.product.pid) != -1) {
						usi_key = "_tvda";
					}

					/*(usi_app.is_enabled && usi_app.product && usi_app.product.category && (usi_app.product.category.toLowerCase().indexOf("tv") != -1 || usi_app.product.category.toLowerCase().indexOf("television") != -1 || usi_app.product.category.toLowerCase().indexOf("appliances") != -1)) {
						usi_key = "_tvda";
					}*/
					if (usi_key != "") {
						usi_commons.load("0a2384mjS9aRHlIX0RQLwoX", "45247", usi_commons.device + usi_key);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		 };

		usi_app.get_rec = function(pid, which) {
			var usi_combos = [];
			if (which == 1 || which == -1) {
				usi_combos = ['SM-F946BLBBEUE,SM-F946BZEBEUE,SM-F946BZKBEUE,SM-F946BZUBEUE,SM-F946BZBBEUE--SM-R510NZAAEUE,EF-OF94PCUEGWW,EP-P5400BBEGEU,EF-VF946PBEGWW,SM-R965FZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-OF94PCBEGWW,EP-P5400BWEGEU,EF-VF946PLEGWW,SM-R965FZSAEUE,EF-OF94KKBEGWW,SM-R510NLVAEUE,EF-OF94PCLEGWW,EP-T4510XBEGEU,EF-OF94KKBEGWW,SM-R955FZKAEUE,SM-R935FZEAEUE',
				'SM-F946BLBCEUE,SM-F946BZECEUE,SM-F946BZKCEUE,SM-F946BZUCEUE,SM-F946BZBCEUE--SM-R510NZAAEUE,EF-OF94KKBEGWW,EP-P5400BBEGEU,EF-VF946PBEGWW,SM-R965FZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-OF94PCUEGWW,EP-P5400BWEGEU,EF-VF946PLEGWW,SM-R965FZSAEUE,EF-OF94KKBEGWW,SM-R510NLVAEUE,EF-OF94PCBEGWW,EP-T4510XBEGEU,EF-OF94KKBEGWW,SM-R955FZKAEUE,SM-R935FZEAEUE',
				'SM-F946BLBNEUE,SM-F946BZENEUE,SM-F946BZKNEUE,SM-F946BZUNEUE,SM-F946BZBNEUE--SM-R510NZAAEUE,EF-OF94PCUEGWW,EP-P5400BBEGEU,EF-VF946PBEGWW,SM-R965FZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-OF94PCBEGWW,EP-P5400BWEGEU,EF-VF946PLEGWW,SM-R965FZSAEUE,EF-OF94KKBEGWW,SM-R510NLVAEUE,EF-OF94PCLEGWW,EF-OF94KKBEGWW,EF-OF94KKBEGWW,SM-R955FZKAEUE,SM-R935FZEAEUE',
				'SM-F731BLGGEUE,SM-F731BLIGEUE,SM-F731BZAGEUE,SM-F731BZEGEUE,SM-F731BZUGEUE,SM-F731BZBGEUE,SM-F731BZYGEUE,SM-F731BZGGEUE--SM-R510NZAAEUE,EF-XF731CTEGWW,EP-T2510NBEGEU,EF-PF731TNEGWW,EP-T2510XBEGEU,SM-R930NZEAEUE,SM-R510NZWAEUE,EF-PF731TOEGWW,EP-T2510NWEGEU,EF-PF731TUEGWW,EP-T2510XWEGEU,SM-R930NZKAEUE,SM-R510NLVAEUE,EF-PF731TVEGWW,EP-T2510XBEGEU,EF-PF731TMEGWW,EP-T2510NWEGEU,SM-R940NZKAEUE',
				'SM-F731BLGHEUE,SM-F731BLIHEUE,SM-F731BZAHEUE,SM-F731BZEHEUE,SM-F731BZUHEUE,SM-F731BZBHEUE,SM-F731BZYHEUE,SM-F731BZGHEUE--SM-R510NZAAEUE,EF-XF731CTEGWW,EP-T2510NBEGEU,EF-PF731TNEGWW,EP-T2510XBEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,EF-PF731TOEGWW,EP-T2510NWEGEU,EF-PF731TUEGWW,EP-T2510XWEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE,EF-PF731TVEGWW,EP-T2510XBEGEU,EF-PF731TMEGWW,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-S918BLIPEUE,SM-S918BZEPEUE,SM-S918BZGPEUE,SM-S918BZKPEUE,SM-S918BLBPEUE,SM-S918BLGPEUE,SM-S918BZAPEUE,SM-S918BZRPEUE--SM-R510NZAAEUE,EF-ZS918CBEGWW,EP-P5400BBEGEU,EF-QS918CTEGWW,SM-R965FZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-ZS918CVEGWW,EP-P5400BWEGEU,EF-ZS918CGEGWW,SM-R965FZSAEUE,SM-R400NZAAEUE,SM-R510NLVAEUE,EF-ZS918CUEGWW,EP-T2510NBEGEU,EF-ZS918CUEGWW,SM-R955FZKAEUE,SM-R935FZEAEUE',
				'SM-S918BLIHEUE,SM-S918BZEHEUE,SM-S918BZGHEUE,SM-S918BZKHEUE,SM-S918BLBHEUE,SM-S918BLGHEUE,SM-S918BZAHEUE,SM-S918BZRHEUE--SM-R510NZAAEUE,EF-ZS918CBEGWW,EP-P5400BBEGEU,EF-QS918CTEGWW,SM-R965FZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-ZS918CVEGWW,EP-P5400BWEGEU,EF-ZS918CGEGWW,SM-R965FZSAEUE,SM-R400NZAAEUE,SM-R510NLVAEUE,EF-ZS918CUEGWW,EP-T2510NBEGEU,EF-ZS918CUEGWW,SM-R955FZKAEUE,SM-R935FZEAEUE',
				'SM-S918BZEDEUE,SM-S918BZGDEUE,SM-S918BZKDEUE,SM-S918BLIDEUE,SM-S918BLBDEUE,SM-S918BLGDEUE,SM-S918BZADEUE,SM-S918BZRDEUE--SM-R510NZAAEUE,EF-ZS918CBEGWW,EP-P5400BBEGEU,EF-QS918CTEGWW,SM-R965FZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-ZS918CVEGWW,EP-P5400BWEGEU,EF-ZS918CGEGWW,SM-R965FZSAEUE,SM-R400NZAAEUE,SM-R510NLVAEUE,EF-ZS918CUEGWW,EP-T2510NBEGEU,EF-ZS918CUEGWW,SM-R955FZKAEUE,SM-R935FZEAEUE',
				'SM-S916BLIDEUE,SM-S916BZEDEUE,SM-S916BZGDEUE,SM-S916BZKDEUE,SM-S916BLGDEUE,SM-S916BZADEUE--SM-R510NZAAEUE,EF-ZS916CBEGWW,EP-P5400BBEGEU,EF-QS916CTEGWW,SM-R960NZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-ZS916CVEGWW,EP-P5400BWEGEU,EF-ZS916CGEGWW,SM-R960NZSAEUE,SM-R400NZAAEUE,SM-R510NLVAEUE,EF-ZS916CGEGWW,EP-T2510NBEGEU,EF-ZS916CUEGWW,SM-R950NZKAEUE,SM-R935FZEAEUE',
				'SM-S916BLIGEUE,SM-S916BZEGEUE,SM-S916BZGGEUE,SM-S916BZKGEUE,SM-S916BLGGEUE,SM-S916BZAGEUE--SM-R510NZAAEUE,EF-ZS916CVEGWW,EP-P5400BBEGEU,EF-QS916CTEGWW,SM-R950NZKAEUE,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-ZS916CBEGWW,EP-P5400BWEGEU,EF-ZS916CGEGWW,SM-R950NZSAEUE,SM-R400NZAAEUE,SM-R510NLVAEUE,EF-ZS916CGEGWW,EP-T2510NBEGEU,EF-ZS916CUEGWW,SM-R960NZKAEUE,SM-R935FZEAEUE',
				'SM-S911BLIDEUE,SM-S911BZEDEUE,SM-S911BZGDEUE,SM-S911BZKDEUE,SM-S911BLGDEUE,SM-S911BZADEUE--SM-R510NZAAEUE,EF-ZS911CBEGWW,EP-T2510NBEGEU,EF-QS911CTEGWW,EP-T2510XWEGEU,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-ZS911CUEGWW,EP-T2510NWEGEU,EF-ZS911CGEGWW,EP-T2510XBEGEU,SM-R400NZAAEUE,SM-R510NLVAEUE,EF-ZS911CVEGWW,EP-T2510XBEGEU,EF-ZS911CVEGWW,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-S911BLIGEUE,SM-S911BZEGEUE,SM-S911BZGGEUE,SM-S911BZKGEUE,SM-S911BLGGEUE,SM-S911BZAGEUE--SM-R510NZAAEUE,EF-ZS911CGEGWW,EP-T2510NBEGEU,EF-QS911CTEGWW,EP-T2510XWEGEU,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-ZS911CVEGWW,EP-T2510NWEGEU,EF-ZS911CBEGWW,EP-T2510XBEGEU,SM-R400NZAAEUE,SM-R510NLVAEUE,EF-ZS911CUEGWW,EP-T2510XBEGEU,EF-ZS911CGEGWW,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-S901BZEDEUE,SM-S901BZADEUE,SM-S901BLBDEUE,SM-S901BZVDEUE,SM-S901BZKDEUE,SM-S901BLVDEUE,SM-S901BZGDEUE,SM-S901BIDDEUE,SM-S901BZWDEUE--SM-R510NZAAEUE,EF-ZS901CEEGEE,EP-T2510NBEGEU,EF-PS901TBEGWW,EP-P5400BBEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,EF-PS901TPEGWW,EP-T2510NWEGEU,SM-R400NZAAEUE,EP-P5400BWEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE,EF-ZS901CBEGEE,EP-T2510XBEGEU,EP-T2510XWEGEU,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-S901BZEGEUE,SM-S901BZAGEUE,SM-S901BLBGEUE,SM-S901BZVGEUE,SM-S901BZKGEUE,SM-S901BLVGEUE,SM-S901BZGGEUE,SM-S901BIDGEUE,SM-S901BZWGEUE--SM-R510NZAAEUE,EF-ZS901CEEGEE,EP-T2510NBEGEU,EF-PS901TBEGWW,EP-P5400BBEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,EF-PS901TPEGWW,EP-T2510NWEGEU,SM-R400NZAAEUE,EP-P5400BWEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE,EF-ZS901CBEGEE,EP-T2510XBEGEU,EP-T2510XWEGEU,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-G990BZADEUE,SM-G990BLGDEUE,SM-G990BLVDEUE,SM-G990BZWDEUE--SM-R510NZAAEUE,SM-R930NZEAEUE,EP-T2510NBEGEU,EI-T5600BWEGEU,EP-T2510XWEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R930NZKAEUE,EP-T2510NWEGEU,SM-R400NZAAEUE,EP-T2510XBEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE,SM-R940NZKAEUE,EP-T2510XBEGEU,SM-R935FZEAEUE,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-G990BZAGEUE,SM-G990BLGGEUE,SM-G990BLVGEUE,SM-G990BZWGEUE--SM-R510NZAAEUE,SM-R930NZEAEUE,EP-T2510NBEGEU,EI-T5600BWEGEU,EP-T2510XWEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R930NZKAEUE,EP-T2510NWEGEU,SM-R400NZAAEUE,EP-T2510XBEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE,SM-R940NZKAEUE,EP-T2510XBEGEU,SM-R935FZEAEUE,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-G990BLGFEUE,SM-G990BLVFEUE,SM-G990BZAFEUE,SM-G990BZWFEUE--SM-R510NZAAEUE,SM-R930NZEAEUE,EP-T2510NBEGEU,EI-T5600BWEGEU,EP-T2510XWEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R930NZKAEUE,EP-T2510NWEGEU,SM-R400NZAAEUE,EP-T2510XBEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE,SM-R940NZKAEUE,EP-T2510XBEGEU,SM-R935FZEAEUE,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-G990BZAWEUE,SM-G990BLVWEUE,SM-G990BLGWEUE,SM-G990BZWWEUE--SM-R510NZAAEUE,SM-R930NZEAEUE,EP-T2510NBEGEU,EI-T5600BWEGEU,EP-T2510XWEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R930NZKAEUE,EP-T2510NWEGEU,SM-R400NZAAEUE,EP-T2510XBEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE,SM-R940NZKAEUE,EP-T2510XBEGEU,SM-R935FZEAEUE,EP-T2510NWEGEU,SM-R935FZEAEUE',
				'SM-S711BZWGEUE,SM-S711BZAGEUE,SM-S711BZBGEUE,SM-S711BLGGEUE,SM-S711BZPGEUE,SM-S711BZOGEUE--SM-R510NZAAEUE,EF-ZS711CBEGWW,EP-T2510NBEGEU,EF-QS711CTEGWW,EP-P5400BBEGEU,SM-R950NZKAEUE,SM-R510NZWAEUE,EF-ZS711CWEGWW,EP-T2510NWEGEU,EF-ZS711CMEGWW,EP-P5400BWEGEU,SM-R950NZSAEUE,SM-R510NLVAEUE,EF-ZS711CMEGWW,EP-T2510XBEGEU,SM-R400NZWAEUE,EP-T2510NBEGEU,SM-R960NZKAEUE',
				'SM-A536BZKNEEE--EF-GA536TNEGWW,EP-T2510NBEGEU,SM-R400NZAAEUE,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R935FZEAEUE,EF-GA536TWEGWW,EP-T2510NWEGEU,SM-R400NZWAEUE,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R935FZKAEUE,EF-PA536TBEGWW,EP-T2510XBEGEU,SM-R510NZAAEUE,SM-R930NZKAEUE,SM-R510NLVAEUE,SM-R945FZKAEUE',
				'SM-S711BZWDEUE,SM-S711BZADEUE,SM-S711BZBDEUE,SM-S711BLGDEUE,SM-S711BZPDEUE,SM-S711BZODEUE,SM-S711BZWGEUE,SM-S711BZAGEUE,SM-S711BZBGEUE,SM-S711BLGGEUE,SM-S711BZPGEUE,SM-S711BZOGEUE--SM-R510NZAAEUE,EF-ZS711CBEGWW,EP-T2510NBEGEU,SM-R940NZKAEUE,EF-PS711TBEGWW,EF-US711CTEGWW,SM-R510NZWAEUE,EF-ZS711CMEGWW,EP-T2510NWEGEU,SM-R930NZEAEUE,EF-PS711TOEGWW,EF-QS711CTEGWW,SM-R510NLVAEUE,EF-ZS711CWEGWW,EP-T2510XBEGEU,SM-R935FZEAEUE,EF-PS711TMEGWW,EI-T5600BWEGEU',
				"SM-S921BZYDEUE,SM-S921BZVDEUE,SM-S921BLGDEUE,SM-S921BZADEUE,SM-S921BZKDEUE,SM-S921BZODEUE,SM-S921BLBDEUE,SM-S921BZYGEUE,SM-S921BZVGEUE,SM-S921BLGGEUE,SM-S921BZAGEUE,SM-S921BZKGEUE,SM-S921BZOGEUE,SM-S921BLBGEUE--EF-ZS921CBEGWW,EP-T2510NBEGEU,EF-US921CTEGWW,EF-PS921TEEGWW,SM-R930NZEAEUE,EI-T5600BBEGEU,EF-ZS921CGEGWW,EP-T2510NWEGEU,EF-XS921CTEGWW,EF-PS921TVEGWW,SM-R930NZKAEUE,EI-T5600BWEGEU,EF-ZS921CVEGWW,EP-T2510XBEGEU,GP-FPS921SAATW,EF-PS921TGEGWW,SM-R960NZKAEUE,EP-P5400BBEGEU",
				"SM-S926BZYDEUE,SM-S926BZVDEUE,SM-S926BLGDEUE,SM-S926BZADEUE,SM-S926BZKDEUE,SM-S926BZODEUE,SM-S926BLBDEUE,SM-S926BZYGEUE,SM-S926BZVGEUE,SM-S926BLGGEUE,SM-S926BZAGEUE,SM-S926BZKGEUE,SM-S926BZOGEUE,SM-S926BLBGEUE--EF-ZS926CBEGWW,EP-T4510XBEGEU,EF-PS926TEEGWW,EF-US926CTEGWW,SM-R935FZEAEUE,EI-T5600BBEGEU,EF-ZS926CGEGWW,EP-P5400BBEGEU,EF-PS926TVEGWW,EF-XS926CTEGWW,SM-R945FZKAEUE,EI-T5600BWEGEU,EF-ZS926CVEGWW,EP-T2510NBEGEU,EF-PS926TGEGWW,GP-FPS926SAATW,SM-R960NZKAEUE,EP-P5400BBEGEU",
				"SM-S928BZKPEUE,SM-S928BLBPEUE,SM-S928BZTPEUE,SM-S928BLGPEUE,SM-S928BZOPEUE,SM-S928BZVPEUE,SM-S928BZYPEUE,SM-S928BZKGEUE,SM-S928BLBGEUE,SM-S928BZTGEUE,SM-S928BLGGEUE,SM-S928BZOGEUE,SM-S928BZVGEUE,SM-S928BZYGEUE,SM-S928BZKHEUE,SM-S928BLBHEUE,SM-S928BZTHEUE,SM-S928BLGHEUE,SM-S928BZOHEUE,SM-S928BZVHEUE,SM-S928BZYHEUE--EF-ZS928CBEGWW,EP-T4510XBEGEU,EF-PS928TEEGWW,EF-US928CTEGWW,SM-R960NZKAEUE,EI-T5600BBEGEU,EF-ZS928CGEGWW,EP-P5400BBEGEU,EF-PS928TVEGWW,EF-XS928CTEGWW,SM-R950NZKAEUE,EI-T5600BWEGEU,EF-ZS928CVEGWW,EP-T2510NBEGEU,EF-PS928TGEGWW,EJ-PS928BBEGEU,SM-R955FZKAEUE,EP-P5400BBEGEU"
				];

				usi_combos.push('SM-A546BLGCEUE,SM-A546BLVCEUE,SM-A546BZKCEUE,SM-A546BZWCEUE--SM-R390NZAAEUE,EF-ZA546CBEGWW,EP-T2510NBEGEU,EF-QA546CTEGWW,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,EP-P5400BBEGEU,EP-T2510NWEGEU,SM-R945FZSAEUE,SM-R930NZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,EF-QA546CTEGWW,EP-T2510XBEGEU,EP-P5400BBEGEU,SM-R940NZKAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A546BZKDEUE,SM-A546BLGDEUE,SM-A546BLVDEUE,SM-A546BZWDEUE--SM-R390NZAAEUE,EF-ZA546CBEGWW,EP-T2510NBEGEU,EF-QA546CTEGWW,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,EP-P5400BBEGEU,EP-T2510NWEGEU,SM-R945FZSAEUE,SM-R930NZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,EF-QA546CTEGWW,EP-T2510XBEGEU,EP-P5400BBEGEU,SM-R940NZKAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A346BLGAEUE,SM-A346BLVAEUE,SM-A346BZKAEUE,SM-A346BZSAEUE--SM-R390NZAAEUE,EP-T2510NBEGEU,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R935FZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,EP-T2510NWEGEU,SM-R930NZKAEUE,SM-R400NZAAEUE,SM-R935FZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,EP-T2510XBEGEU,SM-R940NZKAEUE,SM-R935FZEAEUE,SM-R945FZSAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A346BZKEEUE,SM-A346BLGEEUE,SM-A346BLVEEUE,SM-A346BZSEEUE--SM-R390NZAAEUE,EP-T2510NBEGEU,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R935FZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,EP-T2510NWEGEU,SM-R930NZKAEUE,SM-R400NZAAEUE,SM-R935FZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,EP-T2510XBEGEU,SM-R940NZKAEUE,SM-R935FZEAEUE,SM-R945FZSAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A236BLBUEUE,SM-A236BZKUEUE--SM-R390NZAAEUE,EP-T2510NBEGEU,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R935FZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,EP-T2510NWEGEU,SM-R930NZKAEUE,SM-R400NZAAEUE,SM-R935FZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,EP-T2510XBEGEU,SM-R940NZKAEUE,SM-R935FZEAEUE,SM-R945FZSAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A145RLGUEUE,SM-A145RZKUEUE,SM-A145RZSUEUE--SM-R390NZAAEUE,EP-T1510XBEGEU,SM-R930NZEAEUE,EP-T1510XWEGEU,SM-R935FZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,EP-T1510NBEGEU,SM-R930NZKAEUE,SM-R510NZWAEUE,SM-R935FZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,EP-T1510XWEGEU,SM-R940NZKAEUE,EP-T1510XWEGEU,SM-R945FZSAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A146PLGDEUE,SM-A146PZKDEUE,SM-A146PZSDEUE--SM-R390NZAAEUE,EP-T1510XBEGEU,SM-R930NZEAEUE,EP-T1510XWEGEU,SM-R935FZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,EP-T1510NBEGEU,SM-R930NZKAEUE,SM-R510NZWAEUE,SM-R935FZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,EP-T1510XWEGEU,SM-R940NZKAEUE,EP-T1510XWEGEU,SM-R945FZSAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A256BZKDEUE,SM-A256BZBDEUE,SM-A256BZGDEUE,SM-A256BZSDEUE,SM-A256BZYDEUE--SM-R390NZAAEUE,EF-OA256TBEGWW,EP-T2510NBEGEU,SM-R400NZAAEUE,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,GP-FPA256VAATW,EP-T2510NWEGEU,SM-R400NZWAEUE,SM-R930NZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,SM-R400NZWAEUE,EP-T2510XBEGEU,SM-R510NZAAEUE,SM-R940NZKAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-A155FZKDEUE,SM-A155FZBDEUE,SM-A155FZYDEUE--SM-R390NZAAEUE,EF-OA156TBEGWW,EP-T2510NBEGEU,SM-R400NZAAEUE,SM-R930NZEAEUE,EI-T5600BWEGEU,SM-R390NZSAEUE,GP-FPA156VAATW,EP-T2510NWEGEU,SM-R400NZWAEUE,SM-R930NZKAEUE,SM-R400NZAAEUE,SM-R390NIDAEUE,SM-R400NZWAEUE,EP-T2510XBEGEU,SM-R510NZAAEUE,SM-R940NZKAEUE,SM-R935FZEAEUE');
				usi_combos.push('SM-R390NZAAEUE,SM-R390NZSAEUE,SM-R390NIDAEUE--ET-SFR39MGEGEU,SM-R400NZAAEUE,EI-T5600BWEGEU,ET-SFR39MOEGEU,SM-R400NZWAEUE,EI-T5600BBEGEU');
				// 3/11/2024 product launch
				usi_combos.push("SM-A556BLBAEUE,SM-A556BLVAEUE,SM-A556BZKAEUE,SM-A556BZYAEUE,SM-A556BLBCEUE,SM-A556BLVCEUE,SM-A556BZKCEUE,SM-A556BZYCEUE--EF-QA556CTEGWW,EP-T2510NBEGEU,EF-PA556TBEGWW,SM-R400NZAAEUE,EI-T5600BBEGEU,EF-UA556CTEGWW,EP-T2510NWEGEU,EF-PA556TLEGWW,SM-R400NZWAEUE,EI-T5600BWEGEU,EF-PA556TBEGWW,EP-T2510XWEGEU,EF-PA556TMEGWW");
				usi_combos.push("SM-A356BLB2EUE,SM-A356BLBBEUE,SM-A356BLVBEUE,SM-A356BZK2EUE,SM-A356BZKBEUE,SM-A356BZYBEUE,SM-A356BLBGEUE,SM-A356BLVGEUE,SM-A356BZKGEUE,SM-A356BZYGEUE--EF-QA356CTEGWW,EP-T2510NBEGEU,EF-PA356TLEGWW,SM-R400NZAAEUE,EI-T5600BBEGEU,EF-UA356CTEGWW,EP-T2510NWEGEU,EF-PA356TMEGWW,SM-R400NZWAEUE,EI-T5600BWEGEU,EF-PA356TBEGWW,EP-T2510XWEGEU,EF-ZA356CBEGWW");
				// July 2024 product launch
				if (!usi_app.is_cart_page) {
					usi_combos.push("SM-F741BLBGEUE,SM-F741BLBHEUE,SM-F741BLGGEUE,SM-F741BLGHEUE,SM-F741BZSGEUE,SM-F741BZSHEUE,SM-F741BZYGEUE,SM-F741BZYHEUE,SM-F741BAKGEUE,SM-F741BAKHEUE,SM-F741BZWGEUE,SM-F741BZWHEUE,SM-F741BZOGEUE,SM-F741BZOHEUE--SM-R530NZAAEUE,SM-L305FZGAEUE,SM-R630NZAAEUE,SM-L705FDAAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L300NZGAEUE,SM-R530NZWAEUE,SM-L705FDAAEUE,SM-R630NZWAEUE,SM-L705FZWAEUE,SM-R530NZAAEUE,SM-L705FDAAEUE,SM-R630NZAAEUE,SM-L300NZEAEUE,SM-R630NZWAEUE,SM-L315FZGAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZAAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L305FZGAEUE");
					usi_combos.push("SM-F956BDBNEUE,SM-F956BDBBEUE,SM-F956BDBCEUE,SM-F956BLINEUE,SM-F956BLIBEUE,SM-F956BLICEUE,SM-F956BZSNEUE,SM-F956BZSBEUE,SM-F956BZSCEUE,SM-F956BAKNEUE,SM-F956BAKBEUE,SM-F956BAKCEUE,SM-F956BZWNEUE,SM-F956BZWBEUE,SM-F956BZWCEUE--SM-R630NZAAEUE,SM-L705FDAAEUE,SM-R530NZAAEUE,SM-L305FZGAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L300NZGAEUE,SM-R630NZWAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L705FDAAEUE,SM-R530NZAAEUE,SM-L705FDAAEUE,SM-R630NZAAEUE,SM-L300NZEAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L315FZGAEUE,SM-R630NZAAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L305FZGAEUE");
					usi_combos.push("SM-L705FDAAEUE,SM-L705FZWAEUE,SM-L705FZTAEUE--SM-R630NZAAEUE,SM-F956BZSCEUE,SM-R630NZWAEUE,SM-F741BZSHEUE,SM-R530NZAAEUE,SM-F956BZWCEUE");
					usi_combos.push("SM-L315FZGAEUE,SM-L315FZSAEUE,SM-L305FZGAEUE,SM-L305FZEAEUE,SM-L310NZGAEUE,SM-L310NZSAEUE,SM-L300NZGAEUE,SM-L300NZEAEUE--SM-R530NZAAEUE,SM-F741BZWHEUE,SM-R530NZWAEUE,SM-F741BAKHEUE,SM-R630NZAAEUE,SM-F956BDBBEUE");
					usi_combos.push("SM-R630NZAAEUE,SM-R630NZWAEUE--SM-F741BLBGEUE,SM-L705FZWAEUE,SM-F741BLGGEUE,SM-L300NZEAEUE,SM-F956BAKNEUE,SM-L315FZGAEUE");
					usi_combos.push("SM-R530NZAAEUE,SM-R530NZWAEUE--SM-F741BZYGEUE,SM-L300NZGAEUE,SM-F741BZOGEUE,SM-L310NZSAEUE,SM-F956BZWCEUE,SM-L705FZTAEUE");
					//usi_combos.push("SM-F741BLBGEUE,SM-F741BLBHEUE,SM-F741BLGGEUE,SM-F741BLGHEUE,SM-F741BZSGEUE,SM-F741BZSHEUE,SM-F741BZYGEUE,SM-F741BZYHEUE,SM-F741BAKGEUE,SM-F741BAKHEUE,SM-F741BZWGEUE,SM-F741BZWHEUE,SM-F741BZOGEUE,SM-F741BZOHEUE--SM-R530NZAAEUE,SM-L305FZGAEUE,SM-R630NZAAEUE,SM-L705FDAAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L300NZGAEUE,SM-R530NZWAEUE,SM-L705FDAAEUE,SM-R630NZWAEUE,SM-L705FZWAEUE,SM-R530NZAAEUE,SM-L705FDAAEUE,SM-R630NZAAEUE,SM-L300NZEAEUE,SM-R630NZWAEUE,SM-L315FZGAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZAAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L305FZGAEUE");
					//usi_combos.push("SM-F956BDBNEUE,SM-F956BDBBEUE,SM-F956BDBCEUE,SM-F956BLINEUE,SM-F956BLIBEUE,SM-F956BLICEUE,SM-F956BZSNEUE,SM-F956BZSBEUE,SM-F956BZSCEUE,SM-F956BAKNEUE,SM-F956BAKBEUE,SM-F956BAKCEUE,SM-F956BZWNEUE,SM-F956BZWBEUE,SM-F956BZWCEUE--SM-R630NZAAEUE,SM-L705FDAAEUE,SM-R530NZAAEUE,SM-L305FZGAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L300NZGAEUE,SM-R630NZWAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L705FDAAEUE,SM-R530NZAAEUE,SM-L705FDAAEUE,SM-R630NZAAEUE,SM-L300NZEAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L315FZGAEUE,SM-R630NZAAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L305FZGAEUE");
					//usi_combos.push("SM-L705FDAAEUE,SM-L705FZWAEUE,SM-L705FZTAEUE--SM-R630NZAAEUE,SM-F956BZSCEUE,SM-R630NZWAEUE,SM-F741BZSHEUE,SM-R530NZAAEUE,SM-F956BZWCEUE");
					//usi_combos.push("SM-L315FZGAEUE,SM-L315FZSAEUE,SM-L305FZGAEUE,SM-L305FZEAEUE,SM-L310NZGAEUE,SM-L310NZSAEUE,SM-L300NZGAEUE,SM-L300NZEAEUE--SM-R530NZAAEUE,SM-F741BZWHEUE,SM-R530NZWAEUE,SM-F741BAKHEUE,SM-R630NZAAEUE,SM-F956BDBBEUE");
					//usi_combos.push("SM-R630NZAAEUE,SM-R630NZWAEUE--SM-F741BLBGEUE,SM-L705FZWAEUE,SM-F741BLGGEUE,SM-L300NZEAEUE,SM-F956BAKNEUE,SM-L315FZGAEUE");
					//usi_combos.push("SM-R530NZAAEUE,SM-R530NZWAEUE--SM-F741BZYGEUE,SM-L300NZGAEUE,SM-F741BZOGEUE,SM-L310NZSAEUE,SM-F956BZWCEUE,SM-L705FZTAEUE");
				} else {
					usi_combos.push("SM-F741BLBGEUE,SM-F741BLBHEUE,SM-F741BLGGEUE,SM-F741BLGHEUE,SM-F741BZSGEUE,SM-F741BZSHEUE,SM-F741BZYGEUE,SM-F741BZYHEUE,SM-F741BAKGEUE,SM-F741BAKHEUE,SM-F741BZWGEUE,SM-F741BZWHEUE,SM-F741BZOGEUE,SM-F741BZOHEUE--SM-R530NZAAEUE,SM-L305FZGAEUE,SM-R630NZAAEUE,SM-L705FDAAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L300NZGAEUE,SM-R530NZWAEUE,SM-L705FDAAEUE,SM-R630NZWAEUE,SM-L705FZWAEUE,SM-R530NZAAEUE,SM-L705FDAAEUE,SM-R630NZAAEUE,SM-L300NZEAEUE,SM-R630NZWAEUE,SM-L315FZGAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZAAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L305FZGAEUE");
					usi_combos.push("SM-F956BDBNEUE,SM-F956BDBBEUE,SM-F956BDBCEUE,SM-F956BLINEUE,SM-F956BLIBEUE,SM-F956BLICEUE,SM-F956BZSNEUE,SM-F956BZSBEUE,SM-F956BZSCEUE,SM-F956BAKNEUE,SM-F956BAKBEUE,SM-F956BAKCEUE,SM-F956BZWNEUE,SM-F956BZWBEUE,SM-F956BZWCEUE--SM-R630NZAAEUE,SM-L705FDAAEUE,SM-R530NZAAEUE,SM-L305FZGAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L300NZGAEUE,SM-R630NZWAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L705FDAAEUE,SM-R530NZAAEUE,SM-L705FDAAEUE,SM-R630NZAAEUE,SM-L300NZEAEUE,SM-R530NZWAEUE,SM-L705FZTAEUE,SM-R630NZWAEUE,SM-L315FZGAEUE,SM-R630NZAAEUE,SM-L705FZWAEUE,SM-R530NZWAEUE,SM-L305FZGAEUE");
					usi_combos.push("SM-L705FDAAEUE,SM-L705FZWAEUE,SM-L705FZTAEUE--SM-R630NZAAEUE,SM-F956BZSCEUE,SM-R630NZWAEUE,SM-F741BZSHEUE,SM-R530NZAAEUE,SM-F956BZWCEUE");
					usi_combos.push("SM-L315FZGAEUE,SM-L315FZSAEUE,SM-L305FZGAEUE,SM-L305FZEAEUE,SM-L310NZGAEUE,SM-L310NZSAEUE,SM-L300NZGAEUE,SM-L300NZEAEUE--SM-R530NZAAEUE,SM-F741BZWHEUE,SM-R530NZWAEUE,SM-F741BAKHEUE,SM-R630NZAAEUE,SM-F956BDBBEUE");
					usi_combos.push("SM-R630NZAAEUE,SM-R630NZWAEUE--SM-F741BLBGEUE,SM-L705FZWAEUE,SM-F741BLGGEUE,SM-L300NZEAEUE,SM-F956BAKNEUE,SM-L315FZGAEUE");
					usi_combos.push("SM-R530NZAAEUE,SM-R530NZWAEUE--SM-F741BZYGEUE,SM-L300NZGAEUE,SM-F741BZOGEUE,SM-L310NZSAEUE,SM-F956BZWCEUE,SM-L705FZTAEUE");
				}
						thisloop: for (var i = 0; i < usi_combos.length; i++) {
					if (usi_combos[i].split("--")[0].indexOf(pid) != -1) {
						return usi_combos[i].split("--")[1];
					}
				}
			}
			if (which == 2 || which == -1) {
				usi_combos = ['SM-X916BZAAEUE,SM-X916BZAEEUE,SM-X916BZAIEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-BX910PWEGWW,EF-DX910UBEGWW,EJ-P5600SWEGEU,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-BX910PBEGWW,EF-RX710CBEGWW,EI-T5600BBEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,SM-R510NLVAEUE,EF-BX910PWEGWW,EI-T5600BWEGEU',
				'SM-X910NZAAEUE,SM-X910NZAEEUE,SM-X910NZAIEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-BX910PWEGWW,EF-DX910UBEGWW,EJ-P5600SWEGEU,EI-T5600BWEGEU,SM-R510NZWAEUE,EF-BX910PBEGWW,EF-RX710CBEGWW,EI-T5600BBEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,SM-R510NLVAEUE,EF-BX910PWEGWW,EI-T5600BWEGEU',
				'SM-X816BZAAEUE,SM-X816BZAEEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-BX810PWEGWW,EF-BX810PBEGWW,EF-ZX812PWEGWW,EF-DX810UBEGWW,SM-R510NZWAEUE,EF-BX810PBEGWW,EF-DX810UBEGWW,EJ-P5600SWEGEU,EI-T5600BWEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,EF-BX810PWEGWW,EI-T5600BWEGEU,EI-T5600BBEGEU',
				'SM-X810NZAAEUE,SM-X810NZAEEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-BX810PWEGWW,EF-BX810PBEGWW,EF-ZX812PWEGWW,EF-DX810UBEGWW,SM-R510NZWAEUE,EF-BX810PBEGWW,EF-DX810UBEGWW,EJ-P5600SWEGEU,EI-T5600BWEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,EF-BX810PWEGWW,EI-T5600BWEGEU,EI-T5600BBEGEU',
				'SM-X716BZAAEUE,SM-X716BZEAEUE,SM-X716BZAEEUE,SM-X716BZEEEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-BX710PWEGWW,EF-ZX712PWEGWW,EF-DX710UBEGWW,EJ-P5600SWEGEU,SM-R510NZWAEUE,EF-BX710PBEGWW,EI-T5600BWEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,EI-T5600BBEGEU',
				'SM-X710NZAAEUE,SM-X710NZEAEUE,SM-X710NZAEEUE,SM-X710NZEEEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-BX710PWEGWW,EF-ZX712PWEGWW,EF-DX710UBEGWW,EJ-P5600SWEGEU,SM-R510NZWAEUE,EF-BX710PBEGWW,EI-T5600BWEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,EI-T5600BBEGEU',
				'SM-X510NZAAEUE,SM-X510NLGAEUE,SM-X510NLIAEUE,SM-X510NZAEEUE,SM-X516BZAAEUE,SM-X516BLGAEUE,SM-X516BLIAEUE,SM-X516BZAEEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-RX610CBEGWW,EF-BX810PWEGWW,EF-DX810UBEGWW,EJ-P5600SWEGEU,SM-R510NZWAEUE,EF-BX810PBEGWW,SM-R400NZAAEUE,EI-T5600BWEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,EI-T5600BBEGEU,SM-R400NZWAEUE',
				'SM-X610NZAAEUE,SM-X610NLGAEUE,SM-X610NZAEEUE,SM-X616BZAAEUE,SM-X616BLGAEUE,SM-X616BZAEEUE--SM-R510NZAAEUE,EP-T4510XBEGEU,EF-RX610CBEGWW,EF-BX810PWEGWW,EF-DX810UBEGWW,EJ-P5600SWEGEU,SM-R510NZWAEUE,EF-BX810PBEGWW,SM-R400NZAAEUE,EI-T5600BWEGEU,EI-T5600KWEGEU,SM-R510NLVAEUE,EI-T5600BBEGEU,SM-R400NZWAEUE',
				'SM-P613NZAAXEO,SM-P613NZBAXEO--SM-R400NZWAEUE,EF-BP610PLEGEU,EI-T5600BWEGEU,SM-R510NZAAEUE,SM-R400NZAAEUE,SM-R510NLVAEUE,SM-R510NZWAEUE,SM-R510NZAAEUE',
				'SM-X210NZAAEUE,SM-X210NZAEEUE,SM-X216BZAAEUE,SM-X216BZAEEUE--SM-R400NZWAEUE,EI-T5600BWEGEU,SM-R930NZEAEUE,SM-R510NZAAEUE,SM-R400NZAAEUE,EI-T5600BBEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R510NZAAEUE,EI-T5600KWEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE',
				'SM-X110NZAAEUE,SM-X110NZAEEUE,SM-X115NZAAEUE,SM-X115NZAEEUE--SM-R400NZWAEUE,EI-T5600BWEGEU,SM-R930NZEAEUE,SM-R510NZAAEUE,SM-R400NZAAEUE,EI-T5600BBEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R510NZAAEUE,EI-T5600KWEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE',
				'SM-X200NZAEEUE,SM-X200NZSEEUE,SM-X200NZAFEUE--SM-R400NZWAEUE,EI-T5600BWEGEU,SM-R930NZEAEUE,SM-R510NZAAEUE,SM-R400NZAAEUE,EI-T5600BBEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R510NZAAEUE,EI-T5600KWEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE',
				'SM-T220NZAAEUE,SM-T220NZSAEUE--SM-R400NZWAEUE,EI-T5600BWEGEU,SM-R930NZEAEUE,SM-R510NZAAEUE,SM-R400NZAAEUE,EI-T5600BBEGEU,SM-R940NZKAEUE,SM-R510NZWAEUE,SM-R510NZAAEUE,EI-T5600KWEGEU,SM-R940NZSAEUE,SM-R510NLVAEUE'];
				thisloop: for (var i = 0; i < usi_combos.length; i++) {
					if (usi_combos[i].split("--")[0].indexOf(pid) != -1) {
						return usi_combos[i].split("--")[1];
					}
				}
			}
			if (which == 3 || which == -1) {
				usi_combos = ['SM-R960NZKAEUE,SM-R960NZSAEUE,SM-R950NZKAEUE,SM-R950NZSAEUE,SM-R955FZKAEUE,SM-R955FZSAEUE,SM-R965FZKAEUE,SM-R965FZSAEUE--SM-R510NZAAEUE,EP-OR900BBEGWW,ET-SVR94LBEGEU,ET-SHR96LSEGEU,EP-P5400BBEGEU,ET-SHR96LNEGEU,SM-R510NZWAEUE,ET-SVR94LUEGEU,ET-SHR96LBEGEU,EP-P5400BWEGEU,SM-R510NLVAEUE,ET-SVR94LLEGEU,ET-SHR96LNEGEU',
					'SM-R890NZKAEUE,SM-R890NZSAEUE,SM-R880NZKAEUE,SM-R880NZSAEUE,SM-R895FZKAEUE,SM-R895FZSAEUE,SM-R885FZKAEUE,SM-R885FZSAEUE--SM-R400NZAAEUE,EP-OR900BBEGWW,ET-SVR94LBEGEU,ET-SHR96LSEGEU,EP-P5400BBEGEU,ET-SHR96LNEGEU,SM-R400NZWAEUE,ET-SVR94LUEGEU,ET-SHR96LBEGEU,EP-P5400BWEGEU,ET-SVR94LLEGEU,ET-SHR96LNEGEU',
					'SM-R930NZEAEUE,SM-R930NZKAEUE,SM-R940NZKAEUE,SM-R940NZSAEUE,SM-R935FZEAEUE,SM-R935FZKAEUE,SM-R945FZKAEUE,SM-R945FZSAEUE--SM-R510NZAAEUE,EP-OR900BBEGWW,ET-SVR94LBEGEU,ET-SHR96LSEGEU,EP-P5400BBEGEU,ET-SHR96LNEGEU,SM-R510NZWAEUE,ET-SVR94LUEGEU,ET-SHR96LBEGEU,EP-P5400BWEGEU,SM-R510NLVAEUE,ET-SVR94LLEGEU,ET-SHR96LNEGEU',
					'SM-R900NZAAEUE,SM-R900NZDAEUE,SM-R900NZSAEUE,SM-R905FZAAEUE,SM-R905FZDAEUE,SM-R905FZSAEUE,SM-R910NZAAEUE,SM-R910NZBAEUE,SM-R910NZSAEUE,SM-R915FZAAEUE,SM-R915FZBAEUE,SM-R915FZSAEUE--SM-R400NZAAEUE,EP-OR900BBEGWW,ET-SFR93SNEGEU,ET-SVR94LBEGEU,ET-SFR93SUEGEU,EP-P5400BBEGEU,SM-R400NZWAEUE,ET-SFR93SBEGEU,ET-SVR94LUEGEU,ET-SFR93SLEGEU,EP-P5400BWEGEU,ET-SFR93SSEGEU,ET-SVR94LLEGEU,ET-SFR93SMEGEU',
					'SM-R870NZKAEUE,SM-R870NZSAEUE,SM-R870NZGAEUE,SM-R860NZKAEUE,SM-R860NZSAEUE,SM-R860NZDAEUE,SM-R875FZKAEUE,SM-R875FZSAEUE,SM-R875FZGAEUE,SM-R865FZKAEUE,SM-R865FZSAEUE,SM-R865FZDAEUE--SM-R400NZAAEUE,EP-OR900BBEGWW,ET-SFR93SNEGEU,EP-P5400BBEGEU,ET-SFR93SUEGEU,SM-R400NZWAEUE,ET-SFR93SBEGEU,EP-P5400BWEGEU,ET-SFR93SLEGEU,ET-SFR93SSEGEU,ET-SFR93SMEGEU',
					'SM-R510NZAAEUE,SM-R510NZWAEUE,SM-R510NLVAEUE--EP-T2510NBEGEU,GP-FPR510SBHRW,EP-P5400BBEGEU,GP-FPR510SBJBW,EP-T2510NWEGEU,GP-FPR510SBHOW,EP-P5400BWEGEU,GP-FPR510SBKVW,GP-FPR510SBHYW',
					'SM-R180NZKAEUE,SM-R180NZWAEUE,SM-R180NZNAEUE,SM-R180NZTAEUE--EP-T2510NBEGEU,GP-FPR510SBHRW,EP-P5400BBEGEU,GP-FPR510SBJBW,EP-T2510NWEGEU,GP-FPR510SBHOW,EP-P5400BWEGEU,GP-FPR510SBKVW,GP-FPR510SBHYW',
					'SM-R177NZWAEUE,SM-R177NZKAEUE,SM-R177NZGAEUE,SM-R177NLVAEUE,SM-R177NZTAEUE--EP-T2510NBEGEU,GP-FPR510SBHRW,GP-FPR510SBJBW,EP-T2510NWEGEU,GP-FPR510SBHOW,GP-FPR510SBKVW,GP-FPR510SBHYW',
					'SM-R400NZAAEUE,SM-R400NZWAEUE--EP-T2510NBEGEU,GP-FPR510SBHRW,GP-FPR510SBJBW,EP-T2510NWEGEU,GP-FPR510SBHOW,GP-FPR510SBKVW,GP-FPR510SBHYW'];
				thisloop: for (var i = 0; i < usi_combos.length; i++) {
					if (usi_combos[i].split("--")[0].indexOf(pid) != -1) {
						return usi_combos[i].split("--")[1];
					}
				}
			}
			return "";
		};

		usi_app.load_product_campaigns = function () {
			try {

				try {
					if (document.getElementsByClassName("pdd16-step-buying").length > 0 && document.getElementsByClassName("pdd16-step-buying")[0].style.display == "") {
						//Don't include this if the add-on is up
						return;
					}
				} catch (err) {
					usi_commons.report_error(err);
				}

				var control_site_id = '50567';
				var group = usi_app.force_group || (Math.random() < 0.10 ? 0 : 1);
				usi_split_test.instantiate(control_site_id, group);
				if (usi_split_test.get_group(control_site_id) == '1') {
					// Load site
					usi_commons.log("Split Group: USI");
					var priceBefore = Number(usi_app.product_page_data.msrp);
					var priceAfter = Number(usi_app.product_page_data.price);
					var priceDropPercentage = Math.round((1 - priceAfter / priceBefore) * 100);

					if (usi_app.site == "main" && priceDropPercentage >= .05) {
						// Price drop

						var version = "";
						if (usi_app.url.match("samsung.com/pl/tvs/") != null || usi_app.url.match("samsung.com/pl/audio-accessories") != null || usi_app.url.match("samsung.com/pl/projectors") != null || usi_app.url.match("samsung.com/pl/audio-devices/") != null || usi_app.url.match("samsung.com/pl/tv-accessories/") != null) {
							version = "_ce";
						} else if (usi_app.url.match("samsung.com/pl/smartphones/") != null || usi_app.url.match("samsung.com/pl/tablets/") != null || usi_app.url.match("samsung.com/pl/audio-sound/") != null || usi_app.url.match("samsung.com/pl/mobile-accessories/") != null) {
							version = "_mx";
						} else if (usi_app.url.match("samsung.com/pl/refrigerators/") != null || usi_app.url.match("samsung.com/pl/washers-and-dryers/") != null || usi_app.url.match("samsung.com/pl/vacuum-cleaners/") != null || usi_app.url.match("samsung.com/pl/cooking-appliances/") != null || usi_app.url.match("samsung.com/pl/dishwashers/") != null || usi_app.url.match("samsung.com/pl/air-care/") != null || usi_app.url.match("samsung.com/pl/microwave-ovens/") != null || usi_app.url.match("samsung.com/pl/business/climate/") != null) {
							version = "_da";
						}
						usi_commons.load_view("A5vt80s3vYIvy7ybkU2O1zs", "44463", usi_commons.device + version);

					}
				} else {
					usi_commons.log("Split Group: Control");
				}

				usi_commons.log("Split Group: USI");
				if ((document.getElementsByClassName("tg-wtb").length == 1 || document.querySelector('[an-ac="where to buy"]') != null) && usi_app.url.match("s23") == null) {
					if (usi_commons.device == "desktop") {
						if (document.getElementsByClassName("tg-wtb").length == 1) {
							document.getElementsByClassName("tg-wtb")[0].addEventListener("mouseover", function () {
								usi_app.mouse_over = 1;
								setTimeout(usi_app.load_wtb, 1000);
							});
							document.getElementsByClassName("tg-wtb")[0].addEventListener("mouseout", function () {
								usi_app.mouse_over = 0;
							});
						} else {
							document.querySelector('[an-ac="where to buy"]').addEventListener("mouseover", function () {
								usi_app.mouse_over = 1;
								setTimeout(usi_app.load_wtb, 1000);
							});
							document.querySelector('[an-ac="where to buy"]').addEventListener("mouseout", function () {
								usi_app.mouse_over = 0;
							});
						}
					} else {
						var usi_over_write_img = document.createElement("div");
						usi_over_write_img.style.position="relative";
						usi_over_write_img.style.zIndex="2400";
						usi_over_write_img.innerHTML = "<button style='position: absolute; width: 100%; top: -30px; height: 40px; left: 0px;' onclick='usi_app.load_wtb()' id='usi_overwrite_button'/>";
						if (document.getElementsByClassName("tg-wtb").length == 1) {
							document.getElementsByClassName("tg-wtb")[0].parentNode.appendChild(usi_over_write_img);
						} else {
							document.querySelector('[an-ac="where to buy"]').parentNode.appendChild(usi_over_write_img);
						}
					}
				}

				var usi_nomatch = "\"original_price\":\"0.0\",OUTOFSTOCK,PREORDER,";
				var usi_pid = usi_app.product.pid;
				var usi_rows = 20;
				var usi_force_exact = 0;
				var usi_less_expensive = usi_app.product.price * 2;
				var usi_recs_match = usi_app.get_rec(usi_app.product.pid, -1);
				if (usi_recs_match == "") {
					return;
				}

				if (usi_date.is_between("2024-04-25T00:00:00-00:00", "2024-05-05T23:59:59-00:00")) {
					if ("SM-A356BLBBEUE,SM-A356BLVBEUE,SM-A356BZKBEUE,SM-A356BZYBEUE,SM-A356BLBGEUE,SM-A356BLVGEUE,SM-A356BZKGEUE,SM-A356BZYGEUE,SM-A556BLBAEUE,SM-A556BLVAEUE,SM-A556BZKAEUE,SM-A556BZYAEUE,SM-A556BLBCEUE,SM-A556BLVCEUE,SM-A556BZKCEUE,SM-A556BZYCEUE".indexOf(usi_app.product.pid) != -1) {
						usi_recs_match = "SM-R177NZTAEUE," + usi_recs_match;
						usi_app.modified_price["SM-R177NZWAEUE"] = "1";
						usi_app.modified_price["SM-R177NZKAEUE"] = "1";
						usi_app.modified_price["SM-R177NZGAEUE"] = "1";
						usi_app.modified_price["SM-R177NLVAEUE"] = "1";
						usi_app.modified_price["SM-R177NZTAEUE"] = "1";
					}
				}
				if (usi_app.is_enabled && usi_date.is_between("2024-09-01T00:00:00-00:00", "2024-09-01T23:59:59-00:00")) {
					if ("SM-F741BLBGEUE,SM-F741BLBHEUE,SM-F741BLGGEUE,SM-F741BLGHEUE,SM-F741BZSGEUE,SM-F741BZSHEUE,SM-F741BZYGEUE,SM-F741BZYHEUE,SM-F741BAKGEUE,SM-F741BAKHEUE,SM-F741BZWGEUE,SM-F741BZWHEUE,SM-F741BZOGEUE,SM-F741BZOHEUE,SM-F956BDBNEUE,SM-F956BDBBEUE,SM-F956BDBCEUE,SM-F956BLINEUE,SM-F956BLIBEUE,SM-F956BLICEUE,SM-F956BZSNEUE,SM-F956BZSBEUE,SM-F956BZSCEUE,SM-F956BAKNEUE,SM-F956BAKBEUE,SM-F956BAKCEUE,SM-F956BZWNEUE,SM-F956BZWBEUE,SM-F956BZWCEUE,SM-L705FDAAEUE,SM-L705FZWAEUE,SM-L705FZTAEUE,SM-L315FZGAEUE,SM-L315FZSAEUE,SM-L305FZGAEUE,SM-L305FZEAEUE,SM-L310NZGAEUE,SM-L310NZSAEUE,SM-L300NZGAEUE,SM-L300NZEAEUE,SM-R630NZAAEUE,SM-R630NZWAEUE,SM-R530NZAAEUE,SM-R530NZWAEUE".indexOf(usi_app.product.pid) != -1) {
						if (typeof usi_app.trade_up == "undefined") usi_app.bundle = {};
						usi_app.bundle.header = "Do 600 z\u0142 rabatu kupuj\u0105c w zestawie";
					}
				}

				usi_pid = usi_app.product.pid + "," + usi_recs_match;
				usi_force_exact = 0;
				usi_app.pids = usi_pid;
				usi_app.load_product_data({
					siteID: usi_app.product_page_recs,
					association_siteID: usi_app.cart_page_recs,
					pid: usi_pid,
					rows: usi_rows,
					less_expensive: usi_less_expensive,
					force_exact: usi_force_exact,
					nomatch: usi_nomatch,
					callback: function () {
						usi_app.remove_oos();
						usi_app.product_rec_bundle = usi_app.product_rec;
						usi_app.populate_prices(usi_app.product_rec_bundle, "pl", function() {
							if (typeof(usi_app.product_rec_bundle["product2"]) !== "undefined") {
								usi_commons.load("zNfAKdfxTi9kuYF5UfNWQQ5", "41334", "v3");
							}
						});
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.calculate_bundle_discount = function(){
			try {
				if ("SM-F741BLBGEUE,SM-F741BLBHEUE,SM-F741BLGGEUE,SM-F741BLGHEUE,SM-F741BZSGEUE,SM-F741BZSHEUE,SM-F741BZYGEUE,SM-F741BZYHEUE,SM-F741BAKGEUE,SM-F741BAKHEUE,SM-F741BZWGEUE,SM-F741BZWHEUE,SM-F741BZOGEUE,SM-F741BZOHEUE,SM-F956BDBNEUE,SM-F956BDBBEUE,SM-F956BDBCEUE,SM-F956BLINEUE,SM-F956BLIBEUE,SM-F956BLICEUE,SM-F956BZSNEUE,SM-F956BZSBEUE,SM-F956BZSCEUE,SM-F956BAKNEUE,SM-F956BAKBEUE,SM-F956BAKCEUE,SM-F956BZWNEUE,SM-F956BZWBEUE,SM-F956BZWCEUE,SM-L705FDAAEUE,SM-L705FZWAEUE,SM-L705FZTAEUE,SM-L315FZGAEUE,SM-L315FZSAEUE,SM-L305FZGAEUE,SM-L305FZEAEUE,SM-L310NZGAEUE,SM-L310NZSAEUE,SM-L300NZGAEUE,SM-L300NZEAEUE,SM-R630NZAAEUE,SM-R630NZWAEUE,SM-R530NZAAEUE,SM-R530NZWAEUE".indexOf(usi_app.product.pid) != -1) {
					if (document.getElementsByClassName("usi_mini_product").length == 2) {
						return 400;
					} else if (document.getElementsByClassName("usi_mini_product").length >= 3) {
						return 600;
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.populate_prices = function(usi_prod_array, locale, callback) {
			var i=0;
			var usi_pid_list = "";
			while (typeof(usi_prod_array["product"+i]) != "undefined") {
				usi_pid_list += usi_prod_array["product" + i].pid + ",";
				i++;
			}
			var usi_url = "https://searchapi.samsung.com/v6/front/b2c/product/card/detail/newhybris?siteCode="+locale+"&modelList="+usi_pid_list+"&saleSkuYN=N&onlyRequestSkuYN=Y&vd3PACardYN=Y&commonCodeYN=N";
			$.ajax({
				url: usi_url,
				type: "GET",
				dataType: "json",
				success: function (data) {
					var api_data = data.response.resultData.productList;
					var i=0;
					while (typeof(usi_prod_array["product"+i]) != "undefined") {
						var usi_prices = usi_app.grab_price_from_api(usi_prod_array["product"+i].pid, api_data);
						var usi_url = usi_app.grab_url_from_api(usi_prod_array["product"+i].pid, api_data);
						if (usi_url != null) {
							usi_prod_array["product" + i].url = usi_url;
						}
						if (usi_prices != null && usi_prices.indexOf("null") == -1) {
							usi_prod_array["product" + i].price = usi_prices.split("_")[0];
							if (typeof(usi_prod_array["product" + i].extra) === "string") {
								var usi_extra = JSON.parse(usi_samsung.decode_html(usi_prod_array["product" + i].extra));
								usi_extra.original_price = usi_prices.split("_")[2];
								usi_prod_array["product" + i].extra = JSON.stringify(usi_extra);
							} else {
								usi_prod_array["product" + i].extra.original_price = usi_prices.split("_")[2];
							}
						}
						i++;
					}
					callback();
				},
				error: function (err) {
					usi_commons.report_error(err);
				}
			});
		};

		usi_app.grab_url_from_api = function(pid, api_data) {
			for (var i=0; i<api_data.length;i++) {
				if (api_data[i].modelList[0].modelCode == pid && api_data[i].modelList[0].configuratorUrl != null) {
					return "https://www.samsung.com" + api_data[i].modelList[0].configuratorUrl;
				}
			}
			return null;
		};

		usi_app.grab_price_from_api = function(pid, api_data) {
			for (var i=0; i<api_data.length;i++) {
				if (api_data[i].modelList[0].modelCode == pid) {
					return api_data[i].modelList[0].promotionPrice + "_" + api_data[i].modelList[0].price + "_" + api_data[i].modelList[0].lowestWasPrice;
				}
			}
			return null;
		};

		usi_app.find_match = function(pids) {
			try {
				var found = 1;
				var i=1;
				while (typeof(usi_app.product_rec["product"+i]) != "undefined") {
					if (pids.indexOf(usi_app.product_rec["product"+i].pid) != -1) {
						return usi_app.product_rec["product" + i];
					}
					i++;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return null;
		};

		usi_app.remove_duplicates = function(cart_contents) {
			try {
				usi_app.product_rec2 = {};
				usi_app.product_rec2["product" + 0] = usi_app.product_rec["product" + 0];
				var found = 1;
				var usi_buds = false;
				var usi_watch = false;
				var usi_starter_pack = false;
				var usi_watch_band = false;
				for (var i=0; i<cart_contents.length;i++) {
					if (cart_contents[i].name.indexOf("Bud") != -1 && cart_contents[i].name.indexOf("Cover") == -1) {
						usi_buds = true;
					}
					if (cart_contents[i].name.indexOf("Watch") != -1 && cart_contents[i].name.indexOf("Band") != -1) {
						usi_watch_band = true;
					} else if (cart_contents[i].name.indexOf("Watch") != -1) {
						usi_watch = true;
					}
					if (cart_contents[i].name.indexOf("Starter Pack") != -1) {
						usi_starter_pack = true;
					}
				}
				var i=1;
				var usi_pid_list = "";
				while (typeof(usi_app.product_rec["product"+i]) != "undefined") {
					if (usi_app.product_rec["product"+i].productname.indexOf("Bud") != -1 && usi_app.product_rec["product"+i].productname.indexOf("Cover") == -1 && usi_buds) {
						//ignore
					} else if (usi_app.product_rec["product"+i].productname.indexOf("Watch") != -1 && usi_app.product_rec["product"+i].productname.indexOf("Band") == -1 && usi_watch) {
						//ignore
					} else if (usi_app.product_rec["product"+i].productname.indexOf("Watch") != -1 && usi_app.product_rec["product"+i].productname.indexOf("Band") != -1 && usi_watch_band) {
						//ignore
					} else if (usi_app.product_rec["product"+i].productname.indexOf("Starter Pack") != -1 && usi_starter_pack) {
						//ignore
					} else {
						usi_pid_list += "~"+usi_app.product_rec["product"+i].pid+"~";
						usi_app.product_rec2["product" + found] = usi_app.product_rec["product"+i];
						found++;
					}
					i++;
				}
				usi_app.product_rec = usi_app.product_rec2;
			} catch (err) {
				usi_commons.report_error(err);
			}
		}

		usi_app.remove_oos = function() {
			try {
				usi_app.product_rec2 = {};
				usi_app.product_rec2["product" + 0] = usi_app.product_rec["product" + 0];
				var found = 1;
				var i=1;
				var usi_pid_list = "";
				while (typeof(usi_app.product_rec["product"+i]) != "undefined") {
					if (usi_app.product_rec["product"+i].extra.indexOf("OUTOFSTOCK") == -1 && usi_pid_list.indexOf("~"+usi_app.product_rec["product"+i].pid+"~") == -1) {
						usi_pid_list += "~"+usi_app.product_rec["product"+i].pid+"~";
						usi_app.product_rec2["product" + found] = usi_app.product_rec["product"+i];
						found++;
					}
					i++;
				}
				usi_app.product_rec = usi_app.product_rec2;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_oos = function () {
			try {
				//var control_site_id = '37811';
				//var group = usi_app.force_group || (Math.random() < 0.02 ? 0 : 1);
				//usi_split_test.instantiate(control_site_id, group);
				//if (usi_split_test.get_group(control_site_id) == '0') {
				//	return usi_commons.log("Split Group: Control");
				//}

				var usi_pid = usi_app.product.pid;
				if (usi_app.grab_oos_matches(usi_app.product.pid) != "") {
					usi_pid = usi_app.product.pid + "," + usi_app.grab_oos_matches(usi_app.product.pid);
				}

				var usi_force_exact = 1;
				var usi_match = usi_samsung.scrape_category(usi_app.depth_level) + ",";

				// if s21 pids match on provided pids
				if (usi_app.low_stock_pids.indexOf(usi_app.product.pid) != -1) {
					usi_match += "/smartphones/galaxy-z-fold3-5g/,/smartphones/galaxy-z-flip3-5g/,SM-G781BZBDEUE,SM-G781BZBDEUE,";
				}

				//check for lifestyle tv
				if (location.href.match("/lifestyle-tvs/") != null) {
					usi_match += "/lifestyle-tvs/,";
				}
				if (usi_app.url.match("/pl/lifestyle-tvs/the-frame/ls03b-65-inch-the-frame-qled-4k-smart-tv-black-qe65ls03bauxxh/") != null) {
					usi_pid += ",QE65LS03BGUXXH";
				}
				//usi_match += usi_samsung.grab_category_restrictions(usi_app.product.category2.substring(0, 3));

				usi_app.load_product_data({
					siteID: usi_app.product_page_recs,
					pid: usi_pid,
					rows: 50,
					//allow_dupe_names: 1,
					days_back: 7,
					match: usi_match,//is_pid ? "home appliances" :
					nomatch: "\"original_price\":\"0.0\",OUTOFSTOCK,PREORDER,SM-A725FZKDEUE,SM-A525FZWGEUE,",
					force_exact: usi_force_exact,
					callback: function () {
						usi_app.remove_oos();
						if (typeof (usi_app.product_rec.product4) != "undefined") {
							window['usi_force'] = 1;
							var usi_append_key = "";
							if (usi_commons.is_mobile) usi_append_key = "_mobile";
							usi_app.remove_loads();
							var rec_array = [];
							rec_array = rec_array.sort(function(a, b){return a.price - b.price;});
							for(var i = 0; i<rec_array.length; i++){
								usi_app.product_rec["product"+i] = rec_array[i]
							}

							for (var i=1;i<=4;i++) {
								if (usi_app.product_rec["product"+i].pid == "") {
									usi_app.product_rec["product"+i].image = "https://images.samsung.com/is/image/samsung/p6pim/pl/sm-g781bzbdeue/gallery/pl-galaxy-s20-fe-5g-g781-sm-g781bzbdeue-thumb-348722008?$160_160_PNG$";
								}
							}
							usi_app.populate_prices(usi_app.product_rec, "pl", function() {
								if (typeof(usi_app.product_rec["product4"]) !== "undefined") {
									usi_commons.load("yprzJftxsPjF1wVEqvzKG8k", "37809", usi_app.site + usi_append_key);
								}
							});


						} else if (usi_app.depth_level > 1) {
							var usi_previous_level = usi_samsung.scrape_category(usi_app.depth_level).split("~").length;
							if (usi_previous_level[usi_previous_level - 1] == "accessories") {
								//Don't go deeper than accessories
								usi_commons.log("Found accessories, that's sort of bedrock");
							} else {
								usi_app.depth_level--;
								usi_app.load_oos();
							}
						}
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart = function () {
			usi_commons.log("usi_app.scrape_cart()");
			try {
				var cart_rows = document.getElementsByClassName('cart-row');
				var prod_array = [], product;
				for (var i = 0; i < cart_rows.length; i++) {
					var row = cart_rows[i];
					product = {};
					if (row.querySelector(".cart-item-thumb a") != null) product.link = row.querySelector(".cart-item-thumb a").href;
					product.image = row.querySelector(".cart-item-thumb img").src;
					product.name = row.querySelector(".name").textContent.trim();
					product.price = row.querySelector(".item-price").textContent.trim().split("\n")[0];
					product.pid = row.querySelector("[data-omni-variant]").getAttribute("data-omni-variant");
					product.quantity = row.querySelector(".update-entry-quantity-input").value;
					if (product.link.indexOf("/smartphones/") != -1) {
						usi_app.smartphone = true;
					}
					prod_array.push(product);
				}
				usi_commons.log(prod_array);
				if (prod_array.length > 0) {
					usi_app.load_cart_recs(prod_array);
					var pid = prod_array[0].pid;
					var subtotal = prod_array[0].price;
					subtotal = subtotal.replace("\u{20AC}", "");
					subtotal = subtotal.trim();
					subtotal = subtotal.replace(".", "");
					subtotal = subtotal.replace(/([^,]*$)/, "");
					subtotal = subtotal.replace(",", "");
					usi_cookies.set("usi_pid", pid, usi_cookies.expire_time.week, true);
					usi_cookies.set("usi_subtotal", subtotal, usi_cookies.expire_time.week, true);
				} else {
					setTimeout(usi_app.scrape_cart, 2000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_cart_recs = function (cart) {
			try {
				usi_app.cart = cart;
				var usi_nomatch = "%7B%7B,/smartphones/,OUTOFSTOCK,PREORDER,";
				var usi_match = "";
				var usi_recs_match_found = 0;
				var usi_pid = usi_app.cart[0].pid;
				var usi_has_40p = 0;
				var usi_has_25p = 0;

				if (usi_commons.gup("usi_pid") != "") {
					usi_app.cart[0].pid = usi_commons.gup("usi_pid");
				}

				for (var i = 0; i < usi_app.cart.length; i++) {
					if (usi_date.is_between("2024-04-25T00:00:00-00:00", "2024-05-05T23:59:59-00:00")) {
						if ("SM-A356BLBBEUE,SM-A356BLVBEUE,SM-A356BZKBEUE,SM-A356BZYBEUE,SM-A356BLBGEUE,SM-A356BLVGEUE,SM-A356BZKGEUE,SM-A356BZYGEUE,SM-A556BLBAEUE,SM-A556BLVAEUE,SM-A556BZKAEUE,SM-A556BZYAEUE,SM-A556BLBCEUE,SM-A556BLVCEUE,SM-A556BZKCEUE,SM-A556BZYCEUE".indexOf(usi_app.cart[i].pid) != -1) {
							usi_pid = usi_pid + ",SM-R177NZTAEUE";
							usi_app.modified_price["SM-R177NZWAEUE"] = "1";
							usi_app.modified_price["SM-R177NZKAEUE"] = "1";
							usi_app.modified_price["SM-R177NZGAEUE"] = "1";
							usi_app.modified_price["SM-R177NLVAEUE"] = "1";
							usi_app.modified_price["SM-R177NZTAEUE"] = "1";
						}
					}
				}

				thisloop: for (var j=1; j<=3; j++) {
					for (var i = 0; i < usi_app.cart.length; i++) {
						if (j == 1) {
							usi_nomatch += usi_app.cart[i].pid.substring(0, 9) + "," + usi_app.cart[i].pid;
						}
						var usi_recs_match = usi_app.get_rec(usi_app.cart[i].pid, j);
						if (j == 1 && usi_app.list_40p.indexOf(usi_app.cart[i].pid) != -1) {
							usi_has_40p++;
						}
						if (j == 1 && usi_app.list_25p.indexOf(usi_app.cart[i].pid) != -1) {
							usi_has_25p++;
						}
						if (usi_recs_match != "") {
							usi_recs_match_found += Number(usi_app.cart[i].quantity);
							usi_pid += "," + usi_recs_match;
						}
					}
				}
				if (usi_recs_match_found == 0) {
					return;
				}

				usi_app.load_product_data({
					siteID: usi_app.product_page_recs,
					association_siteID: usi_app.cart_page_recs,
					pid: usi_pid,
					nomatch: usi_nomatch,
					match: usi_match,
					//less_expensive: true,
					rows: 7,
					callback: function () {
						usi_app.remove_oos();
						usi_app.remove_duplicates(cart);
						if (typeof (usi_app.product_rec.product4) != "undefined") {
							var usi_customizations = "";
							usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product1.extra);
							usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product2.extra);
							usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product3.extra);
							usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product4.extra);
							if (typeof (usi_app.product_rec.product5) != "undefined") usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product5.extra);
							if (typeof (usi_app.product_rec.product6) != "undefined") usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product6.extra);
							if (typeof (usi_app.product_rec.product7) != "undefined") usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product7.extra);
							usi_commons.log("usi_customizations: " + usi_customizations);
							if (usi_customizations != "") {
								usi_app.product_rec_temp = usi_app.product_rec;
								usi_app.load_product_data({
									siteID: usi_app.product_page_recs,
									pid: "cache1b",
									rows: 100,
									match: usi_customizations,
									nomatch: usi_nomatch,
									allow_dupe_names: 1,
									force_exact: 1,
									callback: function () {
										usi_app.remove_oos();
										usi_app.product_rec_colours = usi_app.product_rec;
										usi_app.product_rec = usi_app.product_rec_temp;
										usi_force = 1;
										usi_app.remove_loads();
										usi_commons.load("CAvqRcApIGzbcr6F4IhLwko", "49577", "cart2");
									}
								});
							} else {
								usi_app.product_rec_colours = usi_app.product_rec;
								usi_force = 1;
								usi_app.remove_loads();
								usi_commons.load("CAvqRcApIGzbcr6F4IhLwko", "49577", "cart2");
							}
						}
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.grab_customizations = function (json_str) {
			if (typeof (json_str) == "undefined") return "";
			var extra = JSON.parse(json_str.replace(/&quot;+/g, "\""));
			extra.customizable = extra.customizable.replace("colour:", "colour~").replace("color:", "color~");
			usi_commons.log("extra.customizable: ", extra.customizable);
			if (typeof (extra.customizable) != "undefined" && (extra.customizable.indexOf("color~") == 0 || extra.customizable.indexOf("colour~") == 0)) {
				return extra.customizable.split("~")[2] + ",";
			} else {
				return "";
			}
		};
		usi_app.seen = function (usi_products, id, site_id) {
			try {
				if (!id) id = usi_js.campaign.id;
				if (!site_id) site_id = usi_js.campaign.site_id;
				usi_app.current_upsells = usi_products;
				if (usi_cookies.get("usi_" + site_id + "_c") == null) {
					usi_commons.load_script("https://www.upsellit.com/utility/update_launch_point.jsp?id=" + id + "&trackingInfo=" + usi_commons.get_id() + "~" + encodeURIComponent(usi_products));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.seen2 = function(id, site_id, config_id, seenProducts, targetProduct) {
			try {
				var targetType = 'product';
				var targetValue = targetProduct;
				var targetPrice = 0;

				if (typeof(targetProduct) === 'undefined') {
					targetType = 'unknown';
					targetValue = 'unknown';
				} else if (targetProduct === 'Sale Page') {
					targetType = 'category';
				} else if (typeof(targetProduct.pid) !== 'undefined') {
					targetValue = targetProduct.pid;
					targetPrice = targetProduct.price;
				}

				var viewClient = usipr_client.viewClientBuilder()
						.setChatId(id)
						.setSiteId(site_id)
						.setConfigurationId(config_id)
						.setTarget(targetType, targetValue, targetPrice)
						.build();

				for (var i = 0; i < seenProducts.length; i++) {
					var pid = seenProducts[i].pid || seenProducts[i].code;

					var price = seenProducts[i].price;
					price = (typeof(price) === "undefined") ? "0" : "" + price;
					price = price.replaceAll("$", "");
					price = price.replaceAll(",", "");

					viewClient.addProduct(pid, price);
				}

				if (seenProducts.length > 0) {
					viewClient.sendEvent();
				} else {
					usi_commons.log("No products seen, not sending view event");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.clicked = function (usi_clicked, id, site_id) {
			try {
				if (!id) id = usi_js.campaign.id;
				if (!site_id) site_id = usi_js.campaign.site_id;
				if (usi_clicked == "") return;
				if (usi_app.current_upsells.indexOf(usi_clicked) != -1) {
					var usi_products = usi_clicked.split(",");
					for (var i = 0; i < usi_products.length; i++) {
						if (usi_app.current_upsells.indexOf(usi_products[i] + "[C]") == -1) {
							usi_app.current_upsells = usi_app.current_upsells.replace(usi_products[i], usi_products[i] + "[C]");
						}
					}
				} else {
					usi_app.current_upsells += "," + usi_clicked + "[C]";
				}
				usi_cookies.set("usi_" + site_id + "_c", usi_app.current_upsells, 7 * 24 * 60 * 60, true);
				usi_commons.load_script("https://www.upsellit.com/utility/update_launch_point.jsp?id=" + id + "&trackingInfo=" + usi_commons.get_id() + "~" + encodeURIComponent(usi_app.current_upsells));
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.clicked2 = function (id, site_id, config_id, clickedProduct, targetProduct, usi_callback) {
			try {
				var targetType = 'product';
				var targetValue = targetProduct;

				if (typeof(targetProduct) === 'undefined') {
					targetType = 'unknown';
					targetValue = 'unknown';
				} else if (targetProduct === 'Sale Page') {
					targetType = 'category';
				} else if (typeof(targetProduct.pid) !== 'undefined') {
					targetValue = targetProduct.pid;
				}

				var clickClient = usipr_client.clickClientBuilder()
						.setChatId(id)
						.setSiteId(site_id)
						.setConfigurationId(config_id)
						.setTarget(targetType, targetValue);

				if (typeof(usi_callback) === 'function') {
					clickClient = clickClient.setCallback(usi_callback);
				}

				clickClient = clickClient.build();

				if (clickedProduct && clickedProduct.pid) {
					clickClient.setProduct(clickedProduct.pid, clickedProduct.price);
					clickClient.sendEvent();
				} else {
					usi_commons.log("No products clicked, not sending click event");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_product_data = function (options) {
			usi_commons.log("usi_app.load_product_data()");
			try {
				var queryStr = "";
				if (options.siteID) queryStr += '?siteID=' + options.siteID;
				if (options.association_siteID) queryStr += '&association_siteID=' + options.association_siteID;
				if (options.pid) queryStr += '&pid=' + options.pid;
				if (options.less_expensive) queryStr += '&less_expensive=' + options.less_expensive;
				if (options.rows) queryStr += '&rows=' + options.rows;
				if (options.days_back) queryStr += '&days_back=' + options.days_back;
				if (options.match) queryStr += '&match=' + options.match;
				if (options.nomatch) queryStr += '&nomatch=' + options.nomatch;
				if (options.force_exact) queryStr += '&force_exact=' + options.force_exact;
				if (options.allow_dupe_names) queryStr += '&allow_dupe_names=' + options.allow_dupe_names;
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations.jsp' + queryStr, function(){
					if (typeof options.callback === 'function' && typeof usi_app.product_rec !== 'undefined') {
						options.callback(usi_app.product_rec);
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.send_product_data = function () {
			try {
				setTimeout(function(){
					var current_prod = usi_app.scrape_product_page();
					if (current_prod != null && current_prod.name != "" && current_prod.pid != "" && current_prod.image.indexOf("https://images.samsung.com/") != -1 && current_prod.price != "" && (current_prod.link.indexOf("www.samsung.com") != -1 || current_prod.link.indexOf("shop.samsung.com") != -1)) {
						if (usi_samsung.check_for_consistency(current_prod)) {
							usi_app.product_page_data = current_prod;
							usi_app.last_pid = current_prod.pid;
							usi_app.last_price = current_prod.price;
							usi_commons.send_prod_rec(usi_app.product_page_recs, current_prod, true);
							//usi_commons.send_prod_rec(usi_app.product_page_recs, current_prod, true);
							usi_commons.log(current_prod);
							usi_app.load_product_page();
						}
					}
				},500);
				setTimeout(usi_app.send_product_data, 2000);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_product_page = function () {
			try {
				var product = {};
				product.pid = usi_samsung.scrape_sku();
				product.name = usi_samsung.scrape_name();
				product.link = usi_samsung.scrape_link();
				product.image = usi_samsung.scrape_image();
				$.ajax({
					url: 'https://searchapi.samsung.com/v6/front/b2c/product/card/detail/newhybris?siteCode=pl&modelList=' + encodeURIComponent(product.pid) + '&saleSkuYN=N&onlyRequestSkuYN=Y&vd3PACardYN=Y&commonCodeYN=N',
					type: "GET",
					dataType: "json",
					success: function (data) {
						var tradeup_data = data.response.resultData.productList;
						usi_app.product_image_api(tradeup_data);
					},
					error: function (err) {
						usi_commons.report_error(err);
					}
				});
				if (!product.image && usi_cookies.value_exists("usi_pdpscrape_image")) product.image = usi_cookies.get("usi_pdpscrape_image");
				product.category = usi_samsung.scrape_category(3);
				product.category2 = usi_samsung.scrape_category2();
				product.stock = usi_samsung.scrape_stock();
				if (product.stock == "OUTOFSTOCK") {
					usi_app.legit_OOS = true;
				}
				product.price = usi_samsung.scrape_price();
				product.msrp = usi_app.scrape_msrp();
				product.details = usi_samsung.scrape_details();
				if (product.stock == "OUTOFSTOCK" && product.price == "") product.price = "0.0";
				if (product.stock == "OUTOFSTOCK" && product.msrp == "") product.msrp = "0.0";
				if (Number(product.price) == 0) {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=1&url="+encodeURIComponent(location.href));
					product.stock = "OUTOFSTOCK"; //prevent zeros
				}
				var usi_customizable = usi_samsung.scrape_customizations();
				var usi_rating = usi_samsung.scrape_ratings();
				var usi_model_name = usi_samsung.scrape_model_name();
				var usi_badge = "";
				if (document.getElementsByClassName("badge-icon  badge-icon--label badge-icon--bg-color-teal").length > 0) {
					usi_badge = document.getElementsByClassName("badge-icon  badge-icon--label badge-icon--bg-color-teal")[0].innerText;
				}
				product.extra = JSON.stringify({
					category: product.category,
					category2: product.category2,
					original_price: product.msrp,
					details: product.details,
					stock: product.stock,
					rating: usi_rating,
					customizable: usi_customizable,
					model_name: usi_model_name,
					badge: usi_badge
				});
				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.product_image_api = function(data) {
			try {
				var image;
				if (data && data[0] && data[0].modelList && data[0].modelList.length > 0) {
					if (data[0].modelList[0].thumbUrl) {
						image = data[0].modelList[0].thumbUrl;
						if (image.indexOf("https:") == -1) image = "https:" + image;
						usi_cookies.set("usi_pdpscrape_image", image, usi_cookies.expire_time.hour, true);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_msrp = function () {
			try {
				var usi_msrp = "";
				var usi_buttons = document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now");
				if (document.querySelector(".pd-buying-price__was del") != null) {
					usi_msrp = document.querySelector(".pd-buying-price__was del").textContent.trim();
				} else if (document.querySelector(".pd-buying-price__was") != null) {
					usi_msrp = document.querySelector(".pd-buying-price__was").textContent.trim();
				} else if (document.getElementsByClassName("cost-box__price-original").length > 0) {
					usi_msrp = document.getElementsByClassName("cost-box__price-original")[0].textContent;
				} else if (document.getElementById("originalPrice") != null) {
					usi_msrp = document.getElementById("originalPrice").value;
				} else if (document.getElementById("product-price-old") != null) {
					usi_msrp = document.getElementById("product-price-old").innerText;
				} else if (document.getElementsByClassName("hubble-price-bar__price-total-save-inner").length > 0) {
					usi_msrp = document.getElementsByClassName("hubble-price-bar__price-total-save-inner")[0].getElementsByTagName("s")[0].innerText;
				} else if (document.getElementsByClassName("hubble-product__summary-product-price").length > 0 && document.getElementsByClassName("hubble-product__summary-product-price")[0].getElementsByTagName("span").length > 0) {
					usi_msrp = document.getElementsByClassName("hubble-product__summary-product-price")[0].getElementsByTagName("span")[0].innerText;
				} else if (document.getElementsByClassName("hubble-product__summary-product-price").length > 0) {
					usi_msrp = document.getElementsByClassName("hubble-product__summary-product-price")[0].innerText;
				} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelprice") != null) {
					usi_msrp =  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelprice");
				} else if (document.querySelector(".s-price-total .del-price") != null) {
					usi_msrp = document.querySelector(".s-price-total .del-price").textContent;
				} else if (document.getElementsByClassName("product-promo ng-scope").length > 0) {
					usi_msrp = document.getElementsByClassName("product-promo ng-scope")[0].innerText;
				}
				if (usi_msrp.indexOf("{{") != -1) return "";
				if (usi_msrp.indexOf(" z\u0142") != -1) usi_msrp = usi_msrp.substring(0, usi_msrp.indexOf(" z\u0142"));
				if (usi_msrp.indexOf(" Ft") != -1) usi_msrp = usi_msrp.substring(0, usi_msrp.indexOf(" Ft"));
				if (/[A-Za-z]/.test(usi_msrp)) return ""; //alpha in the price = bad
				if (usi_msrp != "") return usi_samsung.standardize_currency(usi_msrp);
			} catch (err) {
				usi_commons.report_error(err);
			}
			return "";
		};

		usi_app.add_to_cart = function (pid, callback) {
			usi_commons.log("usi_app.add_to_cart: " + pid);
			var pids_split = pid.split(",");
			var pids_array = [];
			for (var i = 0; i < pids_split.length; i++) {
				pids_array.push({
					"productCode": pids_split[i],
					"quantity": 1
				});
			}
			if (location.href.indexOf("/cart") != -1) {
				var xhr = new XMLHttpRequest();
				var url = "https://shop.samsung.com/pl/servicesv2/addToCart";
				xhr.open("POST", url);
				xhr.setRequestHeader("Content-Type", "application/json");
				xhr.setRequestHeader("Accept", "application/json");
				xhr.onreadystatechange = function () {
					if (xhr.readyState === 4) {
						callback();
					}
				};
				xhr.send(JSON.stringify({"products": pids_array}));
			} else {
				$.ajax({
					url: "https://shop.samsung.com/pl/servicesv2/addToCart",
					type: "POST",
					dataType: "json",
					cache: !0,
					crossDomain: !0,
					contentType: "application/json",
					timeout: 3E4,
					xhrFields: {
						withCredentials: !0
					},
					data: JSON.stringify({"products": pids_array}),
					success: function () {
						callback();
					},
					error: function (a) {
						console.log(a)
					}
				})
			}
		};
		usi_app.add_items = usi_app.add_to_cart;

		usi_app.cart_contains = function (arr, pid) {
			try {
				for (var i = 0; i < arr.length; i++) {
					if (pid.indexOf(arr[i]) != -1) return true;
				}
				return false;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.monitor_for_analytics = function() {
			try {
				if (typeof(usi_app.last_url) === "undefined" || usi_app.last_url != location.href) {
					usi_app.last_url = location.href;
					usi_analytics.send_page_hit("VIEW", usi_app.company_id);
				}
				setTimeout(usi_app.monitor_for_analytics, 2000);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_samsung.scrape_stock = function () {
			try {
				if (document.getElementById("apiChangeStockStatus") != null && document.getElementById("apiChangeStockStatus").value == 'OUTOFSTOCK') {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=2&url="+encodeURIComponent(location.href));
					return "OUTOFSTOCK";
				} else if (document.getElementsByClassName("s-btn-encased s-blue js-buy-now").length > 0 && document.getElementsByClassName("s-btn-encased s-blue js-buy-now")[0].innerText.indexOf("PRE ORDER") != -1) {
					return "PREORDER";
				} else if (document.getElementById("btn-notify") != null && document.getElementById("btn-notify").style.display != "none") {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=2&url="+encodeURIComponent(location.href));
					return "OUTOFSTOCK";
				} else if (document.getElementsByClassName("tg-out-stock").length > 0 ) {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=3&url="+encodeURIComponent(location.href));
					return "OUTOFSTOCK";
				} else if (document.getElementsByClassName("tg-pre-order").length > 0) {
					return "PREORDER";
				} else if (document.getElementsByClassName("s-hubble-total-cta").length > 0 &&
						(document.getElementsByClassName("s-hubble-total-cta")[0].innerText.indexOf("Not for Sale") != -1 || document.getElementsByClassName("s-hubble-total-cta")[0].innerText.indexOf("Receive stock alerts") != -1)) {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=4&url="+encodeURIComponent(location.href));
					return "OUTOFSTOCK";
				} else if (document.getElementsByClassName("add-to-cart-btn").length > 0 && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ac") != null && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ac").indexOf("stock alert") != -1) {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=5&url="+encodeURIComponent(location.href));
					return "OUTOFSTOCK";
				} else if (document.getElementsByClassName("btn-2 add-to-cart").length > 0 ) {
					//Removed: || document.getElementsByClassName("js-buy-now").length > 0 ||
					return "INSTOCK";
				} else if (document.getElementsByClassName("add-to-cart-btn").length > 0 && document.getElementsByClassName("add-to-cart-btn")[0].className.indexOf("usi_") == -1 && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ca") !== "stock alert" && document.getElementsByClassName("add-to-cart-btn")[0].className.indexOf("is-cta-disabled") == -1) {
					return "INSTOCK";
				} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now tg-add-to-cart").length > 0) {
					return "INSTOCK";
				} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging tg-add-to-cart").length > 0) {
					return "INSTOCK";
				} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now tg-continue").length > 0) {
					return "INSTOCK";
				} else if (document.querySelector(".product-details-simple.js-buy-now") != null) {
					return "INSTOCK";
				} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-an-la") == "secondary navi:add to cart") {
					return "INSTOCK";
				} else if (document.querySelector('.product-basket [data-an-tr="stock-alert"]') != null) {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=6&url="+encodeURIComponent(location.href));
					return "OUTOFSTOCK";
				} else if (document.querySelector('[data-an-tr="add-to-cart"]') != null) {
					return "INSTOCK";
				} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging tg-bespoke").length > 0) {
					return "INSTOCK";
				} else if (document.getElementsByClassName("btn-add-to-basket").length > 0 && document.getElementsByClassName("btn-add-to-basket")[0].getAttribute("data-stock-level") == 'inStock') {
					return "INSTOCK";
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?polandoos=7&url="+encodeURIComponent(location.href));
			return "OUTOFSTOCK";
		};

		setTimeout(usi_app.main, 2000);

		if (location.href.indexOf("offer/aktualne-promocje-it") != -1) {
			usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?offer_url="+encodeURIComponent(location.href));
		}

	} catch (err) {
		usi_commons.report_error(err);
	}
}
