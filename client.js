var PORT = 7400;
var HOST = '127.0.0.1';
const form = document.getElementById('listen');
const msgwrp = form.elements['msg'];
const full_msg = msgwrp.value;
var dgram = require('dgram');
var message = new Buffer(full_msg);

form.addEventListener("submit", function (event) {
var client = dgram.createSocket('udp4');
client.send(message, 0, message.length, PORT, HOST, function(err, bytes) {
  if (err) throw err;
  console.log('UDP message sent to ' + HOST +':'+ PORT);
  client.close();
});
});