#!/usr/bin/perl

use strict;
use Test::More tests => 1;
use FindBin qw($Bin);
use lib "$Bin/lib";
use MemcachedTest;


my $server = new_memcached("-t 64");
my $sock1 = $server->sock;
my $sock2 = $server->new_sock;
my $sock3 = $server->new_sock;
my $sock4 = $server->new_sock;

my @result;
my @result2;
my @result3;
my @result4;

ok($sock1 != $sock2, "have two different connections open");

my $cnt=0;

while(1){

#print "aa\n";

print $sock1 "set foo1 1 1 1 \r\n5\r\n";
my $res1 = <$sock1>;
print $sock2 "set foo1 1 1 1 \r\n5\r\n";
my $res2 = <$sock2>;

print $sock3 "set foo3 1 1 1 \r\n6\r\n";
my $res3 = <$sock3>;

print $sock4 "set foo4 1 1 1 \r\n4\r\n";
my $res4 = <$sock4>;

$cnt = 0;
	while($cnt++<105){

		print $sock1 "incr foo1 3 \r\n";
#@result = mem_gets($sock4, "foo3");
		print $sock2 "incr foo1 5 \r\n";
#@result = mem_gets($sock3, "foo4");		
		print $sock3 "incr foo3 7 \r\n";
#@result = mem_gets($sock2, "foo2");
		print $sock4 "incr foo4 9 \r\n";
#@result = mem_gets($sock1, "foo1");
		 $res1 = <$sock1>;
		 $res2 = <$sock2>;
		 $res3 = <$sock3>;
		 $res4 = <$sock4>;

	}
}
