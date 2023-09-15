Class {
	#name : #FTVTraitsTagging,
	#superclass : #Object,
	#instVars : [
		'kinds',
		'colorDict'
	],
	#category : #'Famix-TraitsVisualization-Utils'
}

{ #category : #querying }
FTVTraitsTagging >> allTraits [

	^ self relationTraits , self propertyTraits , self technicalTraits
	  , self entityTraits
]

{ #category : #querying }
FTVTraitsTagging >> colorForTrait: aTrait [

	^ colorDict at: (self kind: aTrait)
]

{ #category : #accessing }
FTVTraitsTagging >> entityTraits [

	^ {
		  FamixTAnnotationType.
		  FamixTAnnotationInstanceAttribute.
		  FamixTPrimitiveType.
		  FamixTPreprocessorDefine.
		  FamixTTypedAnnotationInstanceAttribute.
		  FamixTImplicitVariable.
		  FamixTNamespace.
		  FamixTTemplate.
		  FamixTCaughtException.
		  FamixTParameterType.
		  FamixTLocalVariable.
		  FamixTPreprocessorIfdef.
		  FamixTEnumValue.
		  FamixTTemplateUser.
		  FamixTCompilationUnit.
		  FamixTFileNavigation.
		  FamixTClass.
		  FamixTComment.
		  FamixTParameterizedType.
		  FamixTTypeAlias.
		  FamixTAnnotationTypeAttribute.
		  FamixTFunction.
		  FamixTHeader.
		  FamixTException.
		  FamixTParameter.
		  FamixTModule.
		  FamixTThrownException.
		  FamixTAnnotationInstance.
		  FamixTEnum.
		  FamixTIndexedFileNavigation.
		  FamixTFolder.
		  FamixTGlobalVariable.
		  FamixTParameterizedTypeUser.
		  FamixTTypedAnnotationInstance.
		  FamixTDeclaredException.
		  FamixTMethod.
		  FamixTUnknownVariable.
		  FamixTPackage.
		  FamixTAttribute }
]

{ #category : #initialization }
FTVTraitsTagging >> initialize [

	super initialize.
	colorDict := Dictionary new.
	colorDict at: 'Technical' put: Color blue.
	colorDict at: 'Property' put: Color green.
	colorDict at: 'Relation' put: Color yellow.
	colorDict at: 'Entity' put: Color red.
	self initializeKindsDictionary
]

{ #category : #initialization }
FTVTraitsTagging >> initializeKindsDictionary [

	kinds := Dictionary new.
	kinds at: 'Technical' put: self technicalTraits.
	kinds at: 'Property' put: self propertyTraits.
	kinds at: 'Relation' put: self relationTraits.
	kinds at: 'Entity' put: self entityTraits
]

{ #category : #accessing }
FTVTraitsTagging >> kind: aTrait [

	^ kinds keyAtValue: (kinds value
			   detect: [ :arr | arr includes: aTrait ]
			   ifNone: [ ^ 'Technical' ])
]

{ #category : #accessing }
FTVTraitsTagging >> propertyTraits [

	^ {
		  FamixTWithPackages.
		  FamixTWithAttributes.
		  FamixTWithThrownExceptions.
		  FamixTWithMethods.
		  FamixTWithAnnotationTypes.
		  FamixTWithTemplates.
		  FamixTWithExceptions.
		  FamixTWithLocalVariables.
		  FamixTWithAnnotationInstances.
		  FamixTWithStatements.
		  FamixTWithEnumValues.
		  FamixTWithAnnotationInstanceAttributes.
		  FamixTWithDeclaredExceptions.
		  FamixTWithImplicitVariables.
		  FamixTWithReferences.
		  FamixTWithCompilationUnit.
		  FamixTWithClasses.
		  FamixTWithHeader.
		  FamixTWithParameters.
		  FamixTWithComments.
		  FamixTWithTypes.
		  FamixTWithGlobalVariables.
		  FamixTWithParameterizedTypes.
		  FamixTWithClassScope.
		  FamixTWithTypeAliases.
		  FamixTWithFunctions.
		  FamixTWithParameterizedTypeUsers.
		  FamixTWithCaughtExceptions.
		  FamixTWithFiles.
		  FamixTStructuralEntity.
		  FamixTTypedEntity.
		  FamixTPackageable.
		  FamixTNamedEntity.
		  FamixTHasModifiers.
		  FamixTHasSignature.
		  FamixTDefinedInModule.
		  FamixTTraitUser.
		  FamixTFileSystemEntity.
		  FamixTFile.
		  FamixTType.
		  FamixTSourceEntity }
]

{ #category : #accessing }
FTVTraitsTagging >> relationTraits [

	^ {
		  FamixTAssociation.
		  FamixTWithAccesses.
		  FamixTAccess.
		  FamixTAccessible.
		  FamixTInheritance.
		  FamixTWithInheritances.
		  FamixTInvocable.
		  FamixTInvocation.
		  FamixTInvocationsReceiver.
		  FamixTWithInvocations.
		  FamixTWithReferences.
		  FamixTReferenceable.
		  FamixTReference.
		  FamixTTraitUsage.
		  FamixTWithTraits.
		  FamixTTrait.
		  FamixTDereferencedInvocation.
		  FamixTWithDereferencedInvocations.
		  FamixTFileInclude.
		  FamixTWithFileIncludes }
]

{ #category : #accessing }
FTVTraitsTagging >> technicalTraits [

	^ {
		  FamixTMultipleFileAnchor.
		  FamixTFileAnchor.
		  FamixTRelativeSourceAnchor.
		  FamixTSourceAnchor.
		  FamixTLCOMMetrics.
		  FamixTCohesionCouplingMetrics.
		  FamixTWithSourceLanguage.
		  FamixTHasImmediateSource.
		  FamixTUnknownSourceLanguage.

		  FamixTSourceLanguage }
	  , ((RPackageOrganizer default packageNamed: 'Moose-Query')
			   classTagNamed: 'Traits') classes asArray
]
