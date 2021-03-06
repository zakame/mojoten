package Mojoten::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(message => 'Welcome to the Mojolicious Web Framework!');
}

# This renders the Mojoten index page
sub index { shift->render(template => 'example/mojoten-index') }

1;
