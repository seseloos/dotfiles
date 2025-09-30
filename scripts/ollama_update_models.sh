#!/bin/bash

# Get the list of models from the Docker container
models=$(ollama list | tail -n +2 | awk '{print $1}')
model_count=$(echo "$models" | wc -w)

echo "You have $model_count models available. Would you like to update all models at once? (y/n)"
read -r bulk_response

case "$bulk_response" in
  y|Y)
    echo "Updating all models..."
    for model in $models; do
      ollama pull "$model"
    done
    ;;
  n|N)
    # Loop through each model and prompt the user for input
    for model in $models; do
      echo "Do you want to update the model '$model'? (y/n)"
      read -r response

      case "$response" in
        y|Y)
          ollama pull "$model"
          ;;
        n|N)
          echo "Skipping '$model'"
          ;;
        *)
          echo "Invalid input. Skipping '$model'"
          ;;
      esac
    done
    ;;
  *)
    echo "Invalid input. Exiting."
    exit 1
    ;;
esac
