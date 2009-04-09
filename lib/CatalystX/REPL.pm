package CatalystX::REPL;
# ABSTRACT: read-eval-print-loop for debugging your Catalyst application

use Moose::Role;
use Carp::REPL ();
use Catalyst::Utils;

use namespace::clean -except => 'meta';

=head1 SYNOPSIS

    package MyApp;

    use Moose;

    # Requires Catalyst 5.8 series
    extends 'Catalyst';
    with 'CatalystX::REPL';

    __PACKAGE__->setup(qw/-Debug/);

    1;

=head1 DESCRIPTION

Using L<Carp::REPL|Carp::REPL> with a Catalyst application is hard. That's
because of all the internal exceptions that are being thrown and caught by
Catalyst during application startup. You'd have to manually skip over all of
those.

This role works around that by automatically setting up Carp::REPL after
starting your application, if the C<CATALYST_REPL> or C<MYAPP_REPL> environment
variables are set:

 MYAPP_REPL=1 ./script/myapp_server.pl
 # Hit an action
 ...

 42 at lib/MyApp/Controller/Foo.pm line 8.

 # instead of exiting, you get a REPL!
 Trace begun at lib/MyApp/Controller/Foo.pm line 8
 MyApp::Controller::Foo::bar('MyApp::Controller::Foo=HASH(0xc9fe20)', 'MyApp=HASH(0xcea6a4)') called at ...
 ... # Many more lines of stack trace

 $ $c
 MyApp=HASH(0xcea6ec)
 $ $c->req->uri
 http://localhost/foo/bar
 $

Options like C<warn> or C<nodie> can be passed to Carp::REPL by putting them,
seperated by commas, into the environment variable:

 MYAPP_REPL=warn,nodie ./script/myapp_server.pl

Carp::REPL uses L<Devel::REPL> for the shell, so direct any questions how how
to use or customize the repl at that module.

=head1 SEE ALSO

L<Carp::REPL>

L<Devel::REPL>

=cut

after setup_finalize => sub {
    my ($self) = @_;
    if (my $repl_options = Catalyst::Utils::env_value($self, 'repl')) {
        Carp::REPL->import(split q{,}, $repl_options);
    }
};

1;
