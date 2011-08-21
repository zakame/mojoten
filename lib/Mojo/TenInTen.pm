package Mojo::TenInTen;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc" (this plugin requires Perl 5.10)
  $self->plugin('PODRenderer');

  # Routes
  my $r = $self->routes;

  # Normal route to controller
  $r->route('/welcome')->to('example#welcome');

  # Random quotes
  $r->route('/randomquote')->to('random_quote#index');
  $r->route('/randomquote/quote')->to('random_quote#quote');
  $r->route('/randomquote/show_all')->to('random_quote#show_all');

  # prevent caching for JSON responses for IE (taken from
  # http://toroid.org/ams/etc/mojolicious-static-resources)
  $self->hook(after_dispatch => sub {
    my $tx   = shift;
    my $type = $tx->res->headers->content_type;
    return unless $type =~ /json/;
    $tx->res->headers->header(
      Expires => Mojo::Date->new(time-365*86400)
    );
    $tx->res->headers->header(
      'Cache-Control' => 'max-age=1, no-cache'
    );
  });
}

1;
