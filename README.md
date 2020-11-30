# FamixTraitsVisualization

Graphical presentations of Famix Traits.

To load this project in a Moose (Pharo 9) image:
```smalltalk
[ Metacello new
	baseline: 'FamixTraitsVisualization';
	repository: 'github://ClotildeToullec/FamixTraitsVisualization:main/src';
	load ]
	on: MCMergeOrLoadWarning
	do: [ :warning | warning load ]
