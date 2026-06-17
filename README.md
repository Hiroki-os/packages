# muz - Hiroki OS Paket Yoneticisi

`muz`, Hiroki OS icin ozel paket yoneticisidir.

## Kullanim

```
muz install <paket>       # pacman ile yukle (normal)
muz ara <paket>            # paket ara
muz sil <paket>            # paket sil
muz guncelle               # sistemi guncelle (pacman -Syu)

muz lu install <paket>     # kendi repondan yukle
muz lu -S <paket>          # kendi repondan yukle
```

## Kendi Paket Sunucunu Kur

### 1. GitHub'da repo ac

1. https://github.com  -> Yeni repo -> Adi: `packages`
2. `Settings` -> `Pages` -> `Deploy from branch` -> `main` -> Kaydet

### 2. Repoyu klonla

```bash
git clone https://github.com/hiroki-os/packages.git
cd packages
```

### 3. Bu klasordeki dosyalari kopyala

```
packages/
  index.html
  repo-ekle.sh
  muz/
    usr/bin/muz
```

### 4. Paket ekle

```bash
# Once bir PKGBUILD hazirla, sonra:
makepkg -si                    # Derle
./repo-ekle.sh paket-1.0-1-x86_64.pkg.tar.zst

# GitHub'a gonder
git add .
git commit -m "paket eklendi"
git push
```

Bir kere push ettikten sonra sunucun hazir:
```
https://hiroki-os.github.io/packages/
```

### 5. ISO'ya ekle

`/etc/pacman.conf` icine:
```ini
[hiroki]
Server = https://hiroki-os.github.io/packages/$arch
```

## Paket Nasil Hazirlanir

Ornek PKGBUILD (`hiroki-welcome` icin):

```bash
pkgname=hiroki-welcome
pkgver=1.0
pkgrel=1
pkgdesc="Hiroki OS Hos Geldin Ekrani"
arch=(x86_64)
depends=(python-pyqt5)
source=(main.py)

package() {
    install -Dm755 main.py "$pkgdir/usr/bin/hiroki-welcome"
}
```

```bash
makepkg -si              # derle
ls *.pkg.tar.zst         # paket bu
./repo-ekle.sh *.pkg.tar.zst
```

## ISO Olmadan Test

Mevcut sisteminde dene:

```bash
sudo cp muz/usr/bin/muz /usr/local/bin/muz
sudo chmod +x /usr/local/bin/muz
muz --version
```
