//node auth.js to execute
var request = require('request');
var defaultHeaders = {'Content-Type' : 'application/json'};
var request = request.defaults({ jar: true, headers: defaultHeaders, json: true }); 
var user = 'XXX';
var pass = 'XXX';
//var msisdn = 'xxx';


function login(){
				var credentials = {"username" : user, "password" : pass};
				request( { method: "POST", url: "http://revolutionmsg.com/api/v1/authenticate", body: credentials },
				function (error, response, body) {console.log(response.statusCode);
				
				//additional requests work here inside callback 
				});
				}
login();