package Mojoten;
use Mojo::Base 'Mojolicious';

our $VERSION = "0.000001";

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc" (this plugin requires Perl 5.10)
  $self->plugin('PODRenderer');

  # Routes
  my $r = $self->routes;

  # Normal route to controller
  $r->route('/welcome')->to('example#welcome');

  # Mojoten index
  $r->route('/')->to('example#index');

  # Random quotes
  $r->route('/randomquote')->to('random_quote#index');
  $r->route('/randomquote/quote')->to('random_quote#quote');
  $r->route('/randomquote/show_all')->to('random_quote#show_all');

  # Moon phase
  $r->route('/moonphase')->to('moon_phase#index');
  $r->route('/moonphase/check')->to('moon_phase#check');
  $r->route('/moonphase/*time')->to('moon_phase#check');

  # prevent caching for JSON responses for IE (taken from
  # http://toroid.org/ams/etc/mojolicious-static-resources)
  $self->hook(after_dispatch => sub {
    my $tx   = shift;
    my $type = $tx->res->headers->content_type;
    return unless $type and $type =~ /json/;
    $tx->res->headers->header(
      Expires => Mojo::Date->new(time-365*86400)
    );
    $tx->res->headers->header(
      'Cache-Control' => 'max-age=1, no-cache'
    );
  });
}

1;
__END__

=head1 NAME

Mojoten - 10 Mojolicious Models in 10 days

=head1 SYNOPSIS

    # run the webapp port 3000
    morbo script/mojoten

=head1 DESCRIPTION

This project is inspired by L<10 Catalyst Models in 10
Days|http://sedition.com/a/2733> by Ashley Pond V, using
L<Mojolicious|http://mojolicious.org> for the web framework instead of
Catalyst.  I started this mainly so I can practice writing Modern Perl
while also learning more about writing good HTML5 and JavaScript.  Aside
from Mojolicious, I will also be using L<jQuery|http://jquery.com>
(bundled with Mojolicious) and L<Modernizr|http://www.modernizr.com> for
UI and decoration, as well as web fonts from L<Font
Squirrel|http://www.fontsquirrel.com> and L<Google Web
Fonts|http://www.google.com/webfonts>.

=head2 Goals

Aside from the aforementioned learning goals, I'm also going for the
following:

=over 4

=item

Despite the name "Mojo Models", I'll be writing the models in such a way
s they can be made standalone as possible, preferring to either use them
directly in a L<Mojolicious::Controller>, or interact with them through
an adaptor class that pulls them in via L<Mojo::Base>.  That way, I can
pull these models out when I want, say, to do a L<Dancer>-based practice
project instead of Mojo ;)

=item

Practice good design as much as possible.  Not only in code, but also n
visual/print design as well.  HTML5/CSS3 offers a richer set of
possibilities for web designs than ever before; make sure I get to use
it!

=item

Write tests for the models, where applicable.  This especially gets
ifficult as the practice calls for enhancing the app using JavaScript,
so I need to learn of ways to do proper testing...

=back

=head1 AUTHOR

Zak B. Elep E<lt>zakame@cpan.orgE<gt>

=head1 SEE ALSO

C<Models.org> in this dist's root directory for a description of the
models used in this app.

=cut
