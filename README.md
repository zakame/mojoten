# NAME

Mojoten - 10 Mojolicious Models in 10 days

# SYNOPSIS

    # run the webapp port 3000
    morbo script/mojoten

# DESCRIPTION

This project is inspired by [10 Catalyst Models in 10
Days](http://sedition.com/a/2733) by Ashley Pond V, using
[Mojolicious](http://mojolicious.org) for the web framework instead of
Catalyst.  I started this mainly so I can practice writing Modern Perl
while also learning more about writing good HTML5 and JavaScript.  Aside
from Mojolicious, I will also be using [jQuery](http://jquery.com)
(bundled with Mojolicious) and [Modernizr](http://www.modernizr.com) for
UI and decoration, as well as web fonts from [Font
Squirrel](http://www.fontsquirrel.com) and [Google Web
Fonts](http://www.google.com/webfonts).

## Goals

Aside from the aforementioned learning goals, I'm also going for the
following:

- Despite the name "Mojo Models", I'll be writing the models in such a way
as they can be made standalone as possible, preferring to either use
them directly in a [Mojolicious::Controller](https://metacpan.org/pod/Mojolicious::Controller), or interact with them
through an adaptor class that pulls them in via [Mojo::Base](https://metacpan.org/pod/Mojo::Base).  That
way, I can pull these models out when I want, say, to do a
[Dancer](https://metacpan.org/pod/Dancer)-based practice project instead of Mojo ;)
- Practice good design as much as possible.  Not only in code, but also in
visual/print design as well.  HTML5/CSS3 offers a richer set of
possibilities for web designs than ever before; make sure I get to use
it!
- Write tests for the models, where applicable.  This especially gets
difficult as the practice calls for enhancing the app using JavaScript,
so I need to learn of ways to do proper testing...

# AUTHOR

Zak B. Elep <zakame@cpan.org>

# SEE ALSO

`Models.org` in this dist's root directory for a description of the
models used in this app.
