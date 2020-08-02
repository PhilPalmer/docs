FROM continuumio/miniconda:4.6.14
LABEL authors="phil@lifebit.ai" \
      description="Docker image containing requirements for FastQC"

# Install procps so that Nextflow can poll CPU usage
RUN apt-get update && apt-get install -y procps && apt-get clean -y

# Install Conda packages
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/fastqc/bin:$PATH