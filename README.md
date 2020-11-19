# Container version of Finnish Meteorological Institute Probabilistic Precipitation Nowcasting system (FMI-PPN)

Package for running FMI-PPN nowcasting system (see documentation and further instructions at https://github.com/fmidev/fmippn-oper) inside a container. Contains Dockerfile and example script for building and running it in podman (/docker) with mounted volumes for input and output data.

## Files

* Dockerfile : Builds needed conda environment etc for FMI-PPN
* run_ppn_podman.sh : Example script for building and running the Dockerfile using podman (/docker) with volume mounts for input/output and configuration files
* environment.yml : List of python packages for the conda environment
* pystepsrc : List of used domains, should be modified to add own domain
* *.json : Every domain has its own domain.json file with domain specific configurations. All the used domains should also be listed in pystepsrc.

                                                                                                                                                                                  
~                                                                                                                                                                                      
~                                                                                                                                                           
