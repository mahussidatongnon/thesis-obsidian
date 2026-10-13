# Introduction
-  Digital Twin definitions → (e.g., Grieves, Tao, Kritzinger…)
- - DTs in industrial engineering: why they matter (decision support, monitoring, design, troubleshooting).
- Why hybridization is common and beneficial (physics gives structure; data gives adaptation).
- The gap: ad hoc hybridization + weak documentation → poor transferability.
- **Contributions :**
	1. Engineering report of CETIM fluidic-loop DT development
	2. DT characterization using Bentley et al.
	3. Complementary hybridization perspective (2 dimensions) applied to the case
	4. Transferable lessons learned + supplementary material

# Backgrownd  & terminology
Industrial systems are commonly modeled to support prediction, optimization, and what‑if analysis under operational constraints. Two broad families of modeling approaches dominate the engineering literature and practice: **deductive (physics‑based/knowledge‑based) models**, which derive system behavior from first principles, and **inductive (data‑driven) models**, which infer system behavior from observed data. Increasingly, industrial digitalization has motivated the **hybridization** of these approaches to exploit complementary strengths, interpretability and extrapolation for deductive models, and flexibility and computational efficiency for inductive models. In industrial practice, the modeling pipeline has historically relied on deductive models for simulation and decision support. However, deductive and inductive approaches provide complementary capabilities. **Hybridization** broadly denotes any systematic strategy that **combines deductive and inductive components** within a single modeling workflow to improve qualities such as accuracy, robustness, computational efficiency, or interpretability.

## Hybridization at usage (run‑time): coupling deductive and inductive models
When multiple deductive simulators are executed together, each representing a subsystem, and are numerically coordinated to exchange variables during execution, the approach is typically described as **co‑simulation** (EX1). Co‑simulation thus refers to _multi‑model_ integration where each participating model remains explicit and mechanistic. A closely related, but distinct, case arises when **deductive and inductive models are executed jointly at run‑time**. In this setting, a physics‑based simulator and a learned model exchange information during execution, for example:
- [Example 1 of hyrbidization at runtime]
- [Example 2 of hyrbidization at runtime]
When the operational output is produced by **combining contributions from both deductive and inductive models during deployment**, this constitutes **hybridization at usage** (EX1). The defining feature is that _both_ model types are present and active in the deployed system, and the final prediction depends on their coordinated execution.
To make the concept operational, it is useful to distinguish hybridization by _when_ and _how_ the integration occurs: **hybridization at usage (run‑time integration)** versus **hybridization at creation (design‑time integration)**.
	
## Hybridization at creation (design‑time): physics‑informed training and surrogate modeling
Hybridization can also occur during _model construction_, even if only one model type is used at deployment. A prominent example is **surrogate modeling**, where a deductive (physics‑based) model is used to generate training data for an inductive model that emulates the simulator’s input, output behavior. In this case:
- A deductive model is executed offline across a range of operating conditions to produce synthetic data,
- An inductive model is trained on this data to approximate the simulator, and
- At deployment, the **surrogate** (inductive model) may replace the original deductive model entirely.
Although the deductive model may no longer be executed at usage time, its **structural assumptions and implied physical relationships are transferred** into the learned surrogate through the training dataset and learning objective [ref]. This constitutes **hybridization at creation**, because the integration occurs during the development phase rather than during run‑time operation.
		
	    
# Fluidic loop case study
The physical twin considered in this work is a  hydraulic loop equipped with three actuators: (i) pump rotational speed, (ii) opening of a regulation valve, and (iii) activation of a cooling on/off valve. These actuators enable the regulation of **pressure, flow rate, and temperature** within the loop. The system is instrumented with multiple sensors (e.g., pressures at key locations, pump speed, and process temperature) to ensure observability of the operating state. The digital twin (DT) of this fluidic loop is described following the characterization framework proposed by Bentley _et al._, which structures DTs across **requirements, realization, deployment, and operation** phases. This framework is selected because it provides a formalized and comprehensive description of DT systems, capturing both their architectural components and operational roles.

## DT characterization
### Requirements, Conceptualization, and Design
#### System under study and physical components
The system under study is the fluidic loop itself (MC1), composed of physical actuators (MC2) and sensing components (MC3). The actuators include the regulation valve and the cooling unit, while the sensing layer captures variables such as inlet/outlet pressures, pump speed, and temperature.
#### Physical - virtual interactions
Sensor data are continuously collected and transmitted to the digital environment through a data infrastructure (data lake), forming the **physical-to-virtual interface** (MC4). Conversely, the **virtual-to-physical interaction** (MC5) enables the DT to influence the physical system through actuator commands, such as adjusting valve opening or managing cooling strategies. 

