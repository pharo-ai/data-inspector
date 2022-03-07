[![Build status](https://github.com/pharo-ai/data-inspector/workflows/CI/badge.svg)](https://github.com/pharo-ai/data-inspector/actions/workflows/CI.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/data-inspector/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/data-inspector?branch=master)
[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/data-inspector/master/LICENSE)

# Description

A Pharo inspector extension to operate and view DataFrame multiple information in a same inspector view. Currently it displays:

- The DataFrame in the upper part.
- In the middle part, an Evaluator with a summary data table (basic statistics).
- A lower part with Roassal histograms for each column and a data table which describes basic data frame information such as dimensions, if has nil values, etc.

A configurable limit is set by default to quickly visualize a DataFrame. To change the limit, for example to 50000, you can evaluate:

```smalltalk
AISpDataFrameInspector maxRows: 50000
```

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

![data-inspector-screenshot](https://user-images.githubusercontent.com/4825959/143688886-49ee898b-1bcf-4ef3-aadb-245708df6d8b.gif)

![Capture d’écran 2022-03-07 à 17 39 37](https://user-images.githubusercontent.com/33934979/157077758-49fd5b65-29de-47de-8559-a549cfc49357.png)
