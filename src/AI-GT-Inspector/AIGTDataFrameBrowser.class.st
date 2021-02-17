Class {
	#name : #AIGTDataFrameBrowser,
	#superclass : #GLMCompositePresentation,
	#instVars : [
		'cachedHashes'
	],
	#category : #'AI-GT-Inspector'
}

{ #category : #building }
AIGTDataFrameBrowser >> compose [

	self title: 'Data Evaluator'.
	self tabulator with: [ :browser |
		browser 
			row: #dataFrame; 
			row: #evaluator.
		self composeDataPane: browser.
		self composeOperationsPane: browser.
		browser transmit 
			from: #dataFrame; 
			toOutsidePort: #selection; 
			transformed: [ :aNode | aNode ifNotNil: [aNode value]].
		browser transmit 
			from: #evaluator; 
			toOutsidePort: #selection ].
	self wantsAutomaticRefresh: true
]

{ #category : #building }
AIGTDataFrameBrowser >> composeDataPane: browser [

	browser transmit 
		to: #dataFrame; 
		andShow: [ : a | 
			a morph display: [ : anObject | self dataFrameIn: anObject  ] ].
]

{ #category : #building }
AIGTDataFrameBrowser >> composeOperationsPane: browser [

	browser transmit 
		to: #evaluator; 
		andShow: [: sub | 
			sub tabulator with: [ : b |
				b
					column: #evalPane;
					column: #summary.
				b transmit
					to: #evalPane;
					andShow: [ :a | self evaluatorIn: a ].
				b transmit 
					to: #summary;
					andShow: [ : a | self summaryDisplayIn: a ] ] ]
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> dataFrameIn: composite [
	| table headerNames |

	table := FTTableMorph new.
	"extent: 650@500"
	table
		beResizable;
		intercellSpacing: 1;
		dataSource: (DataFrameFTData elements: self entity);
		onAnnouncement: FTSelectionChanged
			do: [ :ann | (self entity rowAt: ann newSelectedIndexes first) inspect ].

	"		onAnnouncement: FTSelectionChanged 
			do: [ :ann | (self rowsAt: ann newSelectedRowIndexes) gtInspectorItemsIn: composite ];"
	headerNames := #('#') , self entity columnNames.
	table
		columns: (headerNames collect: [ :name | (FTColumn id: name) width: 100 ]).
	^ table
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> evaluatorIn: composite [

	composite pharoScript
		doItReceiver: [ :object | object ];
		smalltalkClass: [ :object | object class ];
		display: [ :object | 
			String streamContents: [ :stream | 
				stream 
					nextPutAll: (self printStringOf: object);
					cr;
					nextPutAll: (GTSnippets snippetAt: object class)] ];
		onChangeOfPort: #text act: [ :textPresentation :object |
				GTSnippets 
					snippetAt: object class 
					put: (self stringWithoutInitialCommentFrom: textPresentation text asString).
				 textPresentation clearUserEdits ];
		installDefaultSelectionActions
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> iconFor: anObject [
		
	^ [ (anObject gtInspectorIcon)
		ifNil: [ anObject class systemIcon ] ]
			on: Error do: [ :error | self iconFor: anObject error: error ]
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> iconFor: anEyeElement error: error [
	^ self iconNamed: #smallWarningIcon
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> printStringOf: anObject [
	| className |
	className := anObject class name.
	^ (String streamContents: [ :s |
		s
			nextPutAll: (className first isVowel ifTrue: ['an '] ifFalse: ['a ']);
			nextPutAll: className ]) asComment
]

{ #category : #stepping }
AIGTDataFrameBrowser >> requestRefresh [
	(self presentations first paneNamed: #dataFrame) presentations requestRefresh
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> stringWithoutInitialCommentFrom: aString [
	^ (aString trimLeft isEmpty not and: [ aString trimLeft first = $" ])
		ifFalse: [ aString trimRight ]
		ifTrue: [|startIndex doubleQuoteCounter|
			startIndex := aString findAnySubstring: '"' startingAt: (aString indexOf: $") + 1.
			doubleQuoteCounter := 1.
			"we need to iterate over the whole string queuing quotes to support nested double quotes"
			[ startIndex <= aString size
				and: [ doubleQuoteCounter % 2 = 1
					or: [ (aString at: startIndex) = $"
						or: [ (aString at: startIndex) isSeparator ] ] ] ]
			whileTrue: [ 
				(aString at: startIndex) = $" ifTrue: [ 
					doubleQuoteCounter := doubleQuoteCounter + 1 ].
				startIndex := startIndex + 1 ].
	
			(startIndex >= (aString size + 1)) ifTrue: [ "No content if a comment cannot be identified. " ^ '' ].
			(aString
				copyFrom: startIndex
				to: aString size) trimBoth ]
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> summaryDescriptorsAt: aDataFrame [

	^ Dictionary new
		at: 'Dimensions' put: #dimensions;
		yourself
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> summaryDescriptorsFrom: aDataFrame [

	^ { 'Dimensions' } 
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> summaryDisplayIn: composite [

	composite fastTable
		beMultiple;
		wantsAutomaticRefresh: true;
		display: [ : aDataFrame | self summaryDescriptorsFrom: aDataFrame  ];
		column: 'Type'
			evaluated: [ '' ]
			width: 75
			tags: [ : anObject  | anObject ]
			sortedBy: [ :x :y |  x variableTag < y  variableTag ];
		column: 'Value' 
			evaluated: [ : aString |  GTObjectPrinter asNonTruncatedTextFrom: (self summaryDescriptorsAt: aString) ]
			width: 175
]

{ #category : #'private building' }
AIGTDataFrameBrowser >> summaryItemsFrom: aDataFrame [

	^ { 
		aDataFrame dimensions  } 
]
