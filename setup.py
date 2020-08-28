import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="comparatorWL",
    version="0.0.3",
    author="Tony Kappen",
    author_email="tkappen.neppak@gmail.com",
    description="An implementation of Weisfeiler-Leman algorithm to compare programs",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/mrKappen/comparator",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
)