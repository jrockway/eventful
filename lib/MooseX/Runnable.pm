package MooseX::Runnable;
use Moose::Role;

our $RUNNING_APP;

requires 'run';

sub run_as_application {
    my $class = shift;
    my @args = @_;

    if($class->does('MooseX::Getopt')){
        my $self = $class->new_with_options(@args);
        local $RUNNING_APP = $self;
        exit $self->run( $self->extra_argv );
    }

    local $RUNNING_APP = $class->new(@args);
    exit $RUNNING_APP->run;
}

1;
