THESE QUERIES EXPLORE THE INFORMATION PROVIDED IN LOS ANGELES CRIME DATA FROM 2020 TO 2023



SELECT *
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]

ALTER TABLE [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
ALTER COLUMN [Date Reported] DATE

ALTER TABLE [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
ALTER COLUMN [Date Occurred] DATE

--THIS QUERY WILL ROLL UP THE CRIME DESCRIPTION TO AVOID UNNECESARRY DUPLICATES
 UPDATE [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
SET [Crime  Description]=
CASE 
WHEN [Crime  Description] LIKE '%Assault%' THEN 'Assult'
WHEN [Crime  Description] LIKE '%Battery%' THEN 'Battery'
WHEN [Crime  Description] LIKE '%Bunco%' THEN 'Bunco'
WHEN [Crime  Description] LIKE '%Bike%' THEN 'Stolen Bike'
WHEN [Crime  Description] LIKE '%Burglary%' THEN 'Burglary'
WHEN [Crime  Description] LIKE '%Child Abuse%' THEN 'Child Abuse'
WHEN [Crime  Description] LIKE '%Defrauding%' THEN 'Fraud'
WHEN [Crime  Description] LIKE '%Dishonest%' THEN 'Dishonesty'
WHEN [Crime  Description] LIKE '%Document%' THEN 'Document issues'
WHEN [Crime  Description] LIKE '%Embezzlement%' THEN 'Embezzlement'
WHEN [Crime  Description] LIKE '%Theft Of Identity%' THEN 'Theft Of Identity'
WHEN [Crime  Description] LIKE '%Intimate %' THEN 'Assult'
WHEN [Crime  Description] LIKE '%Kidnapping%' THEN 'Kidnapping'
WHEN [Crime  Description] LIKE '%Lewd%' THEN 'Lewd Conduct'
WHEN [Crime  Description] LIKE '%Pickpocket%' THEN 'Pickpocket'
WHEN [Crime  Description] LIKE '%Purse%' THEN 'Purse Snatching'
WHEN [Crime  Description] LIKE '%Rape%' THEN 'Rape'
WHEN [Crime  Description] LIKE '%Sex%' THEN 'Sex Offence'
WHEN [Crime  Description] LIKE '%Shoplifting%' THEN 'Shoplifting'
WHEN [Crime  Description] LIKE '%Shots Fired%' THEN 'Shots Fired'
WHEN [Crime  Description] LIKE '%Theft%' THEN 'Theft'
WHEN [Crime  Description] LIKE '%Till Tap%' THEN 'Till Tap'
WHEN [Crime  Description] LIKE '%Vandalism%' THEN 'Vandalism'
WHEN [Crime  Description] LIKE '%Vehicle%' THEN 'Stolen Vehicle'
WHEN [Crime  Description] LIKE '%Violation Of%' THEN 'Violation Of Order'
Else [Crime  Description]
End 

--THIS QUERY WILL RETURN THE TOTAL NUMBER OF CASES
SELECT COUNT(*)
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]

--THIS QUERY WILL RETURN THE NUMBER OF YEARS BETWEEN THE DAY THE CRIME OCCURED AND THE DAY IT WAS REPORTED
SELECT  [Crime  Description],DATEDIFF(YEAR,[Date Occurred],[Date Reported]) AS Years_Between_Occurence_and_Report
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  ORDER BY DATEDIFF(MONTH,[Date Occurred],[Date Reported]) DESC

  --THIS QUERY WILL COUNT THE DISTINCT CRIMES REPORTED
  SELECT COUNT(DISTINCT [Crime  Description])
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]

  --THIS QUERY WILL RETURN THE COUNT OF EACH CRIME IN ORDER TO SHOW THE NUMBER OF TIMES EACH CRIME WAS REPORTED
  SELECT DISTINCT [Crime  Description], COUNT(*)
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  GROUP BY [Crime  Description]
  ORDER BY COUNT(*) DESC

  --THIS QUERY WILL RETURN THE NUMBER OF CRIMES REPORTED IN EACH AREA IN ORDER TO FIND OUT WHAT AREA SUFFERS THE MOST AMOUNT OF CRIMES
  SELECT TOP 5  [Area Name], COUNT(*)
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  GROUP BY [Area Name]
  ORDER BY COUNT(*) DESC

  --THIS QUERY WILL RETURN THE NUMBER OF CRIMES REPORTED IN EACH AREA IN ORDER TO FIND OUT WHAT AREA SUFFERS THE LEAST AMOUNT OF CRIMES
   SELECT TOP 5  [Area Name], COUNT(*)
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  GROUP BY [Area Name]
  ORDER BY COUNT(*) 
  
  
  --THIS QUERY WILL RETURN THE AVERAGE AGE OF STOLEN IDENTITY VICTIMS PER GENDER
  SELECT [Victim  Sex] AS GENDER , ROUND(AVG([Victim Age]),1) AS Avg_Age
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  WHERE  [Crime  Description] = 'Theft Of Identity'
  AND [Victim  Sex]<> 'Unknown'
  GROUP BY [Victim  Sex]

  --THIS QUERY WILL RETURN THE NUMBER OF VICTIMS PER GENDER
  SELECT [Victim  Sex] AS GENDER , COUNT(*) AS No_Of_Victims
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  WHERE  [Victim  Sex]<> 'Unknown'
  GROUP BY [Victim  Sex]
  
  --THIS QUERY WILL CHANGE THE STATUS DESCRIPTION FROM UNK TO UNKNOWN
  UPDATE  [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  SET [Status Desc] = 'Unknown'
  WHERE [Status Desc]='UNK'

  --THIS QUERY WILL COUNT THE NUMBER OF CASES FOR EACH STATUS DESCRIPTION,TO LET US KNOW HOW MANY CULPRITS HAVE BEEN ARRESTED ,SENTENCED,
  --ARE STILL UUNDERGOING INVESTIGATION OR STATUS IS UNKNOWN
  SELECT DISTINCT([Status Desc]),COUNT(*) AS Status_Count
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  GROUP BY [Status Desc]

  --THIS QUERY WILL RETURN THE TOP 10 PREMISES WHERE CRIMES TOOK PLACE
  SELECT TOP 10 [Premises Description],COUNT(*) AS Crime_Count
  FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
  GROUP BY [Premises Description]
  ORDER BY COUNT(*) DESC

  --THIS QUERY WILL RETURN THE TOTAL NUMBER OF CASES PER YEAR
SELECT DISTINCT YEAR([Date Reported]), COUNT(*)
 FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
 GROUP BY YEAR([Date Reported])
 ORDER BY YEAR([Date Reported]) 

 --THIS QUERY WILL RETURN THE TOTAL NUMBER OF CASES PER MONTH, THIS WILL TELL US THE MONTH WITH THE HIGHEST CRIME RATE
 SELECT  DISTINCT DATENAME(MONTH,[Date Reported]), COUNT(*)
 FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
 GROUP BY DATENAME(MONTH,[Date Reported])
 ORDER BY COUNT(*) DESC

--THIS QUERY WILL RETURN THE AREAS WHERE EACH CRIME OCCURS THE MOST AND THE NUMBER OF TIMES IT HAS OCCURED
 WITH RANKINGS AS( 
 SELECT [Crime  Description], [Area Name], COUNT(*) AS Frequency,
 ROW_NUMBER() OVER(PARTITION BY [Crime  Description] ORDER BY COUNT(*))Row_Num
 FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
 GROUP BY [Crime  Description], [Area Name])
 --ORDER BY COUNT(*) DESC)
 SELECT [Crime  Description],[Area Name],Frequency
 FROM RANKINGS
 WHERE Row_Num = 1
 GROUP BY [Crime  Description],[Area Name], Frequency
 ORDER BY Frequency DESC

--THIS QUERY WILL RETURN THE PREMISES WHERE EACH CRIME OCCURS THE MOST AND THE NUMBER OF TIMES IT HAS OCCURED
  WITH RANKINGS AS( 
 SELECT [Crime  Description], [Premises Description], COUNT(*) AS Frequency,
 ROW_NUMBER() OVER(PARTITION BY [Crime  Description] ORDER BY COUNT(*))Row_Num
 FROM [Crime Data Analysis].[dbo].[Crime_Data_from_2020_to_Present$]
 GROUP BY [Crime  Description], [Area Name],[Premises Description])
 --ORDER BY COUNT(*) DESC)
 SELECT [Crime  Description],[Premises Description]
 FROM RANKINGS
 WHERE Row_Num = 1
 GROUP BY [Crime  Description],[Premises Description]
  
























