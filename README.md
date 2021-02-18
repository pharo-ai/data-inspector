# Description

A little Pharo tool to operate and view DataFrame info in a same inspector view. It shows the DataFrame in the upper part, and an Evaluator with two views: One with the data frame basic statistics, and another one to describe basic data frame information such as dimensions, if has nil values, etc.

# Installation

```smalltalk
Metacello new
	baseline: 'AIGT';
	repository: 'github://pharo-ai/data-inspector/src';
	load.
```

# If you want to depend on it

```smalltalk
spec 
   baseline: 'AIGT' 
   with: [ spec repository: 'github://pharo-ai/data-inspector/src' ].
```

# Usage

Just inspect any DataFrame and select the palette with "Data Inspector":

