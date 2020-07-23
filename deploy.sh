#!/bin/sh
echo "Stopping app..."

# ./_build/prod/rel/linear/bin/linear stop

echo "Getting dependencies..."

MIX_ENV=prod mix deps.get

echo "Generating static assets..."

npm i --prefix assets
npm run deploy --prefix assets
MIX_ENV=prod mix phx.digest

echo "Building release app..."

MIX_ENV=prod mix release --overwrite

echo "Starting app..."

# ./_build/prod/rel/linear/bin/linear daemon
