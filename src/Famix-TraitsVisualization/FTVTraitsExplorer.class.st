Class {
	#name : #FTVTraitsExplorer,
	#superclass : #SpPresenter,
	#instVars : [
		'traitsList',
		'view'
	],
	#category : #'Famix-TraitsVisualization'
}

{ #category : #specs }
FTVTraitsExplorer class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		  add: #traitsList;
		  position: 150;
		  add: #view;
		  yourself
]

{ #category : #'instance creation' }
FTVTraitsExplorer class >> open [

	<script>
	self new openWithSpec
]

{ #category : #specs }
FTVTraitsExplorer class >> title [

	^ 'Traits Visualization'
]

{ #category : #specs }
FTVTraitsExplorer class >> windowSize [
	^ 600 @ 600
]

{ #category : #visualization }
FTVTraitsExplorer >> buildVisualizationFor: aTrait [

	| visualization |
	visualization := self newVisualizationFor: aTrait.
	view script: [ :canvas | 
		canvas @ RSCanvasController new noLegend ].
	visualization generator view: view canvas.
	visualization generateWith: visualization generator.
	view canvas zoomToFit
]

{ #category : #initialization }
FTVTraitsExplorer >> initializePresenters [

	super initializePresenters.
	traitsList := self newList
		              items: self traits;
		              sortingBlock: [ :t1 :t2 | t1 name < t2 name ];
		              whenSelectionChangedDo: [ :selection | 
			              self buildVisualizationFor: selection selectedItem ].
	view := SpRoassalPresenter new
]

{ #category : #initialization }
FTVTraitsExplorer >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	aWindowPresenter initialExtent: self class windowSize
]

{ #category : #visualization }
FTVTraitsExplorer >> newVisualizationFor: aTrait [

	| visualization |
	visualization := TLCycleDependencies new
		                 entities: (self traitsToShowAround: aTrait);
		                 property: [ :trait | trait traitComposition traits ].

	(visualization > #packages) styleSheet borderColor: [ :trait | 
		trait = aTrait
			ifTrue: [ Color red ]
			ifFalse: Color black ].

	"(visu > #packages) styleSheet
		nodeLabel: [ :trait | trait name withoutPrefix: 'Famix' ];
		adaptNodeWidthFromLabel;
		nodeLabelMaxWidth: 100."

	"visualization > #packages addInteraction:
		((TLCustomAction block: [ :node | node entity browse ]) withMenu:
			 'Browse')."

	visualization > #packages addInteraction:
		(TLCustomAction block: [ :node | node entity browse ]) onRightClick.

	^ visualization
]

{ #category : #helpers }
FTVTraitsExplorer >> traits [

	self flag: 'Probably a better way'.
	^ ((RPackageOrganizer default packageNamed: 'Famix-Traits') classes
	   , (RPackageOrganizer default packageNamed: 'Moose-Query') classes 
		   select: #isTrait) asOrderedCollection
]

{ #category : #helpers }
FTVTraitsExplorer >> traitsToShowAround: aTrait [

	^ { 
		  aTrait.
		  (aTrait allUsers flattened select: #isTrait).
		  aTrait traitComposition allTraits } flattened asSet
]
