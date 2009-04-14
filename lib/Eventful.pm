package Eventful;
use Moose::Role;

with 'MooseX::Runnable';

has 'name' => (
    traits  => ['NoGetopt'],
    is      => 'ro',
    isa     => 'Str',
    builder => 'build_name',
);

sub build_name {
    my $self = shift;
    my $appname = $0;
    $appname =~ s{([^/\\]+)[.]\w+}{$1};
    return $appname;
}

sub run {
    my $self = shift;
    $self->setup;
    $self->start;
    $self->cleanup;
    return $self->end;
}

# these functions don't take arguments; communicate with instance
# state.
requires 'setup';
requires 'start';
requires 'cleanup';
requires 'end';

1;
