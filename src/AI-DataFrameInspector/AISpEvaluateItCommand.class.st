"
I am a command that can be converted into a button to be used in the toolbar of the evaluator
"
Class {
	#name : #AISpEvaluateItCommand,
	#superclass : #AISpAbstractToolbarCommand,
	#category : #'AI-DataFrameInspector-Toolbar evaluator commands'
}

{ #category : #default }
AISpEvaluateItCommand class >> defaultDescription [

	^ 'Do it all and print it.'
]

{ #category : #initialization }
AISpEvaluateItCommand class >> defaultIconName [

	^ #smallDoIt
]

{ #category : #default }
AISpEvaluateItCommand class >> defaultName [

	^ 'Do it'
]

{ #category : #accessing }
AISpEvaluateItCommand class >> order [

	^ 0
]

{ #category : #converting }
AISpEvaluateItCommand >> asSpecCommand [

	^ super asSpecCommand
		  iconName: self class defaultIconName;
		  yourself
]

{ #category : #executing }
AISpEvaluateItCommand >> execute [
	
	| evaluatingResult |

	context evaluatorPresenter selectAll.
	
	evaluatingResult := context evaluatorPresenter 
		evaluate: context evaluatorPresenter selectedTextOrLine
		onCompileError: [ ^ self ]
		onError: [ :e | e pass ].
	
	context evaluatorPresenter insertPrintPopoverAfterCurrentSelection: evaluatingResult
]
