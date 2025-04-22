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
```
# 37996
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
# This language design review focuses on LLM graphs, a new feature for version 14.3, designed to orchestrate LLM calls and support complex workflows, including asynchronous operations. The LLM graph allows users to chain LLM calls together, with nodes representing LLM functions, and can be applied asynchronously. Key features include the ability to define inputs, conditions, and outputs, along with the option for listable and template-based functionality.
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