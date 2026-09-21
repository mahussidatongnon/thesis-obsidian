- Modelica Association ecosystem
	- DCP - Distributed Co-Simulation Protocol
		C'est un standard pour faire fonctionner des composants de simulation qui peuvent être **distribués**, éventuellement sur différentes machines, et les faire communiquer de manière coordonnée.
		- https://chatgpt.com/c/6a705550-86bc-83eb-b433-6c7469474c8e
		- Les modele sont dans différents environnement
	- eFMI - FMI for embedded systems (NOT CONCERNED)
		L'objectif est différent : partir d'un modèle de simulation relativement complexe et arriver à une implémentation adaptée à une cible **embarquée**.]
	- SSP (System Structure and Parametization) - Comment décrire un système composé de modèles ?
		- Note: https://chatgpt.com/c/6a7044f9-b594-83eb-b998-19b5d23225e1
		- SSD <-> the constellation
		- SSM <-> defining mapping between element such as paraneters
		- SSB (Signal Dictionary) <-> defining the glossary of making clear some  unified concept
		- https://eclipse.dev/openpass/content/html/advanced_topics/simulator/system_structure_and_parameterization_%28SSP%29.html
- Open Simulation Plateform (and its spec: OSP-IS)
	A co-sim plateform that support SSP

- Build your own co-sim
	- providing high-level functionalities, which ease the handling and manipulation of such models and tools (see chapter on [import functionalities](https://fmipp.readthedocs.io/en/latest/import.html)). Furthermore, the FMI++ library provides utilities to implement FMI-compliant interfaces for a large class of simulation tools (see chapter on [export functionalities](https://fmipp.readthedocs.io/en/latest/export.html)).
	- https://fmipp.readthedocs.io/en/latest/
- Remote execution FMUs:
	- https://github.com/open-simulation-platform/proxy-fmu
- kind of inductives models
	- https://chatgpt.com/c/6a7044f9-b594-83eb-b998-19b5d23225e1
	- taxonomy: [[taxonomy-inductives-models]]

- Dataset
	- croissant: https://mlcommons.org/working-groups/data/croissant