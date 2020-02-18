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
  if ($tx->res->is_success) {
    $tx->res->dom->find('best_book')->each(sub {
      my ($id, $title, $url)
        = ($_->at('id'), $_->at('title'), $_->at('image_url'));
      return if $url =~ /nophoto/;
      my $link = join '' => 'https://www.goodreads.com/book/show/', $id->text;
      push @$covers => {
        id    => $id->text,
        link  => $link,
        title => $title->text,
        url   => $url->text
      };
    });
  }
  else {
    my $err = $tx->error;
    croak "Something went wrong: $err->{message}";
  }

  $covers;
}

1;
