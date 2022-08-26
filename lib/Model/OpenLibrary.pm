package Model::OpenLibrary;
use Mojo::Base -base;
use Mojo::UserAgent;
use Carp;

has ua => sub { Mojo::UserAgent->new };

sub covers_for_title {
  my $self = shift;

  my $title = shift or croak 'You must provide a title string';

  my $url = Mojo::URL->new('https://openlibrary.org/search.json');
  $url->query({q => $title, fields => 'title,cover_i,key'});

  my $covers = [];
  my $tx     = $self->ua->get($url);
  if ($tx->res->is_success) {
    for my $doc (@{$tx->res->json->{docs}}) {
      next unless $doc->{cover_i};
      my $link = join '' => 'https://openlibrary.org', $doc->{key};
      my $url  = join '' => 'https://covers.openlibrary.org/b/id/',
        $doc->{cover_i}, '-M.jpg';
      push @$covers => {
        id    => $doc->{cover_i},
        link  => $link,
        title => $doc->{title},
        url   => $url
      };
    }
    croak "No books found" unless @$covers;
  }
  else {
    my $err = $tx->error;
    croak "Something went wrong: $err->{message}";
  }

  $covers;
}

1;
