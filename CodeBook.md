Codebook
================

## Introduction

This code book explains any differences between the tidy dataset
contained within **tidydata.txt** and the original codebooks that came
with the **UCI HAR Dataset**, namely;

  - Readme.txt

  - features\_info.txt: Shows information about the variables used on
    the feature vector.

  - features.txt: List of all features.

  - activity\_labels.txt: Links the class labels with their activity
    name.

  - Features are normalized and bounded within \[-1,1\] with no units.

to indicate all the variables and summaries calculated, along with
units, and any other relevant information.

## Summary of Modifications

  - Training and Test Data were merged into a single dataset.

  - Activity names were modified to be more descriptive.

  - Only a subset of the data, involving means and standard deviations,
    was extracted from the feature vector. Details in the following
    section.

  - The data was summarised by activity and subject.

## Changes to activity names.

1.  walk
2.  upstairs
3.  downstairs
4.  sit
5.  stand
6.  lie

## Subsetting the data.

The raw feature vector contains 561 predictors. For the purposes of this
exercise, the feature vector was subsetted based on a few criteria. The
resulting feature vector was only 18-long.

1.  Measurements along a single axis (x-,y,z-) were omitted and
    therefore only the magnitudes of the 3D-signal were used. These were
    variables were denoted **Mag** in the raw data.

2.  Only estimations of the mean and standard deviation of the signals
    were included. These variables ended with either *mean()* or
    *std()*.

## Changes to Variable Names

The variable names were modified so that they would be a little easier
to interpret. The new nomenclature scheme can be divided into 5 parts.

1.  Data was measured in the time domain as indicated by the prefix
    **Time**. If the signal was then transformed using FFT, then it was
    given the prefix **Freq**.

2.  Most data was collected based on body acceleration or angular
    velocity, and is denoted **Body**. Otherwise the **Gravity** denotes
    an estimate of the contribution from gravity.

3.  The terms **Linear** and **Angular** referring to linear and angular
    measurements respectively.

4.  **Acceleration**, **Velocity** and **Jerk** refer to the relevant
    motion measurement.

5.  **Mean** and **Std** refer respectively to the mean and standard
    deviation of the signal.
