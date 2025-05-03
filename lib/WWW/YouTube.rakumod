use v6.d;

unit module WWW::YouTube;

use HTTP::UserAgent;
use JSON::Fast;

#==========================================================
# Metadata
#==========================================================

#| Get metadata for a video
sub youtube-metadata(Str:D $videoID, :$not-available-mark = 'N/A') is export {
    # Construct video URL
    my $pre = 'https://www.youtube.com/watch?v=';
    my $url = $videoID.starts-with($pre) ?? $videoID !! $pre ~ $videoID;

    # Fetch the video page
    my $ua = HTTP::UserAgent.new;
    my $page = try $ua.get($url).content;
    if $! {
        note "Cannot fetch video page.";
        return Nil;
    }

    my %metadata =
            title => ($page ~~ / '<title>' (.*?) '</title>' / ?? $0.Str.subst(' - YouTube', '').trim !! $not-available-mark),
            description => ($page ~~ / '"description":{"simpleText":"' (.*?) '"}'/ ?? $0.Str !! $not-available-mark),
            channel-title => ($page ~~ / '"channelName":"' (.*?) '"' / ?? $0.Str !! $not-available-mark),
            view-count => ($page ~~ / '"viewCount":{"simpleText":"' (.*?) '"}' / ?? $0.Str !! $not-available-mark),
            publish-date => ($page ~~ / '"publishDate":"' (.*?) '"' / ?? $0.Str !! $not-available-mark);

    return %metadata;
}

#==========================================================
# Playlist
#==========================================================

#| Get the video IDs of a playlist.
sub youtube-playlist(Str:D $playlistID) is export {
    # Construct video playlist URL
    my $pre = 'https://www.youtube.com/playlist?list=';
    my $url = do if $playlistID ~~ / 'https://www.youtube.com/' ['watch' | 'playlist'] '?list=' / {
        $playlistID.subst('/watch', '/playlist')
    } else {
        $pre ~ $playlistID
    }

    # Fetch the video page
    my $ua = HTTP::UserAgent.new;
    my $page = try $ua.get($url).content;
    if $! {
        note "Cannot fetch video playlist page.";
        return Nil;
    }

    my @videoIDs = do with $page.match(/ '"playlistVideoRenderer":{"videoId":"' $<vid>=(.+?) '"' /):g { $/».<vid>».Str  };

    return @videoIDs;
}

#==========================================================
# Transcript
#==========================================================

#| Get transcript of a video.
sub youtube-transcript(Str:D $videoID, :$format is copy = 'text') is export {

    # Process format
    if $format.isa(Whatever) { $format = 'text'}
    die 'The value of $format is expected to be Whatever or one of "text", "dataset", "json"'
    unless $format ~~ Str:D && $format.lc ∈ <text dataset json>;

    # Construct video URL
    my $pre = 'https://www.youtube.com/watch?v=';
    my $url = $videoID.starts-with($pre) ?? $videoID !! $pre ~ $videoID;

    # Fetch the video page
    my $ua = HTTP::UserAgent.new;
    my $page = try $ua.get($url).content;
    if $! {
        note "Cannot fetch video page.";
        return Nil;
    }

    # Extract caption track URLs
    my @captionURLs = do with $page.match(/ '"captionTracks":[' (.+?) ']'/) { $0.Str };
    @captionURLs .= map({ $_.Str.subst('\u0026', '&'):g });
    @captionURLs .= map({ with $_.match(/ '"baseUrl":"' (.+?) '"'/) { $0.Str } }).flat;

    # Check if captions are found
    if !@captionURLs {
        note "No captions available for this video.";
        return Nil;
    }

    # Fetch the first caption track
    my $transcript = try $ua.get(@captionURLs[0]).content;
    if $! {
        note "No transcript text found.";
        return Nil;
    }

    return do given $format.lc {

        when 'text' {
            my @lines = do with $transcript.match(/ '<text start=' .+? '>' $<content>=(.*?) '</text>' /):g { $/».<content>».Str };
            @lines.join("\n").subst( '&amp;#39;', '\''):g
        }

        when $_ ∈ <dataset json> {
            my @records = do with $transcript.match(/ '<text start="' $<time>=(.+?) '"' \s* 'dur="' $<duration>=(.+?) '">' $<content>=(.*?) '</text>' /):g {
                $/.map({ %( time => $_<time>.Numeric, duration => $_<duration>.Numeric, content => $_<content>.Str.subst( '&amp;#39;', '\''):g ) })
            };

            $_ eq 'json' ?? to-json(@records) !! @records
        }
    }
}