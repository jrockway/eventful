package MooseX::Runnable;
use Moose::Role;

requires 'run';

sub run_as_application {
    my $class = shift;
    my @args = @_;

    if($class->does('MooseX::Getopt')){
        my $self = $class->new_with_options;
        exit $self->run( $self->extra_argv );
    }

    exit $class->new(@args)->run;
}

1;
