- article [1]

L. von Rueden, S. Mayer, R. Sifa, C. Bauckhage, and J. Garcke, “Combining Machine Learning and Simulation to a Hybrid Modelling Approach: Current and Future Directions,” in _Advances in Intelligent Data Analysis XVIII_, M. R. Berthold, A. Feelders, and G. Krempl, Eds., Cham: Springer International Publishing, 2020, pp. 548–560. doi: [10.1007/978-3-030-44584-3_43](https://doi.org/10.1007/978-3-030-44584-3_43).


- Inductive models:
	- Generation Phase: Learning an Inductive Model
		- Training Data
			- creating additional training data in a controlled environment. (JNEM fault localization example)
		- Hypothesis Set
			- directly as the solvers or through deduced, empirical functions that compactly describe the simulations results. These functions can be built into the architecture of a neural network, as shown for the application of finding an optimal design strategy for a warm forming process
		- Algorithm
			- The integration of simulations into the learning algorithm can for example be realized by generative adversarial networks (GANs),
		- Final Hypothesis
			- where first a machine learning model suggests new compounds based on patterns in a data basis, and second the physical properties are computed and thus checked by a density functional theory simulation
		- An approach that uses simulations along the whole machine learning pipeline is reinforcement learning (RL), when the model is learned in a simulated environment
	- Application Phase: Inference / Prediction
	- Hybridization can happen in any step of the Generation phase
- Deductive models:
	- Generation Phase: Identifying a Deductive Model
	- Application Phase: Running a Simulation
		- model
		- parameter
		- numerical method
		- simulation result
	- Hybridization can happen in any step of the Application phase

