Class {
	#name : #FTVTraitsExplorer,
	#superclass : #SpPresenter,
	#instVars : [
		'traitsList',
		'view',
		'categories'
	],
	#category : #'Famix-TraitsVisualization-Browser'
}

{ #category : #layout }
FTVTraitsExplorer class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: (SpPanedLayout newHorizontal
				   add: #categories;
				   add: #traitsList;
				   yourself);
		  positionOfSlider: 300;
		  add: #view;
		  yourself
]

{ #category : #'instance creation' }
FTVTraitsExplorer class >> open [

	<script>
	self new open
]

{ #category : #specs }
FTVTraitsExplorer class >> title [

	^ 'Traits Visualization'
]

{ #category : #specs }
FTVTraitsExplorer class >> windowSize [
	^ 900 @ 600
]

{ #category : #'visualization - boxes' }
FTVTraitsExplorer >> addBoxesToMenu: menu [

	menu addItem: [ :item |
		item
			name: 'Visualize as expanding boxes';
			action: [ self visualizeAsBoxes: traitsList selectedItem ] ]
]

{ #category : #'visualization - tree' }
FTVTraitsExplorer >> addTreeToMenu: menu [

	menu addItem: [ :item |
		item
			name: 'Visualize as tree';
			action: [ self visualizeAsTree: traitsList selectedItem ] ]
]

{ #category : #'visualization - UML' }
FTVTraitsExplorer >> addUMLToMenu: menu [

	menu addItem: [ :item |
		item
			name: 'Visualize as UML';
			action: [ self visualizeAsUML: traitsList selectedItem ] ]
]

{ #category : #'visualization - boxes' }
FTVTraitsExplorer >> buildBoxesVisualizationFor: aTrait [

	view script: [ :canvas |
		FTVExpandingBoxes new
			canvas: canvas;
			children: [ :trait | trait traits ];
			addItem: aTrait.
		canvas zoomToFit.
		canvas @ RSCanvasController ]
]

{ #category : #'visualization - tree' }
FTVTraitsExplorer >> buildTreeVisualizationFor: aTrait [

	| visualization |
	visualization := FTVUsageGraph new forTrait: aTrait.
	view script: [ :canvas | canvas @ RSCanvasController new noLegend ].
	visualization generator view: view canvas.
	visualization generateWith: visualization generator.
	view canvas zoomToFit
]

{ #category : #'visualization - UML' }
FTVTraitsExplorer >> buildUMLVisualizationFor: aTrait [

	view script: [ :canvas |
		| builder |
		builder := FTVUMLTraitBuilder new.
		builder traits: (self traitsToShowAround: aTrait).
		builder renderIn: canvas.
		canvas zoomToFit.
		canvas @ RSCanvasController ]
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
					              (selection selectedItem classes select: #isTrait) asOrderedCollection ].
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

{ #category : #initialization }
FTVTraitsExplorer >> traitsMenu [

	| menu |
	menu := SpMenuPresenter new.
	menu addItem: [ :item |
		item
			name: 'Browse';
			action: [ traitsList selectedItem browse ] ].
	self addTreeToMenu: menu.
	self addBoxesToMenu: menu.
	self addUMLToMenu: menu.
	^ menu
]

{ #category : #initialization }
FTVTraitsExplorer >> traitsToShowAround: aTrait [

	^ {
		  aTrait.
		  (aTrait allUsers flattened select: #isTrait).
		  aTrait traitComposition allTraits } flattened asSet
]

{ #category : #'visualization - boxes' }
FTVTraitsExplorer >> visualizeAsBoxes: aTrait [

	aTrait ifNotNil: [ self buildBoxesVisualizationFor: aTrait ]
]

{ #category : #'visualization - tree' }
FTVTraitsExplorer >> visualizeAsTree: aTrait [

	aTrait ifNotNil: [ self buildTreeVisualizationFor: aTrait ]
]

{ #category : #'visualization - UML' }
FTVTraitsExplorer >> visualizeAsUML: aTrait [

	aTrait ifNotNil: [ self buildUMLVisualizationFor: aTrait ]
]
