Class {
	#name : #BaselineOfFamixTraitsVisualization,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixTraitsVisualization
}

{ #category : #baselines }
BaselineOfFamixTraitsVisualization >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self defineDependencies: spec.
		self definePackages: spec ]
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualization >> baselineOfFamix: spec [
	spec
		baseline: 'Famix'
		with: [ spec repository: 'github://moosetechnology/Famix:v1.0.0/src' ]
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualization >> baselineOfTelescope: spec [
	spec
		baseline: 'TelescopeRoassal3'
		with: [ spec repository: 'github://TelescopeSt/TelescopeRoassal3' ]
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualization >> defineDependencies: spec [

	"self baselineOfFamix: spec."
	self baselineOfTelescope: spec
]

{ #category : #baselines }
BaselineOfFamixTraitsVisualization >> definePackages: spec [

	spec
		package: 'Famix-TraitsVisualization'
		with: [ spec requires: #( 'TelescopeRoassal3' ) ]
]
