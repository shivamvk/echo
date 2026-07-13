#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "./scripts/release.sh <version>"
    echo ""
    echo "Example:"
    echo "./scripts/release.sh 1.0.3"
    exit 1
fi

VERSION=$1

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

DERIVED_DATA=$(find ~/Library/Developer/Xcode/DerivedData -maxdepth 1 -type d -name "echo-*")

RELEASE="$DERIVED_DATA/Build/Products/Release"

SPARKLE="$DERIVED_DATA/SourcePackages/artifacts/sparkle/Sparkle/bin"

OUTPUT="$HOME/Desktop/EchoRelease"

mkdir -p "$OUTPUT"

echo ""
echo "📦 Zipping app..."

rm -f "$RELEASE/echo-$VERSION.zip"

ditto \
-c \
-k \
--sequesterRsrc \
--keepParent \
"$RELEASE/echo.app" \
"$RELEASE/echo-$VERSION.zip"

echo "✅ ZIP created"

echo ""
echo "🔐 Signing..."

"$SPARKLE/sign_update" \
"$RELEASE/echo-$VERSION.zip"

echo ""
echo "📁 Copying ZIP..."

cp \
"$RELEASE/echo-$VERSION.zip" \
"$OUTPUT"

echo ""
echo "📰 Generating appcast..."

"$SPARKLE/generate_appcast" \
--download-url-prefix "https://github.com/shivamvk/echo/releases/download/v$VERSION/" \
"$OUTPUT"

mkdir -p "$PROJECT_ROOT/docs"

cp \
"$OUTPUT/appcast.xml" \
"$PROJECT_ROOT/docs/appcast.xml"

echo ""
echo "====================================="
echo "✅ Release prepared!"
echo ""
echo "Next steps:"
echo ""
echo "1. git add docs/appcast.xml"
echo "2. git commit -m \"Release v$VERSION\""
echo "3. git push"
echo ""
echo "4. Create GitHub Release:"
echo "   Tag: v$VERSION"
echo "   Upload:"
echo "   $OUTPUT/echo-$VERSION.zip"
echo ""
echo "====================================="
