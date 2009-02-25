package CatalystX::REPL;
# read-eval-print-loop for debugging your Catalyst application

use Moose::Role;
use Carp::REPL ();

use namespace::clean -except => 'meta';

after setup_finalize => sub {
    my ($self) = @_;
    $SIG{__DIE__} = \&Carp::REPL::repl
        if $self->debug && $ENV{CATALYST_REPL};
};

1;
