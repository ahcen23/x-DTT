# x-DTT
Easy to use x-DTT MATLAB package for DTT and Integer DTT transform kernel generation.
This function exists to facilitate the calculation of Discrete Tchebichef Transform (DTT) and Integer Discrete Tchebichef Transform (IDTT) and its inverse operation (Inverse-IDTT). 

IDTT is dedicated to the integration of this transformation in the embedded compression systems ( Image and Video Compression) with a low-cost energy budget. While DTT is dedicated to the generation of Discete Tchebichef Transform used for image compression and also for fearures extraction and image analysis.

 The result of the DTT calculation in this package is a matrix of size NxN. The results of the IDTT operation are two matrices as below:

- One full Integer Matrix of size NxN named b.

- One Diagonal Matrix of size NxN named c.



The result of the multiplication of b x c is a matrix a.



The original developer is PhD. Ahcen Aliouat. This toolkit runs on MATLAB R2009a or is newer in Microsoft Windows or Linux. 
Mac OS is not officially supported, but should function as intended. 

Contact Ahcen Aliouat <ahcen2300@gmail.com> with any questions, comments, or concerns regarding this toolkit.
