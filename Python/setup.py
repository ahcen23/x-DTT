from setuptools import setup, find_packages

setup(
    name='DTT',               # Name of your package
    version='0.1',                   # Version number (start with 0.1 for a new package)
    packages=find_packages(),        # Automatically finds your package directory
    install_requires=[               # List any dependencies (e.g., 'numpy', 'scipy')
        'numpy',
    ],
    author='Dr. Ahcen Aliouat',              
    author_email='ahcen2300@gmail.com',  
    description='Easy to use x-DTT MATLAB package for DTT and Integer DTT transform kernel generation. This function exists to facilitate the calculation of Discrete Tchebichef Transform (DTT) and Integer Discrete Tchebichef Transform (IDTT) and its inverse operation (Inverse-IDTT). IDTT is dedicated to the integration of this transformation in the embedded compression systems ( Image and Video Compression) with a low-cost energy budget. While DTT is dedicated to the generation of Discete Tchebichef Transform used for image compression and also for fearures extraction and image analysis. The result of the DTT calculation in this package is a matrix of size NxN. The results of the IDTT operation are two matrices as below:One full Integer Matrix of size NxN named b. One Diagonal Matrix of size NxN named c. The result of the multiplication of b x c is a matrix a.',
    url='https://github.com/ahcen23/x-DTT',  # Optional: link to your repository
)
