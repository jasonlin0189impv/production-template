from setuptools import find_packages, setup

version = "1.0.0.dev0"


with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

with open("requirements.txt") as fh:
    requirements = fh.readlines()

with open("requirements-dev.txt") as fh:
    requirements_dev = fh.readlines()

setup(
    name="production name",
    version=version,
    author="Ethan Lin",
    author_email="chenshin2475@gmail.com",
    description="production template",
    long_description=long_description,
    long_description_content_type="text/markdown",
    python_requires=">=3.6",
    packages=find_packages(),
    package_data={"": ["resources/jars/*"]},
    install_requires=requirements,
    extras_require={"dev": requirements_dev},
)
