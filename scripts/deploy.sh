#!/bin/bash

# Pre-build checks
echo "Running pre-build checks..."
npm run lint || exit 1

# Clean dist directory
echo "Cleaning dist directory..."
rm -rf dist/

# Production build
echo "Building for production..."
NODE_ENV=production npm run build

# Post-build optimizations
echo "Running post-build optimizations..."

# Copy robots.txt and sitemap.xml
cp public/robots.txt dist/
cp public/sitemap.xml dist/

echo "Build completed successfully!"