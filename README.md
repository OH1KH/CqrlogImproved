# CqrlogImproved
Improved clone from Cqrlog (by Petr, OK2CQR & Martin OK1RR)

This is Cqrlog version that I have modified by my needs and because of programming is fun.
Despite Petr's suggest I am not going to rename this project with other name.
My version has hundreds of additions, fixes and improvements compared to original 2.5.2 Cqrlog, but anyhow Petr is still the owner of this product and I am not going to steal it using another name.

Because of the previous CqrlogAlpha name caused misleading I call this now CqrlogImproved. The idea is same that Uwe, DG2YCB, uses with his verson of original Wsjt-x. Same way Uwe's version has great number of improvements to original Wsjt-x, but is still compatible with it's origin.

You can use and modify this by your needs by the rules of open source licence.
If you like to keep your old workhorse Cqrlog 2.5.2 but also try this you can rename and copy this binary (src/cqrlog) to another name like /usr/bin/cqrlog2. (run just make, make cqrlog_qt5 or make cqrlog_qt6, do not run make install)
Then, if you "save your logs to local machine", you just need to copy your ~/.config/cqrlog folder to ~/.config/cqrlog2 and start the cqrlog2.  Then you have separated logs and you do not need to run the "make install" at all.
If you do not copy new help files to /usr/share/cqrlog it's contents does not change and can be used by both versions.

MariaDB log databases may differ a bit, but they should be backwards compatible so far. DB version numbers are higher than originals, so when ever the original Cqrlog modifies it's DB version numbers the compatibility will break.

