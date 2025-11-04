#!/bin/bash
set -e
#sudo apt-get update

#sudo apt-get install -y git-lfs

#git lfs update --force
echo "Adding game wrappers to .bashrc..."
echo 'source /workspaces/terminus-like-template/.game/wrappers.sh 2>/dev/null || true' >> ~/.bashrc
echo "✅ Setup complete!"