#### Digital twin services
 The DT provides several operational services (MC6), including:
- Cavitation detection,
- **Virtual sensing**, where flow rate can be estimated in case of sensor failure,
- **Energy consumption analysis**, through simulation of alternative cooling strategies,
- **Divergence detection**, identifying discrepancies between the physical and virtual systems to trigger recalibration. 


### Realization
The realization of the digital twin (DT) for the fluidic loop relies on the integration of heterogeneous models, data pipelines, and computational enablers, orchestrated to support the different operational services. This section details the DT realization according to models and data, enabling technologies, system orchestration, lifecycle evolution, and fidelity considerations.

#### Digital Twin Models and Data (MC10)
The DT is composed of both **deductive (physics-based)** and **inductive (data-driven)** models, forming a hybrid modeling architecture.
- **Physics-based models:**  
	A 1D thermo-hydraulic simulation model (Simcenter Flomaster) is used to represent the fluidic loop. Two variants are employed:  
	- (i) a simplified hydraulic model, and  
	- (ii) a more detailed model incorporating head losses and thermal effects.  
	These models simulate system variables (e.g., pressure, flow rate, temperature) based on component parameters and control inputs. 
- **Data-driven models:**  
	Two inductive models complement the simulation:
	- A **fault localization model** (decision tree), identifying which parameters of the physical model are responsible for observed discrepancies.
	- A **fault estimation model** (LS‑SVR), estimating the corrected values of these parameters.
- **Data structure:**  
	The DT relies on a **data lake** that stores sensor measurements and simulation data. Training datasets for the ML models are generated using a combination of:
	
	- sampled control vectors (e.g., valve opening, pump speed),
	- perturbed parameter sets of the simulation model (loss pressur in certain pipes),
	- corresponding simulated process variables.


#### Tooling and Enablers (MC11)
The DT implementation is supported by a distributed ecosystem of industrial and cloud-based tools:
- **Industrial layer:**
	- Beckhoff PLC (automation and control),
	- Industrial PC for local computation.
- **Interoperability an simulation:**
	- FMPy library for executing Functional Mock-up Units (FMU),
	- Model registry for managing simulation assets.
- **Cloud infrastructure:**
	- Azure IoT Hub and Event Hub for data ingestion and streaming,
	- Azure Functions for event-driven computation,
	- Data Lake for storage,
	- OPC UA server for communication.
- **Application layer:**
	Web application interface for visualization and interaction. 
These enablers collectively ensure data acquisition, model execution, orchestration, and user interaction.


#### Digital Twin Constellation (MC12)
The DT constellation describes how models, data, and services are orchestrated within the virtual environment.
The architecture follows a **service-oriented organization**, in which each DT service (e.g., cavitation detection, virtual sensing, energy analysis, fault detection) relies on a specific combination of:
- simulation models (FMU-based),
- machine learning components,
- real-time and historical data.
The orchestration is event-driven:
- sensor data streams are ingested into the data infrastructure,
- services are triggered either on-demand or periodically,
- outputs are fed back either to operators (decision support) or to actuators.

#### Twinning Process and Digital Twin Evolution (MC13)
The DT evolves over time to improve accuracy and operational capabilities.
- **Model evolution:**  
	The simulation model progresses from a purely hydraulic representation to a **thermo-hydraulic model**, increasing fidelity.
- **Learning strategy evolution:**  
	The initial approach relies on generating dedicated datasets and training models per use case. This process is expected to evolve toward more advanced strategies, such as **continual learning**, enabling adaptation without full retraining.
- **Operational adaptation:**  
	The DT incorporates mechanisms such as divergence detection, which trigger recalibration or parameter updates during operation.

	
#### Fidelity and Validity Considerations (MC14)
The fidelity of the DT depends on the accuracy of both simulation and data-driven components, as well as their interaction.
Key aspects include:
- **Parameter representation:**  
	The DT relies on a set of parameters exchanged between the physical and virtual systems. Their accuracy, level of abstraction, and uncertainty directly influence model validity.
- **Impact of hybridization:**  
	Machine learning models (fault localization and estimation) influence DT fidelity by dynamically updating simulation parameters. While this improves adaptability, it introduces potential uncertainties related to model generalization and data quality.
