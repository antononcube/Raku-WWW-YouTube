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

`youtube-metadata($id)`

- Get the metadata of the YouTube video with identifier `$id`.

`youtube-playlist($id)`

- Get the video identifiers of the YouTube playlist with identifier `$id`.

`youtube-transcript($id)`

- Get the transcript of the YouTube video with identifier `$id`.

----

## Details

- All three subs, `youtube-metadata`, `youtube-playlist`, and `youtube-transript`, 
  work with strings that are identifiers or (full) URLs.

- `youtube-metdata` extracts the metadata associated with a YouTube video identifier.
  
  - Returns a record (hashmap) with keys `<channel-title description publish-date title view-count>`. 

- `youtube-playlist` extracts the video identifiers of a given YouTube playlist identifier.

  - *Currently, gives only the first 100 videos.* 

- `youtube-transcript` extracts the captions of the video, if they exist.

  - The transcript can be returned as plain text, array of hashmaps, JSON string.

  - The YouTube Data API has usage quotas.

  - Not all YouTube videos have automatic or manual captions. If no captions are available, the function returns a message indicating this.

- `youtube-transcript` processes "captionTracks" of the YouTube Data API, which is a field of YouTube's video metadata.

  - The field "captionTracks" is an array of objects, where each object represents a single caption track (e.g., for a specific language or type).

  - From "captionTracks" the "baseURL" string is extracted, which is the URL to fetch the caption content.

-----

## Examples

### Metadata

Get the metadata associated with a YouTube video identifier:

```raku, results=asis
use WWW::YouTube;
use Data::Translators;

youtube-metadata('S_3e7liz4KM') 
==> to-html(align => 'left')
```

### Transcripts

```raku
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

Get the transcript as a dataset:

```raku, results=asis
my @t = youtube-transcript('S_3e7liz4KM', format => 'dataset');

@t.head(10) ==> to-html(field-names => <time duration content>, align => 'left')
```

### Playlists

```raku
youtube-playlist('PLke9UbqjOSOiMnn8kNg6pb3TFWDsqjNTN')
```

-----

## CLI

The package provides Command Line Interface (CLI) scripts. Here are their usage messages:

```shell
youtube-metadata --help
```

```shell
youtube-playlist --help
```

```shell
youtube-transcript --help
```

-----

## TODO

- [ ] TODO Implementation
  - [X] DONE Get transcript for a video identifier
  - [X] DONE Video metadata retrieval
  - [ ] TODO Video identifiers for a playlist
    - [X] DONE For playlists with ≤ 100 videos
    - [ ] TODO Large playlists
  - [ ] TODO Different transcript output formats
    - [X] DONE Text
    - [X] DONE Dataset (array of hashmap records)
    - [X] DONE JSON
    - [ ] TODO WebVTT
    - [ ] TODO SRT
  - [ ] Implement versions of the subs using a YouTube API key
- [ ] TODO Documentation
  - [X] DONE Basic usage
  - [ ] TODO Transcripts retrieval for a playlist

-----

## References

[AAf1] Anton Antonov,
[YouTubeTranscript](https://resources.wolframcloud.com/FunctionRepository/resources/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).