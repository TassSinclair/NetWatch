_ = require('lodash');
var express = require('express'),
    app = express(),
    server = require('http').createServer(app),
    io = require('socket.io').listen(server, { log: false }),
    nmap = require('libnmap'),
    opts = {
      range: [
        '192.168.0.1/24'
      ]
    },
    port = 3000;

var nodes = [];

function makeHostData(host) {
    return {
        addr: host.address[0].item.addr,
        name: host.hostnames[0]
    };
}

nmap.scan(opts, function(err, report) {
  if (err) throw new Error(err);
 
  var nodeData = _.reduce(report, function(acc, segment) {
    return segment.host ? acc.concat(segment.host) : acc;
  }, []).map(makeHostData);
  
  nodes = nodeData;
  io.sockets.emit('nodes', nodes);
});

app.get('/', function (req, res) {
    res.sendfile(__dirname + '/client/views/index.html')
});

app.use('/', express.static(__dirname + "/client/views"));

io.sockets.on('connection', function (socket) {
    socket.on('getNodes', function(getNodes) {
        socket.emit('nodes', nodes);
    });
});

server.listen(port);
console.log('Hosted on port',port);
