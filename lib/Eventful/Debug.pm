package Eventful::Debug;
use Moose::Role;

with 'Eventful';

has 'debug' => (
    is       => 'ro',
    isa      => 'Bool',
    required => 1,
    default  => 0,
);

before run => sub {
    my $self = shift;
    if($self->debug){
        require Carp::Always;
    }
};

1;
