package Model::RandomQuote;
use Modern::Perl;

# The do block makes sure $/ can't escape its scope.
my @Quotes = do { local $/ = "\n\n"; <DATA> } ;

sub get_one { $Quotes[rand @Quotes] }

sub get_all { wantarray ? @Quotes : [ @Quotes ] }

"Quoth the raven, `Nevermore.'";

__DATA__
You should study not only that you become a mother when your child is
born, but also that you become a child.

Zen mind is not Zen mind. That is, if you are attached to Zen mind, then
you have a problem, and your way is very narrow.  Throwing away Zen mind
is correct Zen mind.  Only keep the question, "What is the best way of
helping other people?"

Empty your mind, be formless, shapeless - like water. Now you put water
into a cup, it becomes the cup, you put water into a bottle, it becomes
the bottle, you put it in a teapot, it becomes the teapot. Now water can
flow or it can crash. Be water, my friend.

Never gonna give you up, Never gonna let you down, Never gonna run
around and desert, you Never gonna make you cry, Never gonna say
goodbye, Never gonna tell a lie and hurt you :3

JESUS CHRIST IT'S A LION GET IN THE CAR!

A cat is fine too...

LOL WUT

Oh, so they have internet on computers now!

Twelve Highlanders and a bagpipe make a rebellion.
