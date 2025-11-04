#!/bin/bash
set -e

echo "Adding game wrappers to .bashrc..."
echo 'source /workspaces/terminus-like-template/.game/wrappers.sh 2>/dev/null || true' >> ~/.bashrc
echo "✅ Setup complete!"