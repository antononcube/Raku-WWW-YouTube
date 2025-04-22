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

## Usage examples

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
# This discussion reviews the design of LLM graph, a tool for orchestrating LLM calls to create more complex workflows and asynchronous calls. The LLM graph uses nodes with prompts and dependencies, offering features like listable templates and conditional execution.  The design incorporates LLM function, node function, and test function, and the output is an association with results from each node.
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

## References

[AAf1] Anton Antonov,
[YouTubeTranscript](https://www.wolframcloud.com/obj/antononcube/DeployedResources/Function/YouTubeTranscript/),
(2025),
[Wolfram Function Repository](https://resources.wolframcloud.com/FunctionRepository/).