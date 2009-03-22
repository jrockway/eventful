package Eventful::Loop;
use Moose::Role;

use MooseX::Getopt;
use AnyEvent;
use Set::Object;
use MooseX::Types::Set::Object;

use namespace::clean -except => ['meta'];

with 'Eventful';

# todo, make this a stack
has 'main_loop' => (
    traits     => ['NoGetopt'],
    is         => 'ro',
    isa        => 'AnyEvent::CondVar',
    lazy_build => 1,
);

sub _build_main_loop {
    my $self = shift;
    return AnyEvent->condvar;
}

has 'watchers' => (
    traits   => ['NoGetopt'],
    init_arg => 'watchers',
    reader   => '_watcher_set',
    isa      => 'Set::Object',
    required => 1,
    default  => sub { Set::Object->new },
    handles  => {
        add_watcher    => 'insert',
        delete_watcher => 'remove',
        watchers       => 'members',
    },
);

sub loop {
    my $self = shift;
    return $self->main_loop->recv;
}

sub unloop {
    my $self = shift;
    $self->main_loop->send(@_);
}

after start => sub {
    my $self = shift;
    return $self->loop;
};

1;
