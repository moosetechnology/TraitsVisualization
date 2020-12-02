Class {
	#name : #FTVTraitBuilder,
	#superclass : #RSUMLAbstractBuilder,
	#instVars : [
		'traits'
	],
	#category : #'Famix-TraitsVisualization-Roassal'
}

{ #category : #initialization }
FTVTraitBuilder >> initialize [

	super initialize.
	self
		modelDescriptor: FTVUMLTraitDescriptor new;
		renderer: RSBasicUMLClassRenderer new
]

{ #category : #hooks }
FTVTraitBuilder >> objects [
	^ traits
]

{ #category : #hooks }
FTVTraitBuilder >> renderIn: aCanvas [

	super renderIn: aCanvas.
	self renderer edgeBuilder
		canvas: aCanvas;
		shapes: shapes;
		connectFromAll: modelDescriptor traits.

	self layout on: shapes.
	renderer setUpCanvas: aCanvas
]

{ #category : #accessing }
FTVTraitBuilder >> traits: anObject [

	traits := anObject
]
