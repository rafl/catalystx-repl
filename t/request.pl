use strict;
use warnings;

BEGIN { @ENV{qw/CATALYST_DEBUG CATALYST_REPL/} = (1, 1); }

use FindBin;
use lib "$FindBin::Bin/lib";

use Catalyst::Test 'TestApp';

$Carp::REPL::noprofile = 1;

request($ARGV[0]);
