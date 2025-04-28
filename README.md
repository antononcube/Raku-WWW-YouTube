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
```
# 36700
# Hi everyone, welcome to a wolf from
# language design review for version 14.3.
# We are talking about LLM
# graph. So,
# okay. So this is for the purpose of of
# knitting together LLM calls like LLM
# function type calls.
# Exactly.
# To support more complex workflows
# um and and to have asynchronous calls to
# LLMs.
```

Summarize using a Large Language Model (LLM):

```raku
use LLM::Functions;
use LLM::Prompts;

llm-synthesize(llm-prompt('Summarize')($transcript), e => 'Gemini')
```
```
# This design review introduces LLM graphs, which orchestrate LLM calls for complex workflows and asynchronous operations.  LLM graphs use nodes containing prompts or code, with dependencies between them, and offer both synchronous and asynchronous evaluation.  Key features include LLM function and node function for different types of operations, and a "listable" option for parallel processing of inputs.
```

### Playlists

```raku
youtube-playlist('PLke9UbqjOSOiMnn8kNg6pb3TFWDsqjNTN')
```
```
# (9xp1XWmJ_Wo S_3e7liz4KM 5qXgqqRZHow THh4fT0O7IY 15gn_V6ltyU q4iwzxwEts8 9Zq79uu_o5E Bh_QhurLUwU JFvrcd4VVkU -UMx24FWKGs OwjqdzuovY0 qT9neos0YDk kjEms2Mk0Js 4fezP875xOQ v6Hby8-TZSE _bLX5WfDQfM ARCb-UcNm1s ONcY0BM5EAg BYMqvahuFUQ cYM0qTPFyKc kYissYTEjww 0UN_HbOTTcI OQ3EvRcTS6c fwQrQyWC7R0 E7qhutQcWCY kQo3wpiUu6w JHO2Wk1b-Og 0uJl9q7jIf8)
```

-----

## CLI

The package provides a Command Line Interface (CLI) scripts. Here are their usage messages:

```shell
youtube-transcript --help
```
```
# Usage:
#   youtube-transcript <id> -- Get YouTube transcripts.
#   
#     <id>    Video identifier
```

```shell
youtube-playlist --help
```
```
# Usage:
#   youtube-playlist <id> -- Get video identifiers of a YouTube playlist.
#   
#     <id>    Video playlist identifier
```

-----

## TODO

- [ ] TODO Implementation
  - [X] DONE Get transcript for a video identifier
  - [ ] TODO Different output formats
    - [X] DONE Text
    - [ ] TODO JSON
    - [ ] TODO Pretty
    - [ ] TODO WebVTT
    - [ ] TODO SRT
  - [ ] TODO Video identifiers for a playlist
    - Only partially implemented: additional video IDs are included in the results.
  - [ ] TODO Video metadata retrieval
- [ ] TODO Documentation
  - [X] DONE Basic usage
  - [ ] TODO Transcripts retrieval for a playlist

-----

## References

[AAf1] Anton Antonov,
[YouTubeTranscript](https://www.wolframcloud.com/obj/antononcube/DeployedResources/Function/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).