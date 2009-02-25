package TestApp;

use Moose;

extends 'Catalyst';
with 'CatalystX::REPL';

__PACKAGE__->setup;

1;
