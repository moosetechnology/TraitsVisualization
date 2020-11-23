Class {
	#name : #FTVTraitsExplorer,
	#superclass : #SpPresenter,
	#instVars : [
		'traitsList',
		'visualization'
	],
	#category : #'Famix-TraitsVisualization'
}

{ #category : #specs }
FTVTraitsExplorer class >> defaultSpec [

	^ SpPanedLayout newHorizontal
		  add: #traitsList;
		  position: 150;
		  add: #visualization;
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

{ #category : #update }
FTVTraitsExplorer >> buildVisualizationFor: aTrait [

	| visu |
	visu := self newVisualizationFor: aTrait.
	visualization script: [ :canvas | 
		canvas @ RSCanvasController new noLegend ].
	visu generator view: visualization canvas.
	visu generateWith: visu generator.
	visualization canvas zoomToFit
]

{ #category : #initialization }
FTVTraitsExplorer >> initializePresenters [

	super initializePresenters.
	traitsList := self newList
		              items:
			              ((RPackageOrganizer default packageNamed:
					                'Famix-Traits') classes select: #isTrait)
				              asOrderedCollection;
		              sortingBlock: [ :t1 :t2 | t1 name < t2 name ];
		              whenSelectionChangedDo: [ :selection | 
			              self buildVisualizationFor: selection selectedItem ].
	visualization := SpRoassalPresenter new.
	visualization script: [ :canvas | 
		canvas @ RSCanvasController new noLegend ]
]

{ #category : #initialization }
FTVTraitsExplorer >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	aWindowPresenter initialExtent: self class windowSize
]

{ #category : #update }
FTVTraitsExplorer >> newVisualizationFor: aTrait [

	| visu |
	visu := TLCycleDependencies new
		        entities: { 
				        aTrait.
				        (aTrait allUsers flattened select: #isTrait).
				        aTrait traitComposition allTraits } flattened asSet;
		        property: [ :trait | trait traitComposition traits ].
	(visu > #packages) styleSheet borderColor: [ :trait | 
		trait = aTrait
			ifTrue: [ Color red ]
			ifFalse: Color black ].
	visu > #packages addInteraction:
		(TLCustomAction block: [ :trait | trait browse ]) onRightClick.
	^ visu
]
