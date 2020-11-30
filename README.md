# FamixTraitsVisualization

Graphical presentations of Famix Traits.

To load this project in a Moose (Pharo 9) image:
```smalltalk
[ Metacello new
	baseline: 'FamixTraitsVisualization';
	repository: 'github://ClotildeToullec/FamixTraitsVisualization:main/src';
	onConflictUseLoaded;
	load ]
	on: MCMergeOrLoadWarning
	do: [ :warning | warning cancel ]