- **Validation mechanisms:**  
	Ensuring fidelity requires:
	- validation of updated parameters against observed data,
	- monitoring divergence between DT and physical twin,

Overall, fidelity is not static but emerges from the **continuous interaction between physics-based models, data-driven models, and real-world observations**. The interaction between these models illustrates a hybrid architecture, where physics-based simulation is augmented by data-driven inference mechanisms.
		
### Deployment
The deployment of the digital twin (DT) for the fluidic loop is based on a **distributed edge–cloud architecture**, ensuring reliable communication between the physical system, computational components, and user interfaces. This architecture supports real-time data acquisition, model execution, and bidirectional interaction with the physical twin.

#### Digital Twin Technical Connection (MC15)
The DT deployment relies on a multi-layer communication infrastructure structured along three main segments:
- Factory-to-Edge Layer
	At the physical level, sensors and actuators are connected to an **industrial controller (Beckhoff PLC)**, which serves as the primary interface with the physical system. This controller aggregates sensor measurements (e.g., pressures, temperatures, pump speed) and transmits them through an industrial communication stack.
	Communication between the factory and the edge is ensured through:
	- **OPC UA protocols**, enabling standardized industrial data exchange,
	- **MQTT-based connectors**, facilitating efficient data transmission toward cloud services.
- Edge-to-Cloud Layer
	The edge layer communicates with the cloud infrastructure to enable scalable data processing and storage. This connection is implemented using:
	- **Azure IoT Operations**, acting as a gateway for device management and data ingestion,
	- **Azure Event Hub**, supporting high-throughput streaming of telemetry data,
	- Secure communication channels based on **VPN, firewall configurations, and identity management (Azure Active Directory)**. 
	This layer ensures the reliable transfer of both real-time and historical data to the cloud environment, where most DT services are executed.
- Cloud-to-Edge Layer
	The DT also supports feedback from the virtual environment to the physical system. A .NET containerized application, deployed on a Kubernetes cluster at the edge (via Azure Arc), interacts with cloud APIs to retrieve computed results .
	These outputs are transmitted back to the industrial controller using the **TwinCAT ADS communication library**, enabling the Beckhoff PLC to actuate system components accordingly.

#### Digital Twin Hosting and Deployment (MC16)
The DT is hosted across a **hybrid infrastructure**, combining edge and cloud resources:
- **Edge computing layer:**
	- Industrial PC for local execution and low-latency operations,
	- Kubernetes cluster for containerized services,
	- Real-time interaction with the physical system.
- **Cloud computing layer:**
	- Azure-based services for scalable data processing,
	- Data Lake for persistent storage,
	- Event-driven computation (Azure Functions),
	- Model management (FMU registry).
- **Application layer:**
	Web-based interface for visualization, monitoring, and user interaction.
			
### Operation
The operation phase of the digital twin (DT) describes how the system delivers value in real-time through continuous interaction with the physical twin, data processing, and decision support. It focuses on **service execution, synchronization mechanisms, and operational insights** derived from the DT.

#### Insights and Decision-Making (MC17)
At the operational level, the DT provides several value-added services supporting monitoring, diagnosis, and optimization of the fluidic loop:
#####  **Cavitation detection:**  
The DT evaluates operating conditions to detect cavitation risks within the hydraulic system using the simulation model.
##### Virtual sensing  
In case of sensor failure (e.g., flow rate sensor), the DT estimates missing variables using the simulation model, ensuring continuity of monitoring.
##### Energy consumption analysis  
The DT simulates different cooling strategies (e.g., fast, medium, slow cooling scenarios) and evaluates their energy impact, enabling informed operational decisions.
##### Divergence detection
The DT continuously compares simulated outputs with real measurements to identify discrepancies. When divergence is detected, it triggers recalibration or parameter update processes.
			
## Hybridization perspective
To ensure consistency with the digital twin (DT) description, the **hybridization characteristics (HC)** are introduced by establishing a direct correspondence with the **Bentley _et al._ framework**. While Bentley et al. structure a DT along its lifecycle dimensions (requirements, realization, deployment, operation), the hybridization characteristics refine this description by **focusing specifically on how deductive and inductive models are combined**, why this combination is needed, and how it evolves within the DT. n this perspective, hybridization is not treated as an isolated concept but as a **cross-cutting concern** embedded within the DT characteristic. HC is structured along two complementary dimensions: **Motivation** and **Realization**. This decomposition is consistent with  Bentley _et al._, where motivation aligns with **requirements, conceptualization, and design (MC1–MC6)**, while realization relates to **implementation and operation aspects (MC10–MC14, MC7, MC17)**.
#### Motivation Dimension
The motivation dimension captures **why hybridization is introduced**, independently of its implementation. It formalizes the problem context, the limitations of existing DT assets, and the expected capabilities of the hybridized system.

