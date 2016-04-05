use IO::Socket::INET;

$| = 1;

my $socket = new IO::Socket::INET(
	LocalHost => '0.0.0.0',
	LocalPort => '50000',
	Proto => 'tcp',
	Listen => 5,
	Reuse => 1
);
die "Cannot create socket $!\n" unless $socket;
print "Server waiting for client connection on port 7890\n";

while(1)
{
	my $client_socket = $socket->accept();
	
	my $client_address = $client_socket->peerhost();
	my $client_port = $client_socket->peerport();
	print "Connection from $client_address:$client_port\n";

	my $data = "";
	$client_socket->recv($data,1024);
	print "Received data : $data\n";

	$data = "OK";
	$client_socket->send($data);

	shutdown($client_socket, 1);
}

$socket->close();
