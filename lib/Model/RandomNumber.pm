package Model::RandomNumber;
use Mojo::Base -base;
use Carp;

use Mojo::JSON 'encode_json';
use Mojo::UserAgent;
use Mojo::Util qw(md5_sum steady_time);

has lower => 0;
has upper => 1;

has 'key';
has ua => sub {
  Mojo::UserAgent->new->tap(sub {
    shift->transactor->add_generator(
      jsonrpc => sub {
        my ($t, $tx, $method, $params) = @_;
        my $id = md5_sum 'j' . steady_time . rand;
        my $obj = {id => $id, jsonrpc => '2.0', method => $method};
        $obj->{params} = $params if $params;
        $tx->req->body(encode_json $obj)
          ->headers->content_type('application/json-rpc');
      }
    );
  });
};

sub generate {
  my ($self, %args) = @_;

  my $integer = delete $args{integer} // '';

  croak 'unsupported args or combination of args', join ', ' => %args
    if keys %args;

  croak 'upper bound not greater than lower bound'
    unless $self->upper > $self->lower;

  my $range = $self->upper - $self->lower;
  $integer ? $self->_generate_integer : rand($range) + $self->lower;
}

sub _generate_integer {
  my $self = shift;

  croak 'no API key set' unless $self->key;

  my $tx = $self->ua->post('https://api.random.org/json-rpc/1/invoke',
    jsonrpc => generateIntegers =>
      {apiKey => $self->key, max => $self->upper, min => $self->lower, n => 1});

  if (my $res = $tx->success) {
    if (my $error = $res->json->{error}) {
      croak "Error in RPC: ", $error->{message};
    }
    $res->json->{result}{random}{data}[0];
  }
  else {
    carp "Failed to make RPC: ", $tx->error->{message};
    my $range = $self->upper - $self->lower;
    int(rand($range) + $self->lower + 0.5 * ($range <=> 0));
  }
}

1;
