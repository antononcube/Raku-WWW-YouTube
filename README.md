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


----

## Details

- `youtube-transcript` extracts the captions of the video, if they exist.

- The transcript is returned as plain text.

- The YouTube Data API has usage quotas.

- Not all YouTube videos have automatic or manual captions. If no captions are available, the function returns a message indicating this.

- `youtube-transcript` processes "captionTracks" of the YouTube Data API, which is a field of YouTube's video metadata.

- The field "captionTracks" is an array of objects, where each object represents a single caption track (e.g., for a specific language or type).

- From "captionTracks" the "baseURL" string is extracted, which is the URL to fetch the caption content.

-----

## Examples

```raku
use WWW::YouTube;

my $transcript = youtube-transcript('ewU83vHwN8Y');

say $transcript.chars;

say $transcript.substr(^300);
```
```
# 35820
# hi everyone welcome to a wolf from
# language design review for version 14.3
# we are talking about LLM
# graph so
# okay so this is for the purpose of of
# knitting together LLM calls like LLM
# function type calls
# exactly
# to support more complex workflows
# um and and to have asynchronous calls to
# LLMs
# yes to w
```

Summarize using a Large Language Model (LLM):

```raku
use LLM::Functions;
use LLM::Prompts;

llm-synthesize(llm-prompt('Summarize')($transcript), e => 'Gemini')
```
```
# This language design review for LLM graphs in version 14.3 introduces a system for orchestrating LLM calls, enabling complex workflows and asynchronous execution.  The core concept involves nodes with prompts that can depend on each other, offering a powerful update to LLM synthesize and a stepping stone to more agentic workflows.  The design includes features like "listable template" and "node function" for enhanced functionality, with an "LLM graph submit" function for execution.
```

-----

## CLI

The package provides a Command Line Interface (CLI) script. Here is its usage message:

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
  - [ ] TODO Different output formats
    - [X] DONE Text
    - [ ] TODO JSON,
    - [ ] TODO Pretty
    - [ ] TODO WebVTT
    - [ ] TODO SRT
  - [ ] TODO Video metadata retrieval
  - [ ] TODO Video identifiers for a playlist
- [ ] TODO Documentation
  - [X] DONE Basic usage
  - [ ] TODO Transcripts retrieval for a playlist

-----

## References

[AAf1] Anton Antonov,
[YouTubeTranscript](https://www.wolframcloud.com/obj/antononcube/DeployedResources/Function/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).