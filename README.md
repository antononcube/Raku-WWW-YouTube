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
<table border="1"><tr><th>description</th><td align=left>Computationally neat examples with Raku packages featuring graphs and graph plots. (3rd set.)\n\nHere is the presentation Jupyter notebook: https://github.com/antononcube/RakuForPrediction-blog/blob/main/Presentations/Notebooks/Graph-neat-examples-set-3.ipynb\n\n------------------\n\nPlease, consider buying me a coffee: https://buymeacoffee.com/antonov70</td></tr><tr><th>channel-title</th><td align=left>N/A</td></tr><tr><th>publish-date</th><td align=left>2024-11-28T11:24:44-08:00</td></tr><tr><th>view-count</th><td align=left>139 views</td></tr><tr><th>title</th><td align=left>Graph neat examples in Raku (Set 3)</td></tr></table>


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
# This design review discusses the creation of an LLM graph, a tool for orchestrating and managing asynchronous calls to LLMs, supporting complex workflows. The LLM graph allows for chaining LLM functions, which can be templates or code, and includes features like conditional execution and list processing. The review also covers the syntax, including the use of "LLM function" for LLM calls, "node function" for code, and "test function" for conditional logic within the graph.
```

Get the transcript as a dataset:

```raku, results=asis
my @t = youtube-transcript('S_3e7liz4KM', format => 'dataset');

@t.head(10) ==> to-html(field-names => <time duration content>, align => 'left')
```
<table border="1"><thead><tr><th>time</th><th>duration</th><th>content</th></tr></thead><tbody><tr><td align=left>0.52</td><td align=left>4.64</td><td align=left>this presentation is titled graph neat</td></tr><tr><td align=left>2.8</td><td align=left>5.2</td><td align=left>examples in Raku set</td></tr><tr><td align=left>5.16</td><td align=left>4.84</td><td align=left>three my name is Anton Antonov today&#39;s</td></tr><tr><td align=left>8</td><td align=left>5</td><td align=left>November 28th</td></tr><tr><td align=left>10</td><td align=left>6</td><td align=left>2024 I have prepared two sets of</td></tr><tr><td align=left>13</td><td align=left>6.68</td><td align=left>examples nested graphs and file system</td></tr><tr><td align=left>16</td><td align=left>5.72</td><td align=left>graphs the neat examples in general are</td></tr><tr><td align=left>19.68</td><td align=left>3.96</td><td align=left>defined as concise or straightforward</td></tr><tr><td align=left>21.72</td><td align=left>3.76</td><td align=left>code that produce compelling visual</td></tr><tr><td align=left>23.64</td><td align=left>4.399</td><td align=left>textual outputs I&#39;m going to be</td></tr></tbody></table>


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
#   youtube-metadata <id> [--format=<Str>] -- Get YouTube video metadata.
#   
#     <id>              Video identifier
#     --format=<Str>    Format of the result, one of 'json', 'raku', 'asis'. [default: 'json']
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