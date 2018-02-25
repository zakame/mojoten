package Model::Goodreads;
use Mojo::Base -base;
use Mojo::UserAgent;
use Carp;

has 'key';
has ua => sub { Mojo::UserAgent->new };

sub covers_for_title {
  my $self = shift;

  my $title = shift or croak 'You must provide a title string';

  my $url = Mojo::URL->new('https://www.goodreads.com/search.xml');
  $url->query({q => $title, key => $self->key, search => 'title'});

  my $covers = [];
  my $tx     = $self->ua->get($url);
  if (my $res = $tx->success) {
    $res->dom->find('best_book')->each(sub {
      my ($id, $title, $url)
        = ($_->at('id'), $_->at('title'), $_->at('image_url'));
      return if $url =~ /nophoto/;
      push @$covers =>
        {id => $id->text, title => $title->text, url => $url->text};
    });
  }
  else {
    my $err = $tx->error;
    croak "Something went wrong: $err->{message}";
  }

  $covers;
}

1;