#### Overview / Context
(Link to MC1: System under study, MC6: DT services, MC10: Models). The considered DT is based on a **1D thermo-hydraulic simulation model** used to support multiple operational services, including flow simulation, cavitation detection, and energy analysis. 
This simulation model constitutes the **core deductive component** of the DT. However, the increasing demand for adaptive and reliable services (MC6) highlights the need to extend this model beyond its original static capabilities. Hybridization is introduced in this context as a mechanism to **augment the DT with adaptive capabilities while preserving the existing simulation-based structure**.

#### Problem Statement
(Link to MC6: Services, MC14: Fidelity and validity)
The DT faces a fundamental limitation:  
the **simulation model is calibrated only once during the creation phase**, and its parameters remain fixed during operation. 
As a consequence:
- the DT cannot account for **system evolution, degradation, or unforeseen operating conditions**,
- discrepancies arise between simulated outputs and real measurements,
- the **reliability of DT services (MC6)** is degraded,
- the **fidelity of the DT (MC14)** decreases over time.
The core problem can therefore be stated as follows:
> _How can the DT maintain alignment with the physical system despite evolving conditions, without requiring repeated manual recalibration?_
#### Existing Twin Assets and Gaps
_(Link to MC10: Models and data, MC14: Fidelity)_
The DT already includes:
- a **physics-based simulation model**,
- a **data infrastructure** (sensor streams, data lake),
- an initial **parameter calibration**.
However, the following gaps are identified:
- **Static parameterization:** no mechanism for runtime adaptation,
- **Lack of causal diagnosis:** inability to identify which parameters explain observed discrepancies,
- **Limited robustness:** reduced performance under unmodeled or rare conditions.

Hybridization addresses these gaps by introducing **inductive models** that:
- identify the parameters responsible for deviations,
- infer updated parameter values based on observed data. 

#### Intended Deliverable Capability (IDC)
_(Link to MC6: Services, MC12: DT constellation, MC10: Models)_
Hybridization aims to provide the following capabilities within the DT:	
- **Parameter identification capability:**  
	Determine which model parameters must be updated to explain discrepancies.
- **Parameter estimation capability:**  
	Infer corrected values or correction laws for the identified parameters.
- **Adaptive simulation capability:**  
	Enable the simulation model to **continuously reflect the behavior of the physical system** without direct recalibration.
These capabilities enhance the DT by enabling **adaptive and self-consistent behavior**, directly improving service reliability (MC6) and model interaction within the DT constellation (MC12).

#### Conceptual Requirements
_(Link to MC10: Data and models, MC13: Evolution, MC14: Fidelity)_
To ensure the validity of hybridization, the following requirements are defined:
- **Coverage of operating conditions:**  
	Training datasets must span a sufficiently wide range of control configurations.
- **Consistency of dataset semantics:**  
	Datasets must be generated with fixed nominal parameters; any change requires a new dataset version.
- **Parameter sampling adequacy:**  
	Each parameter must be sufficiently sampled to allow stable inference.
- **Validation before deployment:**  
	Any parameter update must be validated before being applied; otherwise, previous values must be retained.
These requirements ensure that hybridization:
	- preserves **model validity and robustness (MC14)**,
	- supports controlled **DT evolution (MC13)**. 

#### Deliverable Requirements
_(Link to MC11: Tooling, MC12: Constellation, MC17: Operation)_
The outputs of hybridization namely the inductive models must satisfy operational constraints:
- **Low latency:**  
	Predictions must be computed within time constraints compatible with DT services.
- **Stability:**  
	Outputs must not disrupt existing simulation workflows.
These requirements ensure seamless integration of hybridization into:
- the DT execution environment (MC11),
- the orchestration of services (MC12),
- real-time operation (MC17).


# Result
- What becomes clearer when using Bentley + hybridization lens
- Examples of explicit decisions that were previously implicit:
	- ??? why ML was used (e.g., compensate unknown friction losses)
	- ??? how it was integrated (residual, surrogate, parameter estimator)
- Evidence types:
	- engineering traceability improvements
	- stakeholder feedback (if you have it)
	- reduced ambiguity in documentation
		- easier onboarding of new team members (if applicable)
    
# Discussion & Conclusion
- What your framework enables; next steps.