Class {
	#name : #FTVExpandingBoxes,
	#superclass : #RSExpandingBoxes,
	#instVars : [
		'children'
	],
	#category : #'Famix-TraitsVisualization-Roassal'
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

{ #category : #adding }
FTVExpandingBoxes >> addItem: anItem [

	canvas add: (self nodeFor: anItem).
	self update
]

{ #category : #adding }
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

{ #category : #accessing }
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

{ #category : #helpers }
FTVExpandingBoxes >> nodeFor: anItem [

	| com |
	com := base copy.
	com model: anItem.
	(self childrenFor: anItem) ifNotEmpty: [ com border: border ].
	com announcer: base announcer.
	com color: (color scale: anItem) translucent.
	^ com
]

{ #category : #events }
FTVExpandingBoxes >> open: shape [

	shape addAll: ((self childrenFor: shape model) collect: [ :item |
			 self nodeFor: item ]).
	self update
]

{ #category : #events }
FTVExpandingBoxes >> processEvent: anEvent [

	self flag:
		'This is empty to avoid triggering left click action when right clicking. It should be improved at superclass level (in Roassal3)'
]

{ #category : #action }
FTVExpandingBoxes >> processLeftClick: evt [

	| shape |
	shape := evt shape.
	shape children
		ifEmpty: [ self open: shape ]
		ifNotEmpty: [ self close: shape ]
]

{ #category : #running }
FTVExpandingBoxes >> run [

	canvas open
]
