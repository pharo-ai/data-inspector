[![Build status](https://github.com/pharo-ai/data-inspector/workflows/CI/badge.svg)](https://github.com/pharo-ai/data-inspector/actions/workflows/CI.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/data-inspector/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/data-inspector?branch=master)
[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/data-inspector/master/LICENSE)

# Description

A Pharo inspector extension to operate and view DataFrame multiple information in a same inspector view. Currently it displays:

A configurable limit is set by default to quickly visualize a DataFrame. To change the limit, for example to 50000, you can evaluate:

```smalltalk
AISpDataFrameInspector maxRows: 50000
```

# Installation

```smalltalk
EpMonitor disableDuring: [ 
	Metacello new
		baseline: 'AIDataFrameInspector';
		repository: 'github://pharo-ai/data-inspector/src';
		onConflictUseIncoming;
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

![Capture d’écran 2022-08-16 à 19 02 33](https://user-images.githubusercontent.com/33934979/184937228-37bdc3ce-58ef-4009-999c-10524ef81843.png)

![Capture d’écran 2022-08-16 à 19 02 42](https://user-images.githubusercontent.com/33934979/184937251-590b12b2-5344-4f36-b043-deec1ccfce3a.png)

It is also possible to visualize the historigrams of a DataFrame or a DataSeries like this

```st
iris := AIDatasets loadIris.

iris historigrams.
(iris column: #'petal length (cm)') historigram.
```