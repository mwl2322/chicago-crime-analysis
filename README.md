# chicago-crime-analysis
Data analysis &amp; visualization of the Chicago crime dataset using Python and PostgreSQL.
# Chicago Crime Data Analysis (EDA & Geospatial Visualization)

This project explores a sample of Chicago crime records using **Python**, **Pandas**, **Matplotlib**, and **Folium** to uncover patterns in crime types, arrest outcomes, time trends, and geographic distribution.

## Project Overview
The goal of this project is to demonstrate an end-to-end **exploratory data analysis (EDA)** workflow, including:
- Data cleaning and type conversion  
- Descriptive statistics  
- Visual analytics  
- Geospatial heat map visualization  
- Interpretation of results and limitations  

## Dataset
- Sample dataset containing **200 crime records**
- Fields include crime type, date, arrest status, location description, year, latitude, and longitude
- Coordinates are approximate/synthetic and filtered to realistic Chicago bounds

## Tools & Technologies
- Python 3  
- Pandas  
- Matplotlib  
- Folium (interactive heat maps)  
- Jupyter Notebook  

## Key Analyses
- Crime count by primary type  
- Arrest vs. no-arrest comparison  
- Crime trends by year  
- Crime distribution by location description  
- Geospatial heat map of crime incidents  
- Arrest rate by crime type (advanced insight)  

## Key Insights
- **ASSAULT** was the most frequent crime type in this dataset.  
- The majority of crimes did not result in an arrest.  
- Crime counts show year-to-year variation, with a noticeable increase around 2021.  
- Crimes were most common in **APARTMENT**, **RESIDENCE**, and **STREET** locations.  
- The filtered heat map highlights spatial clustering of incidents across Chicago.  

## Limitations
- Small sample size (200 rows)  
- Coordinates may be approximate  
- Results are directional and not representative of all Chicago crime data  

## Possible Extensions
- Time-of-day analysis  
- Community-area crime patterns  
- Domestic vs. non-domestic comparison  
- Predictive modeling for arrest likelihood  
- SQL / PostgreSQL version of the analysis  

## Outputs
- Cleaned analysis tables  
- Interactive heat map (`chicago_crime_heatmap_filtered.html`)  
- Jupyter Notebook containing the full analysis  

## Author
**Mohammed**  
Focus areas: Data Analysis, Python, Visualization, Geospatial Analysis
