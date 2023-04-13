#!/bin/sh

# Build the GitBook
gitbook build

# Copy the built GitBook to the saleor_docs directory
cp -r _book/* saleor_docs

# Clean up the saleor_docs directory
cd saleor_docs
git clean -fx node_modules
git clean -fx _book

