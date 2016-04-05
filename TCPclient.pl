use IO::Socket::INET;

$| = 1;

my $socket = new IO::Socket::INET(
	PeerHost => '192.168.1.0',
	PeerPort => '50000',
	Proto => 'tcp',
);
die "Cannot connect to the server $!\n" unless $socket;
print "Connected to the server\n";

my $req = 'Hello World';
my $size = $socket->send($req);
print "Sent data of length $size\n";

shutdown($socket, 1);

my $response = "";
$socket->recv($response, 1024);
print "Received response: $response\n";

$socket->close();
