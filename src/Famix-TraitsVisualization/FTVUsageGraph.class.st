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
FTVUsageGraph >> buildVisualization [

	| cycleCalculator |
	self flag: '12/7/20 - To remove if PR in Telescope is accepted'.
	cycleCalculator := self cycleCalculator.

	(self > #packages) styleSheet backgroundColor: [ :namespace | 
		(cycleCalculator findNode: namespace) isInCycle
			ifTrue: [ self highlightColorForNode: namespace ]
			ifFalse: [ self defaultColorForNode: namespace ] ].

	self widthBlock ifNotNil: [ :blk | 
		(self > #packages) styleSheet width: blk ].
	self heightBlock ifNotNil: [ :blk | 
		(self > #packages) styleSheet height: blk ].

	self styleSheet > #connection backgroundColor: self edgeColor.

	(self > #packages)
		addNodesFromEntities: self entities;
		connectFollowingProperty: self property;
		addInteraction: self popup;
		layout: self nodesLayout
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
