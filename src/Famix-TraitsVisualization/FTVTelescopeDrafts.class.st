Class {
	#name : #FTVTelescopeDrafts,
	#superclass : #Object,
	#instVars : [
		'visu'
	],
	#category : #'Famix-TraitsVisualization'
}

{ #category : #dynamic }
FTVTelescopeDrafts >> addShapeFor: aTrait [

	| shape |
	shape := visu addNodeFromEntity: aTrait.
"	aTrait traitUsers ifNotEmpty: [ 
		shape addInteraction:
			(TLPopUpAction
				 text: [ :trait | 'Expand users' ]
				 position: [ :each | 
					 TLPosition new
						 horizontal: #center;
						 vertical: #bottom;
						 yourself ]) onMouseOver ]."

	^ shape
]

{ #category : #drafts }
FTVTelescopeDrafts >> butterfly: aTrait [

	TLButterfly new
		mainEntity: aTrait;
		leftEntities: [ :trait | trait traitComposition traits ];
		rightEntities: [ :trait | trait users ];
		open
]

{ #category : #drafts }
FTVTelescopeDrafts >> cycleDependencies: aTrait [

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
	^ visu open
]

{ #category : #drafts }
FTVTelescopeDrafts >> cycleDependenciesAllTraits [

	TLCycleDependencies new
		entities:
			((RPackageOrganizer default packageNamed: 'Famix-Traits') classes 
				 select: #isTrait);
		property: [ :each | each traitComposition traits ];
		open
]

{ #category : #dynamic }
FTVTelescopeDrafts >> dynamicVisuForTrait2: aTrait [

	visu layout: TLTreeLayout new useOutgoingLinks.
	visu addNodeFromEntity: aTrait.

	visu addInteraction:
		(TLExpandCollapseNodesAction property: [ :trait | 
			 trait traitUsers select: [ :class | class isTrait ] ]) onClick.

	visu addInteraction: (TLHideAction hide: #yourself) onRightClick.

	visu open
]

{ #category : #dynamic }
FTVTelescopeDrafts >> dynamicVisuForTrait: aTrait [

	| origin |
	visu layout: TLTreeLayout new useOutgoingLinks.

	origin := visu addNodeFromEntity: aTrait.
	"origin addInteraction: (TLShowAction on:
			 (visu addNodeFromEntity: aTrait traitUsers anyOne) hide) onClick."
	visu addInteraction:
		(TLExpandCollapseNodesAction property: [ :trait | 
			 trait traitUsers select: [ :class | class isTrait ] ]) onClick.
	visu addInteraction: (TLHideAction hide: #yourself) onRightClick.

	visu open
]

{ #category : #initialization }
FTVTelescopeDrafts >> initialize [

	super initialize.
	visu := TLVisualization new.
	visu styleSheet
		nodeLabel: [ :trait | trait name withoutPrefix: 'Famix' ]
		position: #top
]

{ #category : #drafts }
FTVTelescopeDrafts >> pathBuilder: aTrait [

	TLPathBuilder new
		origin: aTrait;
		incomingBlock: [ :trait | trait traitComposition traits ];
		outgoingBlock: [ :trait | trait users ];
		open
]
