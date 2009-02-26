package CatalystX::REPL;
# ABSTRACT: read-eval-print-loop for debugging your Catalyst application

use Moose::Role;
use Carp::REPL ();
use Catalyst::Utils;

use namespace::clean -except => 'meta';

=head1 SYNOPSIS

    package MyApp;

    use Moose;

    extends 'Catalyst';
    with 'CatalystX::REPL';

    __PACKAGE__->setup(qw/-Debug/);

    1;

=head1 DESCRIPTION

This role automatically sets up Carp::REPL after starting your application, if
the C<CATALYST_REPL> or C<MYAPP_REPL> environment variabeles are set.

=cut

after setup_finalize => sub {
    my ($self) = @_;
    $SIG{__DIE__} = \&Carp::REPL::repl
        if Catalyst::Utils::env_value($self, 'repl');
};

1;
