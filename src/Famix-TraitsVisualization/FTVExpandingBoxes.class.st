Class {
	#name : #FTVExpandingBoxes,
	#superclass : #RSExpandingBoxes,
	#instVars : [
		'children'
	],
	#category : #'Famix-TraitsVisualization'
}

{ #category : #'instance creation' }
FTVExpandingBoxes class >> example [

	<script>
	self
		runOnItems: { 
				FamixTNamed.
				FamixTException }
		children: [ :trait | trait traitComposition traits ]
]

{ #category : #'instance creation' }
FTVExpandingBoxes class >> runOnItem: anItem children: aBlockOrValuable [

	^ (self new
		   children: aBlockOrValuable;
		   addItem: anItem) run
]

{ #category : #'instance creation' }
FTVExpandingBoxes class >> runOnItems: someItems children: aBlockOrValuable [

	self new
		children: aBlockOrValuable;
		addItems: someItems;
		run
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> addItem: anItem [

	canvas add: (self nodeFor: anItem).
	self update
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> addItems: someItems [

	canvas add: (RSComposite new
			 addAll: (someItems collect: [ :item | self nodeFor: item ]);
			 yourself).

	self update
]

{ #category : #accessing }
FTVExpandingBoxes >> canvas: aRSCanvas [

	canvas := aRSCanvas
]

{ #category : #accessing }
FTVExpandingBoxes >> children [

	^ children ifNil: [ :item | children := {  } ]
]

{ #category : #accessing }
FTVExpandingBoxes >> children: anObject [

	children := anObject
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> childrenFor: anItem [

	^ self children value: anItem
]

{ #category : #initialization }
FTVExpandingBoxes >> initialize [

	super initialize.
	base when: RSMouseLeftClick do: [ :evt | self processLeftClick: evt ].
	base @ (RSMenuActivable new menuDo: [ :menu :element | 
		 menu add: 'Browse' target: element model selector: #browse ])
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> nodeFor: anItem [

	| com |
	com := base copy.
	com model: anItem.
	(self childrenFor: anItem) ifNotEmpty: [ com border: border ].
	com announcer: base announcer.
	com color: (color scale: anItem) translucent.
	^ com
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> open: shape [

	shape addAll: ((self childrenFor: shape model) collect: [ :item | 
			 self nodeFor: item ]).
	self update
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> processEvent: anEvent [

	self flag:
		'This is empty to avoid triggering left click action when right clicking. It should be improved at superclass level (in Roassal3)'
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> processLeftClick: evt [

	| shape |
	shape := evt shape.
	shape children
		ifEmpty: [ self open: shape ]
		ifNotEmpty: [ self close: shape ]
]

{ #category : #'as yet unclassified' }
FTVExpandingBoxes >> run [

	canvas open
]
