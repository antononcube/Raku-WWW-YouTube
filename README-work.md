# Raku-WWW-YouTube

Raku package for getting metadata and transcripts of YouTube videos.

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

## Usage examples

```raku
use WWW::YouTube;

my $transcript = youtube-transcript('ewU83vHwN8Y');

say $transcript.chars;

say $transcript.substr(^300);
```

Summarize using a Large Language Model (LLM):

```raku
use LLM::Funcitons;
use LLM::Prompts;

llm-synthesize(llm-prompt('Summarize')($transcript), e => 'Gemini')
```

-----

## CLI

***TBD...***

-----

## References

[AAf1] Anton Antonov,
[YouTubeTranscript](https://www.wolframcloud.com/obj/antononcube/DeployedResources/Function/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).