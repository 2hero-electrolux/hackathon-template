#!/usr/bin/env bash
# Hackathon Codespace tools: the Google Cloud CLI (gcloud) and pdftotext. Run on create, and again on start if either is missing.
set -euo pipefail
# The universal image ships an expired Yarn apt source that fails every apt-get update (the Saab az fix, 11 Nov).
sudo rm -f /etc/apt/sources.list.d/yarn.list
if ! command -v gcloud >/dev/null; then
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/cloud.google.gpg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list >/dev/null
fi
sudo apt-get update -qq
sudo apt-get install -y -qq google-cloud-cli poppler-utils
echo "✓ Hackathon codespace ready: $(gcloud --version | head -1)"
