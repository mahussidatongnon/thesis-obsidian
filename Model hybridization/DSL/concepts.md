- Component
	- Anything that can be triggered
- Models
	- an FMU standard
		- Co-Simulation (doStep)
	- an ONNX standard
- Datasource
	- a repository of data
- Aggregator
	-  that combines multiple data sources using various methods, such as set operations or algebraic combinations.
	- equivalent to Expression in current DSL (4 aout 2026)

- Mutiplexer
	- synchronizes two or more data flows

- ComponentElement
	- Anything that belong to a component
		- Port
		- Trigger
			- Predicat
				- Every x ...
# Existing component and connections
For this we use existing standard like FMU, ONNX, etc...
	- https://eclipse.dev/openpass/content/html/advanced_topics/simulator/system_structure_and_parameterization_%28SSP%29.html

#  The Mapper
Ref: SSM in SSP. Here, we complete information about component.
- The validity frame of each input and output 
- METADATA that characterize the value moving into a connection (level of thruthness )

# The Dictionnnary
Like SSB in SSP