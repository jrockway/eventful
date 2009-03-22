package MyWebApp;
use Moose;
use feature ':5.10';

use POE;

use HTTP::Engine;

with 'Eventful', 'Eventful::Loop', 'Eventful::Debug', 'Eventful::Component::REPL';

sub build_name { 'MyWebApp' };

has 'engine' => (
    is         => 'ro',
    isa        => 'HTTP::Engine',
    lazy_build => 1,
);

sub _build_engine {
    my $self = shift;
    my $e = HTTP::Engine->new(
        interface => {
            module => 'POE',
            args   => {
                host => 'localhost',
                port => 3000,
            },
            request_handler => sub {
                $self->handle_web_request(@_);
            },
        },
    );
    return $e;
}

sub setup {
    my $self = shift;
    say 'Starting MyApp';

    $self->add_watcher(
        AnyEvent->timer(
            after => 1, interval => 5, cb => sub {
                say 'Still alive: '. AnyEvent->now;
            },
        ),
    );

    $self->engine->run;
}

our $NEXT_BODY = 'hello';

sub handle_web_request {
    my ($self, $req) = @_;
    return HTTP::Engine::Response->new( body => $NEXT_BODY ); # for testing the REPL
}

sub start {

}

sub cleanup {
    say 'Cleanup.';
}

sub exit_code { 0 }

1;
