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

Summarize using a Large Language Model (LLM):

```raku
use LLM::Functions;
use LLM::Prompts;

llm-synthesize(llm-prompt('Summarize')($transcript), e => 'Gemini')
```

-----

## CLI

The package provides a Command Line Interface (CLI) script. Here is its usage message:

```shell
youtube-transcript --help
```

-----

## References

[AAf1] Anton Antonov,
[YouTubeTranscript](https://www.wolframcloud.com/obj/antononcube/DeployedResources/Function/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).