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
- decide on signal, background -> where to find DSIDs
- what variables -> link page with names
- nevents, skim, lumi
- directory name


## Run the code to create the black box
Now you can run the code with your config:
```
python create_blackbox.py your_config.json
```
A checkpoint directory is created which holds in the `events` sub directory the events of each DSID saved in a parquet file once it is finished. When all DSIDs are processed all events are combined and shuffeled. the event variables are saves in `blackbox_data.parquet` while the labels are stored in `blackbox_labels.parquet`. In the notebook `!!!` you can find an example how to load the black box and explore the output.


## Example: Z'->\mu\mu
- why is this interesting
- config Zprime_config.json
    - choose signal and background DSIDs
    - choose skim
- run the code with Z' config:
```
python create_blackbox.py Zprime_config.json
```

