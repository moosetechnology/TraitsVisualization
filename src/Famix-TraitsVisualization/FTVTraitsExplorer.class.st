Class {
	#name : #FTVTraitsExplorer,
	#superclass : #SpPresenter,
	#instVars : [
		'traitsList',
		'view',
		'categories'
	],
	#category : #'Famix-TraitsVisualization'
}

{ #category : #specs }
FTVTraitsExplorer class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		  add: (SpPanedLayout newHorizontal
				   add: #categories;
				   add: #traitsList;
				   yourself);
		  position: 300;
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
	^ 900 @ 600
]

{ #category : #visualization }
FTVTraitsExplorer >> buildBoxesVisualizationFor: aTrait [

	view script: [ :canvas | 
		FTVExpandingBoxes new
			canvas: canvas;
			children: [ :trait | trait traits ];
			addItem: aTrait ].

	view canvas zoomToFit
]

{ #category : #visualization }
FTVTraitsExplorer >> buildTreeVisualizationFor: aTrait [

	| visualization |
	visualization := self treeVisualizationFor: aTrait.
	view script: [ :canvas | 
		canvas @ RSCanvasController new noLegend ].
	visualization generator view: view canvas.
	visualization generateWith: visualization generator.
	view canvas zoomToFit
]

{ #category : #helpers }
FTVTraitsExplorer >> categories [

	self flag: 'Maybe a better way to do it'.
	^ (RPackageOrganizer default packageNamed: 'Famix-Traits') classTags
		  asOrderedCollection
		  add: ((RPackageOrganizer default packageNamed: 'Moose-Query') 
				   classTagNamed: 'Traits');
		  yourself
]

{ #category : #initialization }
FTVTraitsExplorer >> initializePresenters [

	super initializePresenters.
	categories := self newList
		              items: self categories;
		              beSingleSelection;
		              display: [ :tag | tag name ];
		              sortingBlock: [ :t1 :t2 | t1 name < t2 name ];
		              whenSelectionChangedDo: [ :selection | 
			              traitsList items:
					              (selection selectedItem classes select: #isTrait) ].
	self initializeTraitsList.
	view := SpRoassalPresenter new
]

{ #category : #initialization }
FTVTraitsExplorer >> initializeTraitsList [

	traitsList := self newList
		              sortingBlock: [ :t1 :t2 | t1 name < t2 name ];
		              whenSelectionChangedDo: [ :selection | 
			              self visualizeAsTree: selection selectedItem ];
		              contextMenu: self traitsMenu
]

{ #category : #initialization }
FTVTraitsExplorer >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	aWindowPresenter initialExtent: self class windowSize
]

{ #category : #helpers }
FTVTraitsExplorer >> traits [

	self flag: 'Probably a better way'.
	^ ((RPackageOrganizer default packageNamed: 'Famix-Traits') classes
	   , (RPackageOrganizer default packageNamed: 'Moose-Query') classes 
		   select: #isTrait) asOrderedCollection
]

{ #category : #initialization }
FTVTraitsExplorer >> traitsMenu [

	^ SpMenuPresenter new
		  addItem: [ :item | 
			  item
				  name: 'Browse';
				  action: [ traitsList selectedItem browse ] ];
		  addItem: [ :item | 
			  item
				  name: 'Visualize as tree';
				  action: [ self visualizeAsTree: traitsList selectedItem ] ];
		  addItem: [ :item | 
			  item
				  name: 'Visualize as expanding boxes';
				  action: [ self visualizeAsBoxes: traitsList selectedItem ] ]
]

{ #category : #helpers }
FTVTraitsExplorer >> traitsToShowAround: aTrait [

	^ { 
		  aTrait.
		  (aTrait allUsers flattened select: #isTrait).
		  aTrait traitComposition allTraits } flattened asSet
]

{ #category : #visualization }
FTVTraitsExplorer >> treeVisualizationFor: aTrait [

	| visualization |
	visualization := TLCycleDependencies new
		                 entities: (self traitsToShowAround: aTrait);
		                 property: [ :trait | trait traitComposition traits ].

	(visualization > #packages) styleSheet borderColor: [ :trait | 
		trait = aTrait
			ifTrue: [ Color red ]
			ifFalse: Color black ].

	(visualization > #packages) styleSheet
		nodeLabel: [ :trait | trait name withoutPrefix: 'Famix' ];
		adaptNodeWidthFromLabel;
		nodeLabelMaxWidth: 100.

	"visualization > #packages addInteraction:
		((TLCustomAction block: [ :node | node entity browse ]) withMenu:
			 'Browse')."

	visualization > #packages addInteraction:
		(TLCustomAction block: [ :node | node entity browse ]) onRightClick.

	^ visualization
]

{ #category : #visualization }
FTVTraitsExplorer >> visualizeAsBoxes: aTrait [

	aTrait ifNotNil: [ self buildBoxesVisualizationFor: aTrait ]
]

{ #category : #visualization }
FTVTraitsExplorer >> visualizeAsTree: aTrait [

	aTrait ifNotNil: [ self buildTreeVisualizationFor: aTrait ]
]
