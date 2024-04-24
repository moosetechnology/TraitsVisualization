Class {
	#name : #FTVUsageGraph,
	#superclass : #TLCycleDependencies,
	#instVars : [
		'mainTrait'
	],
	#category : #'TraitsVisualization-Telescope'
}

{ #category : #configuration }
FTVUsageGraph >> borderColorFor: aTrait [

	^ FTVTraitsTagging new colorForTrait: aTrait
]

{ #category : #building }
FTVUsageGraph >> buildVisualization [

	super buildVisualization.
	(self > #packages) styleSheet borderColor: [ :trait |
		self borderColorFor: trait ].

	(self > #packages) styleSheet
		nodeLabel: [ :trait | trait name withoutPrefix: 'Famix' ];
		adaptNodeWidthFromLabel;
		nodeLabelMaxWidth: 100.

	"self > #packages addInteraction:
		((TLCustomAction block: [ :node | node entity browse ]) withMenu:
			 'Browse')."
	self > #packages addInteraction:
		(TLCustomAction block: [ :node | node entity browse ]) onRightClick
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
