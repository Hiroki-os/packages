#!/bin/bash
# Paket Ekleme Scripti
# Kullanim:
#   ./repo-ekle paket-1.0-1-x86_64.pkg.tar.zst

set -e
REPO_DIR="x86_64"
DB_NAME="hiroki"

if [ $# -eq 0 ]; then
    echo "Kullanim: $0 <paket.pkg.tar.zst> [paket2.pkg.tar.zst ...]"
    exit 1
fi

mkdir -p "$REPO_DIR"

for pkg in "$@"; do
    if [ ! -f "$pkg" ]; then
        echo "HATA: $pkg bulunamadi"
        exit 1
    fi
    cp "$pkg" "$REPO_DIR/"
    echo "Kopyalandi: $pkg"
done

repo-add "$REPO_DIR/$DB_NAME.db.tar.gz" "$REPO_DIR/"*.pkg.tar.zst
echo ""
echo "Basariyla eklendi!"
echo "Simdi commit & push yap:"
echo "  git add ."
echo "  git commit -m \"yeni paket\""
echo "  git push"
