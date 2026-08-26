#!/bin/bash

ENV_FILE=$1

if [ -z "$ENV_FILE" ]; then
    echo "Usage: ./create_environment.sh environment.yml"
    exit 1
fi

# ---------------------------------------------------------
# Read environment name and Python version
# ---------------------------------------------------------

ENV_NAME=$(grep '^name:' "$ENV_FILE" | awk '{print $2}')
PYTHON_VERSION=$(grep '^python:' "$ENV_FILE" | awk '{print $2}')

echo "Environment: $ENV_NAME"
echo "Python:      $PYTHON_VERSION"

# ---------------------------------------------------------
# Check that we are not currently in the environment
# ---------------------------------------------------------

CURRENT_ENV=$(pyenv version-name)

if [ "$CURRENT_ENV" = "$ENV_NAME" ]; then
    echo ""
    echo "ERROR: You are currently inside '$ENV_NAME'."
    echo "Please deactivate it first:"
    echo ""
    echo "    pyenv deactivate"
    echo ""
    exit 1
fi

# ---------------------------------------------------------
# Remove existing environment
# ---------------------------------------------------------

if pyenv versions --bare | grep -q "^${ENV_NAME}$"; then

    echo ""
    echo "Environment '$ENV_NAME' already exists."
    echo "Removing it..."

    pyenv uninstall -f "$ENV_NAME"
fi

# ---------------------------------------------------------
# Install Python if necessary
# ---------------------------------------------------------

if ! pyenv versions --bare | grep -q "^${PYTHON_VERSION}$"; then

    echo ""
    echo "Installing Python $PYTHON_VERSION..."

    pyenv install "$PYTHON_VERSION"
fi

# ---------------------------------------------------------
# Create environment
# ---------------------------------------------------------

echo ""
echo "Creating environment '$ENV_NAME'..."

pyenv virtualenv "$PYTHON_VERSION" "$ENV_NAME"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create environment."
    exit 1
fi

# ---------------------------------------------------------
# Get path of NEW environment
# ---------------------------------------------------------

ENV_PATH=$(pyenv prefix "$ENV_NAME")

echo ""
echo "New environment:"
echo "$ENV_PATH"

# Use Python and pip DIRECTLY from the new environment
ENV_PYTHON="$ENV_PATH/bin/python"
ENV_PIP="$ENV_PATH/bin/pip"

echo ""
echo "Python executable:"
echo "$ENV_PYTHON"

echo ""
echo "Pip executable:"
echo "$ENV_PIP"

# ---------------------------------------------------------
# Extract pip packages from YAML
# ---------------------------------------------------------

TEMP_REQUIREMENTS=$(mktemp)

awk '
    /^pip:/ {
        in_pip=1
        next
    }

    in_pip && /^  - / {
        sub(/^  - /, "")
        print
        next
    }

    in_pip && !/^  - / {
        exit
    }
' "$ENV_FILE" > "$TEMP_REQUIREMENTS"

echo ""
echo "Packages to install:"
echo "----------------------------------------"
cat "$TEMP_REQUIREMENTS"
echo "----------------------------------------"

# ---------------------------------------------------------
# Install packages into NEW environment
# ---------------------------------------------------------

echo ""
echo "Installing packages into $ENV_NAME..."

"$ENV_PYTHON" -m pip install --upgrade pip

"$ENV_PYTHON" -m pip install -r "$TEMP_REQUIREMENTS"

if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: Package installation failed."
    rm "$TEMP_REQUIREMENTS"
    exit 1
fi

rm "$TEMP_REQUIREMENTS"

# ---------------------------------------------------------
# Verify installation
# ---------------------------------------------------------

echo ""
echo "========================================"
echo "Environment successfully created!"
echo "========================================"

echo ""
echo "Environment:"
echo "    $ENV_NAME"

echo ""
echo "Python:"
"$ENV_PYTHON" --version

echo ""
echo "Installed packages:"
"$ENV_PYTHON" -m pip freeze

echo ""
echo "To activate it:"
echo "    pyenv activate $ENV_NAME"