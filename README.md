# CqrlogImproved
Improved clone from Cqrlog (by Petr, OK2CQR & Martin OK1RR) (development branch)

This is a version of Cqrlog that I have modified to meet my own needs and simply because programming is fun. Despite Petr's suggestion, I am not going to rename this project. My version includes hundreds of additions, fixes, and improvements compared to the original Cqrlog 2.5.2, but Petr remains the owner of this product, and I have no intention of 'stealing' it by renaming it.

Because the previous name 'CqrlogAlpha' caused confusion, I now call this 'CqrlogImproved'. The concept is similar to how Uwe (DG2YCB) manages his version of the original WSJT-X. Like Uwe's version, which features numerous improvements over the original WSJT-X while remaining compatible with its origin, my version follows the same philosophy.

You are free to use and modify this according to the rules of the open-source license. If you wish to keep your original Cqrlog 2.5.2 installation but also try this version, you can copy the binary (src/cqrlog) and rename it (e.g., to /usr/bin/cqrlog2). Simply run make, make cqrlog_qt5, or make cqrlog_qt6—do not run make install. If you store your logs locally, you just need to copy your ~/.config/cqrlog folder to ~/.config/cqrlog2 and start cqrlog2. This way, you have separate logs and do not need to run make install at all. As long as you do not copy the new help files to /usr/share/cqrlog, the original contents will remain unchanged and can be used by both versions.

MariaDB log databases may differ slightly, but they should be backward compatible for now. The database version numbers are higher than the originals, so whenever the original Cqrlog modifies its database structure, compatibility may break.

