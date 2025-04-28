# WWW::YouTube

Raku package for getting metadata and transcripts of YouTube videos.

The Raku implementation closely follows the Wolfram Language function `YouTubeTranscript`, [AAf1]. 

------

## Installation 

From [Zef ecosystem](https://raku.land):

```
zef install WWW::YouTube
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-WWW-YouTube.git
```

-----

## Usage

Get the transcript of the YouTube video with identifier `$id`:

`youtube-transcript($id)` 

Get the video identifiers of the YouTube playlist with identifier `$id`:

`youtube-playlist($id)`


----

## Details

- `youtube-transcript` extracts the captions of the video, if they exist.

- The transcript is returned as plain text.

- The YouTube Data API has usage quotas.

- Not all YouTube videos have automatic or manual captions. If no captions are available, the function returns a message indicating this.

- `youtube-transcript` processes "captionTracks" of the YouTube Data API, which is a field of YouTube's video metadata.

- The field "captionTracks" is an array of objects, where each object represents a single caption track (e.g., for a specific language or type).

- From "captionTracks" the "baseURL" string is extracted, which is the URL to fetch the caption content.

- `youtube-playlist` extracts the video identifiers of a given YouTube playlist identifier.

- Both `youtube-transript` and `youtube-playlist` work with strings that are identifiers or (full) URLs.

-----

## Examples

### Transcripts

```raku
use WWW::YouTube;

my $transcript = youtube-transcript('ewU83vHwN8Y');

say $transcript.chars;

say $transcript.substr(^300);
```

Summarize using a Large Language Model (LLM):

```raku
use LLM::Functions;
use LLM::Prompts;

llm-synthesize(llm-prompt('Summarize')($transcript), e => 'Gemini')
```

### Playlists

```raku
youtube-playlist('PLke9UbqjOSOiMnn8kNg6pb3TFWDsqjNTN')
```

-----

## CLI

The package provides a Command Line Interface (CLI) scripts. Here are their usage messages:

```shell
youtube-transcript --help
```

```shell
youtube-playlist --help
```

-----

## TODO

- [ ] TODO Implementation
  - [X] DONE Get transcript for a video identifier
  - [X] DONE Video identifiers for a playlist
  - [ ] TODO Video metadata retrieval
  - [ ] TODO Different transcript output formats
    - [X] DONE Text
    - [ ] TODO JSON
    - [ ] TODO Pretty
    - [ ] TODO WebVTT
    - [ ] TODO SRT
- [ ] TODO Documentation
  - [X] DONE Basic usage
  - [ ] TODO Transcripts retrieval for a playlist

-----

## References

[AAf1] Anton Antonov,
[YouTubeTranscript](https://www.wolframcloud.com/obj/antononcube/DeployedResources/Function/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).