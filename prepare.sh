#!/bin/bash

ROOT_DIR=$(git rev-parse --show-toplevel)

for platform in $(find "${ROOT_DIR}"  -type d -mindepth 1 -maxdepth 1 -not -path '*/\.git/*'); do
    for module in $(find "${platform}"  -type d -mindepth 1 -maxdepth 1 -not -path '*/\.git/*'); do
        cd "${module}"
        echo "Working on ${module}"
        echo "Formating Terraform"
        terraform fmt -recursive
        echo "Generating docs"
        terraform-docs markdown table --output-file README.md --output-mode inject ./
    done
done
cd ${ROOT_DIR}
git commit -am "Script: Adjust formatting and docs"