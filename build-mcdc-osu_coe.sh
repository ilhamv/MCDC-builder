#!/bin/bash -x
cd

# =============================================================================
# Setups
# =============================================================================

# MC/DC branch
MCDC_BRANCH="main"

# Name for the virtual environment
VENV_NAME="mcdc"

# Python versions
PYTHON_VERSION="3.13"

# Paths
WORKSPACE="$HOME"
MCDC_DIR="$WORKSPACE/MCDC"

# =============================================================================
# Preparation
# =============================================================================

# Set modules
module purge
module load slurm
module load conda/25.3
module load intel/oneapi
module load mpi/latest

# =============================================================================
# Create Python environment
# =============================================================================

# Remove any pre-existing instance of the environment
yes | conda env remove --name "$VENV_NAME"

# Create the environment
yes | conda create --name "$VENV_NAME" python="$PYTHON_VERSION"

# Activate the venv
conda activate "$VENV_NAME"

# Make sure we are working with a recent version of pip and setuptools
pip install --upgrade pip
pip install --upgrade setuptools

# =============================================================================
# Install MC/DC
# =============================================================================

# MC/DC
cd "$MCDC_DIR"
git checkout "$MCDC_BRANCH"
pip install -e .[dev]
