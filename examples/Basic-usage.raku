use v6.d;

use WWW::YouTube;

my $transcript = youtube-transcript('ewU83vHwN8Y');

say $transcript.chars;

say $transcript.substr(^300);
