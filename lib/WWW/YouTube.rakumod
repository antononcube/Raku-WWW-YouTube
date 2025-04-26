use v6.d;

use HTTP::UserAgent;

#| Get transcript of a video.
sub youtube-transcript(Str:D $videoID) is export {
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

    my @lines = do with $transcript.match(/ '<text start=' .+? '>' $<content>=(.*?) '</text>' /):g { $/».<content>».Str };

    # Return formatted transcript
    @lines .= join("\n");
    return @lines.subst( '&amp;#39;', '\''):g;
}

#| Get the video IDs of a playlist.
sub youtube-playlist(Str:D $playlistID) is export {
    # Construct video playlist URL
    my $pre = 'https://www.youtube.com/watch?list=';
    my $url = $playlistID ~~ / 'https://www.youtube.com/' ('watch' | 'playlist') '?list=' / ?? $playlistID !! $pre ~ $playlistID;

    # Fetch the video page
    my $ua = HTTP::UserAgent.new;
    my $page = try $ua.get($url).content;
    if $! {
        note "Cannot fetch video playlist page.";
        return Nil;
    }

    my @videoIDs = do with $page.match(/ '"videoId":"' $<vid>=(.+?) '"' /):g { $/».<vid>».Str  };

    return @videoIDs;
}