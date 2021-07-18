[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/data-inspector/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/data-inspector?branch=master)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/data-inspector/master/LICENSE)

# Description

A little Pharo tool to operate and view DataFrame info in a same inspector view. It shows the DataFrame in the upper part, and an Evaluator with two views: One with the data frame basic statistics, and another one to describe basic data frame information such as dimensions, if has nil values, etc.

# Installation

```smalltalk
EpMonitor disableDuring: [ 
	Metacello new
		baseline: 'AIDataInspector';
		repository: 'github://pharo-ai/data-inspector/src';
		load ]
```

# If you want to depend on it

```smalltalk
spec 
   baseline: 'AIDataInspector' 
   with: [ spec repository: 'github://pharo-ai/data-inspector/src' ].
```

# Usage

Just inspect any DataFrame and select the palette with "Data Inspector":

```smalltalk
EpMonitor disableDuring: [ 
	Metacello new
		baseline: 'AIDatasets';
		repository: 'github://pharo-ai/datasets';
		load ].

AIDatasets loadIris inspect.
```

![data-inspector-screenshot](https://user-images.githubusercontent.com/4825959/126080714-59abffd3-0d3b-4ed9-a860-13bb77bd7a9b.png)
