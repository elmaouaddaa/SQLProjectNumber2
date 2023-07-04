
NashvilleHousing Data Cleaning
This repository contains SQL queries used to clean and preprocess the NashvilleHousing dataset. The dataset consists of housing sales data in Nashville.

Cleaning Steps
Cleaning Data: This query selects all columns from the NashvilleHousing table, displaying the raw data.

Standardizing Date Format: This query converts the SaleDate column to the proper date format using the CONVERT function.

Populating Properly Address Data: This step populates missing values in the PropertyAddress column by joining records with the same ParcelID but different UniqueID. The ISNULL function is used to fill in the missing values.

Dividing Address to Individual Columns: This step divides the PropertyAddress column into separate columns for Address and City using the SUBSTRING function.

Dividing OwnerAddress to Individual Columns: Similar to the previous step, this query divides the OwnerAddress column into separate columns for OwnerDevisionAddress, OwnerDevisionCity, and OwnerDevisionState using the PARSENAME and REPLACE functions.

Changing Y and N to Yes and No in "SoldAsVacant": This query updates the SoldAsVacant column, replacing 'Y' with 'Yes' and 'N' with 'No'.

Remove Duplicates: This query removes duplicate records based on specific columns using the ROW_NUMBER function.

Deleting Unused Columns: This query drops the PropertyAddress, TaxDistrict, and OwnerAddress columns from the NashvilleHousing table.

Feel free to explore the queries in this repository and modify them according to your needs.


Done By Adil El-maouadda