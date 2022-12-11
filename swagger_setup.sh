#!/usr/bin/env bash

# Get swagger-ui latest version
release_tag=$(curl -sL https://api.github.com/repos/swagger-api/swagger-ui/releases/latest | jq -r ".tag_name")

# Delete the dist directory and index.html
rm -fr swagger
# Download the release
curl -sL -o $release_tag https://api.github.com/repos/swagger-api/swagger-ui/tarball/$release_tag
# Extract the dist directory
tar -xzf $release_tag --strip-components=1 $(tar -tzf $release_tag | head -1 | cut -f1 -d"/")/dist
rm $release_tag
# Move index.html to the root
# mv dist/index.html .
# Fix references in dist/swagger-initializer and index.html
sed -i "" "s|https://petstore.swagger.io/v2/swagger.json|swagger.yaml|g" dist/swagger-initializer.js
# sed -i "s|href=\"./|href=\"dist/|g" index.html
# sed -i "s|src=\"./|src=\"dist/|g" index.html
# sed -i "s|href=\"index|href=\"dist/index|g" index.html
cp swagger.yaml dist/swagger.yaml
mv dist swagger