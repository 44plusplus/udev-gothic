#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
WORK_DIR="$BASE_DIR/build_tmp"
BUILD_DIR="$BASE_DIR/build"

VERSION='0.0.5'

FAMILYNAME="UDEVGothic"
DISP_FAMILYNAME="UDEV Gothic"
FAMILYNAME_LIGA="UDEVGothicLG"
DISP_FAMILYNAME_LIGA="UDEV Gothic LG"
FAMILYNAME_JPDOC="UDEVGothicJPDOC"
DISP_FAMILYNAME_JPDOC="UDEV Gothic JPDOC"

if [ ! -d "$BUILD_DIR" ]
then
  mkdir "$BUILD_DIR"
fi

# リガチャなし版の生成
"${BASE_DIR}/generator.sh" "$VERSION" "$FAMILYNAME" "$DISP_FAMILYNAME" 0 0
"${BASE_DIR}/os2_patch.sh" "$FAMILYNAME"
"${BASE_DIR}/cmap_patch.sh" "$FAMILYNAME"
mv "$WORK_DIR/$FAMILYNAME"*.ttf "$BUILD_DIR"
rm -rf "$WORK_DIR"

# リガチャあり版の生成
"${BASE_DIR}/generator.sh" "$VERSION" "$FAMILYNAME_LIGA" "$DISP_FAMILYNAME_LIGA" 1 0
"${BASE_DIR}/os2_patch.sh" "$FAMILYNAME_LIGA"
"${BASE_DIR}/cmap_patch.sh" "$FAMILYNAME_LIGA"
mv "$WORK_DIR/$FAMILYNAME_LIGA"*.ttf "$BUILD_DIR"
rm -rf "$WORK_DIR"

# JPDOC版の生成
"${BASE_DIR}/generator.sh" "$VERSION" "$FAMILYNAME_JPDOC" "$DISP_FAMILYNAME_JPDOC" 0 1
"${BASE_DIR}/os2_patch.sh" "$FAMILYNAME_JPDOC"
"${BASE_DIR}/cmap_patch.sh" "$FAMILYNAME_JPDOC"
mv "$WORK_DIR/$FAMILYNAME_JPDOC"*.ttf "$BUILD_DIR"
rm -rf "$WORK_DIR"
