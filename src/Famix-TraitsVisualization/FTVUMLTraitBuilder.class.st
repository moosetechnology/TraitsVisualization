Class {
	#name : #FTVUMLTraitBuilder,
	#superclass : #RSUMLAbstractBuilder,
	#instVars : [
		'traits'
	],
	#category : #'Famix-TraitsVisualization-Roassal'
}

{ #category : #initialization }
FTVUMLTraitBuilder >> initialize [

	super initialize.
	self
		modelDescriptor: FTVUMLTraitDescriptor new;
		renderer: RSBasicUMLClassRenderer new
]

{ #category : #hooks }
FTVUMLTraitBuilder >> objects [
	^ traits
]

{ #category : #rendering }
FTVUMLTraitBuilder >> renderIn: aCanvas [

	super renderIn: aCanvas.
	self renderer edgeBuilder
		canvas: aCanvas;
		shapes: shapes;
		connectFromAll: modelDescriptor traits.

	self layout on: shapes.
	renderer setUpCanvas: aCanvas
]

{ #category : #accessing }
FTVUMLTraitBuilder >> traits: anObject [

	traits := anObject
]
