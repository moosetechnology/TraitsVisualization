Class {
	#name : #FTVTraitsFilter,
	#superclass : #SpPresenter,
	#instVars : [
		'kinds',
		'traits',
		'selection',
		'selectedTraits',
		'button'
	],
	#category : #'Famix-TraitsVisualization-Utils'
}

{ #category : #specs }
FTVTraitsFilter class >> defaultSpec [

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
	self new openWithSpec
]

{ #category : #initialization }
FTVTraitsFilter >> initialize [

	super initialize.
	selectedTraits := OrderedCollection new
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
FTVTraitsFilter >> isSelected: aTrait [

	^ selectedTraits includes: aTrait
]

{ #category : #'as yet unclassified' }
FTVTraitsFilter >> selectTrait: aTrait [

	selectedTraits add: aTrait.
	selection items: selectedTraits 
]

{ #category : #'as yet unclassified' }
FTVTraitsFilter >> unselectTrait: aTrait [

	selectedTraits remove: aTrait.
	selection items: selectedTraits 
]
