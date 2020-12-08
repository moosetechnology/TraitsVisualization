Class {
	#name : #FTVUsageGraph,
	#superclass : #TLCycleDependencies,
	#instVars : [
		'mainTrait'
	],
	#category : #'Famix-TraitsVisualization-Telescope'
}

{ #category : #configuration }
FTVUsageGraph >> borderColorFor: aTrait [

	^ FTVTraitsTagging new colorForTrait: aTrait
]

{ #category : #configuration }
FTVUsageGraph >> defaultColorForNode: aTrait [

	^ mainTrait = aTrait
		  ifTrue: [ Color lightBlue ]
		  ifFalse: [ Color white ]
]

{ #category : #initialization }
FTVUsageGraph >> forTrait: aTrait [

	mainTrait := aTrait.
	self
		entities: (self traitsToShowAround: aTrait);
		property: [ :trait | trait traits ]
]

{ #category : #configuration }
FTVUsageGraph >> popup [

	^ (TLPopUpAction new textBlock: [ :t | FTVTraitsTagging new kind: t ])
		  onMouseOver
]

{ #category : #initialization }
FTVUsageGraph >> traitsToShowAround: aTrait [

	^ { 
		  aTrait.
		  (aTrait allUsers flattened select: #isTrait).
		  aTrait traitComposition allTraits } flattened asSet
]
