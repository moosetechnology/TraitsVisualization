Class {
	#name : #FTVTraitsFilter,
	#superclass : #SpPresenter,
	#instVars : [
		'traits',
		'selection',
		'selectedTraits',
		'button'
	],
	#category : #'TraitsVisualization-Utils'
}

{ #category : #layout }
FTVTraitsFilter class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: #traits;
		  add: (SpBoxLayout newVertical
				   add: #selection;
				   add: #button height: self buttonHeight;
				   yourself);
		  yourself
]

{ #category : #'instance creation' }
FTVTraitsFilter class >> open [

	<script>
	self new open
]

{ #category : #initialization }
FTVTraitsFilter >> initialize [

	super initialize.
	selectedTraits := OrderedCollection new
]

{ #category : #initialization }
FTVTraitsFilter >> initializePresenters [

	super initializePresenters.
	traits := self newTable
		          addColumn: ((SpCheckBoxTableColumn
				            title: ''
				            evaluated: [ :trait | self isSelected: trait ])
				           onActivation: [ :class | self selectTrait: class ];
				           onDeactivation: [ :class | self unselectTrait: class ];
				           width: 20;
				           yourself);
		          addColumn:
		          (SpStringTableColumn title: 'Name' evaluated: #name);
		          items:
			          (((RPackageOrganizer default packageNamed: 'Famix-Traits')
				            classTags asOrderedCollection sort: [ :t1 :t2 |
				            t1 name < t2 name ]) flatCollect: [ :t | t classes ]);
		          yourself.

	selection := self newList.
	button := self newButton whenActivatedDo: [ :b |
		          selectedTraits inspect ]
]

{ #category : #testing }
FTVTraitsFilter >> isSelected: aTrait [

	^ selectedTraits includes: aTrait
]

{ #category : #selection }
FTVTraitsFilter >> selectTrait: aTrait [

	selectedTraits add: aTrait.
	selection items: selectedTraits
]

{ #category : #selection }
FTVTraitsFilter >> unselectTrait: aTrait [

	selectedTraits remove: aTrait.
	selection items: selectedTraits
]
