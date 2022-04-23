#! /bin/bash

# If using bash, the bash native parser to load in the environment variables.
# https://stackoverflow.com/a/28794976

# For bourne shell, we'll need to use the .env source command.
export ENVFILE=".env"
echo "Loading envvars from '${ENVFILE}'..."
export $(grep = ${ENVFILE} | sed 's/#.*//g' | tr -d '" ' | xargs)

# Rebuild project.
#   Run pre-commit hooks.
#   Run pytest hooks.
make build

# Set the REPOSITORY using the PYPI_REPOSITORY envvar
if [ -n ${PYPI_REPOSITORY:+exists} ]; then
    REPOSITORY=${PYPI_REPOSITORY}
else
    printf "Please enter the repository name:"
    read REPOSITORY
    printf "\n"
fi

# Set the USERNAME using the PYPI_USERNAME envvar
#   or by using the default '__token__'
if [ -n ${PYPI_USERNAME:+exists} ]; then
    USERNAME=${PYPI_USERNAME}
else
    printf "Please enter your username:"
    read USERNAME
    printf "\n"
fi

# Notify user about reason for authentication request.
printf "\nLogging into package index repository '${REPOSITORY}' with username: ${USERNAME}\n"

# Set the PASSWORD using the PYPI_AUTH_TOKEN envvar
#   or by requesting input from the user.
if [[ -n ${PYPI_PASSWORD:+exists} ]]; then
    PASSWORD=${PYPI_PASSWORD}
else
    stty -echo
    printf "Please enter your password:"
    read PASSWORD
    stty echo
    printf "\n"
fi

# Execute poetry publish.
poetry publish -r ${REPOSITORY} --username ${USERNAME} --password ${PASSWORD}

RESULT=$?
if [ $RESULT -gt 0 ]; then
    printf "Failed to upload repository to repo.\n"
else
    printf "Successfully uploaded project to repository.\n"
    poetry version patch
fi
