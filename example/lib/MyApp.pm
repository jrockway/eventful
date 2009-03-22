package MyApp;
use Moose;
use feature ':5.10';

with 'Eventful', 'Eventful::Loop', 'Eventful::Debug';

sub build_name { 'MyApp' };

sub setup {
    my $self = shift;
    say 'Starting MyApp';

    $self->add_watcher(
        AnyEvent->timer(
            after => 1, interval => 1, cb => sub {
                say 'Still alive: '. AnyEvent->now;
            },
        ),
        AnyEvent->timer(
            after => 5, cb => sub {
                warn 'Exiting.';
                $self->unloop(0);
            },
        ),
    );


}

sub start {

}

sub cleanup {
    say 'Cleanup.';
}

sub exit_code { 0 }

1;
