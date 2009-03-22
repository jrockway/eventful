package Eventful::Component::REPL;
use Moose::Role;

use Stylish::Server;

with 'Eventful', 'Eventful::Component', 'Eventful::Loop';

has 'stylish' => (
    traits  => ['NoGetopt'],
    is      => 'ro',
    isa     => 'Stylish::Server',
    default => sub { Stylish::Server->new },
);

after setup => sub {
    my $self = shift;
    $self->stylish->run;
};

1;
