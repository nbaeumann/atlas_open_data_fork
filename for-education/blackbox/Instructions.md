# ATLAS Open Data Black Box
- What are we doing here?


## Set up the environment
- clone repo
- go to directory

- install pyenv
- install packages (from list)


## Specify your parameters in the config
- decide on signal, background -> where to find DSIDs
- what variables -> link page with names
- nevents, skim, lumi
- directory name


## Run the code to create the black box
- command to run the code
- explain print statements
- explain output


## Example: Z'->\mu\mu
- why is this interesting
- config Zprime_config.json
    - choose signal and background DSIDs
    - choose skim
- run the code with Z' config:
```
python create_blackbox.py Zprime_config.json
```

