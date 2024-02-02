# Metabolic Syndrome, risk factors analysis ###

by Carmen Matos & Elisa Cerdá Doñate

  content:    
        
        metabolic.ipynb, 
        metabolic.sql,  
        metabolic.csv,
        Metabolic Syndrome (Google Slides),
        README.md


### The project:
We started with a Kaggle dataset, which we cleaned using the Pandas library in Python. 
After transferring the cleaned data to MySQL, where we ran queries to extract insights, we created visualisations using Tableau and Python to validate our hypothesis. 
This whole process culminated in the integration of our findings into our final presentation.

[View PDF Presentation](https://github.com/calumatos/Metabolic-Syndrome/blob/main/Metabolic%20Syndrome.pdf)

#### About the dataset:
A Comprehensive Dataset on Risk Factors and Health Indicators. This dataset contains information on individuals with metabolic syndrome, a complex medical condition associated with a cluster of risk factors for cardiovascular diseases and type 2 diabetes. The data includes demographic, clinical, and laboratory measurements, as well as the presence or absence of metabolic syndrome.
https://www.kaggle.com/datasets/antimoni/metabolic-syndrome


#### Column Descriptors:

1. **seqn:** Sequential identification number.
2. **Age:** Age of the individual.
3. **Sex:** Gender of the individual (e.g., Male, Female).
4. **Marital:** Marital status of the individual.
5. **Income:** Income level or income-related information.
6. **Race:** Ethnic or racial background of the individual.
7. **WaistCirc:** Waist circumference measurement.
8. **BMI:** Body Mass Index, a measure of body composition.
9. **Albuminuria:** Measurement related to albumin in urine.
10. **UrAlbCr:** Urinary albumin-to-creatinine ratio.
11. **UricAcid:** Uric acid levels in the blood.
12. **BloodGlucose:** Blood glucose levels, an indicator of diabetes risk.
13. **HDL:** High-Density Lipoprotein cholesterol levels (the "good" cholesterol).
14. **Triglycerides:** Triglyceride levels in the blood.
15. **MetabolicSyndrome:** Binary variable indicating the presence (1) or absence (0) of metabolic syndrome.
