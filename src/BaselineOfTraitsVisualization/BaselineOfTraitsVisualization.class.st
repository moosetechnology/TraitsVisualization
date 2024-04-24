Class {
	#name : #BaselineOfTraitsVisualization,
	#superclass : #BaselineOf,
	#category : #BaselineOfTraitsVisualization
}

{ #category : #baselines }
BaselineOfTraitsVisualization >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self defineDependencies: spec.
		self definePackages: spec ]
]

{ #category : #baselines }
BaselineOfTraitsVisualization >> baselineOfTelescope: spec [
	spec
		baseline: 'TelescopeRoassal3'
		with: [ spec repository: 'github://TelescopeSt/TelescopeRoassal3' ]
]

{ #category : #baselines }
BaselineOfTraitsVisualization >> defineDependencies: spec [

	self baselineOfTelescope: spec
]

{ #category : #baselines }
BaselineOfTraitsVisualization >> definePackages: spec [

	spec
		package: 'TraitsVisualization'
		with: [ spec requires: #( 'TelescopeRoassal3' ) ]
]
