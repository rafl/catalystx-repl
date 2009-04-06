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

Using L<Carp::REPL|Carp::REPL> with a Catalyst application is hard. That's because of all the
internal exceptions that are being thrown and caught by Catalyst during
application startup. You'd have to manually skip over all of those.

This role works around that by automatically setting up Carp::REPL after
starting your application, if the C<CATALYST_REPL> or C<MYAPP_REPL> environment
variabeles are set.

=cut

after setup_finalize => sub {
    my ($self) = @_;
    $SIG{__DIE__} = \&Carp::REPL::repl
        if Catalyst::Utils::env_value($self, 'repl');
};

1;
