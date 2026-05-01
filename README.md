# GitHub Repository — "The Role of Prior Knowledge and Probabilistic Framing on the Illusion of Causality"
 
This repository contains all supplementary materials for the project *"The Role of Prior Knowledge and Probabilistic Framing on the Illusion of Causality"*.
 
The project description is available on OSF: [OSF Project](https://osf.io/qf5xm/?view_only=c3c8308055654455b19bfa6ded2473ef).
Please read the OSF project page and the related pre-registrations before accessing the materials below.
 
---
 
## Materials Before Data Collection
 
### Experiment 1
 
- **`Back Translation/`** — Results of the back-translation procedure used to translate the three experimental conditions from Italian to English.
- **`Conditions/`** — The `.xlsx` file used to run the PsychoPy experiment with a null contingency.
- **`Design Analysis/`** — Sample size determination procedure and the priors used to provide statistical evidence for both H0 and H1.

### Experiment 2
 
- **`Back Translation/`** — English texts for the second experiment.
- **`Conditions II/`** — The `.xlsx` file used to run the PsychoPy experiment with a positive contingency.
- **`Design Analysis II/`** — Inferential risk determination procedure for Experiment 2, matched to Experiment 1 sample size.
---
 
## Materials After Data Collection
 
### Experiment 1 — `EXP1 Data and Analysis/`
 
- **`RawData_EXP1.zip`** — Raw data from Experiment 1.
- **`firstDataset.csv`** — Cleaned dataset extracted from raw data.
- **`VariablesS.csv`** — Parameter file used by the analysis pipeline to extract the dataset (see analysis document).
- **`tbt.csv`** — Trial-by-trial information extracted during the main task.
- **`MAIN-ANALYSIS1.html`** — Main analysis document for Experiment 1.
### Experiment 2 — `EXP2 Data and Analysis/`
 
- **`RawData_EXP2.zip`** — Raw data from Experiment 2.
- **`secondDataset.csv`** — Cleaned dataset extracted from raw data.
- **`VariablesS.csv`** — Parameter file used by the analysis pipeline to extract the dataset (see analysis document).
- **`tbt.csv`** — Trial-by-trial information extracted during the main task.
- **`MAIN-ANALYSIS2.html`** — Main analysis document for Experiment 2.
---
 
## Other Materials
 
### `Experiment/`
 
Contains the experiment scripts used to run both experiments.
 
- **`Experiment.zip`** — PsychoPy experiment files.
### `MPT Model/`
 
Contains the analysis for constructing the Multinomial Processing Tree (MPT) model used to summarize the main results.
 
- **`MAIN-ANALYSIS-MPT.html`** — MPT model analysis document.
- **`firstDataset.csv`** — Experiment 1 dataset.
- **`secondDataset.csv`** — Experiment 2 dataset.
### `Rater Task/`
 
Contains materials related to the rating of participant strategies on open-ended questions.
 
- **`raterSHINYAPP.R`** — Shiny app used by raters to rate participant strategies.
- **`RaterInstructions.pdf`** — Instructions provided to raters.
- **`DATAEXP1.csv`** — Participants' open-ended responses from Experiment 1.
- **`DATAEXP2.csv`** — Participants' open-ended responses from Experiment 2.
- **`results_x.csv`** — Raw rater outputs.
- **`conditionresolution.csv`** — Conflict resolutions for the condition variable.
- **`inforesolution.csv`** — Conflict resolutions for the info variable.
- **`contextresolution.csv`** — Conflict resolutions for the context variable.
> Resolution files can be opened either via the Shiny app or through the main analysis pipeline.
