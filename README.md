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

- `youtube-metdata` extracts the metadata associated with a YouTube video identifier.

- `youtube-playlist` extracts the video identifiers of a given YouTube playlist identifier.

- `youtube-transcript` extracts the captions of the video, if they exist.

  - The transcript is returned as plain text.

  - The YouTube Data API has usage quotas.

  - Not all YouTube videos have automatic or manual captions. If no captions are available, the function returns a message indicating this.

- `youtube-transcript` processes "captionTracks" of the YouTube Data API, which is a field of YouTube's video metadata.

  - The field "captionTracks" is an array of objects, where each object represents a single caption track (e.g., for a specific language or type).

  - From "captionTracks" the "baseURL" string is extracted, which is the URL to fetch the caption content.

- The subs `youtube-metadata`, `youtube-playlist`, and `youtube-transript` work with strings that are identifiers or (full) URLs.

-----

## Examples

### Metaadata

Get the metadata associated with a YouTube video identifier:

```raku, results=asis
use WWW::YouTube;
use Data::Translators;

youtube-metadata('S_3e7liz4KM') 
==> to-html(align => 'left')
```
<table border="1"><tr><th>view-count</th><td align=left>139 views</td></tr><tr><th>title</th><td align=left>Graph neat examples in Raku (Set 3)</td></tr><tr><th>publish-date</th><td align=left>2024-11-28T11:24:44-08:00</td></tr><tr><th>description</th><td align=left>Computationally neat examples with Raku packages featuring graphs and graph plots. (3rd set.)\n\nHere is the presentation Jupyter notebook: https://github.com/antononcube/RakuForPrediction-blog/blob/main/Presentations/Notebooks/Graph-neat-examples-set-3.ipynb\n\n------------------\n\nPlease, consider buying me a coffee: https://buymeacoffee.com/antonov70</td></tr><tr><th>channel-title</th><td align=left>N/A</td></tr></table>


### Transcripts

```raku
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
# This design review introduces LLM graphs, which orchestrate calls to large language models (LLMs) to support complex, asynchronous workflows.  LLM graphs use nodes containing prompts or code (node functions) and can chain LLM calls, with outputs defined by terminal nodes.  The discussion also covers features like listable templates, conditional execution, and the distinction between LLM functions and regular code functions, as well as the related concept of graph evaluation.
```

### Playlists

```raku
youtube-playlist('PLke9UbqjOSOiMnn8kNg6pb3TFWDsqjNTN')
```
```
# [fwQrQyWC7R0 S_3e7liz4KM E7qhutQcWCY kQo3wpiUu6w JHO2Wk1b-Og 5qXgqqRZHow 0uJl9q7jIf8]
```

-----

## CLI

The package provides Command Line Interface (CLI) scripts. Here are their usage messages:

```shell
youtube-metadata --help
```
```
# Usage:
#   youtube-metadata <id> -- Get YouTube video metadata.
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

```shell
youtube-transcript --help
```
```
# Usage:
#   youtube-transcript <id> -- Get YouTube transcripts.
#   
#     <id>    Video identifier
```

-----

## TODO

- [ ] TODO Implementation
  - [X] DONE Get transcript for a video identifier
  - [X] DONE Video identifiers for a playlist
  - [X] DONE Video metadata retrieval
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
[YouTubeTranscript](https://resources.wolframcloud.com/FunctionRepository/resources/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).