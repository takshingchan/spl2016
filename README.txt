
      Complex and Quaternionic Principal Component Pursuit


                Tak-Shing Chan and Yi-Hsuan Yang
     Music and Audio Computing Lab, Academia Sinica, Taiwan


To  reproduce  the results of T.-S. T. Chan and Y.-H. Yang, "Com-
plex and quaternionic principal component pursuit and its  appli-
cation  to  audio  separation,"  Signal Processing Letters, 2016,
please do the following:

1  Download QTFM 2.2 to the "qtfm" directory:
   http://qtfm.sourceforge.net/

2  Download the iKala dataset to the "Datasets\iKala" directory:
   http://mac.citi.sinica.edu.tw/ikala/

3  Download the MUS dataset to the "Datasets\MSD100" directory:
   http://corpus-search.nii.ac.jp/sisec/2015/MUS/MSD100_2.zip

4  To run all experiments (in parallel if you want):
   go('separation','rpca_ikala')
   go('separation','crpca_ikala')
   go('separation','rpca_sisec')
   go('separation','crpca_sisec')
   go('separation','qrpca_sisec')

5  To reproduce Table I:
   go('report','rpca_ikala')
   go('report','crpca_ikala')

6  To reproduce Table II:
   go('report','rpca_sisec')
   go('report','crpca_sisec')
   go('report','qrpca_sisec')

7  To reproduce the t-tests:
   stats_ikala
   stats_sisec

8  If you find this software useful, please cite the above paper.

Happy separation!

Tak-Shing Chan
Yi-Hsuan Yang
31 October 2015
