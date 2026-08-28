# ATLAS Open Data Black Box
- What are we doing here?


## Set up the environment
- clone repo
- go to directory
```
git clone https://github.com/atlas-outreach-data-tools/notebooks-collection-opendata atlas-open-data
cd atlas-open-data/for-education/blackbox
```

- install pyenv
- install packages (from list)
```
chmod +x create_environment.sh
./create_environment.sh environment.txt
pyenv activate blackbox
```


## Specify your parameters in the config
In the config file, the content of the black box is specified.
First, you can define the signal and background DSIDs. An overview of the available 13 TeV 2025 data can be found [here](https://opendata.atlas.cern/docs/data/for_education/13TeV25_metadata/#). In addition, the number of signal and background events has to be specified.
Next, the desired variables are listed. [Here](https://opendata.atlas.cern/docs/data/for_education/13TeV25_details/#), you can find all available variable names, as well as the possible skims, which act as a preselection for the events.

Finally, the name of the output directory is defined.


## Run the code to create the black box
Now you can run the code with your config:
```
python create_blackbox.py your_config.json
```
A checkpoint directory is created. In its events subdirectory, the events for each DSID are stored in a Parquet file once processing of the DSID is complete. Once all DSIDs have been processed, all events are combined and shuffled. The event variables are saved in blackbox_data.parquet, while the labels are stored in blackbox_labels.parquet.
In the notebook !!!, you can find an example of how to load the black box and explore the output.


## Example: Z'->\mu\mu
- why is this interesting
- config Zprime_config.json
    - choose signal and background DSIDs
    - choose skim
- run the code with Z' config:
```
python create_blackbox.py Zprime_config.json
```

