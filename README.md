# Insiders Program
<p align="center">
  <img src="./logo.png" />
</p>

## Overview
This is a clustering project with the goal of creating a loyalty program for an e-commerce business.

The company DataSMart, as well as the Insiders program, are fictitious and serve only to give us a business context for our problem. The data was acquired from the [Ecommerce-Data](https://www.kaggle.com/datasets/carrie1/ecommerce-data) from Kaggle. For this project, we conducted an exploratory analysis, trained different unsupervised machine learning models, applied spatial reduction methods, and automated new processes for forming customer clusters.

From a business perspective, this was a very challenging project and we assumed characteristics based on a model study that took into account a customer segmentation model based on Recency, Frequency, and Monetary. In general, Recency can be considered as "How recently a customer has made a purchase", Frequency as "How often a customer makes a purchase", and Monetary value as "How much money a customer spends on purchases". Additionally, in an [RFM model](https://www.annexcloud.com/blog/revolutionising-segmentation-individualisation-using-rfm-to-step-further/), Recency can be considered as the time since the last purchase and the responsibility of our customers, Frequency as the time between transactions and their engagement on the platform, and Monetary as the total revenue and which high-value purchases were made. 

This RFM model is only possible if the company has a minimum customer relation management policy. An initial customer segmentation is also an activity that could be done in advance of any Machine Learning process for a company, and we can think about our case according to the graph below:

<p align="center">
  <img src="./reports/RFM Segmentation.png"/>
</p>

Some of the categories in the graph are self-explanatory, and our interest is immediately in the categories:

**Champions**: these are customers with recent purchases, but they already make them frequently, spending a high value. We should offer some kind of reward for these customers.

**Loyal Customers**: these customers have made recent purchases or make them frequently while spending a good amount of money on them. We can think of a loyalty program (like Insiders) and take upsell actions.

**In Need of Attention**: customers that could be lost if they are not engaged.

**New Customers**: here are customers who have made recent purchases but only do so with low frequency. We need to work on building relationships and offer a catalog of special offers.

**At Risk**: customers who have not made recent purchases. They should be targeted with reactivation campaigns, offers, and products.

We want to know exactly who our Champions are, which we will call Insiders.

# 1. Business Problem

## 1.1. Business Context
The company DataSMart is a "Multi Brand Outlet" that sells second-line products from various brands at a lower price through an e-commerce platform. In just over a year of operation, the marketing team noticed that some customers in their base buy higher-priced products with high frequency, contributing a significant portion of the company's revenue.

Based on this insight, the marketing team is launching a loyalty program for the best customers in their base, called "Insiders". However, the team does not have advanced knowledge in data analysis to select program participants. For this reason, the marketing team requested the data team to provide a selection of eligible customers for the program using advanced data manipulation techniques.

## 1.2. Objectives
We need to determine who the eligible customers are to participate in the Insiders program. With this list, the marketing team will carry out a series of personalized and exclusive actions for this group to increase revenue and purchase frequency. As a result of this project, we expect you to deliver a list of eligible people to participate in the Insiders program, along with a report answering the following questions:

1. Who are the eligible people to participate in the Insiders program?
2. How many customers will be part of the group?
3. What are the main characteristics of these customers?
4. What percentage of revenue contribution comes from Insiders?
5. What is the revenue expectation for this group in the next few months?

# 2. Business Assumptions

## 2.1. General 
We assume that the marketing team will require constant updates of these customer clusters in order to promote purchases at the DataSMart. To achieve this, a simple automation was devised using different Python libraries to automate this process on the local network as well as in the cloud, with data projection for presentation with Metadata.

## 2.2. Variables
| Feature                  | Description                                                  |
| -----------------------| ------------------------------------------------------------ |
| Invoice Number          | Unique identifier for each transaction                       |
| Stock Code Product      | Item code                                                     |
| Description Product     | Item name                                                     |
| Quantity                | The quantity of each item purchased per transaction           |
| Invoice Date            | The date on which the transaction occurred                    |
| Unit Price              | Product price per unit                                        |
| Customer ID             | Unique identifier for the customer                            |
| Country                 | The name of the country where the customer resides            |

For the description of these variables, we consulted the link below:
https://www.kaggle.com/datasets/carrie1/ecommerce-data

# 3. Solution Planning

## 3.1. Final Product
A database containing customers separated into their clusters. This database has been hosted on AWS and can be updated daily and made available to the company. It is also possible to query it for visualization in a tool (we use Metadata).

## 3.2. Tools Used
- Python 3.10.10;
- VS Code;
- Jupyter Notebook;
- YData-Profiling;
- Metabase;
- SQL:
  - SQLite and PostgreSQL;
- Git and Github;
- Amazon Web Services: 
  - S3, RDS and EC2.

# 4. Solution Strategy

My strategy to solve this challenge was:

**Step 01. Data Description:** we renamed the columns, checked the dimensions and data types of the DataFrame, adjusted parts of the missing data by creating new IDs for customers. The missing data that remained in the dataset were from the `description` column and we assumed that they were some type of returns. Finally, we performed a descriptive statistical analysis.

**Step 02. Data Filtering:** we performed filtering on numerical and categorical attributes, removed specific rows from the `country` column, dropped the `description` column, the user with `customer_id` 16446, and separated the DataFrame into two DataFrames to understand how many products were being purchased and how many were being returned. The removal of rows from the `country` column was done with the purpose of studying customer behavior by country in the future. The reason why we removed user 16446 was due to the purchase of 80995 items and the return of the same items, which led us to believe that it was some sort of mistake.

**Step 03. Feature Engineering:** we created a set of features that we thought could help us segment our customers into clusters according to the RFM segmentation model we discussed earlier:
- `gross_revenue`
- `recency_days`
- `qty_invoices`
- `qty_items`
- `qty_products`
- `avg_ticket`
- `avg_recency_days`
- `frequency`
- `qty_returns`

**Step 04. Exploratory Data Analysis:** we used YData-Profiling to obtain a report with univariate, bivariate, and multivariate analyses of our features and manually selected some rows that could contain outliers pointed out by the tool. The latest version of this report is the file `output_v2.html` which is in the reports folder. Then we conducted a study on the spatial distribution of our data, the idea here was to find the best way to avoid high dimensionality. The methods used for this study were: 
- Principal Component Analysis, 
- Uniform Manifold Approximation and Projection, 
- t-Distributed Stochastic Neighbor Embedding, and 
- Tree-Based Embedding using a `RandomForestRegressor()` model. 

Finally, we applied `MinMaxScaler` to our features and chose a combination of Uniform Manifold Approximation and Projection with Tree-Based Embedding.

**Step 05 & 06. Data Preparation and Feature Selection:** it was not necessary to apply any further data preparation because the embedding spaces were organized by our tree based model algorithm and reduced with Umap. There was also no need to perform any feature selection.

**Step 07. Hyperparameter Fine Tunning:** we trained four unsupervised models for the clustering task: K-Means, Gaussian Mixture Model, Hierarchical Clustering, and Density-Based Spatial Clustering of Applications with Noise. We evaluated the models based on their Within-Cluster Sum of Squares and Silhouette Score, which are:
- `WCSS`, or Within-Cluster Sum of Squares, is the sum of the squared distances between each point and the centroid of the cluster it belongs to. The goal is to minimize the variation within each cluster.
- `SS`, or Silhouette Score, measures the quality of a cluster by evaluating how well each point fits in its cluster and how different it is from other clusters. The Silhouette Score ranges from -1 to 1, with values close to 1 indicating that the point is well-fitted to its cluster and far from other clusters, while values close to -1 indicate that the point may have been assigned to the wrong cluster.

**Step 08. Model Training:** given our metrics, we decided on the GMM, Gaussian Mixture Model. This model assumes that the data points are generated from a mixture of several Gaussian distributions, and it estimates the parameters of each distribution to assign each data point to the most likely cluster. We plotted a graph to obtain the best Silhouette Score between 2 and 25 clusters and ended up choosing a model with 10 clusters, which, although not obtaining the best Silhouette Score, provides a number of clusters that the marketing team can comfortably consider which actions will be taken on these customers.

**Step 09. Cluster Analysis:** the resulting clusters were grouped according to features that can offer direct insights into their characteristics, so that each cluster should inform us how many customers are in it, its percentage relative to the total number of customers, and the averages of gross revenue, recency in days, how many products they purchased, quantity of products, purchase frequency, and the quantity of returned products.

**Step 10. Deploy Model to Production:** we created a SQLite database locally to explore the possibility of automating the creation of clusters whenever the marketing team requested it. The idea was to ingest data from new and old customers, redo the clusters, and show the results. We used the Papermill library to manage this automation with the Crontab if regular evaluation was requested within a time period. We used AWS services to make this solution work on the cloud: we created an S3 bucket to store the pkl files and the final model, an RDS PostgreSQL database to allow us to ingest and add new data, and an EC2 instance to run the solution remotely and provide a new notebook with the date and time of this task. The update of this process can be examined with the help of Metabase, which display the situation of the Insiders cluster.

# 6. Top 3 Data Insights

**Hypothesis 01:** Insiders cluster customers is responsible for more than 80% of purchases.

**False**: the Insider cluster has a product purchase volume of 7.92%.

**Hypothesis 02:** the customers in the Insiders cluster have a return rate below the average of the total customer base.

**True**: The insiders cluster has an average return rate of 0%.

*Hypothesis 03:** the **Gross Merchandise Volume** of Insiders cluster is concentrated in the 3rd quartile.
**False**. The revenue of the insiders cluster is concentrated between the 2nd and 3rd quartiles.
<p align="center">
  <img src="./reports/H3.png" />
</p>

# 7. Machine Learning Model Applied

We applied the Gaussian Mixture Model, `GaussianMixture`, which is a probabilistic model based on the assumption that data is generated from normal (i.e. Gaussian) distributions, where each distribution represents a cluster of data. The algorithm randomly initializes the parameters of the distributions and then iteratively updates these parameters until convergence. During each iteration, the algorithm performs the **E-step**, where it calculates the probability of each data point belonging to each distribution, and the **M-step**, where it updates the parameters of the distributions based on the calculated probabilities. 

After estimating the parameters of the distributions, the algorithm can be used for clustering and density estimation. For the purposes of this project, which is a clustering problem, the algorithm assigns each data point to the distribution with the highest probability and considers all points assigned to the same distribution as belonging to the same cluster.

# 8. Machine Learning Model Performance

Our final model has a Silhouette Score of **0.4291628301143646** for 8 clusters, which, as previously mentioned, was a number we found reasonable to present to the marketing team. Below we present the final list of our clusters ranked by the average of their `gross_revenue`:

|   cluster |   customer_id |   perc_customer |   gross_revenue |   recency_days |   qty_products |   frequency |   qty_returns |
|----------:|--------------:|----------------:|----------------:|---------------:|---------------:|------------:|--------------:|
|         0 |            86 |         1.5101  |       4179.9305 |      182.767442 |      485.627907 |    1        |     0         |
|         3 |          1054 |        18.5075  |       2376.396  |       91.273245 |      119.074953 |    0.36202  |    23.312144 |
|         1 |           902 |        15.8385  |       2171.4951 |       96.359202 |       84.579823 |    0.414578 |   133.940133 |
|         6 |           806 |        14.1528  |       1960.92   |       91.942928 |       79.620347 |    0.399659 |    18.543424 |
|         5 |           702 |        12.3266  |       1756.7314 |       92.320513 |       79.921652 |    0.445168 |    11.274929 |
|         4 |           413 |         7.252   |       1538.5923 |      102.099274 |        70.179177 |    0.45777  |     9.200969 |
|         7 |           452 |         7.93679 |       1511.1577 |       77.35177  |       99.818584 |    0.379743 |    13.334071 |
|         9 |           537 |         9.42932 |       1164.9434 |       92.49162  |       82.674115 |    1        |     0         |
|         8 |           550 |         9.65759 |        706.50491 |      297.225455 |        56.094545 |    1        |     0         |
|         2 |           193 |         3.38894 |        701.6228 |      196.26943  |        73.689119 |    1        |     0         |

# 9. Business Results
## Insiders:
- Number of Customers: 86 (1.51% of the customers)
- Gross Revenue: US$ 4179.93
- Average Recency: 183 days
- Average number of products purchased : 486 products
- Frequency of products purchased: 100%

### 1. Who are the eligible people to participate in the Insiders program?
Only 1,51% of the customers.

### 2. How many customers will be part of the group?
86 customers.

### 3. What are the main characteristics of these customers?
- Number of customers: 86 (1.5% of customers)
- Average gross revenue: US$4179,93
- Average recency: 183 days
- Average number of products purchased: 486 products
- Average frequency of products purchased: 1 product/day

### 4. What percentage of revenue contribution comes from Insiders?
**0.035575079092110024%**

### 5. What is the revenue expectation for this group in the next few months?
The average gross revenue is **US$4179.93** with a fluctuation between **US$3745.911** and **US$4613.94**

# 9. Conclusions
Finally, the cluster elected as the Insiders brings some surprises: a cluster with only 86 customers (1.5%) has the highest average gross revenue among all ten clusters. With an average of 1 product per day, an average purchase of 486 products, and no returns, the marketing team urgently needs to decrease the average recency of the customers within this cluster and offer opportunities to add more customers to the Insiders.

Below is a simple Metabase dashboard that allows us to monitor this cluster. We have prepared notebook 10 to receive new data through queries from a local database (SQLite), and this process of data ingestion, clustering model update, and data export to this database can be done with the help of the Papermill library.

However, this automation can also be done online through AWS: our .pkl files have been stored in S3, the PostgreSQL database stored in RDS, and the Papermill process is regulated according to the scheduling of Crontab on a virtual machine prepared in the EC2 service. This entire process can be monitored in an online query through Metabase that displays information about the clusters, including Insiders.

<p align="center">
  <img src="./reports/Dashboard.png" />
</p>

# 10. Lessons Learned
This was not only the first Clustering project we carried out, but also the first one with a solution involving unsupervised machine learning models. Additionally, we conducted research around dimensionality reduction algorithms, as well as the business model incorporated in this challenge. It was also the first time we had the opportunity to think of a solution using AWS.

# 11. Next Steps to Improve
It is possible to devise a better solution for report automation using AWS, since the platform offers solutions for this type of task. If we acquire new data, we can retrain our models and decide whether the number of clusters is appropriate for our customer catalog.