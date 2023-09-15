Class {
	#name : #FTVUMLTraitDescriptor,
	#superclass : #RSUMLAbstractModelDescriptor,
	#instVars : [
		'instVars',
		'methods',
		'traits',
		'methodSelector',
		'instVarSelector',
		'methodsLimit',
		'classname'
	],
	#category : #'Famix-TraitsVisualization-Roassal'
}

{ #category : #accessing }
FTVUMLTraitDescriptor >> classname [

	^ classname
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> classname: anObject [

	classname := anObject
]

{ #category : #public }
FTVUMLTraitDescriptor >> forPharo [

	self
		classname: #name;
		instVars: [ :trait |
			(trait instVarNames
			 \ (trait allTraits flattened flatCollect: #instVarNames)) sorted ];
		methods: [ :trait |
			trait localMethods sorted: [ :meth1 :meth2 |
					meth1 selector < meth2 selector ] ];
		traits: [ :trait | trait traits ];
		methodSelector: #selector;
		instVarSelector: #yourself;
		methodsLimit: SmallInteger maxVal
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> instVarSelector [

	^ instVarSelector
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> instVarSelector: anObject [

	instVarSelector := anObject
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> instVars [

	^ instVars
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> instVars: anObject [

	instVars := anObject
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> isAbstract [

	^ false
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> methodSelector [

	^ methodSelector
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> methodSelector: anObject [

	methodSelector := anObject
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> methods [

	^ methods
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> methods: anObject [

	methods := anObject
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> methodsLimit [

	^ methodsLimit
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> methodsLimit: anObject [

	methodsLimit := anObject
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> traits [

	^ traits
]

{ #category : #accessing }
FTVUMLTraitDescriptor >> traits: anObject [

	traits := anObject
]
