# ATLAS Open Data Black Box
- What are we doing here?


## Set up the environment
First, you have to clone the ATLAS Open Data Git repository. Open your terminal and run:
```
git clone https://github.com/atlas-outreach-data-tools/notebooks-collection-opendata atlas-open-data
cd atlas-open-data/for-education/blackbox
```
You are now in the directory containing all the files required to create your own black box.

To execute the code, several Python packages are required. To ensure that the correct Python version and all required packages are available, you can use `pyenv` to create an environment that fulfills all requirements. First, install `pyenv` by following [these](https://github.com/pyenv/pyenv#installation/#) instructions. 

The required packages are listed in `environment.txt`. To install them, you can use the `create_environment.sh` script. Make the script executable and run it:
```
chmod +x create_environment.sh
./create_environment.sh environment.txt
```
An environment named `blackbox` is ceated. To activate it, run: 
```
pyenv activate blackbox
```
To deactivate it, run `pyenv deactivate blackbox`.


## Specify your parameters in the config
In the config file, the content of the black box is specified. You can use the template `tmp_config.json`, while a concrete example is provided in `Zprime_config.json`.
First, you can define the signal and background DSIDs. An overview of the available 13 TeV 2025 data can be found [here](https://opendata.atlas.cern/docs/data/for_education/13TeV25_metadata/#). In addition, the number of signal and background events has to be specified.
Next, the desired variables are listed. [Here](https://opendata.atlas.cern/docs/data/for_education/13TeV25_details/#), you can find all available variable names, as well as the possible skims, which act as a preselection for the events.
Finally, the name of the output directory is defined.


## Run the code to create the black box
Now you can run the code with your config:
```
python create_blackbox.py your_config.json
```
A checkpoint directory is created. In its events subdirectory, the events for each DSID are stored in a Parquet file once processing of the DSID is complete. Once all DSIDs have been processed, all events are combined and shuffled. The event variables are saved in blackbox_data.parquet, while the labels are stored in blackbox_labels.parquet.
In the notebook `explore_blackbox.ipynb`, you can find an example of how to load the black box and explore the output.


## Example: Z'$\rightarrow\mu\mu$
- why is this interesting
- config Zprime_config.json
    - choose signal and background DSIDs
    - choose skim
- run the code with Z' config:
```
python create_blackbox.py Zprime_config.json
```

