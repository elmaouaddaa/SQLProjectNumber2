-- Cleaning Data of NashvilleHousing


Select *
From NashvilleHousing 

-- Standerdizing Date Format

Select SaleDateConverted, CONVERT(date, SaleDate)
From NashvilleHousing 

Update NashvilleHousing
Set SaleDate = CONVERT(date, SaleDate)

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = CONVERT(date, SaleDate)



------------- Populate Properly Address Data----------------

Select *
From NashvilleHousing 
--where PropertyAddress is null

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
	On a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
Set PropertyAddress =isnull(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
	On a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
Where a.PropertyAddress is null

---------------------------- Dividing address to individual columns ( Address, City, State)

Select PropertyAddress
from NashvilleHousing

Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress))

From NashvilleHousing



Alter Table NashvilleHousing
Add PropertyDevisionAddress nvarchar(255);

Update NashvilleHousing
Set PropertyDevisionAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)


Alter Table NashvilleHousing
Add PropertyDevisionCity nvarchar(255);

Update NashvilleHousing
Set PropertyDevisionCity = SUBSTRING(PropertyAddress, CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress))


Select *
From NashvilleHousing


Select OwnerAddress
From NashvilleHousing


Select 
parsename(replace(OwnerAddress,',','.'), 3)
,parsename(replace(OwnerAddress,',','.'), 2)
,parsename(replace(OwnerAddress,',','.'), 1)
From NashvilleHousing


Alter Table NashvilleHousing
Add OwnerDevisionAddress nvarchar(255);

Update NashvilleHousing
Set OwnerDevisionAddress = parsename(replace(OwnerAddress,',','.'), 3)




Alter Table NashvilleHousing
Add OwnerDevisionCity nvarchar(255);

Update NashvilleHousing
Set OwnerDevisionCity = parsename(replace(OwnerAddress,',','.'), 2)



Alter Table NashvilleHousing
Add OwnerDevisionState nvarchar(255);

Update NashvilleHousing
Set OwnerDevisionState = parsename(replace(OwnerAddress,',','.'), 1)



------------------- Changing Y and N to Yes and No in "SoldAsVacant" --------------

Select distinct(SoldAsVacant), count(SoldAsVacant)
from NashvilleHousing
Group by SoldAsVacant
Order by 2






Select SoldAsVacant,
CASE
	When SoldAsVacant = 'Y' then 'Yes'
	When SoldAsVacant = 'N' then 'No'
	Else SoldAsVacant
	End 
from NashvilleHousing


Update NashvilleHousing
Set SoldAsVacant = CASE
	When SoldAsVacant = 'Y' then 'Yes'
	When SoldAsVacant = 'N' then 'No'
	Else SoldAsVacant
	End 

------------------ Remove Duplicates ------------------------------------------
with RowNumCTE as (
Select *,
		ROW_NUMBER() over(
		partition by ParcelID,
		PropertyAddress,
		SaleDate,
		SalePrice,
		LegalReference
		Order by
		UniqueID
		) Row_num
From NashvilleHousing
)
select*
from RowNumCTE
where Row_num>1
--order by PropertyAddress


------------------- Deleting Unused Columns--------------------

select*
from NashvilleHousing

alter table NashvilleHousing
drop column  PropertyAddress, TaxDistrict, OwnerAddress
















