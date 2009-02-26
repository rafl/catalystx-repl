package CatalystX::REPL;
# ABSTRACT: read-eval-print-loop for debugging your Catalyst application

use Moose::Role;
use Carp::REPL ();
use Catalyst::Utils;

use namespace::clean -except => 'meta';

after setup_finalize => sub {
    my ($self) = @_;
    $SIG{__DIE__} = \&Carp::REPL::repl
        if $self->debug && Catalyst::Utils::env_value($self, 'repl');
};

1;
