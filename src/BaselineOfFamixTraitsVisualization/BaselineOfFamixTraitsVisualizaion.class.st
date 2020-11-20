Class {
	#name : #BaselineOfFamixTraitsVisualizaion,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixTraitsVisualization
}

{ #category : #baselines }
BaselineOfFamixTraitsVisualizaion >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self defineDependencies: spec.
		self definePackages: spec ]
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualizaion >> baselineOfFamix: spec [
	spec
		baseline: 'Famix'
		with: [ spec repository: 'github://moosetechnology/Famix:v1.0.0/src' ]
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualizaion >> baselineOfTelescope: spec [
	spec
		baseline: 'TelescopeRoassal3'
		with: [ spec repository: 'github://TelescopeSt/TelescopeRoassal3' ]
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualizaion >> defineDependencies: spec [

	self baselineOfFamix: spec.
	self baselineOfTelescope: spec
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualizaion >> definePackages: spec [

	spec
		package: 'Famix-TraitsVisualization'
		with: [ spec requires: #( 'Famix' 'TelescopeRoassal3' ) ]
]
