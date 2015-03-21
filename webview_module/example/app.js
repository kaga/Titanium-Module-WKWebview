// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

var webview = require('com.kaga.webview');
Ti.API.info("module is => " + webview);

var view = webview.createHTMLView({
	top: 0, bottom: 0, left: 0, right: 0,
	backgroundColor: 'red',
	url: "http://www.google.com"
});
win.add(view);
win.open();
view.addEventListener('messageFromWebview', function(message) {
 	console.error("message:" + message.message);
});
