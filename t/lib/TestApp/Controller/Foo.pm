package TestApp::Controller::Foo;

use Moose;

BEGIN { extends 'Catalyst::Controller'; }

sub bar : Local {
    die 42;
}

1;
